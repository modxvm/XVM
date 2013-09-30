import events.SetDefaultValueEvent;
import events.ValueChangedEvent;

import flash.utils.clearTimeout;
import flash.utils.setTimeout;

import utils.ConfigUtilsEditor;

protected function updateValue(event:ValueChangedEvent):void
{
    //debug("updateValue");
    try
    {
        if (!event.sender.config)
        {
            error("config is null for: " + event.sender.id);
            return;
        }

        //debug(event.sender.config + "=" + event.sender.value);
        ConfigUtilsEditor.SetValue(event.sender.config, event.sender.value);
        if (preview)
            preview.update();
    }
    catch (ex:Error)
    {
        error(ex.toString(), "updateValue()");
    }
}

protected function updateMarkerValue(event:ValueChangedEvent):void
{
    //debug("updateMarkerValue");
    try
    {
        if (!event.sender.config)
        {
            error("config is null for: " + event.sender.id);
            return;
        }

        var activeElement:String = getActiveMarkerElement().id;
        if (activeElement == "DamageTextNavContent")
            activeElement = Object(vsMarkersDamageText.selectedChild).id;
        var activeMarkerStates:Array = getActiveMarkerStates();
        for each (var state:String in activeMarkerStates)
        {
            var config:String = "markers." + state + "." + activeElement + "." + event.sender.config;
            //debug(config + "=" + event.sender.value);
            ConfigUtilsEditor.SetValue(config, event.sender.value);
            if (preview)
                preview.update();
        }
    }
    catch (ex:*)
    {
        error(ex.toString(), "updateMarkerValue()");
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
            ConfigUtilsEditor.SetValue(config, values[state]);
            if (preview)
                preview.update();
        }
    }
    catch (ex:Error)
    {
        error(ex.toString(), "updateMarkerTextFieldValue()");
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
                ConfigUtilsEditor.SetDefaultValue("battleLoading.showClock");
                ConfigUtilsEditor.SetDefaultValue("battleLoading.showChances");
                ConfigUtilsEditor.SetDefaultValue("battleLoading.showChancesExp");
                ConfigUtilsEditor.SetDefaultValue("battleLoading.removeSquadIcon");
                break;

            case "battleLoading.text":
                ConfigUtilsEditor.SetDefaultValue("battleLoading.formatLeftNick");
                ConfigUtilsEditor.SetDefaultValue("battleLoading.formatRightNick");
                ConfigUtilsEditor.SetDefaultValue("battleLoading.formatLeftVehicle");
                ConfigUtilsEditor.SetDefaultValue("battleLoading.formatRightVehicle");
                break;

            case "statisticForm":
                ConfigUtilsEditor.SetDefaultValue("statisticForm.showChances");
                ConfigUtilsEditor.SetDefaultValue("statisticForm.showChancesExp");
                ConfigUtilsEditor.SetDefaultValue("statisticForm.removeSquadIcon");
                break;

            case "statisticForm.text":
                ConfigUtilsEditor.SetDefaultValue("statisticForm.formatLeftNick");
                ConfigUtilsEditor.SetDefaultValue("statisticForm.formatRightNick");
                ConfigUtilsEditor.SetDefaultValue("statisticForm.formatLeftVehicle");
                ConfigUtilsEditor.SetDefaultValue("statisticForm.formatRightVehicle");
                break;

            case "playersPanel":
                ConfigUtilsEditor.SetDefaultValue("playersPanel.alpha");
                ConfigUtilsEditor.SetDefaultValue("playersPanel.iconAlpha");
                ConfigUtilsEditor.SetDefaultValue("playersPanel.removeSquadIcon");
                break;

            case "battleResults":
                ConfigUtilsEditor.SetDefaultValue("battleResults.startPage");
                ConfigUtilsEditor.SetDefaultValue("battleResults.showNetIncome");
                ConfigUtilsEditor.SetDefaultValue("battleResults.showExtendedInfo");
                ConfigUtilsEditor.SetDefaultValue("battleResults.showChances");
                ConfigUtilsEditor.SetDefaultValue("battleResults.showChancesExp");
                break;

            default:
                if (!ConfigUtilsEditor.SetDefaultValue(path))
                    error("config not found: " + path);
        }
        if (preview)
            preview.update();
    }
    catch (ex:Error)
    {
        error(ex.toString(), "onSetDefaultValue()");
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
                /*case "damageText":
                    config_prefix += "damageText.";
                    ConfigUtilsEditor.SetDefaultValue(config_prefix + "visible");
                    ConfigUtilsEditor.SetDefaultValue(config_prefix + "x");
                    ConfigUtilsEditor.SetDefaultValue(config_prefix + "y");
                    ConfigUtilsEditor.SetDefaultValue(config_prefix + "alpha");
                    ConfigUtilsEditor.SetDefaultValue(config_prefix + "color");
                    ConfigUtilsEditor.SetDefaultValue(config_prefix + "speed");
                    ConfigUtilsEditor.SetDefaultValue(config_prefix + "maxRange");
                    ConfigUtilsEditor.SetDefaultValue(config_prefix + "damageMessage");
                    ConfigUtilsEditor.SetDefaultValue(config_prefix + "blowupMessage");
                    break;*/

                default:
                    ConfigUtilsEditor.SetDefaultValue(config_prefix + event.target.config);
            }
        }
        if (preview)
            preview.update();
    }
    catch (ex:Error)
    {
        error(ex.toString(), "onSetDefaultMarkerValue()");
    }
}
