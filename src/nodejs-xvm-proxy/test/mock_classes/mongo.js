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
                if(query && query.$or) {
                    var playerId = query.$or[1]._id;

                    setMongoResult("mongo_" + playerId + ".json");
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
        currentMongoResult = JSON.parse(fs.readFileSync("./test/mock_responses/" + result, "utf8"));
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
        setMongoResult: setMongoResult,
        resetMongoResult: function() {
            currentMongoResult = undefined;
        },
        toString: function() {
            return "fakeMongo";
        }
    }
})();