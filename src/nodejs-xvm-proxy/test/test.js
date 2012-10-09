var assert = require("assert"),
    worker = require("../worker"),
    fs = require('fs');

var dbName,
    makeRequest,
    req,
    res,
    requestCounter,
    currentWGResponse,
    currentMongoResult,
    lastResponse,
    lastUpdateRequest;

// Mock ups
process.send = function() { };
var fakeCursor = {
    toArray: function(callback) {
        callback(undefined, currentMongoResult || [ ]);
    },
    toString: function() {
        return "fakeCursor";
    }
};
var fakeMongo = {
    Server: function(hostName, port, options) {

    },
    Db: function(db, server) {
        dbName = db;

        return {
            open: function(callback) {
                callback();
            }
        }
    },
    Collection: function(client, collectionName) {
        return {
            find: function() {
                return fakeCursor;
            },
            update: function(key, item, options) {
                lastUpdateRequest.key = key;
                lastUpdateRequest.item = item;
                lastUpdateRequest.options = options;
            },
            toString: function() {
                return "fakeCollection";
            }
        }
    },
    toString: function() {
        return "fakeMongo";
    }
};
var fakeHttp = {
    createServer: function(eventListener) {

        makeRequest = eventListener;
        return {
            listen: function() {

            }
        }
    },
    get: function(options, callback) {
        var callbacks = { };
        var res = {
            setEncoding: function() { },
            on: function(eventName, callback) {
                callbacks[eventName] = callback;
            }
        };

        requestCounter++;

        callback(res);

        callbacks.data(fs.readFileSync("./test/mock_responses/" + currentWGResponse, "utf8"));
        callbacks.end();

        return {
            on: function() { }
        }
    },
    globalAgent: { },
    toString: function() {
        return "fakeHttp";
    }
};

worker.createWorker(fakeMongo, fakeHttp);

suite("Basic functionality", function() {
    setup(function() {
        requestCounter = 0;
        lastResponse = { };
        lastUpdateRequest = { };
        currentMongoResult = null;
        req = { url: "" };
        res = {
            end: function(response) {
                lastResponse = JSON.parse(response);
            }
        };
    });

    teardown(function() {

    });

    suite("responses", function() {
        test("generic request", function() {
            req.url = "http://1.2.3.4/xxx/?1";
            currentWGResponse = "defaultWGStat.json";
            makeRequest(req, res);

            var player = lastResponse.players[0];

            assert.equal(player.id, 1);
            assert.equal(player.status, "ok");
            assert.equal(player.name, "vovaPupkin");
            assert.equal(player.battles, 1160);
            assert.equal(player.wins, 544);
            assert.equal(player.eff, 540);
        });
        test("request with specific vehicle (update from WG)", function() {
            req.url = "http://1.2.3.4/xxx/?1=T-28";
            currentWGResponse = "defaultWGStat.json";
            makeRequest(req, res);

            var player = lastResponse.players[0],
                vehicle = player.v;

            assert.equal(player.vname, "T-28");
            assert.equal(vehicle.name, "T-28");
            assert.equal(vehicle.l, 4);
            assert.equal(vehicle.b, 91);
            assert.equal(vehicle.w, 48);

            assert.equal(requestCounter, 1);
        });
        test("request with specific vehicle (update from DB)", function() {
            setMongoResult("mongoItem.json");
            req.url = "http://1.2.3.4/xxx/?1=T-28";
            makeRequest(req, res);

            var player = lastResponse.players[0],
                vehicle = player.v;

            assert.equal(player.vname, "T-28");
            assert.equal(vehicle.name, "T-28");
            assert.equal(vehicle.l, 4);
            assert.equal(vehicle.b, 91);
            assert.equal(vehicle.w, 48);

            assert.equal(requestCounter, 0);
        });
    });

    suite("mongo DB", function() {
        test("update", function() {
            req.url = "http://1.2.3.4/xxx/?1=T-28";
            currentWGResponse = "defaultWGStat.json";
            makeRequest(req, res);

            assert.equal(lastUpdateRequest.key._id, 1);
            assert.ok(lastUpdateRequest.options.upsert);

            var item = lastUpdateRequest.item;

            assert.equal(item._id, 1);
            assert.equal(item.st, "ok");
            assert.equal(item.nm, "vovaPupkin");
            assert.equal(item.b, 1160);
            assert.equal(item.w, 544);
            assert.equal(item.e, 540);
            assert.equal(item.v.length, 26);
            assert.deepEqual(item.v[0], {
                name: "KV1",
                l: 5,
                b: 208,
                w: 94
            });
        });
    });

    // TODO: error handling, statistics(?)
});

var setMongoResult = function(result) {
    currentMongoResult = JSON.parse(fs.readFileSync("./test/mock_responses/" + result, "utf8"));
    currentMongoResult.dt = new Date();
    currentMongoResult = [currentMongoResult];
};