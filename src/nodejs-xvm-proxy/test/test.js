(function() {
    var includer = require("../includer"),
        assert = require("assert"),
        worker = require("../worker"),
        fakeMongo = require("./mock_classes/mongo"),
        fakeHttp = require("./mock_classes/http");

    var req,
        res,
        lastResponse,
        makeRequest;

    var SERVER_URL = "http://1.2.3.4/xxx/?";

    // Mock ups
    process.send = function() { };
    includer.setHttp(fakeHttp);
    includer.setMongo(fakeMongo);
    worker.createWorker();
    makeRequest = includer.http().makeRequest();

    suite("Basic functionality", function() {
        setup(function() {
            fakeHttp.resetCounter();
            fakeMongo.resetMongoResult();

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
                req.url = SERVER_URL + "001";
                makeRequest(req, res);

                var player = lastResponse.players[0];

                assert.equal(player.id, 1);
                assert.equal(player.status, "ok");
            });

            test("wrong request", function() {
                req.url = SERVER_URL + "wrong_request";
                makeRequest(req, res);

                assert.equal(lastResponse, "wrong request: query match error: wrong_request, url=http://1.2.3.4/xxx/?wrong_request\nserver=?");
            });

            test("generic request", function() {
                req.url = SERVER_URL + "1";

                makeRequest(req, res);

                var player = lastResponse.players[0];

                assert.equal(player.id, 1);
                assert.equal(player.status, "ok");
                assert.equal(player.name, "vovaPupkin");
                assert.equal(player.battles, 1160);
                assert.equal(player.wins, 544);
                assert.equal(player.eff, 525);
            });

            test("request with specific vehicle (update from WG)", function() {
                req.url = SERVER_URL + "1=T-28";
                makeRequest(req, res);

                var player = lastResponse.players[0],
                    vehicle = player.v;

                assert.equal(player.vname, "T-28");
                assert.equal(vehicle.name, "T-28");
                assert.equal(vehicle.l, 4);
                assert.equal(vehicle.b, 91);
                assert.equal(vehicle.w, 48);

                assert.equal(fakeHttp.getTotalRequests(), 1);
            });

            test("request with specific vehicle (update from DB)", function() {
                fakeMongo.setMongoResult("mongoItem.json");
                req.url = SERVER_URL + "1=T-28";
                makeRequest(req, res);

                var player = lastResponse.players[0],
                    vehicle = player.v;

                assert.equal(player.vname, "T-28");
                assert.equal(vehicle.name, "T-28");
                assert.equal(vehicle.l, 4);
                assert.equal(vehicle.b, 91);
                assert.equal(vehicle.w, 48);

                assert.equal(fakeHttp.getTotalRequests(), 0);
            });

            test("multiple players", function() {
                req.url = SERVER_URL + "1111=MS-1,2222=MS-1=1,3333=RenaultFT";

                makeRequest(req, res);

                //TODO is this checks enough?
                assert.equal(lastResponse.players[0].wn, 1294);
                assert.equal(lastResponse.players[1].wn, 917);
                assert.equal(lastResponse.players[2].wn, 462);
            });

            test("commands", function() {
                req.url = SERVER_URL + "0,WN,1111"; // id: 1111

                makeRequest(req, res);

                assert.ok(lastResponse.indexOf("LVL: 5.81") > -1);
            });
        });

        suite("mongo DB", function() {
            test("update", function() {
                req.url = SERVER_URL + "1=T-28";
                makeRequest(req, res);

                var lastUpdateRequest = fakeMongo.getLastUpdateRequest();

                assert.equal(lastUpdateRequest.key._id, 1);
                assert.ok(lastUpdateRequest.options.upsert);

                var item = lastUpdateRequest.item;

                assert.equal(item._id, 1);
                assert.equal(item.st, "ok");
                assert.equal(item.nm, "vovaPupkin");
                assert.equal(item.b, 1160);
                assert.equal(item.w, 544);
                assert.equal(item.e, 525);
                assert.equal(item.vname, "T-28");
            });
        });

        // TODO: error handling, statistics(?)
    });
})();