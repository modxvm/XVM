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
	var config:String = event.sender.config;
	//debug(config);
	
	var c: String;
	switch (config)
	{
		case "battleLoading":
			c = "battleLoading.showClock"; Config.SetValue(c, Config.GetValue(c, utils.DefaultConfig.config));
			c = "battleLoading.showChances"; Config.SetValue(c, Config.GetValue(c, utils.DefaultConfig.config));
			c = "battleLoading.removeSquadIcon"; Config.SetValue(c, Config.GetValue(c, utils.DefaultConfig.config));
			break;

		case "battleLoading.text":
			c = "battleLoading.formatLeft"; Config.SetValue(c, Config.GetValue(c, utils.DefaultConfig.config));
			c = "battleLoading.formatRight"; Config.SetValue(c, Config.GetValue(c, utils.DefaultConfig.config));
			break;
		
		case "statisticForm":
			c = "statisticForm.showChances"; Config.SetValue(c, Config.GetValue(c, utils.DefaultConfig.config));
			c = "statisticForm.removeSquadIcon"; Config.SetValue(c, Config.GetValue(c, utils.DefaultConfig.config));
			break;
		
		case "statisticForm.text":
			c = "statisticForm.formatLeft"; Config.SetValue(c, Config.GetValue(c, utils.DefaultConfig.config));
			c = "statisticForm.formatRight"; Config.SetValue(c, Config.GetValue(c, utils.DefaultConfig.config));
			break;
		
		case "playersPanel":
			c = "playersPanel.alpha"; Config.SetValue(c, Config.GetValue(c, utils.DefaultConfig.config));
			c = "playersPanel.iconAlpha"; Config.SetValue(c, Config.GetValue(c, utils.DefaultConfig.config));
			c = "playersPanel.removeSquadIcon"; Config.SetValue(c, Config.GetValue(c, utils.DefaultConfig.config));
			break;
		
		default:
			var defValue:Object = Config.GetValue(config, utils.DefaultConfig.config);
			if (defValue != null)
			{
				Config.SetValue(config, defValue);
				Config.TuneupConfig();
			}
			else
				debug("config not found: " + config);
	}
}

protected function onSetDefaultMarkerValue(event:SetDefaultValueEvent):void
{
	var config:String = event.sender.config;
	//debug(config);
}
