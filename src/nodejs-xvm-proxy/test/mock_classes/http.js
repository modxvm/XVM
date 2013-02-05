module.exports = (function(undefined) {
    var fs = require('fs'),
        requestCounter,
        currentWgResponse,
        globalAgent = { },
        makeRequest;

    var createServer = function(eventListener) {
        makeRequest = eventListener;
        return {
            listen: function() {

            }
        }
    };

    var get = function(options, callback) {
        var callbacks = { };
        var res = {
            setEncoding: function() { },
            on: function(eventName, callback) {
                callbacks[eventName] = callback;
            }
        };

        requestCounter++;

        callback(res);

        callbacks.data(fs.readFileSync("./test/mock_responses/" + currentWgResponse, "utf8"));
        callbacks.end();

        return {
            on: function() { }
        }
    };

    return {
        createServer: createServer,
        get: get,
        globalAgent: globalAgent,
        makeRequest: function() {
            return makeRequest;
        },
        setWgResponse: function(response) {
            currentWgResponse = response;
        },
        toString: function() {
            return "fakeHttp";
        }
    }
})();