/*
  WARNING: This Batch works fine only in timezone UTC
*/

// Setup
const Themeparks = require("themeparks");
var mysql = require('mysql');
var config = require('config');
var async = require('async');

function timeToPeriod(hours, minutes) {
  /*
    00:00 - 00:29 => 1 (00:15)
    00:30 - 00:59 => 2 (00:45)
    01:00 - 01:29 => 3 (01:15)
    …
    23:30 - 24:00 => 48 (23:45)
  */
  var tmp1 = hours * 2;
  var tmp2 = 1;
  if (30 <= minutes) {
    tmp2 = 2;
  }
  return tmp1 + tmp2;
}

function saveWaitTime(table, data, date) {
  var connection = mysql.createConnection({
    host     : config.get('database.host'),
    user     : config.get('database.user'),
    password : config.get('database.password'),
    database : config.get('database.database')
  });
  connection.connect();
  for (i in data) {
    var today = date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate();
    var period = timeToPeriod(date.getHours(), date.getMinutes());

    var fastpass = '';
    var fpStatus = data[i]['fastPassStatus'] || '';
    if (data[i]['fastPass'] == true && fpStatus != 'All Fastpass Claimed') {
      // (e.g.) 'Fastpass booking: 18:15 - 19:00' => '18:15 - 19:00'
      fastpass = fpStatus.substr(18);
    }
    var waittime = Math.max(data[i]['waitTime'], 0);
    var id = data[i]['id'].split('_')[1]  // 'TokyoDisneyResortMagicKingdom_34' のような形式

    query = 'INSERT INTO '+table+' (name, waittime, status, fastpass, date, period) VALUES ("'+id+'",'+waittime+','+data[i]['active']+',"'+fastpass+'","'+today+'",'+period+')';
    //console.log(query);
    connection.query(query, function(err, _, _) {
      if (err) console.log(err);
    });
    if (i == data.length - 1) {
      connection.end();
    }
  }
}

function saveSchedule(table, data, timeDiff) {
  var connection = mysql.createConnection({
    host     : config.get('database.host'),
    user     : config.get('database.user'),
    password : config.get('database.password'),
    database : config.get('database.database')
  });
  connection.connect();
  for (i in data) {
      var openTime = new Date(data[i]['openingTime']);
      var closeTime = new Date(data[i]['closingTime']);
      var openLocalTime = new Date(openTime.getTime() + timeDiff*3600000)
      var closeLocalTime = new Date(closeTime.getTime() + timeDiff*3600000)
      var open_period = timeToPeriod(openLocalTime.getHours(), openLocalTime.getMinutes());
      var close_period = timeToPeriod(closeLocalTime.getHours(), closeLocalTime.getMinutes());
      query = 'INSERT INTO '+table+' (date, open_period, close_period) VALUES ("'+data[i]['date']+'",'+open_period+','+close_period+') ON DUPLICATE KEY UPDATE open_period = '+open_period+', close_period = '+close_period+'';
      //console.log(query);
      connection.query(query, function(err, _, _) {
        if (err) console.log(err);
      });
    if (i == data.length - 1) {
      connection.end();
    }
  }
}

exports.handler = function(event, context) {
  var dateUTC = new Date;
  console.log(dateUTC)
  var dateJST = new Date(dateUTC.getTime() + 9*3600000);
  var dateCST = new Date(dateUTC.getTime() + 8*3600000);

  // Tokyo Disney Land
  const TokyoDL = new Themeparks.Parks.TokyoDisneyResortMagicKingdom();
  TokyoDL.GetWaitTimes().then((data) => {
    saveWaitTime('tdl_pasts', data, dateJST);
  }).catch((err) => {
    console.error("Error fetching Tokyo Disney Land wait times: " + err);
  });

  });
  TokyoDL.GetOpeningTimes().then((data) => {
      saveSchedule('tdl_schedules', data, 9);
  }).catch((err) => {
      console.error("Error fetching Tokyo Disney Land schedule: " + err);
  });

  // Tokyo Disney Sea
  var TokyoDS = new Themeparks.Parks.TokyoDisneyResortDisneySea();
  TokyoDS.GetWaitTimes().then((data) => {
    saveWaitTime('tds_pasts', data, dateJST);
  }).catch((err) => {
    console.error("Error fetching Tokyo Disney Sea wait times: " + err);
  });
  TokyoDS.GetOpeningTimes().then((data) => {
    saveSchedule('tds_schedules', data, 9);
  }).catch((err) => {
      console.error("Error fetching Tokyo Disney Sea schedule: " + err);
  });

  // HongKong Disney Land
  var HongKongDL = new Themeparks.Parks.HongKongDisneyland();
  HongKongDL.GetWaitTimes().then((data) => {
    saveWaitTime('hdl_pasts', data, dateCST);
  }).catch((err) => {
    console.error("Error fetching HongKong Disney Land wait times: " + err);
  });
  HongKongDL.GetOpeningTimes().then((data) => {
    saveSchedule('hdl_schedules', data, 8);
  }).catch((err) => {
      console.error("Error fetching HongKong Disney Land schedule: " + err);
  });

  // Shanghai Disney Resort
  var ShanghaiDR = new Themeparks.Parks.ShanghaiDisneyResortMagicKingdom();
  ShanghaiDR.GetOpeningTimes().then((data) => {
    saveSchedule('sdl_schedules', data, 8);
  }).catch((err) => {
    console.error("Error fetching Shanghai Disney Resort schedule: " + err);
  });

  // retry until fetch all attractions waittime, because often fails.
  var get_all = false;
  async.whilst(function() {
    return !get_all;
  }, function(callback) {
    ShanghaiDR.GetWaitTimes().then((data) => {
      if (data.length >= 20) get_all = true;
      if (get_all) saveWaitTime('sdl_pasts', data, dateCST);
    }).catch((err) => {
      console.error("Error fetching Shanghai Disney Resort wait times: " + err);
    }).then(() => {
        setTimeout(function() {
          console.info("Retry getting waittime for Shanghai Disney Resort");
          callback();
        }, 3000);
    });
  });
};
