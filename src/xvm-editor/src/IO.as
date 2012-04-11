import flash.net.FileReference;

import mx.utils.ObjectUtil;

import utils.Config;
import utils.DefaultConfig;
import utils.JSON;
import utils.OTMConfigConverter;
import utils.PatchedXMLDecoder;
import utils.Utils;

private static const FILE_TYPES:Array =	[
	new FileFilter("Файл конфигурации XVM, OTM (*.xvmconf; *.xml)", "*.xvmconf; *.xml")
];

private var fr:FileReference;
private var lastFileName:String;

// LOAD

private function LoadConfig():void
{
	fr = new FileReference();
	fr.addEventListener(Event.SELECT, onFileLoadSelect);
	fr.addEventListener(Event.CANCEL,onCancelLoad);
	fr.browse(FILE_TYPES);
}

private function onFileLoadSelect(e:Event):void
{
	lastFileName = fr.name;
	fr.addEventListener(Event.COMPLETE, onLoadComplete);
	fr.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
	fr.load();
}

private function onCancelLoad(e:Event):void
{
	fr = null;
}

private function onLoadComplete(e:Event):void
{
	var data:String = fr.data.readUTFBytes(fr.data.bytesAvailable);
	if (Utils.endsWith(".xml", fr.name.toLowerCase()))
		ParseConfigXml((new PatchedXMLDecoder()).decode(data));
	else
		ParseConfigJson(data);
	fr = null;
}

private function ParseConfigXml(xml:*):void
{
	//debug(mx.utils.ObjectUtil.toString(xml));
	//debug("ParseConfigXml()");
	try
	{
		var config:* = OTMConfigConverter.convert(xml);
		Config.s_config = Config.MergeConfigs(Config.FixConfig(config), DefaultConfig.config);
		debug("Конфигурация загружена.");
		//debug(JSON.stringify(Config.s_config));
	}
	catch (ex:Error)
	{
		debug("ERROR: ParseConfigXml(): " + ex.toString());
	}
	RefreshConfig();
}

private function ParseConfigJson(str:String):void
{
	//debug("ParseConfigJson()");
	try
	{
		var config:* = JSON.parse(str);
		Config.s_config = Config.MergeConfigs(Config.FixConfig(config), DefaultConfig.config);
		Config.TuneupConfig();
		debug("Конфигурация загружена.");
		//debug(JSON.stringify(Config.s_config));
	}
	catch (ex:Error)
	{
		debug("ERROR: ParseConfigJson(): " + ex.toString());
	}
	RefreshConfig();
}

private function onLoadError(e:IOErrorEvent):void
{
	debug("Ошибка загрузки файла: " + e.text);
}

// SAVE
private function SaveConfig(str:String):void
{
	fr = new FileReference();
	fr.addEventListener(Event.COMPLETE, onFileSave);
	fr.addEventListener(Event.CANCEL,onCancelSave);
	fr.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
	fr.save(str, lastFileName.toLowerCase() == "otmdata.xml" ? "XVM.xvmconf" : lastFileName);
}

private function onFileSave(e:Event):void
{
	debug("Конфигурация сохранена.");
	fr = null;
}

private function onCancelSave(e:Event):void
{
	fr = null;
}

private function onSaveError(e:IOErrorEvent):void
{
	debug("Ошибка сохранения файла: " + e.text);
	fr = null;
}
