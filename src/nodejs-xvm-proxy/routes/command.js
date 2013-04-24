var db = require("../db"),
    utils = require("../utils");

exports.wn = function(req, res) {
    db.getPlayersData([ parseInt(req.params.playerId) ], function(error, dbData) {
        var data;

        if(!error) {
            data = dbData[0];
            if(data) {
                data.eff = utils.calculateEfficiency(data);
                data.neff = utils.calculateNEFF(data.eff);
                data.wn6 = utils.calculateWN(data);
                data.nwn6 = utils.calculateNWN(data.wn6);
                data.gwr = (data.w / data.b * 100).toFixed(2);
                data.twr = utils.tcalc(data, false).result.toFixed(2);

                data.admg = (data.dmg / data.b).toFixed(0);
                data.afrg = (data.frg / data.b).toFixed(1);
                data.aspo = (data.spo / data.b).toFixed(1);
                data.adef = (data.def / data.b).toFixed(1);
                data.acap = (data.cap / data.b).toFixed(1);

                data.created = new Date(data.cr * 1000);
                data.updated = new Date(data.up * 1000);
            }
        }

        res.render("wn", {
            error: error,
            title: "WN",
            playerId: req.params.playerId,
            db: data
        });
    });
};

exports.infoById = function(req, res) {
    utils.send({ type: "usage", cmdInfo: 1 });
    db.getPlayersData([ parseInt(req.params.playerId) ], function(error, dbData) {
        res.json(error ? 500 : 200, dbData);
    });
};

exports.infoByName = function(req, res) {
    utils.send({ type: "usage", cmdInfo: 1 });
    db.getPlayerByName(req.params.playerName, req.params.region, function(error, dbData) {
        res.json(error ? 500 : 200, dbData);
    });
};

exports.infoByNameId = function(req, res) {
    utils.send({ type: "usage", cmdInfo: 1 });
    db.getPlayerByNameId(req.params.playerName, function(error, dbData) {
        res.json(error ? 500 : 200, dbData);
    });
};