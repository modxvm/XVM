import components.MergeDialog;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.FileFilter;
import flash.net.FileReferenceList;

import mx.managers.PopUpManager;

import utils.Config;
import utils.DefaultConfig;
import utils.Utils;

private var frl:FileReferenceList;
private var lastFileName:String;
private var merge:Boolean;
private var mergeDialog:MergeDialog;
private var config:Object;

// LOAD

private function LoadConfig(merge:Boolean):void
{
    this.merge = merge;
	frl = new FileReferenceList();
	frl.addEventListener(Event.SELECT, onFileLoadSelect);
	frl.addEventListener(Event.CANCEL,onCancelLoad);
	frl.browse([ new FileFilter(_("FileFilterText"), "*.xvmconf") ]);
}

private function onFileLoadSelect(e:Event):void
{
	lastFileName = frl.fileList[0].name;
	for each (var fr in frl)
	{
		fr.addEventListener(Event.COMPLETE, onLoadComplete);
		fr.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
		fr.load();
	}
}

private function onCancelLoad(e:Event):void
{
	frl = null;
}

private function onLoadComplete(e:Event):void
{
    try
    {
    	var data:String = fr.data.readUTFBytes(fr.data.bytesAvailable);
        config = Config.FixConfig(utils.JSON.parse(data));

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
        Config.s_config = Config.MergeConfigs(config, merge ? Config.s_config : DefaultConfig.config);
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
	fr.save(str, lastFileName);
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
