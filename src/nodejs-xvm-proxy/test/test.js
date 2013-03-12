(function() {
    var assert = require("assert"),
        fakeMongo = require("./mock_classes/mongo"),
        fakeHttp = require("./mock_classes/http"),
        db = require("../db")(fakeMongo),
        http = require("../factoryHttp")(fakeHttp);

    var req,
        res,
        lastResponse,
        makeRequest;

    process.send = function() { };

    suite("Basic functionality", function() {
        setup(function() {
            fakeHttp.resetCounter();
            fakeMongo.resetMongoResult();

            req = { url: "", params: { } };
            res = {
                json: function(status, response) {
                    var resp = typeof status === "number" ? response : status;

                    try {
                        lastResponse = JSON.parse(resp);
                    } catch(e) {
                        lastResponse = resp;
                    }
                },
                render: function(view, params) {
                    lastResponse = params;
                }
            };
        });

        teardown(function() {
            lastResponse = undefined;
            fakeMongo.resetLastUpdateRequest();
        });

        suite("diagnostic", function() {
            setup(function() {
                makeRequest = require("../routes/generic").test;
            });

            test("test request", function() {
                makeRequest(req, res);

                assert.equal(lastResponse.id, 1);
                assert.equal(lastResponse.status, "ok");
            });
        });

        suite("responses", function() {

            //TODO how to test?
            /*test("wrong request", function() {
                req.params = SERVER_URL + "wrong_request";
                makeRequest(req, res);

                assert.equal(lastResponse, "wrong request: query match error: wrong_request, url=http://1.2.3.4/xxx/?wrong_request\nserver=?");
            });*/

            setup(function() {
                makeRequest = require("../routes/generic").stat;
            });

            test("generic request", function() {
                req.params.ids = [ "1111" ];
                makeRequest(req, res);

                var player = lastResponse.players[0];

                assert.equal(player.id, 1111);
                assert.equal(player.status, "cache");
                assert.equal(player.name, "vitsu");
                assert.equal(player.battles, 4908);
                assert.equal(player.wins, 2566);
                assert.equal(player.lvl, 5.81);
                assert.equal(player.eff, 1156);
                assert.equal(player.wn, 1294);
                assert.equal(player.twr, 53);
            });

            test("request with specific vehicle (update from WG)", function() {
                req.params.ids = [ "1=T-28" ];
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
                req.params.ids = [ "1111=T-28" ];
                makeRequest(req, res);

                var player = lastResponse.players[0],
                    vehicle = player.v;

                assert.equal(player.vname, "T-28");
                assert.equal(vehicle.name, "T-28");
                assert.equal(vehicle.l, 4);
                assert.equal(vehicle.b, 42);
                assert.equal(vehicle.w, 22);

                assert.equal(fakeHttp.getTotalRequests(), 0);
            });

            test("multiple players", function() {
                req.params.ids = [ "1111=MS-1", "2222=MS-1=1", "3333=RenaultFT" ];
                makeRequest(req, res);

                //TODO is this checks enough?
                assert.equal(lastResponse.players[0].wn, 1294);
                assert.equal(lastResponse.players[1].wn, 917);
                assert.equal(lastResponse.players[2].wn, 462);
            });

        });

        suite("commands", function() {

            test("WN", function() {
                makeRequest = require("../routes/command").wn;
                req.params.playerId = "1111";
                makeRequest(req, res);

                assert.equal(lastResponse.title, "WN");

                var resp = lastResponse.db;

                assert.equal(resp.nm, "vitsu");
                assert.equal(resp.lvl, 5.81);
                assert.equal(resp.admg, 762);
            });

            test("INFO by id", function() {
                makeRequest = require("../routes/command").infoById;
                req.params.playerId = "1111";
                makeRequest(req, res);

                assert.equal(lastResponse[0]._id, 1111);
                assert.equal(lastResponse[0].nm, "vitsu");
            });

            test("INFO by name", function() {
                makeRequest = require("../routes/command").infoByName;
                req.params.playerName = "vitsu";
                req.params.region = "RU";
                makeRequest(req, res);

                assert.equal(lastResponse[0]._id, 1111);
                assert.equal(lastResponse[0].nm, "vitsu");
            });

            test("INFO by name or id", function() {
                makeRequest = require("../routes/command").infoByNameId;
                req.params.playerName = "1111";
                req.params.region = "RU";
                makeRequest(req, res);

                assert.equal(lastResponse[0]._id, 1111);
                assert.equal(lastResponse[0].nm, "vitsu");
            });

        });

        suite("mongo DB", function() {

            setup(function() {
                makeRequest = require("../routes/generic").stat;
            });

            test("update", function() {
                req.params.ids = [ "1=T-28" ];
                makeRequest(req, res);

                var lastUpdateRequest = fakeMongo.getLastUpdateRequest(),
                    item = lastUpdateRequest.item;

                assert.equal(lastUpdateRequest.key._id, 1);
                assert.ok(lastUpdateRequest.options.upsert);

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