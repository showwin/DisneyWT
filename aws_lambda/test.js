var DisneyAPI = require("wdwjs");

var ShanghaiDR = new DisneyAPI.ShanghaiDisneyResort();
ShanghaiDR.GetWaitTimes(function(err, data) {
    if (err) return console.error("Error fetching hanghai Disney Resort wait times: " + err);

    console.log(JSON.stringify(data, null, 2));
});
