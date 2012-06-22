import events.ValueChangedEvent;

import utils.Config;

protected function updateValue(event:ValueChangedEvent):void
{
	//debug("updateValue");
	try
	{
		if (!event.sender.config)
		{
			debug("ERROR: config is null for: " + event.sender.id);
			return;
		}

		//debug(event.sender.config + "=" + event.sender.value);
		Config.SetValue(event.sender.config, event.sender.value);
	}
	catch (ex:Error)
	{
		debug("ERROR: updateValue(): " + ex.toString());
	}
}

protected function updateMarkerValue(event:ValueChangedEvent):void
{
	//debug("updateMarkerValue");
	try
	{
		if (!event.sender.config)
		{
			debug("ERROR: config is null for: " + event.sender.id);
			return;
		}

		var activeElement:String = getActiveMarkerElement().id;
		var activeMarkerStates:Array = getActiveMarkerStates();
		for each (var state:String in activeMarkerStates)
		{
			var config:String = "markers." + state + "." + activeElement + "." + event.sender.config;
			//debug(config + "=" + event.sender.value);
			Config.SetValue(config, event.sender.value);
		}
	}
	catch (ex:Error)
	{
		debug("ERROR: updateMarkerValue(): " + ex.toString());
	}
}

protected function updateMarkerTextFieldValue(event:ValueChangedEvent):void
{
	//debug("updateMarkerTextFieldValue");
	try
	{
		var values:Object = event.sender.value;
		var activeElement:String = getActiveMarkerElement().id;
		var activeMarkerStates:Array = getActiveMarkerStates();
		for each (var state:String in activeMarkerStates)
		{
			var config:String = "markers." + state + "." + activeElement;
			//debug(config + "=" + event.sender.value);
			Config.SetValue(config, values[state]);
		}
	}
	catch (ex:Error)
	{
		debug("ERROR: updateMarkerTextFieldValue(): " + ex.toString());
	}
}

protected function onSetDefaultValue(event:SetDefaultValueEvent):void
{
	try
	{
		var path:String = event.sender.config;
		//debug(config);

		switch (path)
		{
			case "battleLoading":
				Config.SetDefaultValue("battleLoading.showClock");
				Config.SetDefaultValue("battleLoading.showChances");
				Config.SetDefaultValue("battleLoading.showChancesExp");
				Config.SetDefaultValue("battleLoading.removeSquadIcon");
				break;

			case "battleLoading.text":
				Config.SetDefaultValue("battleLoading.formatLeft");
				Config.SetDefaultValue("battleLoading.formatRight");
				break;

			case "statisticForm":
				Config.SetDefaultValue("statisticForm.showChances");
				Config.SetDefaultValue("statisticForm.showChancesExp");
				Config.SetDefaultValue("statisticForm.removeSquadIcon");
				break;

			case "statisticForm.text":
				Config.SetDefaultValue("statisticForm.formatLeft");
				Config.SetDefaultValue("statisticForm.formatRight");
				break;

			case "playersPanel":
				Config.SetDefaultValue("playersPanel.alpha");
				Config.SetDefaultValue("playersPanel.iconAlpha");
				Config.SetDefaultValue("playersPanel.removeSquadIcon");
				break;

			default:
				if (!Config.SetDefaultValue(path))
					debug("config not found: " + path);
		}
	}
	catch (ex:Error)
	{
		debug("ERROR: onSetDefaultValue(): " + ex.toString());
	}
}

protected function onSetDefaultMarkerValue(event:SetDefaultValueEvent):void
{
	debug("onSetDefaultMarkerValue()");
	try
	{
		var activeMarkerStates:Array = getActiveMarkerStates();
		for each (var state:String in activeMarkerStates)
		{
			var config_prefix:String = "markers." + state + ".";

			switch (event.target.config)
			{
				case "damageText":
					config_prefix += "damageText.";
					Config.SetDefaultValue(config_prefix + "visible");
					Config.SetDefaultValue(config_prefix + "x");
					Config.SetDefaultValue(config_prefix + "y");
					Config.SetDefaultValue(config_prefix + "alpha");
					Config.SetDefaultValue(config_prefix + "color");
					Config.SetDefaultValue(config_prefix + "speed");
					Config.SetDefaultValue(config_prefix + "maxRange");
					Config.SetDefaultValue(config_prefix + "damageMessage");
					Config.SetDefaultValue(config_prefix + "blowupMessage");
					break;

				default:
					Config.SetDefaultValue(config_prefix + event.target.config);
			}
		}
	}
	catch (ex:Error)
	{
		debug("ERROR: onSetDefaultMarkerValue(): " + ex.toString());
	}
}
