import wot.utils.Cache;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.GraphicsUtil;
import wot.utils.Locale;
import wot.utils.Logger;
import wot.utils.StatLoader;
import wot.utils.Utils;

class wot.TeamMemberRenderer.TeamMemberRenderer extends net.wargaming.messenger.controls.TeamMemberRenderer
{
    private var uid:Number;
    private var name:Number;
    private var stat:Object;
    private var m_effField:TextField;

    private static var dummy = Logger.dummy;

    function TeamMemberRenderer()
    {
        super();

        Utils.TraceXvmModule("TeamMemberRenderer");

        uid = 0;
        name = null;
        stat = null;
        m_effField = null;

        Config.LoadConfig("TeamMemberRenderer.as");
    }

    // override
    function configUI()
    {
        var wnd = this["owner"]._parent;
        if (wnd)
        {
            if (wnd.crewStuffField && !wnd.crewStuffFieldXVM)
                wnd.crewStuffFieldXVM = createXVMHeaderLabel(wnd, "crewStuffField", vehicleLevelField);
            if (wnd.queueLabel && !wnd.queueLabelXVM)
                wnd.queueLabelXVM = createXVMHeaderLabel(wnd, "queueLabel", vehicleLevelField);
        }

        textField._x -= 10;
        vehicle_type_icon._x -= 10;
        vehicleNameField._x -= 10;
        vehicleLevelField._x -= 15;

        super.configUI();

        m_effField = Utils.duplicateTextField(this, "eff", vehicleLevelField, 0, "center");
        m_effField._x += 20;
    }

    function createXVMHeaderLabel(wnd:MovieClip, name, fld)
    {
        var res = Utils.duplicateTextField(wnd, name + "XVM", fld, 0, "left");
        res._x = wnd[name]._x + 187;
        res._y = wnd[name]._y + 2;
        res.htmlText = "<span class='xvm_" + name + "XVM'><font color='#" +
            wnd[name].textColor.toString(16) + "'>xwn</font></span>";

        var b = wnd.attachMovie("Button", name + "XVMHolder", wnd.getNextHighestDepth());
        b._x = res._x - 5;
        b._y = res._y;
        b.setSize(30, 20);
        b._alpha = 0;
        b.addEventListener("rollOver", function() {
            net.wargaming.managers.ToolTipManager.instance.show("Рейтинг xwn.\n" +
                "Чтобы увидеть более подробную информацию, наведите курсор мыши на значение рейтинга интересующего игрока.");
        });
        b.addEventListener("rollOut", function() {
            net.wargaming.managers.ToolTipManager.instance.hide();
        });

        return res;
    }

    // override
    function afterSetData()
    {
        super.afterSetData();

        if (!data || !data.uid)
            return;

        if (!Config.s_loaded)
            return;

        if (uid == data.uid)
            setXVMStat();
        else
        {
            uid = data.uid;
            m_effField.htmlText = "";
            processData();
        }
    }

    private function processData()
    {
        if (Config.s_config.rating.showPlayersStatistics != true)
            return;

        var key = "INFO." + uid;
        if (Cache.Exist(key))
        {
            stat = Cache.Get(key);
            setXVMStat();
        } else {
            loadUserData(this);
        }
    }

    private function loadUserData(instance, loop)
    {
        if (!loop)
          loop = 0;
        // Force stats loading after 0.5 sec if enabled (for 12x12 battles, FogOfWar, ...)
        _global.setTimeout
        (
            function() {
                if (GlobalEventDispatcher.getEventListenersCount("userdata_loaded") == 0)
                {
                    GlobalEventDispatcher.addEventListener("userdata_loaded", instance, instance.onUserDataLoaded);
                    StatLoader.LoadUserData(instance.uid, true);
                }
                else
                {
                    instance.loadUserData(instance, loop);
                }
            },
            50 + Math.random() * 50;
        );
    }
    
    private function onUserDataLoaded(event)
    {
        GlobalEventDispatcher.removeEventListener("userdata_loaded", this, onUserDataLoaded);
        if (!event.data || !event.data[0])
            return;
        //Logger.addObject(event.data, "data", 3);
        stat = Cache.Get("INFO." + event.data[0]._id, function() { return TeamMemberRenderer.FixData(event.data[0]); });
        //Logger.addObject(stat, "stat", 3);
        setXVMStat();
    }

    private static function FixData(ud)
    {
        // GWR
        ud.r = ud.b > 0 ? Math.round(ud.w / ud.b * 100) : 0;

        // xeff
        if (ud.e != null)
            ud.xeff = Utils.XEFF(ud.e);

        // xwn
        if (ud.wn != null)
            ud.xwn = Utils.XWN(ud.wn);

        return ud;
    }
    
    private function setXVMStat()
    {
        //Logger.add("setXVMStat: " + uid + " " + stat.nm);
        m_effField.htmlText = "<span class='xvm_eff'>" + (!stat.wn ? "--" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn) + "'>" + (stat.xwn == 100 ? "XX" : (stat.xwn < 10 ? "0" : "") + stat.xwn) + "</font>") + "</span>";
    }

    // override
    function getToolTipData()
    {
        if (!stat)
            return super.getToolTipData();

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
}
