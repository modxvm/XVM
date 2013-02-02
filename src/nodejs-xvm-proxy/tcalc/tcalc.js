module.exports = (function() {

    var def = require('./tcalc_defines.js'),
        tcalc_utils = require('./tcalc_utils.js');

    // PUBLIC

    calc = function(data, isLog) {
        var start = new Date();

        var log = "";

        if (isLog) {
            log = "ID: " + data._id +
                ", Nick: <a href='http://worldoftanks.ru/community/accounts/" + data._id + "-" + data.nm + "/'>" + data.nm + "</a>\n";
            log += "--------------------------\n\n";
        }

        // TODO: remove this legacy code
        if (data.v instanceof Array) {
            var v = {};
            for (var i in data.v) {
                var a = data.v[i];
                v[a.name] = a;
                delete v[a.name].name;
            }
            data.v = v;
        }
        // [/TODO]

        log += parseStatData(data, isLog);

        if (isLog) {
            log += "--------------------------\n\n";
            log += "Battles: " + data.battles + "\n\n";
        }
        if (data.battles > def.FILTER_BATTLES_LOW_LIMIT)
            log += delFirst(data, def.DEL_FIRST_COUNT, isLog);

        data.v.sort(function(a,b){ return b.b - a.b; });

        if (isLog)
            log += "\nCalculation:\n";

        for (var i in data.v)
            log += calculate(data, data.v[i], 0, isLog) + "\n";
        if (isLog) {
            log += "--------------------------\n\n";

            log += "\n\nBegin winrate is: " + (tcalc_utils.getAvgRate(data) || 0).toFixed(2) + "\n";
            log += "rate\tT-rate\tKa\tKd\tTank\n";
            for (var i in data.v)
            {
                var vdata = data.v[i];
                log += vdata.rate.toFixed(2) + "\t" + 
                    vdata.rate_plus.toFixed(2) + "\t" + 
                    vdata.acc.toFixed(2) + "\t" + 
                    damage(vdata).toFixed(2) + "\t" + 
                    vdata.name + "\n";
            }
        }

        var ro = tcalc_utils.getAvgRatePlus(data, isLog);
        var result = ro.result;

//        if (isLog) {
            log += ro.log;
            log += "\nCorrected winrate is: " + (result || 0).toFixed(2) + "\n";

            log += "\ncalculate() duration: " + (new Date() - start) + "ms\n";

//        console.log("twr: " + (new Date() - start) + " ms (" + JSON.stringify(data).length + " bytes)");
//        }

        return { log: log, result: result || 0 };
    }

    //////////////////////////////////////////////////////////////////
    // MAIN CALCULATION

    // recursive engine
    calculate = function(data, vdata, step, isLog) {
        if (!step)
            step = 1;
        var indent = Array(step).join("  ");

        var log = "";
        if (isLog) {
            log = indent + "Begin for " + vdata.name + " b=" + vdata.b + " r=" + vdata.rate.toFixed(2) +
                " acc=" + vdata.acc.toFixed(2) + " dmg=" + damage(vdata).toFixed(2) + "\n";
        }

        // do not cut rate lower 45%
        if (vdata.rate < 45)
            vdata.rate_plus = vdata.rate;

        // check for already actualized data
        if (vdata.rate_plus) {
            if (isLog)
                log += indent + "Return good rate for " + vdata.name + ": " + vdata.rate_plus.toFixed(2) + "\n";
            return log;
        }

        var rate = cutter(vdata); // a little cut stat by damage
        var n = 1;

        var m = search(data, vdata);

        var c = cutter(vdata);
        var c0 = vdata.same[0] ? cutter(vdata.same[0].vdata) : 0;
        var c1 = vdata.same[1] ? cutter(vdata.same[1].vdata) : 0;
        var c2 = vdata.same[2] ? cutter(vdata.same[2].vdata) : 0;
        var cd = m ? (c0 + c1 + c2) / m : 0;

        if (m && vdata.b < 300 && cd > c) {
            vdata.rate += Math.min(5 - vdata.b / 100, cd - c);
            if (isLog)
                log += indent + "  Rate of " + vdata.name + " increased to " + vdata.rate.toFixed(2) + "\n";
        }

        // if trusted tank or not worse then similar tanks
        if ((damage(vdata) * (vdata.l + 10) + vdata.acc * (21 - vdata.l)) / 31 > 1 - 0.1 * step || (cd > vdata.rate)) {
            vdata.rate_plus = rate;
            if (isLog)
                log += indent + "Return cutted rate for " + vdata.name + ": " + vdata.rate_plus.toFixed(2) + "\n";
            return log;
        }

        if (isLog)
            log += indent + "  Similar tanks:\n";

        // search similar tanks, m - count
        if(!m) {
            if (isLog)
                log += indent + "    no similar tanks\n";
        } else {
            var s = "";
            for (var i = 0; i < m; ++i)
            {
                var same = vdata.same[i].same * 100;
                var vd = vdata.same[i].vdata;
                s += (s == "" ? indent + "    " : ", ") + "(" + same.toFixed() + "%) " +
                    vd.name + " b=" + vd.b + " r=" + vd.rate.toFixed(2);
            }

            if (isLog)
                log += s + "\n";

            for (var i = 0; i < m; ++i) {
                if (!vdata.same[i])
                    break;
                var vd = vdata.same[i].vdata;
                if (isLog)
                    log += indent + "  See other tank " + vd.name + "\t" + vd.rate.toFixed(2) + "\n";
                if (vd.rate_plus) {
                    // summ similar tanks if already calculated
                    if (isLog)
                        log += indent + "  Add good rate for " + vdata.name + ": " + vd.rate_plus.toFixed(2) + "\n";
                    rate += vd.rate_plus;
                    n++;
                }
                else if ((damage(vdata) * (vdata.l + 10) + vdata.acc * (21 - vdata.l)) / 31 > 1 - 0.1 * step) {
                    // if not calculated deeper and trunt their stat - also summ, but cut before
                    var cr = cutter(vdata);
                    rate += cr;
                    if (isLog)
                        log += indent + "  Add cutted rate for " + vdata.name + ": " + cr.toFixed(2) + "\n";
                    n++;
                }
                else {
                    // if don't trust - search deeper
                    if (isLog)
                        log += indent + "  Check other tank\n";
                    vdata.stack = 1;
                    log += calculate(data, vd, step + 1, isLog);
                    rate += vd.rate_plus;
                    n++;
                    delete vdata.stack;
                }
            }
        }

        vdata.rate_plus = rate / n;
        if (isLog)
            log += indent + "Return middle rate of " + vdata.name + ": " + vdata.rate_plus.toFixed(2) + "\n";
        return log;
    }

    // calculate sufficient damage
    damage = function(vdata) {
        if (vdata.__damage == undefined) {
            var dmg = 0;
            if (vdata.link.dam55)
                dmg = vdata.damage / (vdata.link.dam55 + vdata.link.dam5 * (vdata.rate - 55) / 5);
            else {
                var hp = vdata.link.hp;
                switch (vdata.cl) {
                    case "HT":  dmg = vdata.damage / (hp * (20 + vdata.rate - 55) / 20); break;
                    case "TD":  dmg = vdata.damage / (hp * 1.2 * (20 + vdata.rate - 55) / 20); break;
                    case "SPG": dmg = vdata.damage / (hp * 3.2 * (20 + vdata.rate - 55) / 20); break;
                    case "LT":  dmg = vdata.damage / (hp * 0.7 * (20 + vdata.rate - 55) / 20); break;
                    case "MT":  dmg = vdata.damage / (hp * (20 + vdata.rate - 55) / 20); break;
                    default:    dmg = 0; break;
                }
            }
            vdata.__damage = dmg;
        }
        return vdata.__damage;
    }

    // cutter by damage
    cutter = function(vdata) {
        if (!vdata)
            return 0;
        if (vdata.__cutter == undefined) {
            var rate = (vdata.rate - 45) * (damage(vdata) * (vdata.l + 10) + vdata.acc * (21 - vdata.l)) / 31 + 45;
            vdata.__cutter = (rate > vdata.rate) ? vdata.rate : rate;
        }
        return vdata.__cutter;
    }

    // search similar tanks
    search = function(data, vdata) {
        var sames = [];
        for (var i in data.v) {
            var vd = data.v[i];
            if (vdata.name == vd.name)
                continue;
            if (vd.stack == 1)
                continue;
            var same = 0;
            if (vdata.cl == vd.cl)
                same++;
            else if (vdata.cl == "SPG" || vd.cl == "SPG")
                same -= 2;
            else if (vdata.cl == "LT" && (vd.cl != "MT" || vd.l < 8))
                same--;
            same += 1 - Math.abs(vdata.link.hp - vd.link.hp) / (vdata.link.hp + vd.link.hp) * 2;
            same += 1 - Math.abs(vdata.link.speed - vd.link.speed) / (vdata.link.speed + vd.link.speed) * 2;
            same += 1 - Math.abs(vdata.link.turn - vd.link.turn) / (vdata.link.turn + vd.link.turn) * 2;
            same += 1 - Math.abs(vdata.link.see - vd.link.see) / (vdata.link.see + vd.link.see) * 2;
            same += vdata.acc;
            same = same / 6;

            sames.push({ same: same, vdata: vd });
        }

        sames.sort(function(a,b){ return b.same-a.same; });
        vdata.same = [];
        for (var i = 0; i < Math.min(3, sames.length); ++i) {
            if (sames[i].same >= 0.5)
                vdata.same.push(sames[i]);
        }

        return vdata.same.length;
    }


    return {
        calc: calc
    }
})();
