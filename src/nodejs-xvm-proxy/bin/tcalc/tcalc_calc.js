module.exports = (function() {

    var sdata;

    log = function(str) { console.log(str); }

    init = function(data) {
        sdata = data;
    }

    // recursive engine
    calculate = function(vdata, step) {
        if (!step)
            step = 1;

        var rate = cutter(vdata);
        vdata.stack = 1;

        log("Begin for " + vdata.name + "\t" + vdata.rate + "\t" + vdata.link.acc + "\t" + damage(vdata));

        // check for already actualized data
        if (vdata.rate_plus) {
            log("Return good rate " + vdata.rate_plus);
            vdata.stack = 0;
            return vdata.rate_plus;
        }

        // search similar tanks, m - count
        var m = search(vdata);

        // if trusted tank or not worse then similar tanks
        if ((damage(vdata) * (vdata.level + 10) + vdata.link.acc * (21 - vdata.level)) / 31 > 1 - 0.1 * step ||
            (cutter(vdata.same[0]) + cutter(vdata.same[1]) + cutter(vdata.same[2])) / m > vdata.rate
        ) {
            vdata.rate_plus = cutter(vdata); // a little cut stat by damage
            log("Return cutted rate " + vdata.rate_plus);
            vdata.stack = 0;
            return vdata.rate_plus;
        }

        log("Same tanks:  ");
        var s = "";
        for (var i = 0; i < m; ++i)
            s += (s == "" ? "  " : "\t") + vdata.same[i].name + " " + vdata.same[i].rate;
        log(s);

        if(!m)
            log("nobody");

        for (var i = 0; i < m; ++i) {
            if (!vdata.same[i])
                break;
            log("See other tank " + vdata.same[i].name + "\t" + vdata.same[i].rate);
            if (vdata.same[i].rate_plus) {
                // summ similar tanks if already calculated
                log("Add good rate " + vdata.same[i].rate_plus);
                rate += vdata.same[i].rate_plus;
            }
            else if ((damage(vdata) * (vdata.level + 10) + vdata.link.acc * (21 - vdata.level)) / 31 > 1 - 0.1 * step) {
                // if not calculated deeper and trunt their stat - also summ, but cut before
                log("Add cutted rate " + cutter(vdata.same[i]));
                rate += cutter(vdata.same[i]);
            }
            else {
                // if don't trust - search deeper
                log("Check other tank");
                rate += calculate(vdata.same[i], step + 1);
            }
        }

        vdata.stack = 0;
        vdata.rate_plus = rate / (i + 1);
        log("Return middle rate of " + vdata.name + " " + vdata.rate_plus.toFixed(2));
        return vdata.rate_plus;
    }

    // calculate sufficient damage
    damage = function(vdata) {
        var hp = vdata.link.hp;

        if (vdata.link.dam55)
            return vdata.damage / (vdata.link.dam55 + vdata.link.dam5 * (vdata.rate - 55) / 5);

        switch (vdata.type) {
            case "HT":  return vdata.damage / (hp * (20 + vdata.rate - 55) / 20);
            case "TD":  return vdata.damage / (hp * 1.2 * (20 + vdata.rate - 55) / 20);
            case "SPG": return vdata.damage / (hp * 3.2 * (20 + vdata.rate - 55) / 20);
            case "LT":  return vdata.damage / (hp * 0.7 * (20 + vdata.rate - 55) / 20);
            case "MT":  return vdata.damage / (hp * (20 + vdata.rate - 55) / 20);
            default: return 0;
        }
    }

    // cutter by damage
    cutter = function(vdata) {
        if (!vdata)
            return 0;
        var rate = (vdata.rate - 45) * (damage(vdata) * (vdata.level + 10) + vdata.link.acc * (21 - vdata.level)) / 31 + 45;
        return (rate > vdata.rate) ? vdata.rate : rate;
    }

    // search similar tanks
    search = function(vdata) {
        //long int i,j, max;
        //float same[300];
        //     float max_same;

        var sames = [];
        for (var i in sdata.vehicles) {
            var vd = sdata.vehicles[i];
            if (vdata.name == vd.name)
                continue;
            var same = 0;
            if (vdata.type == vd.type)
                same++;
            else if (vdata.type == 3 || vd.type == 3)
                same--;
            //same += 1 - Math.abs(vdata->link->level-base[i].link->level)*0.1;
            same += 1 - Math.abs(vdata.link.hp - vd.link.hp) / (vdata.link.hp + vd.link.hp) * 2;
            same += 1 - Math.abs(vdata.link.speed - vd.link.speed) / (vdata.link.speed + vd.link.speed) * 2;
            same += 1 - Math.abs(vdata.link.turn - vd.link.turn) / (vdata.link.turn + vd.link.turn) * 2;
            same += 1 - Math.abs(vdata.link.see - vd.link.see) / (vdata.link.see + vd.link.see) * 2;
            same += vdata.link.acc;
            same = same / 6;

            log(vdata.name + "\t" + vd.name + "\t\t\t\t" + same);
            sames.push({ same: same, vd: vd });
        }

        sames.sort(function(a,b){ return b.same-a.same; });
        vdata.same = [];
        for (var i = 0; i < sames.length; ++i)
            vdata.same.push(sames[i].vd);

        return vdata.same.length;
    }


    return {
        init: init,
        damage: damage,
        calculate: calculate
    }
})();
