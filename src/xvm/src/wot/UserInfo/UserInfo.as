import com.natecook.Sprintf;
import com.xvm.Cache;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.GraphicsUtil;
import com.xvm.Locale;
import com.xvm.Logger;
import com.xvm.StatLoader;
import com.xvm.VehicleInfo;
import com.xvm.Utils;
import com.xvm.Helpers.UserDataLoaderHelper;
import wot.WGDataTypes.CarouselDataItem;
import wot.WGDataTypes.UserInfoDataItem;

class wot.UserInfo.UserInfo
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    private var wrapper:net.wargaming.profile.UserInfo;
    private var base:net.wargaming.profile.UserInfo;

    public function UserInfo(wrapper:net.wargaming.profile.UserInfo, base:net.wargaming.profile.UserInfo)
    {
        this.wrapper = wrapper;
        this.base = base;

        Utils.TraceXvmModule("UserInfo");

        UserInfoCtor();
    }

    function setCommonInfo()
    {
        return this.setCommonInfoImpl.apply(this, arguments);
    }

    function setStat()
    {
        return this.setStatImpl.apply(this, arguments);
    }

    function setList()
    {
        return this.setListImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    static var lastSort = {
        name: "bBat",
        type: [ "fights" ],
        dir: [ "1" ]
    };

    var m_statisticsField1:TextField;
    var m_statisticsField2:TextField;
    var m_statisticsHeaderField:TextField;
    var m_name:String;
    var m_userData:Object;
    var m_rbAll:gfx.controls.RadioButton;
    var m_rbFull:gfx.controls.RadioButton;
    var m_rbOwn:gfx.controls.RadioButton;
    var m_tiFilter:gfx.controls.TextInput;
    var m_button1:MovieClip, m_button2:MovieClip, m_button3:MovieClip, m_button4:MovieClip;
    var m_button5:MovieClip, m_button6:MovieClip, m_button7:MovieClip, m_button8:MovieClip;
    var m_dataLoaded:Boolean;

    private var m_allDataProvider:Array;
    private var m_fullDataProvider:Array;
    private var m_hangarDataProvider:Array;
    
    public function UserInfoCtor()
    {
        m_name = null;
        m_userData = null;
        m_dataLoaded = false;

        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("UserInfo.as");
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);
        loadData();
    }

    function setCommonInfoImpl()
    {
        //Logger.add("setCommonInfo()");
        
        m_name = arguments[1];
        loadData();

        base.setCommonInfo.apply(base, arguments);
    }

    function loadData()
    {
        if (!Config.s_loaded || Config.s_config.rating.showPlayersStatistics != true)
            return;
        if (Config.s_config.rating.enableUserInfoStatistics != true)
            return;
        
        if (!m_name)
            return;
        
        if (m_dataLoaded)
            return;
        m_dataLoaded = true;
        
        if (Cache.Exist("INFO@" + m_name))
            onUserDataLoaded();
        else {
            GlobalEventDispatcher.addEventListener("userdata_cached", this, onUserDataLoaded);
            UserDataLoaderHelper.LoadUserData(m_name, false);
        }
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

    private function perBattle(value:Number, battles:Number):Number
    {
        return battles <= 0 ? 0 : value / battles;
    }
    
    function setStatImpl()
    {
        var battles = 0;
        var battlesExtraId = 0;
        var xp = 0;

        var data = (wrapper.list.selectedIndex > 0) ? wrapper.list.dataProvider[wrapper.list.selectedIndex] : null;

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
                    var gwr = perBattle(wins, battles) * 100;
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
                    arguments[i + 2] = Sprintf.format("%.2f", gwr) + "%";
                    if (data && data.avgR && data.topR)
                        arguments[i + 2] += " (" + Sprintf.format("%.2f", data.avgR * 100) + " / " + Sprintf.format("%.2f", data.topR * 100) + ")";
                    i += 2;
                    break;

                case "losses":
                    arguments[i + 2] = Sprintf.format("%.2f", perBattle(extractNumber(arguments[i + 1]), battles) * 100) + "%";
                    i += 2;
                    break;

                case "survivedBattles":
                    arguments[i + 2] = Sprintf.format("%.2f", perBattle(extractNumber(arguments[i + 1]), battles) * 100) + "%";
                    if (data && data.avgU && data.topU)
                        arguments[i + 2] += " (" + Sprintf.format("%.2f", data.avgU * 100) + " / " + Sprintf.format("%.2f", data.topU * 100) + ")";
                    i += 2;
                    break;

                case "frags":
                    arguments[i + 2] = Sprintf.format("%.2f", perBattle(extractNumber(arguments[i + 1]), battles));
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
                        arguments[i + 2] = Math.round(perBattle(extractNumber(arguments[i + 1]), battles)) +
                            " (" + data.avgD + " / " + data.topD + ")";
                    } else {
                        arguments[i + 2] = Sprintf.format("%.2f", perBattle(extractNumber(arguments[i + 1]), battles));
                    }
                    i += 2;
                    break;

                case "xp":
                    xp = extractNumber(arguments[i + 1]);
                    i += 2;
                    break;

                case "avgExperience":
                    arguments[i + 2] = Sprintf.format("%.2f", perBattle(xp, battles));
                    i += 2;
                    break;

                case "maxXP":
                    break;
            }
        }
        base.setStat.apply(base, arguments);

        if (Config.s_config.rating.enableUserInfoStatistics != true)
            return;

        if (!m_statisticsField1)
        {
            m_statisticsField1 = Utils.duplicateTextField(wrapper.blocksArea.blockcommon.itemsurvivedBattles, "statisticsField",
                wrapper.blocksArea.blockcommon.itemsurvivedBattles.label, wrapper.blocksArea.blockcommon.itemsurvivedBattles.label._height, "left");
            m_statisticsField1._width += 100;
            m_statisticsField2 = Utils.duplicateTextField(wrapper.blocksArea.blockbattleeffect.itemdamageDealt, "statisticsField",
                wrapper.blocksArea.blockbattleeffect.itemdamageDealt.label, wrapper.blocksArea.blockbattleeffect.itemdamageDealt.label._height, "left");
            m_statisticsField2._width += 100;
            m_statisticsHeaderField = Utils.duplicateTextField(wrapper.blocksArea.blockbattleeffect.title, "statisticsHeader",
                wrapper.blocksArea.blockbattleeffect.title.blockName, 0, "left");
            m_statisticsHeaderField._x = 330;
            wrapper.blocksArea.blockcommon.itembattlesCount.extra._width += 45;
            wrapper.blocksArea.blockcommon.itemwins.extra._width += 45;
            wrapper.blocksArea.blockcommon.itemlosses.extra._width += 45;
            wrapper.blocksArea.blockcommon.itemsurvivedBattles.extra._width += 45;
            wrapper.blocksArea.blockbattleeffect.itemfrags.extra._width += 45;
            wrapper.blocksArea.blockbattleeffect.itemdamageDealt.extra._width += 45;
            //Logger.addObject(wrapper.blocksArea.blockcommon, "blocksArea", 1);
        }

        setXVMStat1();
        setXVMStat2();
    }

    private function onUserDataLoaded()
    {
        var key = "INFO@" + m_name;
        if (!Cache.Exist(key))
            return;

        GlobalEventDispatcher.removeEventListener("userdata_cached", this, onUserDataLoaded);

        m_userData = Cache.Get(key);

        if (!m_button1.disabled)
        {
            var dt = m_userData.dt.split("T").join(" ").substr(0, 10);
            m_button5.tooltipText = Locale.get("UserInfoEHint").split("%DATE%").join("<font color='#CCCCCC'>" + dt + "</font>");
        }

        fixList(wrapper.list.dataProvider);
        wrapper.list.invalidate();

        setXVMStat1();
        setXVMStat2();
    }

    private function setXVMStat1()
    {
        if (!m_userData)
            return;

        var b = m_userData.b;
        var eff = m_userData.e;
        var wn = m_userData.wn;
        var xeff = m_userData.xeff;
        var xwn = m_userData.xwn;
        var twr = m_userData.twr;
        var dt = m_userData.dt ? m_userData.dt.split("T").join(" ").substr(0, 10) : Locale.get("unknown");

        var s = "";
        s += "WN6: " + (!wn ? "--" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, xwn) + "'>" + (xwn == 100 ? "XX" : (xwn < 10 ? "0" : "") + xwn) + "</font>") + " ";
        s += "(" + (!wn ? "-" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN, wn) + "'>" + wn + "</font>") + ") ";
        s += Locale.get("EFF") + ": " + (!eff ? "--" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, xeff) + "'>" + (xeff == 100 ? "XX" : (xeff < 10 ? "0" : "") + xeff) + "</font>") + " ";
        s += "(" + (!eff ? "-" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, eff) + "'>" + eff + "</font>") + ") ";
        s += "TWR: " + (!twr ? "-" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TWR, twr) + "'>" + twr + "%</font>") + " ";
        s += "  <font size='11'>" + Locale.get("updated") + ":</font> <font size='12' color='#CCCCCC'>" + dt + "</font>";

        m_statisticsField1.htmlText = "<span class='xvm_statisticsField'>" + s + "</span>";
    }

    private function setXVMStat2()
    {
        if (wrapper.list.selectedIndex == 0)
            setGlobalStatistic();
        else
            setSelectedVehicleStatistic();
    }

    private function setGlobalStatistic()
    {
        m_statisticsHeaderField.htmlText = "";
        if (!m_userData)
            return;
        var spo = m_userData.spo / m_userData.b;
        var def = m_userData.def / m_userData.b;
        var cap = m_userData.cap / m_userData.b;
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

    private function setSelectedVehicleStatistic()
    {
        m_statisticsHeaderField.htmlText = "<span class='xvm_statisticsHeader'>" + Locale.get("player (average / top)") + "</span>";

        var data = wrapper.list.dataProvider[wrapper.list.selectedIndex];
        if (!data)
        {
            m_statisticsField2.htmlText = "";
            return;
        }

        //Logger.addObject(blocksArea, "blocksArea", 3);
        //Logger.addObject(data);
        var tb = data.fights;
        var tw = extractNumber(wrapper.blocksArea.blockcommon.itemwins.value.text);
        var td = extractNumber(wrapper.blocksArea.blockbattleeffect.itemdamageDealt.value.text);
        var tf = extractNumber(wrapper.blocksArea.blockbattleeffect.itemfrags.value.text);
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

        var s2 = "";

        if (tb == 0)
            s2 += "E: - (-)  ";
        else
        {
            var e_color = GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_E, stat.te);
            s2 += "E: " + (!stat.teff ? "-" :
                "<font color='" + e_color + "'>" + (stat.te < 10 ? stat.te : "X") + "</font> (<font color='" + e_color + "'>" + stat.teff + "</font>)") + "  ";
        }

        var specD = tb == 0 ? 0 : td / tb / data.hp || 0;
        s2 += Locale.get("Spec dmg") + ": " + (!specD ? "-" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, specD) + "'>" + Sprintf.format("%.2f", specD) + "</font>") + " ";
        s2 += "(<font color='#ffc133'>" + (data.avgE ? Sprintf.format("%.2f", data.avgE) : "-") + "</font>" +
            " / <font color='#ffc133'>" + (data.topE ? Sprintf.format("%.2f", data.topE) : "-") + "</font>)  ";

        // FIXIT: WG providing incorrect per-vehicle stat
        s2 += Locale.get("Spotted") + ": " + (!data.tsb ? "-" :
            "<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, data.tsb) + "'>" + Sprintf.format("%.2f", data.tsb) + "</font>") + " ";
        s2 += "(<font color='#ffc133'>" + (data.avgS ? Sprintf.format("%.2f", data.avgS) : "-") + "</font>" +
            " / <font color='#ffc133'>" + (data.topS ? Sprintf.format("%.2f", data.topS) : "-") + "</font>)  ";
        // END FIXIT

        m_statisticsField2.htmlText = "<span class='xvm_statisticsField'>" + s2 + "</span>";
    }

    // list

    function setListImpl()
    {
        //Logger.add("setList()");

        base.setList.apply(base, arguments);

        // create sort and filter buttons
        if (m_button1 == null)
            createControls();

        filterList();
        applyFilterAndSort();
        //Logger.addObject(lastSort, "", 2);
        //Logger.addObject(_root, "_root", 2);
        //Logger.addObject(m_fullDataProvider);
    }

    private function filterList()
    {
        // Full
        m_fullDataProvider = wrapper.list.dataProvider;

        fixList(m_fullDataProvider);

        // All
        m_allDataProvider = [ m_fullDataProvider[0] ];
        var commonId = m_fullDataProvider[0].id;
        var len:Number = m_fullDataProvider.length;
        var all = com.xvm.VehicleInfoData2.data;
        for (var vn:String in all)
        {
            if (vn == "unknown" || Utils.endsWith("_training", vn))
                continue;

            var vi = all[vn];
            var icon = "../maps/icons/vehicle/small/" + vi.nation + "-" + vi.name + ".png";

            var item:Object = null;
            for (var i:Number = 1; i < len; ++i)
            {
                if (m_fullDataProvider[i].icon == icon)
                {
                    item = m_fullDataProvider[i];
                    break;
                }
            }

            m_allDataProvider.push(item || {
                id: commonId,
                name: vi.name,
                icon: icon,
                type: UserInfoDataItem.toType(vi.type),
                nation: UserInfoDataItem.toNation(vi.nation),
                level: vi.level,
                toolTip: 0,
                fights: 0,
                wins: 0,
                vehicleClass: 0 // 1,2,3,M
            });
        }
        fixList(m_allDataProvider);
        
        // Hangar
        var carouselData:Array = wot.RootComponents.carousel.dataProvider || _global._xvm_carousel_dataProvider;
        if (!carouselData)
        {
            m_hangarDataProvider = null;
            return;
        }

        m_hangarDataProvider = [ m_fullDataProvider[0] ];
        var ulen:Number = m_fullDataProvider.length;
        var clen:Number = carouselData.length;
        for (var i:Number = 0; i < ulen; ++i)
        {
            var ui:wot.WGDataTypes.UserInfoDataItem = m_fullDataProvider[i];

            for (var j:Number = 0; j < clen; ++j)
            {
                var ci:CarouselDataItem = carouselData[j];
                if (ci.label == ui.name)
                {
                    //Logger.add("ci=ui: " + ci.label);
                    m_hangarDataProvider.push(ui);
                    break;
                }
            }
        }
    }
    
    private function fixList(data:Array)
    {
        //Logger.addObject(data, "", 3);
        for (var i = 1; i < data.length; ++i)
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
            data[i].hp = vi2.hptop;
            data[i].premium = vi2.premium;
            data[i].avgR = vi2.avg.R;
            data[i].avgD = vi2.avg.D;
            data[i].avgE = vi2.avg.E;
            data[i].avgF = vi2.avg.F;
            data[i].avgS = vi2.avg.S;
            data[i].avgU = vi2.avg.U;
            data[i].topR = vi2.top.R;
            data[i].topD = vi2.top.D;
            data[i].topE = vi2.top.E;
            data[i].topF = vi2.top.F;
            data[i].topS = vi2.top.S;
            data[i].topU = vi2.top.U;
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
                if (Config.s_config.userInfo.showEColumn == true)
                {
                    data[i].e = stat.te || 0;
                    data[i].teff = stat.teff || 0;
                }
            }
        }
    }

    private function applyFilterAndSort()
    {
        //Logger.add("applyFilterAndSort()");

        if (m_rbFull != null)
        {
            var selected = m_rbFull.group.selectedButton;
            var data:Array = selected == m_rbOwn ? m_hangarDataProvider || m_fullDataProvider
                : selected == m_rbAll ? m_allDataProvider : m_fullDataProvider;
            if (m_tiFilter.text != null && m_tiFilter.text != "")
            {
                var provider:Array = data;
                data = [ provider[0] ];
                var len:Number = provider.length;
                var filter:String = m_tiFilter.text.toLowerCase();
                for (var i:Number = 1; i < len; ++i)
                {
                    var item:UserInfoDataItem = provider[i];
                    if (filter == "" || item.name.toLowerCase().indexOf(filter) >= 0)
                        data.push(item);
                }
            }

            wrapper.list.dataProvider = data;
        }

        if (lastSort.type)
            sortList(lastSort.type, lastSort.dir);
        
        wrapper.list.selectedIndex = 0;
    }

    // controls

    private function createControls()
    {
        //Logger.add("createControls()");

        // hide original text fields
        wrapper.header.fights._visible = false;
        wrapper.header.wins._visible = false;

        // add new buttons
        var hdr:MovieClip = wrapper.header;

        m_button1 = createButton(hdr, "bLvl", 10,  5, Locale.get("Level"), "left", 1);
        m_button2 = createButton(hdr, "bTyp", 124, 5, Locale.get("Type"), "right", 1);
        m_button3 = createButton(hdr, "bNat", 135, 5, Locale.get("Nation"), "left", 2);
        m_button4 = createButton(hdr, "bNam", 200, 5, Locale.get("Name"), "left", 2);

        m_button5 = createButton(hdr, "bEff", 305, 5, "E", "right", 1);

        // Option for disable "E" column, because WG is providing incorrect per-vehicle stats
        m_button5._visible = Config.s_config.userInfo.showEColumn == true;
        if (Config.s_config.rating.showPlayersStatistics != true || Config.s_config.rating.enableUserInfoStatistics != true)
        {
            m_button5.enabled = false;
            m_button5._alpha = 30;
        }
        
        m_button6 = createButton(hdr, "bBat", 365, 5, Locale.get("Fights"), "right", 1);
        m_button7 = createButton(hdr, "bWin", 435, 5, Locale.get("Wins"), "right", 1);
        m_button8 = createButton(hdr, "bMed", 440, 5, "M", "left", 1);

        // Filter controls
        if (Config.s_config.userInfo.showFilters == true)
        {
            var filter:MovieClip = (IsSelfUserInfo() ? wrapper : wrapper._parent._parent).createEmptyMovieClip("filterPanel", 999);
            filter._x = 392;
            filter._y = IsSelfUserInfo() ? -69 : 0;

            var filterLabel:TextField = filter.createTextField("filterLabel", 0, 100, 0, 60, 20);
            filterLabel.antiAliasType = "advanced";
            filterLabel.styleSheet = Utils.createStyleSheet(Utils.createCSSFromConfig("$FieldFont", Defines.UICOLOR_DEFAULT2, "xvm_filterLabel"));
            filterLabel.selectable = false;
            filterLabel.html = true;
            filterLabel.htmlText = "<span class='xvm_filterLabel'>" + Locale.get("Filter") + ":</span>";
            
            m_tiFilter = gfx.controls.TextInput(Utils.createTextInput(filter, "__xvm_tiFilter", 100, 15, 60));
            m_tiFilter.addEventListener("textChange", this, "applyFilterAndSort");
            
            m_rbOwn = gfx.controls.RadioButton(Utils.createRadioButton(filter, "rbOwnTanks", 0, 0, 100, Locale.get("In hangar"), "filter"));
            m_rbOwn.tooltipText = Locale.get("Show only tanks in own hangar");
            m_rbOwn.selected = IsSelfUserInfo() && Config.s_config.userInfo.inHangarFilterEnabled == true;
            m_rbOwn.addEventListener("select", this, "applyFilterAndSort");
            
            m_rbFull = gfx.controls.RadioButton(Utils.createRadioButton(filter, "rbFullTanks", 0, 12, 100, Locale.get("Player tanks"), "filter"));
            m_rbFull.tooltipText = Locale.get("Show all tanks played");
            m_rbFull.selected = !IsSelfUserInfo() || Config.s_config.userInfo.inHangarFilterEnabled != true;
            m_rbFull.addEventListener("select", this, "applyFilterAndSort");
            
            m_rbAll = gfx.controls.RadioButton(Utils.createRadioButton(filter, "rbAllTanks", 0, 24, 100, Locale.get("All tanks"), "filter"));
            m_rbAll.tooltipText = Locale.get("Show all tanks in the game");
            m_rbAll.selected = false;
            m_rbAll.addEventListener("select", this, "applyFilterAndSort");
        }
    }

    private function IsSelfUserInfo()
    {
        return !wrapper._parent.addToIgnoredButton;
    }
    
    private function createButton(hdr:MovieClip, name, x, y, txt, align, defaultSort):MovieClip
    {
        var b = Utils.createButton(hdr, name, x, y, txt, align);
        Utils.addEventListeners(b, this, {
            click: "onSortClick",
            stateChange: "onButtonStateChangeClick"
        });

        b.group = "sort";
        b.defaultSort = defaultSort;
        b.sortDir = 0;
        if (name == lastSort.name)
        {
            b.sortDir = lastSort.dir[0];
            b.selected = true;
        }

        return b;
    }

    // sorting

    private function onSortClick(e)
    {
        var b = e.target;
        b.selected = true;
        b.sortDir = !b.sortDir ? b.defaultSort : b.sortDir == 2 ? 1 : 2;
        net.wargaming.managers.ToolTipManager.instance.hide();
        onButtonStateChangeClick(e);

        var sortType = b == m_button1 ? [ "level", "nation", "name" ]
            : b == m_button2 ? [ "type", "level", "name" ]
            : b == m_button3 ? [ "nation", "level", "type", "name" ]
            : b == m_button4 ? [ "name" ]
            : b == m_button5 ? [ "e", "fights" ]
            : b == m_button6 ? [ "fights" ]
            : b == m_button7 ? [ "wins" ]
            : [ "vehicleClass", "level", "type", "nation", "name" ];
        var sortDir = b == m_button1 ? [ b.sortDir, 2, 2 ]
            : b == m_button2 ? [ b.sortDir, 1, 2 ]
            : b == m_button3 ? [ b.sortDir, 1, 1, 2 ]
            : b == m_button4 ? [ b.sortDir ]
            : b == m_button5 ? [ b.sortDir, b.sortDir ]
            : b == m_button6 ? [ b.sortDir ]
            : b == m_button7 ? [ b.sortDir ]
            : [ b.sortDir, 1, 1, 2, 2 ];

        sortList(sortType, sortDir);
        lastSort.name = b._name;

        wrapper.list.selectedIndex = 0;
    }
    
    function sortList(sortType, sortDir)
    {
        lastSort.type = sortType.slice();
        lastSort.dir = sortDir.slice();
        for (var i = 0; i < sortDir.length; ++i)
            sortDir[i] = (sortDir[i] == 1 ? Array.DESCENDING : 0) | Array.CASEINSENSITIVE | Array.NUMERIC;
        var data = wrapper.list.dataProvider.slice();
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
        wrapper.list.dataProvider = data;
    }

    // filtering
    
    private function onButtonStateChangeClick(e)
    {
        var b = e.target;
        if (b.selected)
            b.textField.textColor = b.sortDir == b.defaultSort ? Defines.UICOLOR_GOLD : Defines.UICOLOR_BLUE;
        else {
            b.sortDir = 0;
            b.textField.textColor = Defines.UICOLOR_DEFAULT;
        }
    }
}
