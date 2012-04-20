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
