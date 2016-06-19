/*
  WARNING: This Batch works fine only in timezone UTC
*/

// Setup
var DisneyAPI = require("wdwjs");
var mysql = require('mysql');
var config = require('config');
var connection = mysql.createConnection({
  host     : config.get('database.host'),
  user     : config.get('database.user'),
  password : config.get('database.password'),
  database : config.get('database.database')
});

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

function saveWaitTime(table, data, connection, date) {
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

    query = 'INSERT INTO '+table+' (name, waittime, status, fastpass, date, period) VALUES ("'+data[i]['id']+'",'+waittime+','+data[i]['active']+',"'+fastpass+'","'+today+'",'+period+')';
    console.log(query);
    connection.query(query, function(err, _, _) {
      if (err) console.log(err);
    });
    if (i == data.length - 1) {
      connection.end();
    }
  }
}

function saveSchedule(table, data, connection, timeDiff) {
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
      console.log(query);
      connection.query(query, function(err, _, _) {
        if (err) console.log(err);
      });
    if (i == data.length - 1) {
      connection.end();
    }
  }
}

var dateUTC = new Date;
var dateJST = new Date(dateUTC.getTime() + 9*3600000);
var dateCST = new Date(dateUTC.getTime() + 8*3600000);

exports.handler = function(event, context) {
  // Shanghai Disney Resort
  var ShanghaiDR = new DisneyAPI.ShanghaiDisneyResort();
  ShanghaiDR.GetWaitTimes(function(err, data) {
      if (err) return console.error("Error fetching hanghai Disney Resort wait times: " + err);

      saveWaitTime('sdl_pasts', data, connection, dateCST);
  });
  ShanghaiDR.GetOpeningTimes(function(err, data) {
      if (err) return console.error("Error fetching hanghai Disney Resort schedule: " + err);

      saveSchedule('sdl_schedules', data, connection, 8);
  });

  // Tokyo Disney Land
  var TokyoDL = new DisneyAPI.DisneylandTokyo();
  TokyoDL.GetWaitTimes(function(err, data) {
      if (err) return console.error("Error fetching Tokyo Disney Land wait times: " + err);

      saveWaitTime('tdl_pasts', data, connection, dateJST);
  });
  TokyoDL.GetOpeningTimes(function(err, data) {
      if (err) return console.error("Error fetching Tokyo Disney Land schedule: " + err);

      saveSchedule('tdl_schedules', data, connection, 9);
  });

  // Tokyo Disney Sea
  var TokyoDS = new DisneyAPI.DisneySeaTokyo();
  TokyoDS.GetWaitTimes(function(err, data) {
      if (err) return console.error("Error fetching Tokyo Disney Sea wait times: " + err);

      saveWaitTime('tds_pasts', data, connection, dateJST);
  });
  TokyoDS.GetOpeningTimes(function(err, data) {
      if (err) return console.error("Error fetching Tokyo Disney Sea schedule: " + err);

      saveSchedule('tds_schedules', data, connection, 9);
  });

  // HongKong Disney Land
  var HongKongDL = new DisneyAPI.DisneylandHongKong();
  HongKongDL.GetWaitTimes(function(err, data) {
      if (err) return console.error("Error fetching HongKong Disney Land wait times: " + err);

      saveWaitTime('hdl_pasts', data, connection, dateCST);
  });
  HongKongDL.GetOpeningTimes(function(err, data) {
      if (err) return console.error("Error fetching HongKong Disney Land schedule: " + err);

      saveSchedule('hdl_schedules', data, connection, 8);
  });
};
