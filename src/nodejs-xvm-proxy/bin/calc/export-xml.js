#!/bin/bash

var doExport = function(x){
    if (x.region != "RU")
        return;
    var d = 0, ed = 0, f = 0, s = 0;

/*    for (var i in x.topD)
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
    s /= x.topS.length;*/

    d = parseInt(x.topD[0]);
    ed = parseInt(x.topED[0]);
    f = parseInt(x.topF[0]);
    s = parseInt(x.topS[0]);

    print("<v>" +
        "<vname>" + x.vname.toLowerCase() + "</vname>" +
        "<level>" + x.l + "</level>" +
        "<class>" + x.cl + "</class>" +
        "<hp>" + x.hp + "</hp>" +
        "<b>" + x.b + "</b>" +
        "<w>" + x.w + "</w>" +
        "<avgD>" + (x.d / x.b).toFixed(0) + "</avgD>" +
        "<avgED>" + (x.d / x.b / x.hp).toFixed(2) + "</avgED>" +
        "<avgF>" + (x.f / x.b).toFixed(2) + "</avgF>" +
        "<avgS>" + (x.s / x.b).toFixed(2) + "</avgS>" +
        "<topD>" + d.toFixed(0) + "</topD>" +
        "<topED>" + ed.toFixed(2) + "</topED>" +
        "<topF>" + f.toFixed(2) + "</topF>" +
        "<topS>" + s.toFixed(2) + "</topS>" +
        "</v>");
}

print("<vstat>");
db.vstat.find({}, {_id:0}).forEach(doExport);
print("</vstat>");