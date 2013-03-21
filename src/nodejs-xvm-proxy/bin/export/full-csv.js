// CONFIG

var limit = 0; // 10000;

var maxID = 2499999999;
var maxDamage = 7000;
var minB = 1000;
var minVB = function(level) { return level * 10; };
var minUpdated = Math.round((new Date()).getTime() / 1000) - 30*86400; // 30 days
var topCount = 200;

////////////////////////////////////////

var topData = { G:{}, RU:{}, EU:{}, US:{}, SEA:{} };

var fs = require("fs");
var vidata = require("./VehicleInfoData2").data;

var fdG = fs.openSync("_global.csv", "w");
fs.writeSync(fdG, "id;created;updated;name;battles;wins;spotted;hit_percent;captured;damage;frags;defence\n");
var fdV = fs.openSync("_vehicle.csv", "w");
fs.writeSync(fdV, "id;vn;vbattles;vwins;vdamage;vfrags;vspotted;vsurvived\n");

var strG = "";
var strV = "";
var flushStr = function()
{
    fs.writeSync(fdG, strG);
    strG = "";
    fs.writeSync(fdV, strV);
    strV = "";
}

var st = { n: 0, g: 0, v: 0 };
var processDoc = function(d) {
    st.n++;
    if (st.n % 1000 == 0)
        console.warn(JSON.stringify(st) + (d ? ", id=" + d._id : ""));
    if (st.n % 20 == 0)
        flushStr();

    if (!d || !d.v)
        return;
    if (!d.up || d.up < minUpdated)
        return;
    if (!d.b || d.b < minB)
        return;

    var region = getRegion(d._id);
    if (!region) {
        console.log("ERROR: BAD region for id=" + d._id);
        process.exit();
        return;
    }

    var sg =
        d._id + ";" +
        d.cr + ";" +
        d.up + ";" +
        d.nm + ";" +
        d.b + ";" +
        d.w + ";" +
        d.spo + ";" +
        d.hip + ";" +
        d.cap + ";" +
        d.dmg + ";" +
        d.frg + ";" +
        d.def + "\n";


    var sv = "";
    var nv = 0;
    for (vn in d.v) {
        var v = d.v[vn];

        // skip items without data
        if (!v.b || v.b < minVB(v.l) || !v.w || !v.d)
            continue;

        // stop on unknown tanks
        var vdata = vidata[vn.replace(/-/g, "_").toLowerCase()];
        if (!vdata) {
            console.log("ERROR: no vehicle info data for " + vn);
            process.exit();
            return;
        }
        var hp = vdata.hptop;

        // skip bad data
        var U = v.u / v.b * 100;
        var D = v.d / v.b;
        if (U > 100) {
            console.log("ERROR [U>100]: " + d._id + "[" + vn + "]: U=" + U.toFixed(2) + " B=" + v.b);
            //process.exit();
            return;
        }
        if (D > maxDamage) {
            console.log("ERROR [D>" + maxDamage + "]: " + d._id + "[" + vn + "]: D=" + D.toFixed(0) + " B=" + v.b);
            //process.exit();
            return;
        }

        nv++;
        sv += 
            d._id + ";" +
            vn + ";" +
            v.b + ";" +
            v.w + ";" +
            v.d + ";" +
            v.f + ";" +
            v.s + ";" +
            v.u + "\n";

        if (!topData["G"][vn])
            topData["G"][vn] = { topR:[], topD:[], topE:[], topF:[], topS:[], topU:[] };
        if (!topData[region][vn])
            topData[region][vn] = { topR:[], topD:[], topE:[], topF:[], topS:[], topU:[] };

        var td = topData["G"][vn];
        updateTopData(td.topR, v.w / v.b);
        updateTopData(td.topD, D);
        updateTopData(td.topE, D / hp);
        updateTopData(td.topF, v.f / v.b);
        updateTopData(td.topS, v.s / v.b);
        updateTopData(td.topU, U);

        var td = topData[region][vn];
        updateTopData(td.topR, v.w / v.b);
        updateTopData(td.topD, D);
        updateTopData(td.topE, D / hp);
        updateTopData(td.topF, v.f / v.b);
        updateTopData(td.topS, v.s / v.b);
        updateTopData(td.topU, U);

    }

    if (nv > 0) {
        strG += sg;
        strV += sv;
        st.g++;
        st.v += nv;
    }
};

var updateTopData = function(td, value) {
    if (td.length > topCount)
    {
        if (td[0] >= value)
            return;
        td.shift();
    }
    td.push(value);
    td = td.sort(function(a,b){ return a>b?1:a<b?-1:0 });
};

var exportVehicleInfoData = function() {
    var s = "";
    for (var i in vidata) {
        if (i == "unknown")
            continue;
        var v = vidata[i];
        s += v.name.toUpperCase() + ";" +
            v.level + ";" +
            v.type + ";" +
            v.hptop + ";" +
            v.premium + ";" +
            v.nation + ";" +
            v.name + "\n";
    }
    fs.writeFileSync("_vinfo.csv", "vn;level;class;hp;premium;nation;vname\n" + s);
};

var exportTopData = function() {
    var s = "";
    for (var region in topData) {
        for (var vn in topData[region])
        {
            var td = topData[region][vn];
            for (var i = 0; i < topCount; ++i) {
                var R = (td.topR.length > i ? td.topR[i] : "");
                var D = (td.topD.length > i ? td.topD[i] : "");
                var E = (td.topE.length > i ? td.topE[i] : "");
                var F = (td.topF.length > i ? td.topF[i] : "");
                var S = (td.topS.length > i ? td.topS[i] : "");
                var U = (td.topU.length > i ? td.topU[i] : "");
                if (R == "" && D == "" && E == "" && F == "" && S == "" && U == "")
                    break;
                s += region + ";" + vn + ";" +
                    R + ";" +
                    D + ";" +
                    E + ";" +
                    F + ";" +
                    S + ";" +
                    U + "\n";
            }
        }
    }
    fs.writeFileSync("_vtop.csv", "region;vn;topR;topD;topE;topF;topS;topU\n" + s);
};

// func

var getRegion = function(id) {
    if (id >= 2 && id <= 499999999)
        return "RU";
    if (id >= 500000000 && id <= 999999999)
        return "EU";
    if (id >= 1000000000 && id <= 1499999999)
        return "US";
    if (id >= 2000000000 && id <= 2499999999)
        return "SEA";
    return null;
};


// main

exportVehicleInfoData();

var mongo = require("mongodb");

// Connect to database
var options = {
    auto_reconnect: true,
    poolSize: 10
};

var db = new mongo.Db("xvm", new mongo.Server("localhost", 27017, options), { w:0 });
db.open(function(error, client) {
    var players = new mongo.Collection(client, "players");

    var cursor = players.find(
        {_id:{$lte:maxID}},
        {_id:1, cr:1, up:1, nm:1, b:1, w:1, spo:1, hip:1, cap:1, dmg:1, frg:1, def:1, v:1 },
        { sort: {_id:1}, limit: limit });
    cursor.each(function(error, doc) {
        if (doc)
            processDoc(doc);
        else {
            flushStr();
            exportTopData();
            process.exit();
        }
    });
});
