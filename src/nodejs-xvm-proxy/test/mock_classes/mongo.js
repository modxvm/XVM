module.exports = (function(undefined) {
    var currentMongoResult,
        lastUpdateRequest;

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
            find: function() {
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
        SetMongoResult: setMongoResult,
        toString: function() {
            return "fakeMongo";
        }
    }
})();