module.exports = (function() {
    var settings = require("./settings").settings,
        utils = require("./utils"),
        _open_callback = null,
        _mongo = null,
        _mongoRq = 0,
        _mongoMaxRq = settings.dbMaxConnections,
        _mongoMaxRqLastUpdate = null,

        players = null,
        missed = null,
        users = null;

    var initialize = function(callback, mongo) {
        _open_callback = callback;
        _mongo = mongo || require("mongodb");

        // Connect to database
        var options = {
            auto_reconnect: true,
            poolSize: settings.dbMaxConnections
        };

        var db = new _mongo.Db(settings.dbName, new _mongo.Server(settings.mongoServer, settings.mongoPort, options), { w:0 });

        db.open(onOpen);
    };

    var isOverloaded = function() {
        return _mongoRq >= _mongoMaxRq;
    };

    var find = function(collectionName, query) {
        var col = null;
        switch (collectionName) {
            case "players":
                col = players;
                break;
            case "missed":
                col = missed;
                break;
            case "users":
                col = users;
                break;
            default:
                throw "[DB] Bad collectionName: " + collectionName;
        }
        return col.find(query);
    };

    var getPlayersData = function(ids, callback) {
        if (isOverloaded()) {
            callback({
                statusCode: 503, // Service Unavailable
                text: "db overloaded: " + _mongoRq + "/" + _mongoMaxRq
            });
            return;
        }

        // Select required data from cache
        _mongoRq++;
        process.send({ usage: 1, mongorq: 1 });
        var start = new Date();
        var cursor = players.find(
            {_id:{$in:ids}},
            {_id:1, st: 1, dt:1, nm:1, b:1, w:1, spo:1, hip:1, cap:1, dmg:1, frg:1, def:1, lvl:1, e:1, wn:1, twr:1, v:1 });
        cursor.toArray(function(error, result) {
            _mongoRq--;
            process.send({ usage: 1, mongorq: -1 });

            updateDbBalancer(start);

            callback(error ? { statusCode:500, text:error } : null, result);
        });
    };

    var updatePlayersData = function(id, data) {
        players.update({ _id: id }, data, { upsert: true });
    };

    var insertMissed = function(id, miss) {
        missed.insert({ _id: id, missed: miss });
    };

    var removeMissed = function(id) {
        missed.remove({ _id: id }, function(err) {
            if (err) utils.log("[DB] removeMissed(" + id + ") error: " + err);
        });
    };

    var updateUsers = function(id) {
        users.update({ _id: id }, { $inc: { counter: 1 } }, { upsert: true });
    };

    var onOpen = function(error, client) {
        if(error) {
            utils.log("DB connection error!");
            return;
        }
        utils.log("MongoDB connected: " + settings.dbName);
        players = new _mongo.Collection(client, settings.playersCollectionName);

        var options = {
            auto_reconnect: true,
            poolSize: settings.dbMaxConnections2
        };

        var db = new _mongo.Db(settings.dbName2, new _mongo.Server(settings.mongoServer, settings.mongoPort, options), { w:0 });
        db.open(function(error2, client2) {
            utils.log("MongoDB connected: " + settings.dbName2);
            missed = new _mongo.Collection(client2, settings.missedCollectionName);
            users = new _mongo.Collection(client2, settings.usersCollectionName);
            _open_callback();
        });
    };

    // DB connections balancer
    var updateDbBalancer = function(start) {
        var now = new Date();
        var delta = 0;
        var dtime = 0;
        var duration = now - start;
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
    return {
        initialize: initialize,
        find: find,
        getPlayersData: getPlayersData,
        isOverloaded: isOverloaded,
        updatePlayersData: updatePlayersData,
        insertMissed: insertMissed,
        removeMissed: removeMissed,
        updateUsers: updateUsers
    }
})();