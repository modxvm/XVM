package helpers
{
	import mx.utils.ObjectUtil;

	// Convert OTMData.xml => XVM 1.0.0
	public class OTMConfigConverter
	{
		private var otm:Object;
		private var xvm:Object;

		private var dbg:Array = [];

		public function OTMConfigConverter(otm:Object):void
		{
			//dbg.push(ObjectUtil.toString(otm));

			this.otm = otm;
			xvm = {};
			xvm["configVersion"] = "1.0.0";

			Copy("definition/author", "definition/author");
			Copy("definition/description", "definition/description");
			Copy("definition/mod-page", "definition/url");
			Copy("definition/date", "definition/date", function(o:Object):Object { return new Date(o); });
			Copy("definition/game-version", "definition/gameVersion");
			Copy("definition/mod-version-min", "definition/modVersion");
			Copy("battle/showPostmortemTips", "battle/showPostmortemTips");

			xvm["behaviors"] = {};
			ConvertComponents();
			ConvertBehavior();

			//dbg.push(ObjectUtil.toString(xvm));

			if (dbg.length > 0)
				throw new Error(dbg.join("\n"));
		}

		public function get config():Object
		{
			return xvm;
		}

		private function Copy(otmpath:String, xvmpath:String, convertFunc:Function = null):void
		{
			var value:* = ConfigHelper.GetConfigValue(otm, otmpath);
			//dbg.push(otmpath + "=" + ObjectUtil.toString(value));
			
			if (value != null)
				ConfigHelper.SetConfigValue(xvm, xvmpath, value);
		}

		private function CopyX(otmpath:String, xvmpaths:Array, xvmpath_suffix:String = null, convertFunc:Function = null):void
		{
			for each (var xvmpath:String in xvmpaths)
			{
				//dbg.push(otmpath + " > " + (xvmpath_suffix ? xvmpath + "/" + xvmpath_suffix : xvmpath));
				Copy(otmpath, xvmpath_suffix ? xvmpath + "/" + xvmpath_suffix : xvmpath, convertFunc);
			}
		}

		// HINT: elements with name "value" deserialized as array, and actual value is "value[1]".
		private var otmComponentsMap:Object = {
			"combatScrollText/enabled/value/1": "combatScrollText/visible",
			"combatScrollText/speed/value/1": "combatScrollText/speed",
			"combatScrollText/maxRange/value/1": "combatScrollText/maxRange",
			"combatScrollText/textSize/value/1": "combatScrollText/font/size",
			//"combatScrollText/message": "", // Обрабатывается отдельно
			//"combatScrollText/prefix": "", // Обрабатывается отдельно
			//"combatScrollText/postfix": "", // Обрабатывается отдельно
			"combatScrollText/filter/size": "combatScrollText/shadow/size",
			"combatScrollText/filter/angle": "combatScrollText/shadow/angle",
			"combatScrollText/filter/distance": "combatScrollText/shadow/distance",
			"combatScrollText/filter/color": "combatScrollText/shadow/color",
			"combatScrollText/filter/alpha": "combatScrollText/shadow/alpha",
			"combatScrollText/filter/strength": "combatScrollText/shadow/strength",
			//"combatScrollText/hitKind": "", // Обрабатывается отдельно
			"combatScrollText/font": "combatScrollText/font/fontName",
			"contourIcon/tint/amount": "contourIcon/amount",
			"currentHealth/format/size": "currentHealth/font/size",
			"currentHealth/format/align": "currentHealth/font/align",
			"currentHealth/format/font": "currentHealth/font/font",
			"currentHealth/filter/size": "currentHealth/shadow/size",
			"currentHealth/filter/angle": "currentHealth/shadow/angle",
			"currentHealth/filter/distance": "currentHealth/shadow/distance",
			"currentHealth/filter/color": "currentHealth/shadow/color",
			"currentHealth/filter/alpha": "currentHealth/shadow/alpha",
			"currentHealth/filter/strength": "currentHealth/shadow/strength",
			"currentHealth/maxValue/enabled": "currentHealth/showMaxValue",
			"healthBar/border/size": "healthBar/border/size",
			"healthBar/border/color": "healthBar/border/color",
			"healthBar/border/alpha": "healthBar/border/alpha",
			"healthBar/fill/width": "healthBar/width",
			"healthBar/fill/height": "healthBar/height",
			"healthBar/fill/color": "healthBar/fill/color",
			"healthBar/fill/alpha": "healthBar/fill/alpha",
			"healthBar/damage/fade": "healthBar/damage/fade",
			"healthBar/damage/alpha": "healthBar/damage/alpha",
			"healthRatio/format/size": "healthRatio/font/size",
			"healthRatio/format/align": "healthRatio/font/align",
			"healthRatio/format/font": "healthRatio/font/font",
			"healthRatio/filter/size": "healthRatio/shadow/size",
			"healthRatio/filter/angle": "healthRatio/shadow/angle",
			"healthRatio/filter/distance": "healthRatio/shadow/distance",
			"healthRatio/filter/color": "healthRatio/shadow/color",
			"healthRatio/filter/alpha": "healthRatio/shadow/alpha",
			"healthRatio/filter/strength": "healthRatio/shadow/strength",
			"playerName/format/size": "playerName/font/size",
			"playerName/format/align": "playerName/font/align",
			"playerName/format/font": "playerName/font/font",
			"playerName/filter/size": "playerName/shadow/size",
			"playerName/filter/angle": "playerName/shadow/angle",
			"playerName/filter/distance": "playerName/shadow/distance",
			"playerName/filter/color": "playerName/shadow/color",
			"playerName/filter/alpha": "playerName/shadow/alpha",
			"playerName/filter/strength": "playerName/shadow/strength",
			//"vehicleIcon/fill": "", // TODO: what to do with it?
			"vehicleIcon/scale/maxScale": "vehicleIcon/maxScale",
			"vehicleIcon/scale/x": "vehicleIcon/scaleX",
			"vehicleIcon/scale/y": "vehicleIcon/scaleY",
			"vehicleName/format/size": "vehicleName/font/size",
			"vehicleName/format/align": "vehicleName/font/align",
			"vehicleName/format/font": "vehicleName/font/font",
			"vehicleName/filter/size": "vehicleName/shadow/size",
			"vehicleName/filter/angle": "vehicleName/shadow/angle",
			"vehicleName/filter/distance": "vehicleName/shadow/distance",
			"vehicleName/filter/color": "vehicleName/shadow/color",
			"vehicleName/filter/alpha": "vehicleName/shadow/alpha",
			"vehicleName/filter/strength": "vehicleName/shadow/strength"
		};

		private var xp_status_mode_friend:Array = [
			"ally/alive/normal", "ally/alive/extended", "ally/dead/normal", "ally/dead/extended",
			"squad/alive/normal", "squad/alive/extended", "squad/dead/normal", "squad/dead/extended",
			"teamKiller/alive/normal", "teamKiller/alive/extended", "teamKiller/dead/normal", "ally/dead/extended",
		];
		private var xp_status_mode_enemy:Array = [
			"enemy/alive/normal", "enemy/alive/extended", "enemy/dead/normal", "enemy/dead/extended",
		];
		private function ConvertComponents():void
		{
			// components/friend/actionMarker
			for (var i1:String in otm["components"])
			{
				var op:String = "components/" + i1 + "/";
				var xp:Array = ((i1 == "friend") ? xp_status_mode_friend : xp_status_mode_enemy).map(
					function(o:*, i:int, a:Array):String { return "behaviors/" + String(o); });
				for (var o:String in otmComponentsMap)
					CopyX(op + o, xp, otmComponentsMap[o]);

				// Convert combat scroll texts
				var cstPrefix:String = ConfigHelper.GetConfigValue(otm, op + "combatScrollText/prefix");
				var cstPostfix:String = ConfigHelper.GetConfigValue(otm, op + "combatScrollText/postfix");
				var cstHitKind:String = ConfigHelper.GetConfigValue(otm, op + "combatScrollText/hitKind");
				var damageMessage:String = (cstHitKind && cstHitKind.toLowerCase() == "relative") ? "{{percent}}" : "{{dmg}}";
				if (cstPrefix)
					damageMessage = cstPrefix + damageMessage;
				if (cstPostfix)
					damageMessage += cstPostfix;

				var blowupMessage:String = ConfigHelper.GetConfigValue(otm, op + "combatScrollText/message");
				
				for each (var xvmpath:String in xp)
				{
					ConfigHelper.SetConfigValue(xvm, xvmpath + "/combatScrollText/damageMessage", damageMessage);
					ConfigHelper.SetConfigValue(xvm, xvmpath + "/combatScrollText/blowupMessage", blowupMessage);
				}
			}
		}

		private var xp_friend:Array = [	"ally", "squad", "teamKiller" ];
		private var xp_enemy:Array = [ "enemy" ];
		private function ConvertBehavior():void
		{
			// behavior/friend/alive/normal/actionMarker
			for (var i1:String in otm["behavior"])
			{
				for (var i2:String in otm["behavior"][i1])
				{
					for (var i3:String in otm["behavior"][i1][i2])
					{
						for (var i4:String in otm["behavior"][i1][i2][i3])
						{
							var op:String = "behavior/" + i1 + "/" + i2 + "/" + i3 + "/" + i4 + "/";
							var xp:Array = ((i1 == "friend") ? xp_friend : xp_enemy).map(
								function(o:*, i:int, a:Array):String { return "behaviors/" + String(o); });
							for (var o:String in otm["behavior"][i1][i2][i3][i4])
							{
								//dbg.push(op + o + ", [" + xp.join(",") + "], " + i2 + "/" + i3 + "/" + i4 + "/" + o);
								CopyX(op + o, xp, i2 + "/" + i3 + "/" + i4 + "/" + o);
							}
						}
					}
				}
			}
		}
	}
}
