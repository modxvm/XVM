#!/bin/bash

print("Vehicle	hp	battles	wins	avgD	avgED	avgF	avgS	topD	topED	topF	topS	")

var doExport = function(x){
    if (x.region != "RU")
        return;
    var d = 0, ed = 0, f = 0, s = 0;
    for (var i in x.topD)
        d += x.topD[i];
    d /= x.topD.length;
    for (var i in x.topED)
        ed += x.topED[i];
    ed /= x.topED.length;
    for (var i in x.topF)
        f += x.topF[i];
    f /= x.topF.length;
    for (var i in x.topS)
        s += x.topS[i];
    s /= x.topS.length;
    print(x.vname.toLowerCase() + "	" +
        x.hp + "	" +
        x.b + "	" +
        x.w + "	" +
        (x.d / x.b).toFixed(0) + "	" +
        (x.d / x.b / x.hp).toFixed(2) + "	" +
        (x.f / x.b).toFixed(2) + "	" +
        (x.s / x.b).toFixed(2) + "	" +
        d.toFixed(0) + "	" +
        ed.toFixed(2) + "	" +
        f.toFixed(2) + "	" +
        s.toFixed(2))
}

db.vstat.find({}, {_id:0}).forEach(doExport)
