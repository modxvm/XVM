import components.MergeDialog;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.FileFilter;
import flash.net.FileReference;

import mx.collections.XMLListCollection;
import mx.managers.PopUpManager;
import mx.utils.ObjectUtil;

import utils.Config;
import utils.DefaultConfig;
import utils.OTMConfigConverter;
import utils.PatchedXMLDecoder;
import utils.Utils;

private var fr:FileReference;
private var lastFileName:String;
private var merge:Boolean;
private var mergeDialog:MergeDialog;
private var config:Object;

// LOAD

private function LoadConfig(merge:Boolean):void
{
    this.merge = merge;
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
    try
    {
    	var data:String = fr.data.readUTFBytes(fr.data.bytesAvailable);
        config = Utils.endsWith(".xml", fr.name.toLowerCase())
            ? OTMConfigConverter.convert((new PatchedXMLDecoder()).decode(data))
            : utils.JSON.parse(data)

        if (!merge)
            onLoadComplete2(null);
        else
        {
            mergeDialog = PopUpManager.createPopUp(this, MergeDialog, true) as MergeDialog;
            mergeDialog.config = config;
            mergeDialog.addEventListener(Event.CLOSE, onLoadComplete2);
            PopUpManager.centerPopUp(mergeDialog);
        }
    }
    catch (ex:Error)
    {
        debug("ERROR: onLoadComplete(): " + ex.toString());
    }
    finally
    {
        fr = null;
    }
}

private function onLoadComplete2(e:Event):void
{
    try
    {
        if (merge)
        {
            if (mergeDialog.modalResult != true)
            {
                debug(_("Loaded Canceled"));
                return;
            }
            config = mergeDialog.config;
        }
        Config.s_config = Config.MergeConfigs(Config.FixConfig(config), DefaultConfig.config);
        Config.TuneupConfig();
        debug(_("ConfigurationLoaded"));
        RefreshCurrentPage();
    }
    catch (ex:Error)
    {
        debug("ERROR: onLoadComplete2(): " + ex.toString());
    }
    finally
    {
        mergeDialog = null;
    }
}

private function clenupConfig(config:*, data:XMLList):*
{

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
