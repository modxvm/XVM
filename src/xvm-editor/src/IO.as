import com.xvm.JSONx;

import components.MergeDialog;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.net.FileReferenceList;

import mx.managers.PopUpManager;

import utils.Config;
import utils.ConfigUtils;
import utils.DefaultConfig;
import utils.Defines;
import utils.Utils;

private var merge:Boolean;
private var mergeDialog:MergeDialog;
private var config:Object;

// LOAD

private function LoadConfig(merge:Boolean):void
{
    this.merge = merge;
	var frl:FileReferenceList = new FileReferenceList();
	frl.addEventListener(Event.SELECT, onFileLoadSelect);
	//frl.addEventListener(Event.CANCEL,onCancelLoad);
	frl.browse([ new FileFilter(_("FileFilterText"), "*.xc"), new FileFilter(_("FileFilterLegacyText"), "*.xvmconf;OTMData.xml") ]);
}

private function onFileLoadSelect(e:Event):void
{
	for each (var fr:FileReference in FileReferenceList(e.target).fileList)
	{
		fr.addEventListener(Event.COMPLETE, onLoadComplete);
		fr.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
		fr.load();
	}
}

private function onLoadComplete(e:Event):void
{
    try
    {
		debug(JSONx.stringify(e));		
    	var data:String = e.target.data.readUTFBytes(e.target.data.bytesAvailable);
        config = ConfigUtils.FixConfig(JSONx.parse(data));

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
        Config.s_config = ConfigUtils.MergeConfigs(config, merge ? Config.s_config : DefaultConfig.config, "def");
        ConfigUtils.TuneupConfig();
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
	var fr = new FileReference();
	fr.addEventListener(Event.COMPLETE, onFileSave);
	fr.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
	// Serialize and add UTF-8 BOM
	var str:String = "\uFEFF/* Config was created in XVM Editor v" + utils.Defines.EDITOR_VERSION + " */\n" + 
		JSONx.stringify(Config.s_config, null, false, sortFunction) + "\n";
	fr.save(str, "xvm.xc");
}

private function sortFunction(a, b):int
{
	var an = sortElementsOrder.indexOf(a); 
	var bn = sortElementsOrder.indexOf(b); 
	if (an >= 0 && bn == -1)
		return -1;
	if (bn >= 0 && an == -1)
		return 1;
	if (an >= 0 && bn >= 0)
		return an < bn ? -1 : an > bn ? 1 : 0;
	return a < b ? -1 : a > b ? 1 : 0; 
}

private function onFileSave(e:Event):void
{
	debug(_("ConfigurationSaved"));
}

private function onSaveError(e:IOErrorEvent):void
{
	debug(_("SaveFileError") + ": " + e.text);
}
