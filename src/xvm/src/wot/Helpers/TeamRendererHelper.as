/**
 * Helper class for shared functions used in the players lists renderers in the hangar
 */
import net.wargaming.managers.ToolTipManager;
import wot.utils.Cache;
import wot.utils.Defines;
import wot.utils.GraphicsUtil;
import wot.utils.Locale;
import wot.utils.Utils;

class wot.Helpers.TeamRendererHelper
{
    public static function CreateXVMHeaderLabel(wnd:MovieClip, name:String, styleFld:TextField,
        offsetX:Number, offsetY:Number, tipName:String)
    {
        if (!wnd[name] || wnd[name + "XVM"])
            return;

        var res = Utils.duplicateTextField(wnd, name + "XVM", styleFld, 0, "left");
        res._x = wnd[name]._x + offsetX;
        res._y = wnd[name]._y + offsetY;
        res.htmlText = "<span class='xvm_" + name + "XVM'><font color='#" +
            wnd[name].textColor.toString(16) + "'>xwn</font></span>";

        var b = wnd.attachMovie("Button", name + "XVMHolder", wnd.getNextHighestDepth());
        b._x = res._x - 5;
        b._y = res._y;
        b.setSize(30, 20);
        b._alpha = 0;
        b.addEventListener("rollOver", function() {
            ToolTipManager.instance.show(Locale.get(tipName));
        });
        b.addEventListener("rollOut", function() {
            ToolTipManager.instance.hide();
        });

        return res;
    }

    public static function GetToolTipData(stat)
    {
        var dt = stat.dt ? stat.dt.split("T").join(" ").substr(0, 10) : Locale.get("unknown");

        var s = "";
        // line 1
        s += Locale.get("EFF") + ": " + (!stat.e ? "--" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xeff) + "'>" + (stat.xeff == 100 ? "XX" : (stat.xeff < 10 ? "0" : "") + stat.xeff) + "</font>") + " ";
        s += "(" + (!stat.e ? "-" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, stat.e) + "'>" + stat.e + "</font>") + ") ";
        s += "WN6: " + (!stat.wn ? "--" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn) + "'>" + (stat.xwn == 100 ? "XX" : (stat.xwn < 10 ? "0" : "") + stat.xwn) + "</font>") + " ";
        s += "(" + (!stat.wn ? "-" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN, stat.wn) + "'>" + stat.wn + "</font>") + ")\n";
        // line 2
        s += Locale.get("Fights") + ": " + (!stat.b ? "-" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, stat.b / 1000) + "'>" + stat.b + "</font>") + " ";
        s += Locale.get("Wins") + ": " + (!stat.r ? "-" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, stat.r) + "'>" + stat.r + "%</font>") + " ";
        s += "TWR: " + (!stat.twr ? "-" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TWR, stat.twr) + "'>" + stat.twr + "%</font>") + "\n";
        // line 3
        // line 4
        s += "<hr>" + Locale.get("Data was updated at") + ": <font color='#CCCCCC'>" + dt + "</font>";

/*        if (list.selectedIndex == 0)
        {
            m_statisticsHeaderField.htmlText = "";
            var spo = m_userData.spo / b;
            var def = m_userData.def / b;
            var cap = m_userData.cap / b;
            m_statisticsField2.htmlText = "<span class='xvm_statisticsField'>" +
                Locale.get("Avg level") + ": <font color='#ffc133'>" +
                    (m_userData.lvl ? Sprintf.format("%.1f", m_userData.lvl) : "-") + "</font> " +
                Locale.get("Spotted") + ": <font color='#ffc133'>" +
                    (spo ? Sprintf.format("%.2f", spo) : "-") + "</font> " +
                Locale.get("Defence") + ": <font color='#ffc133'>" +
                    (def ? Sprintf.format("%.2f", def) : "-") + "</font> " +
                Locale.get("Capture") + ": <font color='#ffc133'>" +
                    (cap ? Sprintf.format("%.2f", cap) : "-") + "</font> " +
                "</span>";
        }
        else
        {
            m_statisticsHeaderField.htmlText = "<span class='xvm_statisticsHeader'>" + Locale.get("player (average / top)") + "</span>";
            var data = list.dataProvider[list.selectedIndex];
            if (!data)
                m_statisticsField2.htmlText = "";
            else
            {
                //Logger.addObject(blocksArea, "blocksArea", 3);
                //Logger.addObject(data);
                var tb = extractNumber(blocksArea.blockcommon.itembattlesCount.value.text);
                var tw = extractNumber(blocksArea.blockcommon.itemwins.value.text);
                var td = extractNumber(blocksArea.blockbattleeffect.itemdamageDealt.value.text);
                var tf = extractNumber(blocksArea.blockbattleeffect.itemfrags.value.text);
                var vn = VehicleInfo.getVehicleName(data.icon);
                vn = vn.slice(vn.indexOf("-") + 1).toUpperCase();
                var stat = {
                    tb: tb,
                    tw: data.w,
                    tl: data.level,
                    vn: vn,
                    td: td,
                    tf: tf,
                    ts: data.ts
                };
                stat = StatLoader.CalculateStatValues(stat, true);
                //Logger.addObject(stat);

                var effd = td / tb / data.hp || 0;
                var e_color = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_E, stat.te);
                var s2 = "";
                s2 += "E: " + (!stat.teff ? "-" :
                    "<font color='" + e_color + "'>" + (stat.te < 10 ? stat.te : "X") + "</font> (<font color='" + e_color + "'>" + stat.teff + "</font>)") + "  ";
                s2 += Locale.get("Eff damage") + ": " + (!effd ? "-" :
                    "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, effd) + "'>" + Sprintf.format("%.2f", effd) + "</font>") + " ";
                s2 += "(<font color='#ffc133'>" + (data.avgED ? Sprintf.format("%.2f", data.avgED) : "-") + "</font>" +
                    " / <font color='#ffc133'>" + (data.topED ? Sprintf.format("%.2f", data.topED) : "-") + "</font>)  ";
                s2 += Locale.get("Spotted") + ": " + (!data.tsb ? "-" :
                    "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, data.tsb) + "'>" + Sprintf.format("%.2f", data.tsb) + "</font>") + " ";
                s2 += "(<font color='#ffc133'>" + (data.avgS ? Sprintf.format("%.2f", data.avgS) : "-") + "</font>" +
                    " / <font color='#ffc133'>" + (data.topS ? Sprintf.format("%.2f", data.topS) : "-") + "</font>)  ";
                m_statisticsField2.htmlText = "<span class='xvm_statisticsField'>" + s2 + "</span>";
            }
        }
*/
        return s;
    }

    public static function setXVMStat(key, textField)
    {
        var stat = Cache.Get(key);
        textField.htmlText = "<span class='xvm_eff'>" + (!stat.wn ? "--" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn) + "'>" + (stat.xwn == 100 ? "XX" : (stat.xwn < 10 ? "0" : "") + stat.xwn) + "</font>") + "</span>";
        return stat;
    }
}
