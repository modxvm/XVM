import com.natecook.Sprintf;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.GraphicsUtil;
import wot.utils.Locale;
import wot.utils.Logger;
import wot.utils.StatLoader;
import wot.utils.Utils;

class wot.UserInfo.UserInfo extends net.wargaming.profile.UserInfo
{
    var statisticsField:TextField;
    var nick:String;
    var userData:Object;

    private static var dummy = Logger.dummy;
    
    function UserInfo()
    {
        super();

        Utils.TraceXvmModule("UserInfo");

        nick = "";
        userData = null;

        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("UserInfo.as");
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);
        processData();
    }

    private function processData()
    {
        if (Config.s_config.rating.showPlayersStatistics != true)
            return;
        GlobalEventDispatcher.addEventListener("userdata_loaded", this, onUserDataLoaded);

        //Logger.add("Nick: " + nick);
        if (nick)
            StatLoader.LoadUserData(nick);
    }

    private function onUserDataLoaded(event)
    {
        GlobalEventDispatcher.removeEventListener("userdata_loaded", this, onUserDataLoaded);

        userData = event.data ? event.data[0] : null;

        setXVMStat();
    }

    // override
    function setCommonInfo()
    {
        //Logger.addObject(arguments, "setCommonInfo.arguments", 5);

        nick = arguments[1];
        if (Config.s_loaded)
            StatLoader.LoadUserData(nick);

        super.setCommonInfo.apply(this, arguments);
        //Logger.addObject(_root, "_root", 5);
        //Logger.addObject(this, "UserInfo", 5);
        //mButton1.addEventListener("click", this, "onSortClick");
        //mButton2.addEventListener("click", this, "onSortClick");
        //mButton3.addEventListener("click", this, "onSortClick");
        //mButton4.addEventListener("click", this, "onSortClick");
        //mButton5.addEventListener("click", this, "onSortClick");
        //mButton6.addEventListener("click", this, "onSortClick");
    }

    function extractNumber(str)
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
        //Logger.addObject(arguments, "setStat.arguments", 5);

        var battles = 0;
        var battlesExtraId = 0;
        var xp = 0;

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
                    arguments[i + 2] += "   /   " + Sprintf.format("%.2f", wins / battles * 100) + "%";
                    i += 2;
                    break;

                case "losses":
                    arguments[i + 2] += "   /   " + Sprintf.format("%.2f", extractNumber(arguments[i + 1]) / battles * 100) + "%";
                    i += 2;
                    break;
                
                case "survivedBattles":
                    arguments[i + 2] += "   /   " + Sprintf.format("%.2f", extractNumber(arguments[i + 1]) / battles * 100) + "%";
                    i += 2;
                    break;
                
                case "frags":
                    arguments[i + 2] = Sprintf.format("%.2f", extractNumber(arguments[i + 1]) / battles);
                    i += 2;
                    break;
        
                case "maxFrags":
                    break;
                
                case "effectiveShots":
                    break;
                
                case "damageDealt":
                    arguments[i + 2] = Math.round(extractNumber(arguments[i + 1]) / battles);
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

        if (!statisticsField)
        {
            statisticsField = Utils.duplicateTextField(blocksArea.blockcredits.itemmaxXP, "statisticsField",
                blocksArea.blockcredits.itemmaxXP.label, blocksArea.blockcredits.itemmaxXP.label._height + 3, "left");
            statisticsField._width += 100;
            blocksArea.blockcommon.itembattlesCount.extra._width += 30;
        }

        setXVMStat();
    }

    private function setXVMStat()
    {
        if (!userData)
            return;

        var b = userData.b;
        var eff = userData.e || "----";
        var wn = userData.wn || "----";
        var xeff = Utils.XEFF(eff) || "--";
        var xwn = Utils.XWN(wn) || "--";
        var twr = userData.twr || "--";
        var dt = userData.dt.split("T").join(" ").substr(0, 16);
        statisticsField.htmlText = "<textformat leading='0'><span class='xvm_statisticsField'>" +
            Locale.get("EFF") + ": <font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, xeff) + "'>" + xeff + "</font> " +
            "(<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, eff) + "'>" + eff + "</font>) " +
            "WN6: <font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_X, xwn) + "'>" + xwn + "</font> " +
            "(<font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN, wn) + "'>" + wn + "</font>) " +
            "TWR: <font color='" + GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TWR, twr) + "'>" + twr + "%</font> " + 
            "\n" +
            Locale.get("Avg level") + ": <font color='#ffc133'>" + Sprintf.format("%.1f", userData.lvl) + "</font> " +
            Locale.get("Spotted") + ": <font color='#ffc133'>" + Sprintf.format("%.2f", userData.spo / b) + "</font> " +
            Locale.get("Defence") + ": <font color='#ffc133'>" + Sprintf.format("%.2f", userData.def / b) + "</font> " +
            Locale.get("Capture") + ": <font color='#ffc133'>" + Sprintf.format("%.2f", userData.cap / b) + "</font> " +
            "<font size='10'>" + Locale.get("updated") + ":</font> <font size='11' color='#cccccc'>" + dt + "</font>" +
            "</span></textformat>";
    }
}
