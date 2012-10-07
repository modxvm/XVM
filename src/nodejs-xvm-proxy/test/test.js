var assert = require("assert"),
    worker = require("../worker"),
    fs = require('fs');

var dbName,
    makeRequest,
    req,
    res,
    currentResponse,
    lastResponse;

// Mock ups
process.send = function() { };
var fakeCursor = {
    toArray: function(callback) {
        callback(undefined, [ ]);
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
            update: function() { },
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

        callback(res);

        callbacks.data(fs.readFileSync("./test/mock_responses/" + currentResponse, "utf8"));
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
        lastResponse = { };
        req = { url: "" };
        res = {
            end: function(response) {
                console.log(response);
                lastResponse = JSON.parse(response);
            }
        };
    });

    teardown(function() {

    });

    suite("content", function() {
        test("Generic request", function() {
            req.url = "http://1.2.3.4/xxx/?1";
            currentResponse = "default.json";
            makeRequest(req, res);

            var player = lastResponse.players[0];

            assert.equal(player.id, 1);
            assert.equal(player.status, "ok");
            assert.equal(player.name, "squall1989");
            assert.equal(player.battles, 1160);
            assert.equal(player.wins, 544);
            assert.equal(player.eff, 540);
        });
    });
});