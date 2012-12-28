var fs = require('fs'),
    def = require('./tcalc_defines.js'),
    calc = require('./tcalc_calc.js');

var sdata = null;
var tanks = {};

// log helper
log = function(str) { console.log(str); }
debug_enabled = true;
debug = function(str) { if (debug_enabled) console.log("DEBUG: " + str); }

// DEBUG
debug_main = function() {
    fs.readFile('data.json', 'utf8', function (err,data) {
        if (err)
            return log(err);
        sdata = JSON.parse(data);
        main();
    });
}
// END DEBUG

// Parse base.csv file
parseBaseCsv = function(data) {
    lines = data.split(/\r?\n/g);
    for (var lineId in lines) {
        var line = lines[lineId].trim().split(";");
        if (line.length <= 1)
            continue;
        if (line.length != 12)
            return log("Error: format error in base.csv:\n  " + lines[lineId]);

        tanks[line[3].toLowerCase()] = {
            // skip [0] - vehicle country
            // skip [1] - vehicle type
            // skip [2] - vehicle level
            level: parseInt(line[2]),
            name: line[3],
            hp: parseInt(line[4]),
            speed: parseFloat(line[5].replace(",", ".")),
            turn: parseFloat(line[6].replace(",", ".")),
            see: parseFloat(line[7].replace(",", ".")),
            acc: parseFloat(line[8].replace(",", ".")),
            dam55: parseFloat(line[9].replace(",", ".")),
            dam5: parseFloat(line[10].replace(",", "."))
        };
    }
}

// Parse user stats
parseStatData = function(data) {
    data.battles = 0; // total count of "good" battles (more 100 battles for tank)
    var vd = {}; // associative array of vehicles data with vehicle name as key
    for (var vId in data.vehicles) {
        var vdata = data.vehicles[vId];
        if (vdata.battle_count <= def.MIN_VEHICLE_BATTLES)
            continue;
        vdata.link = tanks[vdata.name.toLowerCase()];
        if (!vdata.link) {
            log("WARNING: No data in base.csv for " + vdata.name);
            continue;
        }
        data.battles += vdata.battle_count;
        vdata.damage = vdata.damageDealt / vdata.battle_count;
        vdata.rate = vdata.win_count / vdata.battle_count * 100;
        vdata.type = def.CLASS_TO_TYPE[vdata.class];
        vd[vdata.name.toLowerCase()] = vdata;
    }
    // replace original array with filtered associative array
    data.vehicles = vd;
}

// remove battles with bad stats (teaching)
delFirst = function(battles) {
    var vd = [];
    for (var i in sdata.vehicles) {
        var vdata = sdata.vehicles[i];

        // skip top tanks (level 8+)
        if (vdata.level >= 8)
            continue;

        // skip tanks with good percent
        if (vdata.rate >= 53)
            continue;

        vd.push(vdata);
    }

    vd.sort(function(a,b){ return a.rate-b.rate; });
    while (battles > 0 && vd.length > 0) {
        var vdata = vd.shift();
        battles -= vdata.battle_count;
        debug("Deleted: b=" + vdata.battle_count + "\t%=" + Math.round(vdata.rate) + "\t" + vdata.name);
        delete sdata.vehicles[vdata.name.toLowerCase()];
    }
}

// calculate average win rate
getAvgRate = function() {
    var b = 0, w = 0;
    for (var vname in sdata.vehicles)
    {
        var vdata = sdata.vehicles[vname];
        b += vdata.battle_count;
        w += vdata.win_count;
    }

    return w / b * 100;
}

// calculate average corrected win rate
getAvgRatePlus = function() {
    var b = 0, w = 0;
    for (var vname in sdata.vehicles)
    {
        var vdata = sdata.vehicles[vname];
        b += vdata.battle_count;
        w += vdata.rate_plus * vdata.battle_count / 100;
    }

    return w / b * 100;
}

// read and parse base.csv
main = function() {
    fs.readFile('base.csv', 'utf8', function (err,data) {
        if (err)
            return log(err);

        sdata = sdata.data;

        parseBaseCsv(data);

        main2();
    });
}

main2 = function() {
    parseStatData(sdata);

    log("Battles: " + sdata.battles + "\n");
    if (sdata.battles > def.FILTER_BATTLES_LOW_LIMIT)
        delFirst(1000);

    log("\nCalculating");
    calc.init(sdata);
    for (var vname in sdata.vehicles)
    {
        var vdata = sdata.vehicles[vname];
        vdata.rate_plus = calc.calculate(vdata);
    }

    log("\nBegin winrate is: " + getAvgRate().toFixed(2));
    log("rate\tT-rate\tKa\tKd\tTank");
    for (var vname in sdata.vehicles)
    {
        var vdata = sdata.vehicles[vname];
        log(vdata.rate.toFixed(2) + "\t" + 
            vdata.rate_plus.toFixed(2) + "\t" + 
            vdata.link.acc.toFixed(4) + "\t" + 
            calc.damage(vdata).toFixed(4) + "\t" + 
            vdata.name);
    }
    log("\nCorrected winrate is: " + getAvgRatePlus().toFixed(2));
}


// MAIN
debug_main();
//main();
