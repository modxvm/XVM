var assert = require("assert"),
    request = require("supertest"),
    worker = require("../worker"),
    sinon = require("sinon");

var dbName,
    makeRequest,
    req,
    res,
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
            update: function() { }
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
        callbacks.data(
            '{  "status": "ok",   "status_code": "NO_ERROR",   "data": {    "achievements": {      "medalCarius": 3,       "medalHalonen": 0,       "invader": 0,       "medalFadin": 0,       "armorPiercer": 1,       "medalEkins": 4,       "mousebane": 0,       "medalKay": 3,       "defender": 1,       "medalLeClerc": 3,       "supporter": 1,       "steelwall": 9,       "medalAbrams": 3,       "maxDiehardSeries": 3,       "medalPoppel": 3,       "medalOrlik": 0,       "maxKillingSeries": 2,       "handOfDeath": 0,       "sniper": 6,       "warrior": 0,       "titleSniper": 1,       "maxInvincibleSeries": 2,       "medalWittmann": 0,       "medalBurda": 0,       "maxPiercingSeries": 7,       "scout": 3,       "beasthunter": 0,       "kamikaze": 0,       "raider": 0,       "medalOskin": 0,       "medalBillotte": 0,       "medalLavrinenko": 3,       "medalKolobanov": 0,       "invincible": 0,       "lumberjack": 0,       "medalBoelter": 0,       "tankExpert": 0,       "diehard": 0,       "maxSniperSeries": 16,       "medalKnispel": 3    },     "ratings": {      "spotted": {        "place": 2377559,         "value": 727      },       "dropped_ctf_points": {        "place": 2348870,         "value": 543      },       "battle_avg_xp": {        "place": 2044663,         "value": 216      },       "xp": {        "place": 2225790,         "value": 250546      },       "battles": {        "place": 2282103,         "value": 1160      },       "damage_dealt": {        "place": 2250955,         "value": 225151      },       "ctf_points": {        "place": 2699654,         "value": 786      },       "integrated_rating": {        "place": 2238928,         "value": 1      },       "battle_avg_performance": {        "place": 2618781,         "value": 47      },       "frags": {        "place": 2259177,         "value": 542      },       "battle_wins": {        "place": 2289633,         "value": 544      }    },     "name": "squall1989",     "created_at": 1281653361.0,     "vehicles": [      {        "spotted": null,         "localized_name": "КВ-1",         "name": "KV1",         "level": 5,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 208,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-kv1.png",         "frags": null,         "win_count": 94,         "class": "heavyTank"      },       {        "spotted": null,         "localized_name": "СУ-26",         "name": "SU-26",         "level": 3,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 134,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-su-26.png",         "frags": null,         "win_count": 65,         "class": "SPG"      },       {        "spotted": null,         "localized_name": "Hetzer",         "name": "Hetzer",         "level": 4,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 125,         "nation": "germany",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/germany-hetzer.png",         "frags": null,         "win_count": 60,         "class": "AT-SPG"      },       {        "spotted": null,         "localized_name": "КВ-3",         "name": "KV-3",         "level": 7,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 96,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-kv-3.png",         "frags": null,         "win_count": 39,         "class": "heavyTank"      },       {        "spotted": null,         "localized_name": "Т-28",         "name": "T-28",         "level": 4,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 91,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-t-28.png",         "frags": null,         "win_count": 48,         "class": "mediumTank"      },       {        "spotted": null,         "localized_name": "Panzerjager I",         "name": "PanzerJager_I",         "level": 2,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 84,         "nation": "germany",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/germany-panzerjager_i.png",         "frags": null,         "win_count": 44,         "class": "AT-SPG"      },       {        "spotted": null,         "localized_name": "Marder II",         "name": "G20_Marder_II",         "level": 3,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 71,         "nation": "germany",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/germany-g20_marder_ii.png",         "frags": null,         "win_count": 39,         "class": "AT-SPG"      },       {        "spotted": null,         "localized_name": "AMX 40",         "name": "AMX40",         "level": 4,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 44,         "nation": "france",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/france-amx40.png",         "frags": null,         "win_count": 22,         "class": "lightTank"      },       {        "spotted": null,         "localized_name": "БТ-7",         "name": "BT-7",         "level": 3,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 40,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-bt-7.png",         "frags": null,         "win_count": 15,         "class": "lightTank"      },       {        "spotted": null,         "localized_name": "А-20",         "name": "A-20",         "level": 4,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 39,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-a-20.png",         "frags": null,         "win_count": 17,         "class": "lightTank"      },       {        "spotted": null,         "localized_name": "Т-46",         "name": "T-46",         "level": 3,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 31,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-t-46.png",         "frags": null,         "win_count": 14,         "class": "lightTank"      },       {        "spotted": null,         "localized_name": "СУ-18",         "name": "SU-18",         "level": 2,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 30,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-su-18.png",         "frags": null,         "win_count": 11,         "class": "SPG"      },       {        "spotted": null,         "localized_name": "Leichttraktor",         "name": "Ltraktor",         "level": 1,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 28,         "nation": "germany",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/germany-ltraktor.png",         "frags": null,         "win_count": 13,         "class": "lightTank"      },       {        "spotted": null,         "localized_name": "M2 Medium Tank",         "name": "M2_med",         "level": 3,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 26,         "nation": "usa",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/usa-m2_med.png",         "frags": null,         "win_count": 14,         "class": "mediumTank"      },       {        "spotted": null,         "localized_name": "БТ-2",         "name": "BT-2",         "level": 2,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 26,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-bt-2.png",         "frags": null,         "win_count": 9,         "class": "lightTank"      },       {        "spotted": null,         "localized_name": "AMX 38",         "name": "AMX38",         "level": 3,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 15,         "nation": "france",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/france-amx38.png",         "frags": null,         "win_count": 8,         "class": "lightTank"      },       {        "spotted": null,         "localized_name": "МС-1",         "name": "MS-1",         "level": 1,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 14,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-ms-1.png",         "frags": null,         "win_count": 5,         "class": "lightTank"      },       {        "spotted": null,         "localized_name": "АТ-1",         "name": "AT-1",         "level": 2,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 14,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-at-1.png",         "frags": null,         "win_count": 5,         "class": "AT-SPG"      },       {        "spotted": null,         "localized_name": "Т-26",         "name": "T-26",         "level": 2,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 13,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-t-26.png",         "frags": null,         "win_count": 8,         "class": "lightTank"      },       {        "spotted": null,         "localized_name": "СУ-5",         "name": "SU-5",         "level": 4,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 10,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-su-5.png",         "frags": null,         "win_count": 5,         "class": "SPG"      },       {        "spotted": null,         "localized_name": "Hotchkiss H35",         "name": "Hotchkiss_H35",         "level": 2,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 6,         "nation": "france",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/france-hotchkiss_h35.png",         "frags": null,         "win_count": 4,         "class": "lightTank"      },       {        "spotted": null,         "localized_name": "КВ-2",         "name": "KV2",         "level": 6,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 6,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-kv2.png",         "frags": null,         "win_count": 1,         "class": "heavyTank"      },       {        "spotted": null,         "localized_name": "T2 Medium Tank",         "name": "T2_med",         "level": 2,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 3,         "nation": "usa",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/usa-t2_med.png",         "frags": null,         "win_count": 1,         "class": "mediumTank"      },       {        "spotted": null,         "localized_name": "СУ-76",         "name": "SU-76",         "level": 3,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 3,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-su-76.png",         "frags": null,         "win_count": 1,         "class": "AT-SPG"      },       {        "spotted": null,         "localized_name": "M3 Stuart",         "name": "M3_Stuart_LL",         "level": 3,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 2,         "nation": "ussr",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/ussr-m3_stuart_ll.png",         "frags": null,         "win_count": 1,         "class": "lightTank"      },       {        "spotted": null,         "localized_name": "T1 Cunningham",         "name": "T1_Cunningham",         "level": 1,         "damageDealt": null,         "survivedBattles": null,         "battle_count": 1,         "nation": "usa",         "image_url": "/static/2.1.1/encyclopedia/tankopedia/vehicle/small/usa-t1_cunningham.png",         "frags": null,         "win_count": 1,         "class": "lightTank"      }    ],     "updated_at": 1347715163.0,     "battles": {      "spotted": 727,       "hits_percents": 40,       "capture_points": 786,       "damage_dealt": 225151,       "frags": 542,       "dropped_capture_points": 543    },     "summary": {      "wins": 544,       "losses": 604,       "battles_count": 1160,       "survived_battles": 237    },     "experience": {      "xp": 250546,       "battle_avg_xp": 216,       "max_xp": 963    },     "clan": {      "member": null,       "clan": null,       "clan_ext": null    }  }}'
        );
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
        req = { url: "http://1.2.3.4/xxx/?1" };
        res = {
            end: function(response) {
                lastResponse = JSON.parse(response);
            }
        };
    });

    teardown(function() {

    });

    suite("content", function() {
        test("Generic request", function() {
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