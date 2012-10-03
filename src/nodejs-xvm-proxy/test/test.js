var assert = require("assert"),
    request = require("supertest"),
    worker = require("../worker"),
    sinon = require("sinon"),
    http = worker.http,
    mongo = worker.mongo;

var dbName,
    makeRequest,
    requestCounter,
    req,
    res;

// Mock ups
mongo.Server = function(hostName, port, options) {

};
mongo.Db = function(db, server) {
    dbName = db;

    return {
        open: function(callback) {
            callback();
        }
    }
};
mongo.Collection = function(client, collectionName) {

};
http.createServer = function(eventListener) {
    makeRequest = eventListener;
    return {
        listen: function() {

        }
    }
};

worker.createWorker();

suite("Basic functionality", function() {
    setup(function() {
        req = { url: "http://1.2.3.4/xxx/?1184151,324811,3044017" };
        res = "";
        requestCounter = 0;
    });

    teardown(function() {

    });

    suite("content", function() {
        test("JSON", function() {
            makeRequest(req, res);
            assert.equal(res, "");
        });
    });
});