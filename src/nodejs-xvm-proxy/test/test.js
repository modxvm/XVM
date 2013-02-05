(function() {
    var assert = require("assert"),
        worker = require("../worker"),
        fakeMongo = require("./mock_classes/mongo.js"),
        fakeHttp = require("./mock_classes/http.js");

    var req,
        res,
        lastResponse,
        makeRequest;

    // Mock ups
    process.send = function() { };
    worker.createWorker(fakeMongo, fakeHttp);
    makeRequest = fakeHttp.makeRequest();

    suite("Basic functionality", function() {
        setup(function() {
            /*requestCounter = 0;
            lastResponse = { };
            lastUpdateRequest = { };
            currentMongoResult = null;*/

            req = { url: "" };
            res = {
                end: function(response) {
                    try {
                        lastResponse = JSON.parse(response);
                    } catch(e) {
                        lastResponse = response;
                    }
                }
            };
        });

        suite("responses", function() {

            test("test request", function() {
                req.url = "http://1.2.3.4/xxx/?001";
                makeRequest(req, res);

                var player = lastResponse.players[0];

                assert.equal(player.id, 1);
                assert.equal(player.status, "ok");
            });

            test("wrong request", function() {
                req.url = "http://1.2.3.4/xxx/?wrong_request";
                makeRequest(req, res);

                assert.equal(lastResponse, "wrong request: query match error: wrong_request, url=http://1.2.3.4/xxx/?wrong_request\nserver=?");
            });

            test("generic request", function() {
                req.url = "http://1.2.3.4/xxx/?1";

                fakeHttp.setWgResponse("defaultWGStat.json");
                makeRequest(req, res);

                /*var player = lastResponse.players[0];

                assert.equal(player.id, 1);
                assert.equal(player.status, "ok");
                assert.equal(player.name, "vovaPupkin");
                assert.equal(player.battles, 1160);
                assert.equal(player.wins, 544);
                assert.equal(player.eff, 540);*/
            });

            /*test("request with specific vehicle (update from WG)", function() {
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
            });*/
        });

        /*suite("mongo DB", function() {
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
                    cl: "HT",
                    l: 5,
                    b: 208,
                    w: 94,
                    d: null,
                    f: null,
                    s: null,
                    u: null
                });
            });
        });*/

        // TODO: error handling, statistics(?)
    });
})();