
import mx.core.UIComponent;

import utils.Config;
import utils.DefaultConfig;
import utils.Defines;
import utils.JSON;

public const DEBUG:Boolean = false;

public function debug(str:String):void
{
	if (!DEBUG)
		return;
	taDebug.text += str + "\n";
}

protected function onCreateNewConfigClick():void
{
	lastFileName = "XVM.xvmconf";
	Config.s_config = DefaultConfig.config;
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
