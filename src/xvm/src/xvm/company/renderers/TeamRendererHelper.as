/**
 * Helper class for shared functions used in the players lists renderers in the hangar
 */
package xvm.company.renderers
{
    import com.xvm.*;
    import com.xvm.types.stat.*;
    import com.xvm.utils.*;
    import net.wg.gui.prebattle.squad.*;

    public class TeamRendererHelper
    {
        public static function formatXVMStatText(playerName:String):String
        {
            var pname:String = WGUtils.GetPlayerName(playerName);
            var stat:StatData = Stat.getUserDataByName(pname);
            if (stat == null)
                return "";
            if (Config.config.hangar.xwnInCompany == true)
            {
                return isNaN(stat.wn8) ? "--" :
                    "<font color='" + MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn8) + "'>" +
                    (stat.xwn8 >= 100 ? "XX" : (stat.xwn8 < 10 ? "0" : "") + stat.xwn8.toString()) + "</font>";
            }
            else
            {
                return isNaN(stat.e) ? "--" :
                    "<font color='" + MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xeff) + "'>" +
                    (stat.xeff >= 100 ? "XX" : (stat.xeff < 10 ? "0" : "") + stat.xeff.toString()) + "</font>";
            }
        }

        public static function getToolTipData(fullPlayerName:String, data:Object):String
        {
            var pname:String = WGUtils.GetPlayerName(fullPlayerName);
            var stat:StatData = Stat.getUserDataByName(pname);
            if (stat == null)
                return null;

            var dt:String = isNaN(stat.ts) ? Locale.get("unknown") : Utils.FormatDate("Y-m-d", new Date(stat.ts));

            var s:String = "";

            // line 1
            s += pname + "<font color='#CCCCCC'>" + (WGUtils.GetClanNameWithBrackets(fullPlayerName) || "") + "</font>";
            s += "<br>";
            // line 2
            s += "WN8: " + (!stat.wn8 ? "--" :
                "<font color='" + MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn8) + "'>" +
                (stat.xwn8 == 100 ? "XX" : (stat.xwn8 < 10 ? "0" : "") + stat.xwn8) + "</font>") + " ";
            s += "(" + (!stat.wn8 ? "-" :
                "<font color='" + MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, stat.wn8) + "'>" +
                App.utils.locale.integer(stat.wn8) + "</font>") + ") ";
            s += Locale.get("EFF") + ": " + (!stat.e ? "--" :
                "<font color='" + MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xeff) + "'>" +
                (stat.xeff == 100 ? "XX" : (stat.xeff < 10 ? "0" : "") + stat.xeff) + "</font>") + " ";
            s += "(" + (!stat.e ? "-" :
                "<font color='" + MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, stat.e) + "'>" +
                App.utils.locale.integer(stat.e) + "</font>") + ")";
            s += "<br>";
            // line 3
            s += Locale.get("Fights") + ": " + (!stat.b ? "-" :
                "<font color='" + MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, stat.b / 1000) + "'>" +
                App.utils.locale.integer(stat.b) + "</font>") + " ";
            s += Locale.get("Wins") + ": " + (!stat.r ? "-" :
                "<font color='" + MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, stat.r) + "'>" +
                Math.round(stat.r) + "%</font>") + " ";
            s += "<br>";
            // line 4
            s += Locale.get("Data was updated at") + ": <font color='#CCCCCC'>" + dt + "</font>";

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
                    s2 += "(<font color='#ffc133'>" + (data.avgE ? Sprintf.format("%.2f", data.avgE) : "-") + "</font>" +
                        " / <font color='#ffc133'>" + (data.topE ? Sprintf.format("%.2f", data.topE) : "-") + "</font>)  ";
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

/*        public static function CreateXVMHeaderLabel(wnd:MovieClip, name:String, styleFld:TextField,
            offsetX:Number, offsetY:Number, tipName:String)
        {
            if (!wnd[name] || wnd[name + "XVM"])
                return;

            var res = Utils.duplicateTextField(wnd, name + "XVM", styleFld, 0, "right");
            res._width = 25;
            res._x = wnd[name]._x + offsetX + 25;
            res._y = wnd[name]._y + offsetY;
            if (Config.s_config.hangar.xwnInCompany == true)
            {
                res.htmlText = "<span class='xvm_" + name + "XVM'><font color='#" +
                    wnd[name].textColor.toString(16) + "'>xwn</font></span>";
            }
            else
            {
                res.htmlText = "<span class='xvm_" + name + "XVM'><font color='#" +
                    wnd[name].textColor.toString(16) + "'>xeff</font></span>";
            }

            var b = wnd.attachMovie("Button", name + "XVMHolder", wnd.getNextHighestDepth());
            b._x = res._x;
            b._y = res._y;
            b.setSize(res._width, res._height);
            b._alpha = 0;
            b.addEventListener("rollOver", function() {
                ToolTipManager.instance.show(Locale.get(tipName));
            });
            b.addEventListener("rollOut", function() {
                ToolTipManager.instance.hide();
            });

            return res;
        }*/
    }
}
