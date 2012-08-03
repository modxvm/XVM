import flash.events.Event;

import mx.core.UIComponent;

import utils.Config;
import utils.DefaultConfig;
import utils.Defines;
import utils.JSON;

public const DEBUG:Boolean = false;

public function debug(str:String):void
{
	if (!DEBUG || !preview || !preview.taDebug)
		return;
	preview.taDebug.text += str + "\n";
}

protected function onCreateNewConfigClick():void
{
	lastFileName = "XVM.xvmconf";
	Config.s_config = DefaultConfig.config;
	Config.TuneupConfig();
	RefreshConfig();
}

protected function onLoadConfigClick():void
{
	LoadConfig();
}

protected function onSaveConfigClick():void
{
	Config.s_config.editorVersion = Defines.EDITOR_VERSION;
	SaveConfig();
}

protected function onVehicleStateChanged(event:Event):void
{
	//var target:* = event.target;
	vsMarkers.enabled = (ally.selected || enemy.selected) &&
		(alive.selected || dead.selected) &&
		(normal.selected || extended.selected);

	RefreshMarkersPage();
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
