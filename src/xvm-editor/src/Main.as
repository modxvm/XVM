import events.*;

import mx.core.UIComponent;

protected function onCreateNewConfigClick():void
{
	// TODO: remove after implementing markers editing
//	tabs.removeChild(pgMarkers);
	/////////////////////

//	lastFileName = "XVM.xvmconf";



	//ParseConfig(ConfigHelper.ConfigToJson(new Object()));
//	this.c_definition_url.text = "http://code.google.com/p/wot-xvm/"; // TODO: use default value (from schema?)
//	valueChanged_p(this.c_definition_url);
//	this.c_definition_date.selectedDate = new Date();
//	valueChanged_p(this.c_definition_date);
//	this.c_definition_gameVersion.text = "0.7.1"; // TODO: use default value (from schema?)
//	valueChanged_p(this.c_definition_gameVersion);
//	this.c_definition_modVersion.text = "1.0"; // TODO: use default value (from schema?)
//	valueChanged_p(this.c_definition_modVersion);
}

protected function onLoadConfigClick():void
{
//	LoadConfig();
}

protected function onSaveConfigClick():void
{
//	config["editorVersion"] = EDITOR_VERSION;
//	SaveConfig(ConfigHelper.ConfigToXml(config));
}


protected function valueChanged(event:Event):void
{
//	valueChanged_p(event.target as UIComponent);
}

protected function markerElementChanged(event:events.XVMValueEvent):void
{
//	RefreshMarkers();
}
