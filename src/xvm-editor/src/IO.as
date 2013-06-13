import com.xvm.JSONx;
import com.xvm.JSONxLoader;

import components.MergeDialog;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.net.FileReferenceList;

import mx.managers.PopUpManager;

import utils.Config;
import utils.ConfigUtils;
import utils.ConfigUtilsEditor;
import utils.DefaultConfig;
import utils.Defines;
import utils.OTMConfigConverter;
import utils.PatchedXMLDecoder;
import utils.Utils;

private var loadCounter:int;
private var loadCache:Object;

private var merge:Boolean;
private var mergeDialog:MergeDialog;
private var config:Object;
private var frl:FileReferenceList;

// LOAD

private function LoadConfig(merge:Boolean):void
{
    this.merge = merge;
	frl = new FileReferenceList();
	frl.addEventListener(Event.SELECT, onFileLoadSelect);
	//frl.addEventListener(Event.CANCEL,onCancelLoad);
	frl.browse([ new FileFilter(_("FileFilterText"), "*.xc"), new FileFilter(_("FileFilterLegacyText"), "*.xvmconf;OTMData.xml") ]);
}

private function onFileLoadSelect(e:Event):void
{
	loadCache = {};
	for each (var fr:FileReference in FileReferenceList(e.target).fileList)
	{
		loadCounter++;
		fr.addEventListener(Event.COMPLETE, onLoadComplete);
		fr.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
		fr.load();
	}
}

private function onLoadComplete(e:Event):void
{
    try
    {
		var fr:FileReference = FileReference(e.target);
		loadCounter--;
    	var data:String = e.target.data.readUTFBytes(e.target.data.bytesAvailable);
		loadCache[fr.name] = JSONx.parse(data);

		if (loadCounter > 0)
			return;

		config = Utils.endsWith(".xml", fr.name.toLowerCase())
			? OTMConfigConverter.convert((new PatchedXMLDecoder()).decode(loadCache[fr.name]))
			: CollectConfig(loadCache);
		if (config == null)
			return;
		config = ConfigUtils.FixConfig(config);

		loadCache = null;

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
        error(ex.toString(), "onLoadComplete()");
    }
}

private function CollectConfig(parts:Object):Object
{

	for (var i:String in parts)
	{
		if (parts[i].hasOwnProperty("configVersion"))
		{
			try
			{
				return JSONxLoader.Deref(parts[i], 0, {f:i}, parts);
			}
			catch (ex:*)
			{
				error(ex.error.message, _("ErrorLoadingConfig"));
				return null;
			}
		}
	}
	error(_("NoRootElement"), "CollectConfig()");
	return null;
}

private function onLoadComplete2(e:Event):void
{
    try
    {
        if (merge)
        {
            if (mergeDialog.modalResult != true)
            {
                debug("Loading canceled");
                return;
            }
            config = mergeDialog.config;
        }
        Config.s_config = ConfigUtils.MergeConfigs(config, merge ? Config.s_config : DefaultConfig.config, "def");
        config = ConfigUtils.MergeConfigs(config, merge ? Config.s_config : DefaultConfig.config, "def");
        ConfigUtils.TuneupConfig();
        debug(_("ConfigurationLoaded"));
        RefreshCurrentPage();
    }
    catch (ex:Error)
    {
        error(ex.toString(), "onLoadComplete2()");
    }
    finally
    {
        mergeDialog = null;
    }
}

private function onLoadError(e:IOErrorEvent):void
{
	error(e.text, _("LoadFileError"));
}

// SAVE
private function SaveConfig():void
{
	var fr:FileReference = new FileReference();
	fr.addEventListener(Event.COMPLETE, onFileSave);
	fr.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
	// Serialize and add UTF-8 BOM
	var str:String = "\uFEFF/**\n" +
		" * Config was created in XVM Editor v" + utils.Defines.EDITOR_VERSION + "\n" +
		" * at " + (new Date()).toString() + "\n" +
		" */\n" +
		JSONx.stringify(ConfigUtilsEditor.SimplifyConfig(Config.s_config), null, false, sortFunction) + "\n";
	fr.save(str, "xvm.xc");
}

private function sortFunction(a:String, b:String):int
{
	var an:int = sortElementsOrder.indexOf(a);
	var bn:int = sortElementsOrder.indexOf(b);
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
	error(e.text, _("SaveFileError"));
}
