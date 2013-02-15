import com.natecook.Sprintf;
import wot.utils.Config;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Locale;
import wot.utils.Logger;
import wot.utils.StatData;
import wot.utils.StatLoader;
import wot.utils.Utils;

class wot.UserInfo.UserInfo extends net.wargaming.profile.UserInfo
{
	var statisticsField: TextField;

    function UserInfo()
    {
        super();

        Utils.TraceXvmModule("UserInfo");

        //UserStat.s_loaded = false;
        //StatData.s_data = {};

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

		//StatLoader.LoadUserData(Config.s_game_region, );
	}

	// override
    function setCommonInfo()
    {
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
		//Logger.addObject(arguments, "setStat", 5);
		var battles = 0;
		var battlesExtraId = 0;
		var xp = 0;
		
		for (var i = 0; i < arguments.length; ++i)
		{
			switch (arguments[i]) {
				case "battlesCount":
					battles = extractNumber(arguments[i + 1]);
					Logger.add("battles=" + battles);
					battlesExtraId = i + 2;
					i += 2;
					break;

				case "wins":
					// battles
					var wins = extractNumber(arguments[i + 1]);
					Logger.add("wins=" + wins);
					var gwr = wins / battles * 100;
					var r1 = Math.round(gwr) / 100 + 0.005;
					Logger.add("r1=" + r1);
					var r2 = int(gwr) / 100 + 0.01;
					Logger.add("r2=" + r2);
					var b1 = (battles * r1 - wins) / (1 - r1);
					Logger.add("b1=" + b1);
					var b2 = (battles * r2 - wins) / (1 - r2);
					Logger.add("b2=" + b2);
					b1 = b1 % 1 == 0 ? b1 : (int(b1) + 1);
					b2 = b2 % 1 == 0 ? b2 : (int(b2) + 1);
					b1 = Math.max(0, b1);
					b2 = Math.max(0, b2);
					arguments[battlesExtraId] = (b2 > b1)
						? b1 + Locale.get(" to ") + (r2 * 100 - 0.5) + "% / " + b2 + Locale.get(" to ") + (r2 * 100) + "%"
						: b2 + Locale.get(" to ") + (r2 * 100) + "% / " + b1 + Locale.get(" to ") + (r2 * 100 + 0.5) + "%";

					// wins
					arguments[i + 2] = "   /   " + Sprintf.format("%.2f", wins / battles * 100) + "%";
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
				blocksArea.blockcredits.itemmaxXP.label, 1, "left");
		}
		//statisticsField.htmlText = "<span class='xvm_statisticsField'>EFF: <font color='#FF00FF'>XX</font> GWR: XX TWR: XX%</span>";
    }
}
