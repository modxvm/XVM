import flash.events.Event;

import mx.controls.Alert;
import mx.core.UIComponent;
import mx.events.MenuEvent;

import com.xvm.*;

import utils.ConfigUtils;
import com.xvm.misc.DefaultConfig;

public function error(str:String, title:String = ""):void
{
    if (title == "")
        title = _("Error");
    debug("ERROR: " + title + ": " + str);

    var alert:Alert = Alert.show(str, title);
}

public function debug(str:String):void
{
    preview.taDebug.text += str + "\n";
}

protected function createNewConfig():void
{
    Config.config = DefaultConfig.config;
    ConfigUtils.TuneupConfig();
    RefreshCurrentPage();
}

protected function onLoadConfigClick():void
{
	LoadConfig(false);
}

protected function onSaveConfigClick(trim:Boolean):void
{
	Config.config.editorVersion = Defines.EDITOR_VERSION;
	SaveConfig(trim);
}

protected function onSaveButtonClick(event:MenuEvent):void
{
	var value:String = event.item.value;
	//mx.controls.Menu(saveMenu.popUp).selectedIndex = 0;
    switch (value)
    {
        case "save":
            onSaveConfigClick(true);
            break;
        case "savefull":
            onSaveConfigClick(false);
            break;
    }
}

protected function onVehicleStateChanged(event:Event):void
{
    if (vsMarkers == null)
        return;

    vsMarkers.enabled = (ally.selected || enemy.selected) &&
		(alive.selected || dead.selected) &&
		(normal.selected || extended.selected);

    RefreshCurrentPage();
}

// find all selected marker states
private function getActiveMarkerStates():Array
{
	var res:Array = [];
	if (ally.selected && alive.selected && normal.selected)
		res.push("ally.alive.normal");
	if (ally.selected && alive.selected && extended.selected)
		res.push("ally.alive.extended");
	if (ally.selected && dead.selected && normal.selected)
		res.push("ally.dead.normal");
	if (ally.selected && dead.selected && extended.selected)
		res.push("ally.dead.extended");
	if (enemy.selected && alive.selected && normal.selected)
		res.push("enemy.alive.normal");
	if (enemy.selected && alive.selected && extended.selected)
		res.push("enemy.alive.extended");
	if (enemy.selected && dead.selected && normal.selected)
		res.push("enemy.dead.normal");
	if (enemy.selected && dead.selected && extended.selected)
		res.push("enemy.dead.extended");
	return res;
}

private function getActiveMarkerElement():Object
{
    return elements.selectedItem;
}
