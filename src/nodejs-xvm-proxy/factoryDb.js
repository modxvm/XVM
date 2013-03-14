var db = require("./db"),
    settings = require("./settings").settings,
    utils = require("./utils");

exports.getPlayersData = function(parsedIds, callback) {
    process.send({ usage: 1, requests: 1, players: parsedIds.ids.length });
    db.getPlayersData(parsedIds.ids, function(error, dbData) {
        if(error) {
            callback(500, '{"error":"' + error.text + '","server":"' + settings.serverName + '"}');
            return;
        }

        var procData = {
            dbData: dbData,
            rqData: parsedIds.data
        };

        _onPlayersData(procData, callback);
    });
};

var _onPlayersData = function(processData, callback) {
    try {
        var now = new Date();

        for(var dbi in processData.dbData) {
            var item = processData.dbData[dbi],
                pdata = processData.rqData[item._id];

            item.vname = pdata.vname;
            item.v = utils.filterVehicleData(item, pdata.vname);

            if((now - item.dt) < settings.cacheTtl) {
                if(settings.fixData)
                    _recalculateMissed(item);

                item.st = "cache";
                // remove cached item from request
                delete processData.rqData[item._id];
            } else {
                item.st = "expired";
                processData.rqData[item._id].cache = item;
                delete processData.dbData[dbi];
            }
        }

        // process items with bad id
        for(var rqi in processData.rqData) {
            pdata = processData.rqData[rqi];
            if(pdata.status == "bad_id") {
                processData.dbData.push({_id: rqi, st: pdata.status});
                delete processData.rqData[rqi];
            }
        }

        // db_data - cached items
        // rq_data - items for update from statistics host
        callback(undefined, processData);
    } catch(e) {
        callback(500, '{"error":"' + e + '","server":"' + settings.serverName + '"}');
        utils.log("Error: " + e);
    }
};

var _recalculateMissed = function(data) {
    var ok = false,
        lvl = false;

    if(!data.lvl) {
        // Average Tier
        lvl = true;
        data.lvl = utils.calculateAvgLevel(data.v);
    }

    if(!data.wn) {
        // WN - WN rating http://forum.worldoftanks.com/index.php?/topic/184017-
        data.wn = utils.calculateWN(data);
        ok = true;
        //utils.log("id=" + data._id + " wn=" + data.wn);
    }

    if(!data.twr) {
        // TWR - tourist1984 win rate (aka T-Calc)
        try {
            data.twr = parseFloat(utils.tcalc(data, false).result.toFixed(2));
            ok = true;
            //utils.log("id=" + data._id + " twr=" + data.twr);
        } catch(e) {
            utils.log(e);
        }
    }

    if(lvl) {
        data.lvl = parseFloat(data.lvl.toFixed(1));
        ok = true;
        //utils.log("id=" + data._id + " lvl=" + data.lvl);
    }

    // updating db
    if(ok && Math.floor(Math.random() * 1) === 0) {
        db.updatePlayersData(data._id, data);
    }
};