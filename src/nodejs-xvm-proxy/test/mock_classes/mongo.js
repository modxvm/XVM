module.exports = (function(undefined) {
    var fs = require('fs'),
        currentMongoResult,
        lastUpdateRequest = { };

    var cursor = {
        toArray: function(callback) {
            callback(undefined, currentMongoResult || [ ]);
        },
        toString: function() {
            return "fakeCursor";
        }
    };

    var Server = function(hostName, port, options) {
        return { };
    };

    var Db = function(db, server) {
        return {
            open: function(callback) {
                callback();
            }
        }
    };

    var Collection = function(client, collectionName) {
        return {
            find: function(query) {
                if(query) {
                    var playerId,
                        playerName;

                    if(query.$or) {
                        playerId = query.$or[0]._id || query.$or[1]._id;
                    }
                    if(query.nm) {
                        playerName = query.nm;
                    }
                    if(query._id && query._id.$in) {
                        playerId = query._id.$in[0];
                    }

                    if(playerId || playerName)
                        setMongoResult("mongo_" + (playerId || playerName) + ".json");
                }

                return cursor;
            },
            update: function(key, item, options) {
                lastUpdateRequest.key = key;
                lastUpdateRequest.item = item;
                lastUpdateRequest.options = options;
            },
            remove: function(id, callback) {

            },
            toString: function() {
                return "fakeCollection";
            }
        }
    };

    var setMongoResult = function(result) {
        var path = "./test/mock_responses/" + result;

        if(!fs.existsSync(path)) {
            currentMongoResult = undefined;
            return;
        }
        currentMongoResult = JSON.parse(fs.readFileSync(path, "utf8"));
        currentMongoResult.dt = new Date();
        currentMongoResult = [currentMongoResult];
    };

    return {
        Server: Server,
        Db: Db,
        Collection: Collection,
        getLastUpdateRequest: function() {
            return lastUpdateRequest;
        },
        resetLastUpdateRequest: function() {
            lastUpdateRequest = { };
        },
        setMongoResult: setMongoResult,
        resetMongoResult: function() {
            currentMongoResult = undefined;
        },
        toString: function() {
            return "fakeMongo";
        }
    }
})();