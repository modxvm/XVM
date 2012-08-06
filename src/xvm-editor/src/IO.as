import flash.net.FileReference;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.FileFilter;

import mx.utils.ObjectUtil;

import utils.Config;
import utils.DefaultConfig;
import utils.OTMConfigConverter;
import utils.PatchedXMLDecoder;
import utils.Utils;

private var fr:FileReference;
private var lastFileName:String;

// LOAD

private function LoadConfig():void
{
	fr = new FileReference();
	fr.addEventListener(Event.SELECT, onFileLoadSelect);
	fr.addEventListener(Event.CANCEL,onCancelLoad);
	fr.browse([ new FileFilter(_("FileFilterText"), "*.xvmconf; *.xml") ]);
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
		Config.TuneupConfig();
		debug(_("ConfigurationLoaded"));
		//debug(utils.JSON.stringify(Config.s_config));
	}
	catch (ex:Error)
	{
		debug("ERROR: ParseConfigXml(): " + ex.toString());
	}
    RefreshCurrentPage();
}

private function ParseConfigJson(str:String):void
{
	//debug("ParseConfigJson()");
	try
	{
		var config:* = utils.JSON.parse(str);
		Config.s_config = Config.MergeConfigs(Config.FixConfig(config), DefaultConfig.config);
		Config.TuneupConfig();
		debug(_("ConfigurationLoaded"));
		//debug(utils.JSON.stringify(Config.s_config));
	}
	catch (ex:Error)
	{
		debug("ERROR: ParseConfigJson(): " + ex.toString());
	}
    RefreshCurrentPage();
}

private function onLoadError(e:IOErrorEvent):void
{
	debug(_("LoadFileError") + ": " + e.text);
}

// SAVE
private function SaveConfig():void
{
	fr = new FileReference();
	fr.addEventListener(Event.COMPLETE, onFileSave);
	fr.addEventListener(Event.CANCEL,onCancelSave);
	fr.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
	// Serialize and add UTF-8 BOM
	var str:String = "\uFEFF" + utils.JSON.stringify(Config.s_config);
	fr.save(str, lastFileName.toLowerCase() == "otmdata.xml" ? "XVM.xvmconf" : lastFileName);
}

private function onFileSave(e:Event):void
{
	debug(_("ConfigurationSaved"));
	fr = null;
}

private function onCancelSave(e:Event):void
{
	fr = null;
}

private function onSaveError(e:IOErrorEvent):void
{
	debug(_("SaveFileError") + ": " + e.text);
	fr = null;
}
