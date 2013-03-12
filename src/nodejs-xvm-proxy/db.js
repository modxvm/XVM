var mongodb,
    settings = require("./settings").settings,
    utils = require("./utils");

var options = {
        auto_reconnect: true,
        poolSize: settings.dbMaxConnections
    };
var db,
    players,
    users,
    missed,
    performanceLog;

module.exports = function(fakeMongo) {
    mongodb = mongodb || fakeMongo || require("mongodb");

    if(!db) {
        db = new mongodb.Db(settings.dbName, new mongodb.Server(settings.mongoServer, settings.mongoPort, options), { w: 0 });

        db.open(function(error, client) {
            if(error) {
                utils.log("DB connection error!");
                return;
            }
            players = new mongodb.Collection(client, settings.playersCollectionName);
            users = new mongodb.Collection(client, settings.usersCollectionName);
            missed = new mongodb.Collection(client, settings.missedCollectionName);
            performanceLog = new mongodb.Collection(client, settings.performanceLogCollectionName);
        });
    }

    return {
        getPerformanceReport: getPerformanceReport,
        getPlayerByName: getPlayerByName,
        getPlayerByNameId: getPlayerByNameId,
        getPlayersData: getPlayersData,
        insertMissed: insertMissed,
        insertPerformanceReport: insertPerformanceReport,
        removeMissed: removeMissed,
        updatePlayersData: updatePlayersData,
        updateUsers: updateUsers
    }
};

var getPlayersData = function(ids, callback) {
    var cursor = players.find(
            { _id: { $in: ids } },
            { _id: 1, st: 1, dt: 1, cr: 1, up: 1, nm: 1, b: 1, w: 1, spo: 1, hip: 1, cap: 1, dmg: 1, frg: 1, def: 1, lvl: 1, e: 1, wn: 1, twr: 1, v: 1 }
        );

    _executeDbQuery(cursor, callback);

    /*players.aggregate([
     { $match: { _id: { $in: parsedIds.ids } } },
     { $unwind: "$v" }
     ], function(error, result) {
     var ret = {
     dbData: result,
     rqData: parsedIds.data
     };

     callback(error ? { statusCode:500, text:error } : null, ret);
     });*/
};

var getPlayerByName = function(name, region, callback) {
    var minId,
        maxId;

    switch(region) {
        case "RU":
            minId = 1;
            maxId = 499999999;
            break;
        case "EU":
            minId = 500000000;
            maxId = 999999999;
            break;
        case "NA":
        case "US":
            minId = 1000000000;
            maxId = 1499999999;
            break;
        case "SEA":
            minId = 2000000000;
            maxId = 2499999999;
            break;
        case "VTC":
            minId = 2500000000;
            maxId = 2999999999;
            break;
        case "KR":
            minId = 3000000000;
            maxId = 3499999999;
            break;
    }

    var cursor = players.find({
            nm: name,
            _id: { $gte: minId, $lte: maxId }
        });

    _executeDbQuery(cursor, callback);
};

var getPlayerByNameId = function(nameId, callback) {
    var query = { };

    if(/^\d+$/.test("" + nameId)) {
        query = {
            $or: [
                { _id: parseInt(nameId) },
                { nm: nameId }
            ]
        }
    } else {
        query = { nm: nameId };
    }

    _executeDbQuery(players.find(query), callback);
};

var _executeDbQuery = function(cursor, callback) {
    var startStamp = new Date();

    process.send({ usage: 1, mongorq: 1 });

    cursor.toArray(function(error, result) {
        process.send({ usage: 1, mongorq: -1 });
        updateDbBalancer(startStamp);

        callback(error ? { statusCode: 500, text: error } : undefined, result);
    });
};

var updatePlayersData = function(id, data) {
    players.update({ _id: id }, data, { upsert: true });
};

var removeMissed = function(id) {
    missed.remove({ _id: id }, function(err) {
        if(err)
            utils.log("[DB] removeMissed(" + id + ") error: " + err);
    });
};

var insertMissed = function(id, miss) {
    missed.insert({ _id: id, missed: miss });
};

var _mongoMaxRq = settings.dbMaxConnections,
    _mongoMaxRqLastUpdate = null;

var updateDbBalancer = function(startStamp) {
    var now = new Date(),
        delta = 0,
        dtime = 0,
        duration = now - startStamp;

    if (duration > settings.dbMaxTime) {
        delta = -3;
        dtime = 200;
    } else if (duration < settings.dbMinTime) {
        delta = 1;
        dtime = 200;
    }

    if (!_mongoMaxRqLastUpdate || (now - _mongoMaxRqLastUpdate) > dtime) {
        _mongoMaxRqLastUpdate = now;
        var oldvalue = _mongoMaxRq;
        _mongoMaxRq = Math.max(1, Math.min(settings.dbMaxConnections, _mongoMaxRq + delta));
        if (_mongoMaxRq != oldvalue)
            process.send({ usage: 1, mongorq_max: _mongoMaxRq - oldvalue });
    }
};

var insertPerformanceReport = function(perfStat) {
    performanceLog.insert(perfStat);
};

var getPerformanceReport = function(callback) {
    var cursor = performanceLog.find().sort({ _id: -1 }).limit(25);

    cursor.toArray(callback);
};

var updateUsers = function(id) {
    users.update({ _id: id }, { $inc: { counter: 1 } }, { upsert: true });
};