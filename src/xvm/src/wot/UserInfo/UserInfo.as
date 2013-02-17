import com.natecook.Sprintf;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.GraphicsUtil;
import wot.utils.Locale;
import wot.utils.Logger;
import wot.utils.StatLoader;
import wot.utils.VehicleInfo;
import wot.utils.Utils;

class wot.UserInfo.UserInfo extends net.wargaming.profile.UserInfo
{
    static var lastSort = {
        name: "bBat",
        type: [ "fights" ],
        dir: [ "1" ]
    };

    var m_statisticsField1:TextField;
    var m_statisticsField2:TextField;
    var m_statisticsHeaderField:TextField;
    var m_nick:String;
    var m_userData:Object;
    var m_button1:MovieClip, m_button2:MovieClip, m_button3:MovieClip, m_button4:MovieClip;
    var m_button5:MovieClip, m_button6:MovieClip, m_button7:MovieClip, m_button8:MovieClip;
    
    private static var dummy = Logger.dummy;
    
    function UserInfo()
    {
        super();

        Utils.TraceXvmModule("UserInfo");

        m_nick = "";
        m_userData = null;

        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("UserInfo.as");
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);

        // create sort buttons
        if (m_button1 == null)
            createButtons();

        processData();
    }

    private function processData()
    {
        if (Config.s_config.rating.showPlayersStatistics != true)
            return;
        GlobalEventDispatcher.addEventListener("userdata_loaded", this, onUserDataLoaded);

        if (m_nick)
            StatLoader.LoadUserData(m_nick);
    }

    private function onUserDataLoaded(event)
    {
        GlobalEventDispatcher.removeEventListener("userdata_loaded", this, onUserDataLoaded);

        m_userData = event.data ? event.data[0] : null;
        fixList();
        setXVMStat();
    }

    // override
    function setCommonInfo()
    {
        m_nick = arguments[1];
        if (Config.s_loaded)
            StatLoader.LoadUserData(m_nick);

        super.setCommonInfo.apply(this, arguments);
    }

    private function extractNumber(str)
    {
        var res = "";
        var arr = str.split("");
        for (var i = 0; i < arr.length; ++i)
        {
            if (arr[i] >= "0" && arr[i] <= "9")
                res += arr[i];
        }
        return (res == "") ? 0 : parseInt(res);
    }

    // override
    function setStat()
    {
        var battles = 0;
        var battlesExtraId = 0;
        var xp = 0;

        var data = (list.selectedIndex > 0) ? list.dataProvider[list.selectedIndex] : null;
        
        for (var i = 0; i < arguments.length; ++i)
        {
            switch (arguments[i]) {
                case "battlesCount":
                    battles = extractNumber(arguments[i + 1]);
                    battlesExtraId = i + 2;
                    i += 2;
                    break;

                case "wins":
                    // battles
                    var wins = extractNumber(arguments[i + 1]);
                    var gwr = wins / battles * 100;
                    var r1 = Math.round(gwr) / 100 + 0.005;
                    var r2 = int(gwr) / 100 + 0.01;
                    var b1 = (battles * r1 - wins) / (1 - r1);
                    var b2 = (battles * r2 - wins) / (1 - r2);
                    b1 = b1 % 1 == 0 ? b1 : (int(b1) + 1);
                    b2 = b2 % 1 == 0 ? b2 : (int(b2) + 1);
                    b1 = Math.max(0, b1);
                    b2 = Math.max(0, b2);
                    arguments[battlesExtraId] = (b2 > b1)
                        ? b1 + Locale.get(" to ") + (r2 * 100 - 0.5) + "% / " + b2 + Locale.get(" to ") + (r2 * 100) + "%"
                        : b2 + Locale.get(" to ") + (r2 * 100) + "% / " + b1 + Locale.get(" to ") + (r2 * 100 + 0.5) + "%";

                    // wins
                    arguments[i + 2] = Sprintf.format("%.2f", wins / battles * 100) + "%";
                    i += 2;
                    break;

                case "losses":
                    arguments[i + 2] = Sprintf.format("%.2f", extractNumber(arguments[i + 1]) / battles * 100) + "%";
                    i += 2;
                    break;
                
                case "survivedBattles":
                    arguments[i + 2] = Sprintf.format("%.2f", extractNumber(arguments[i + 1]) / battles * 100) + "%";
                    i += 2;
                    break;
                
                case "frags":
                    arguments[i + 2] = Sprintf.format("%.2f", extractNumber(arguments[i + 1]) / battles);
                    if (data && data.avgF && data.topF)
                        arguments[i + 2] += " (" + Sprintf.format("%.2f", data.avgF) + " / " + Sprintf.format("%.2f", data.topF) + ")";
                    i += 2;
                    break;
        
                case "maxFrags":
                    break;
                
                case "effectiveShots":
                    break;
                
                case "damageDealt":
                    if (data && data.avgD && data.topD)
                    {
                        arguments[i + 2] = Math.round(extractNumber(arguments[i + 1]) / battles) + 
                            " (" + data.avgD + " / " + data.topD + ")";
                    } else {
                        arguments[i + 2] = Sprintf.format("%.2f", extractNumber(arguments[i + 1]) / battles);
                    }
                    i += 2;
                    break;
                
                case "xp":
                    xp = extractNumber(arguments[i + 1]);
                    i += 2;
                    break;
                
                case "avgExperience":
                    arguments[i + 2] = Sprintf.format("%.2f", (xp / battles));
                    i += 2;
                    break;
                
                case "maxXP":
                    break;
            }
        }

        super.setStat.apply(this, arguments);

        if (!m_statisticsField1)
        {
            m_statisticsField1 = Utils.duplicateTextField(blocksArea.blockcommon.itemsurvivedBattles, "statisticsField",
                blocksArea.blockcommon.itemsurvivedBattles.label, blocksArea.blockcommon.itemsurvivedBattles.label._height, "left");
            m_statisticsField1._width += 100;
            m_statisticsField2 = Utils.duplicateTextField(blocksArea.blockbattleeffect.itemdamageDealt, "statisticsField",
                blocksArea.blockbattleeffect.itemdamageDealt.label, blocksArea.blockbattleeffect.itemdamageDealt.label._height, "left");
            m_statisticsField2._width += 100;
            m_statisticsHeaderField = Utils.duplicateTextField(blocksArea.blockbattleeffect.title, "statisticsHeader",
                blocksArea.blockbattleeffect.title.blockName, 0, "left");
            m_statisticsHeaderField._x = 330;
            blocksArea.blockcommon.itembattlesCount.extra._width += 45;
            blocksArea.blockbattleeffect.itemfrags.extra._width += 45;
            blocksArea.blockbattleeffect.itemdamageDealt.extra._width += 45;
            //Logger.addObject(blocksArea, "blocksArea", 3);
        }

        setXVMStat();
    }

    private function setXVMStat()
    {
        if (!m_userData)
            return;

        var b = m_userData.b;
        var eff = m_userData.e || "----";
        var wn = m_userData.wn || "----";
        var xeff = Utils.XEFF(eff) || "--";
        var xwn = Utils.XWN(wn) || "--";
        var twr = m_userData.twr || "--";
        var dt = m_userData.dt.split("T").join(" ").substr(0, 16);
        m_statisticsField1.htmlText = "<span class='xvm_statisticsField'>" +
            Locale.get("EFF") + ": <font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, xeff) + "'>" + (xeff < 100 ? xeff : "XX")  + "</font> " +
            "(<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, eff) + "'>" + eff + "</font>) " +
            "WN6: <font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, xwn) + "'>" + (xwn < 100 ? xwn : "XX") + "</font> " +
            "(<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN, wn) + "'>" + wn + "</font>) " +
            "TWR: <font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TWR, twr) + "'>" + twr + "%</font> " + 
            "  <font size='10'>" + Locale.get("updated") + ":</font> <font size='11' color='#cccccc'>" + dt + "</font>" +
            "</span>";

        if (list.selectedIndex == 0)
        {
            m_statisticsHeaderField.htmlText = "";
            m_statisticsField2.htmlText = "<span class='xvm_statisticsField'>" +
                Locale.get("Avg level") + ": <font color='#ffc133'>" + Sprintf.format("%.1f", m_userData.lvl) + "</font> " +
                Locale.get("Spotted") + ": <font color='#ffc133'>" + Sprintf.format("%.2f", m_userData.spo / b) + "</font> " +
                Locale.get("Defence") + ": <font color='#ffc133'>" + Sprintf.format("%.2f", m_userData.def / b) + "</font> " +
                Locale.get("Capture") + ": <font color='#ffc133'>" + Sprintf.format("%.2f", m_userData.cap / b) + "</font> " +
                "</span>";
        }
        else
        {
            m_statisticsHeaderField.htmlText = "<span class='xvm_statisticsHeader'>" + Locale.get("player (average / top)") + "</span>";
            var data = list.dataProvider[list.selectedIndex];
            //Logger.addObject(data);
            if (!data)
                m_statisticsField2.htmlText = "";
            else
            {
                var s = "";
                var d2 = extractNumber(blocksArea.blockbattleeffect.itemdamageDealt.value.text);
                var b2 = extractNumber(blocksArea.blockcommon.itembattlesCount.value.text);
                var effd = d2 / b2 / data.hp || 0;
                s += Locale.get("Eff damage") + ": " + (!effd ? "-" :
                    "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, effd) + "'>" + Sprintf.format("%.2f", effd) + "</font>") + " ";
                s += "(<font color='#ffc133'>" + (data.avgED ? Sprintf.format("%.2f", data.avgED) : "-") + "</font>" +
                    " / <font color='#ffc133'>" + (data.topED ? Sprintf.format("%.2f", data.topED) : "-") + "</font>)   ";
                s += Locale.get("Spotted") + ": " + (!data.tsb ? "-" :
                    "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, data.tsb) + "'>" + Sprintf.format("%.2f", data.tsb) + "</font>") + " ";
                s += "(<font color='#ffc133'>" + (data.avgS ? Sprintf.format("%.2f", data.avgS) : "-") + "</font>" +
                    " / <font color='#ffc133'>" + (data.topS ? Sprintf.format("%.2f", data.topS) : "-") + "</font>) ";
                //s += "TEFF: " + (!data.teff ? "-" :
                //    "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_E, data.e) + "'>" + data.teff + "</font>");
                m_statisticsField2.htmlText = "<span class='xvm_statisticsField'>" + s + "</span>";
            }
        }
    }

    // list
    
    // override
    function setList()
    {
        super.setList.apply(this, arguments);
        fixList();
        if (lastSort.type)
            sortList(lastSort.type, lastSort.dir);
        //Logger.addObject(lastSort, "", 2);
    }
    
    private function fixList()
    {
        var data = list.dataProvider;
        //Logger.addObject(data, "", 3);
        for (var i = 0; i < data.length; ++i)
        {
            var vi2 = VehicleInfo.getInfo2(data[i].icon);
            if (!vi2) {
                data[i].type = 0;
                continue;
            }
            data[i].type = !vi2 ? 0
                : vi2.type == "SPG" ? 1
                : vi2.type == "LT" ? 2
                : vi2.type == "MT" ? 3
                : vi2.type == "TD" ? 4
                : 5;
            if (m_userData)
            {
                var vn = VehicleInfo.getVehicleName(data[i].icon);
                vn = vn.slice(vn.indexOf("-") + 1).toUpperCase();
                var vdata = m_userData.v[vn];
                var stat = { };
                if (vdata)
                {
                    stat = {
                        b: m_userData.b,
                        w: m_userData.w,
                        tb: vdata.b,
                        tw: vdata.w,
                        tl: vdata.l,
                        e: m_userData.e,
                        wn: m_userData.wn,
                        vn: vn,
                        td: vdata.d,
                        tf: vdata.f,
                        ts: vdata.s
                    };
                    stat = StatLoader.CalculateStatValues(stat);
                }
                data[i].tsb = stat.ts / stat.tb || 0;
                data[i].ts = stat.ts || 0;
                data[i].e = stat.te || 0;
                data[i].teff = stat.teff || 0;
                var vi3 = VehicleInfo.getInfo3(VehicleInfo.getName3(data[i].icon));
                if (vi3 != null)
                {
                    data[i].hp = vi3.hp;
                    data[i].avgD = vi3.avgD;
                    data[i].avgED = vi3.avgED;
                    data[i].avgF = vi3.avgF;
                    data[i].avgS = vi3.avgS;
                    data[i].topD = vi3.topD;
                    data[i].topED = vi3.topED;
                    data[i].topF = vi3.topF;
                    data[i].topS = vi3.topS;
                }
            }
        }

        for (var i in list.renderers)
        {
            if (list.renderers[i].setup != rendererSetup)
            {
                list.renderers[i].setup2 = list.renderers[i].setup;
                list.renderers[i].setup = rendererSetup;
            }
        }
    }

    function rendererSetup()
    {
        this["setup2"].apply(this, arguments);
        var data = this["data"];
        var teff = this["teff"];
        var fights = this["fights"];

        if (!teff)
        {
            teff = Utils.duplicateTextField(this, "teff", fights, 0, "center");
            this["teff"] = teff;
            teff._x -= 37;
            //Logger.add("t=" + teff._x + ", f=" + fights._x);
        }

        if (!data || !data.e || !data.teff)
            teff.htmlText = "";
        else 
        {
            var color = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_E, data.e);
            teff.htmlText =
                "<span class='xvm_teff'>" +
                "<font color='" + color + "'>" + (data.e < 10 ? data.e : "X") + "</font>" +
                //" (<font color='" + color + "'>" + data.teff + "</font>)" +
                "</span>";
        }
    }

    // sorting

    private function createButtons()
    {
        var hdr:MovieClip = null;
        var fld = null;
        for (var i in this)
        {
            if (!Utils.startsWith("instance", i))
                continue;
            for (var j in this[i])
            {
                if (Utils.startsWith("instance", j))
                {
                    hdr = this[i];
                    fld = this[i][j];
                    this[i][j].text = "";
                }
            }
            if (hdr != null)
                break;
        }

        if (hdr == null)
            return;

        m_button1 = createButton(hdr, fld, "bLvl", 10, Locale.get("Level"), "left", 1);
        m_button2 = createButton(hdr, fld, "bTyp", 124, Locale.get("Type"), "right", 1);
        m_button3 = createButton(hdr, fld, "bNat", 135, Locale.get("Nation"), "left", 2);
        m_button4 = createButton(hdr, fld, "bNam", 200, Locale.get("Name"), "left", 2);
        m_button5 = createButton(hdr, fld, "bEff", 305, "E", "right", 1);
        if (Config.s_config.rating.showPlayersStatistics != true)
        {
            m_button5.enabled = false;
            m_button5._alpha = 30;
        }
        m_button6 = createButton(hdr, fld, "bBat", 365, Locale.get("Fights"), "right", 1);
        m_button7 = createButton(hdr, fld, "bWin", 435, Locale.get("Wins"), "right", 1);
        m_button8 = createButton(hdr, fld, "bMed", 440, "M", "left", 1);
    }

    private function createButton(hdr:MovieClip, fld, name, x, txt, align, defaultSort):MovieClip
    {
        var b:MovieClip = hdr.attachMovie("Button", name, hdr.getNextHighestDepth());
        b._x = x;
        b._y = fld._y;
        b.addEventListener("click", this, "onSortClick");
        b.addEventListener("stateChange", this, "onButtonStateChangeClick");
        b.group = "sort";
        b.autoSize = true;
        b.label = txt;

        if (align == "right")
            b._x -= Math.round(b.textField.textWidth + 21);

        b.defaultSort = defaultSort;
        b.sortDir = 0;
        if (name == lastSort.name)
        {
            b.sortDir = lastSort.dir[0];
            b.selected = true;
        }

        return b;
    }
    
    private function onSortClick(e)
    {
        var b = e.target;
        b.selected = true;
        b.sortDir = !b.sortDir ? b.defaultSort : b.sortDir == 2 ? 1 : 2;
        onButtonStateChangeClick(e);

        var sortType = b == m_button1 ? [ "level", "nation", "name" ]
            : b == m_button2 ? [ "type", "level", "name" ]
            : b == m_button3 ? [ "nation", "level", "type", "name" ]
            : b == m_button4 ? [ "name" ]
            : b == m_button5 ? [ "e", "level", "type", "name" ]
            : b == m_button6 ? [ "fights" ]
            : b == m_button7 ? [ "wins" ]
            : [ "vehicleClass", "level", "type", "nation", "name" ];
        var sortDir = b == m_button1 ? [ b.sortDir, 2, 2 ]
            : b == m_button2 ? [ b.sortDir, 1, 2 ]
            : b == m_button3 ? [ b.sortDir, 1, 1, 2 ]
            : b == m_button4 ? [ b.sortDir ]
            : b == m_button5 ? [ b.sortDir, 1, 1, 2 ]
            : b == m_button6 ? [ b.sortDir ]
            : b == m_button7 ? [ b.sortDir ]
            : [ b.sortDir, 1, 1, 2, 2 ];

        sortList(sortType, sortDir);
        lastSort.name = b._name;

        list.selectedIndex = 0;
    }

    function sortList(sortType, sortDir)
    {
        lastSort.type = sortType.slice();
        lastSort.dir = sortDir.slice();
        for (var i = 0; i < sortDir.length; ++i)
            sortDir[i] = (sortDir[i] == 1 ? Array.DESCENDING : 0) | Array.CASEINSENSITIVE | Array.NUMERIC;
        var data = list.dataProvider.slice();
        var first = data.shift();
        var isWins = Utils.indexOf(sortType, "wins") != -1;
        if (isWins)
        {
            for (var i = 0; i < data.length; ++i)
                data[i].wins = extractNumber(data[i].wins);
        }
        data.sortOn(sortType, sortDir);
        if (isWins)
        {
            for (var i = 0; i < data.length; ++i)
                data[i].wins += "%";
        }
        data.unshift(first);
        list.dataProvider = data;
    }
    
    private function onButtonStateChangeClick(e)
    {
        var b = e.target;
        if (b.selected)
            b.textField.textColor = b.sortDir == b.defaultSort ? 0xFFC133 : 0x408CCF;
        else {
            b.sortDir = 0;
            b.textField.textColor = 0xF2F1E1;
        }
    }
}
