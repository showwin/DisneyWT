// Setup API
var DisneyAPI = require("wdwjs");
var mysql = require('mysql');
var config = require('config');
var dbHost = config.get('database.host');
var connection = mysql.createConnection({
  host     : dbHost,
  user     : 'me',
  password : 'secret',
  database : 'my_db'
});
connection.connect();

// Shanghai Disney Resort
var ShanghaiDR = new DisneyAPI.ShanghaiDisneyResort();
ShanghaiDR.GetWaitTimes(function(err, data) {
    if (err) return console.error("Error fetching hanghai Disney Resort wait times: " + err);

    console.log(JSON.stringify(data, null, 2));
});
ShanghaiDR.GetOpeningTimes(function(err, data) {
    if (err) return console.error("Error fetching hanghai Disney Resort schedule: " + err);

    console.log(JSON.stringify(data, null, 2));
});

// Tokyo Disney Land
var TokyoDL = new DisneyAPI.DisneylandTokyo();
TokyoDL.GetWaitTimes(function(err, data) {
    if (err) return console.error("Error fetching Tokyo Disney Land wait times: " + err);

    console.log(JSON.stringify(data, null, 2));
});
TokyoDL.GetOpeningTimes(function(err, data) {
    if (err) return console.error("Error fetching Tokyo Disney Land schedule: " + err);

    console.log(JSON.stringify(data, null, 2));
});

// Tokyo Disney Sea
var TokyoDS = new DisneyAPI.DisneySeaTokyo();
TokyoDS.GetWaitTimes(function(err, data) {
    if (err) return console.error("Error fetching Tokyo Disney Sea wait times: " + err);

    console.log(JSON.stringify(data, null, 2));
});
TokyoDS.GetOpeningTimes(function(err, data) {
    if (err) return console.error("Error fetching Tokyo Disney Sea schedule: " + err);

    console.log(JSON.stringify(data, null, 2));
});

// HongKong Disney Land
var HongKongDL = new DisneyAPI.DisneylandHongKong();
HongKongDL.GetWaitTimes(function(err, data) {
    if (err) return console.error("Error fetching HongKong Disney Land wait times: " + err);

    console.log(JSON.stringify(data, null, 2));
});
HongKongDL.GetOpeningTimes(function(err, data) {
    if (err) return console.error("Error fetching HongKong Disney Land schedule: " + err);

    console.log(JSON.stringify(data, null, 2));
});
