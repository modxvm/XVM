import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.utils.ByteArray;

import mx.utils.ObjectUtil;

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
	var data:ByteArray = fr.data;
	ParseConfigXml(new XML(data.readUTFBytes(data.bytesAvailable)));
	fr = null;
}

private function ParseConfigXml(xml:XML):void
{
	try
	{
		//d.text = xml.toXMLString() + "\n";
		config = ConfigHelper.XmlToConfig(xml);
		d.text += "Конфигурация загружена.\n";
		//d.text += xml + "\n" + ObjectUtil.toString(config) + "\n";
	}
	catch (ex:Error)
	{
		d.text += "ParseConfigXml(): " + ex.toString() + "\n";
	}
	RefreshConfigData();
}

private function onLoadError(e:IOErrorEvent):void
{
	d.text += "Ошибка загрузки файла: " + e.text + "\n";
}

// SAVE
private function SaveConfig(xml:XML):void
{
	fr = new FileReference();
	fr.addEventListener(Event.COMPLETE, onFileSave);
	fr.addEventListener(Event.CANCEL,onCancelSave);
	fr.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
	fr.save(xml, lastFileName == "OTMData.xml" ? "XVM.xvmconf" : lastFileName);
}

private function onFileSave(e:Event):void
{
	d.text += "Конфигурация сохранена.\n";
	fr = null;
}

private function onCancelSave(e:Event):void
{
	fr = null;
}

private function onSaveError(e:IOErrorEvent):void
{
	d.text += "Ошибка сохранения файла: " + e.text + "\n";
	fr = null;
}
