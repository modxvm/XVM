
import mx.core.UIComponent;

import events.XVMValueEvent;

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
	SaveConfig(JSON.stringify(Config.s_config));
}

protected function RefreshConfig():void
{
	debug("RefreshConfig()");
	try
	{
		if (!Config.s_config)
			Config.s_config = DefaultConfig.config;

		//debug(JSON.stringify(Config.s_config));
		RefreshCommonPage();		
		RefreshMarkersPage();
		RefreshBattleLoadingPage();
		RefreshStatisticFormPage();
		RefreshPlayersPanelPage();
		RefreshColorsPage();
		RefreshTransparencyPage();
		RefreshIconsetPage();
		RefreshPlayersPage();
	}
	catch (ex:Error)
	{
		debug("ERROR: RefreshConfigData(): " + ex.toString());
	}
}

private function RefreshCommonPage():void
{
	debug("RefreshCommonPage()");
	try
	{
		var section:*;

		section = Config.s_config.definition;
		this.p_definition.v_author.value = section.author;
		this.p_definition.v_description.value = section.description;
		this.p_definition.v_url.value = section.url;
		this.p_definition.v_date.value = section.date;
		this.p_definition.v_gameVersion.value = section.gameVersion;
		this.p_definition.v_modMinVersion.value = section.modMinVersion;
		
		section = Config.s_config.battle;
		this.p_battle.v_mirroredVehicleIcons.selected = section.mirroredVehicleIcons;
		this.p_battle.v_showPostmortemTips.selected = section.showPostmortemTips;
		this.p_battle.v_removePanelsModeSwitcher.selected = section.removePanelsModeSwitcher;
		this.p_battle.v_drawGrid.selected = section.drawGrid;
		
		section = Config.s_config.rating;
		this.p_rating.v_showPlayersStatistics.selected = section.showPlayersStatistics;
		this.p_rating.v_loadEnemyStatsInFogOfWar.selected = section.loadEnemyStatsInFogOfWar;
	}
	catch (ex:Error)
	{
		debug("ERROR: RefreshCommonPage(): " + ex.toString());
	}
}

private function RefreshMarkersPage():void
{
	debug("RefreshMarkersPage()");
	try
	{
/*		var activeElements:uint = gElements.getActiveElements();
		
		dp = Mapping.filterData(activeElements);
		adg.dataProvider = new HierarchicalData(dp);
		adg.validateNow();
		adg.expandAll();
		
		activeBehaviors = getActiveBehaviors();
		
		for each (var o1:Object in dp)
		{
			for each (var o2:Object in o1["children"])
			o2["value"] = PopulateValue(o2["path"]);
		}*/
	}
	catch (ex:Error)
	{
		debug("ERROR: RefreshMarkersPage(): " + ex.toString());
	}
}

private function RefreshBattleLoadingPage():void
{
	debug("RefreshBattleLoadingPage()");
	try
	{
		var section:*;
		
		section = Config.s_config.battleLoading;
		this.p_battleLoading.v_showClock.selected = section.showClock;
		this.p_battleLoading.v_showChances.selected = section.showChances;
		this.p_battleLoading.v_removeSquadIcon.selected = section.removeSquadIcon;
		this.p_battleLoading_text.v_formatLeft.value = section.formatLeft;
		this.p_battleLoading_text.v_formatRight.value = section.formatRight;
		
		section = Config.s_config.battleLoading.clanIcon;
		this.p_battleLoading_icons.v_show.selected = section.show;
		this.p_battleLoading_icons.v_x.value = section.x;
		this.p_battleLoading_icons.v_y.value = section.y;
		this.p_battleLoading_icons.v_w.value = section.w;
		this.p_battleLoading_icons.v_h.value = section.h;
		this.p_battleLoading_icons.v_alpha.value = section.alpha;
	}
	catch (ex:Error)
	{
		debug("ERROR: RefreshBattleLoadingPage(): " + ex.toString());
	}
}

private function RefreshStatisticFormPage():void
{
	debug("RefreshStatisticFormPage()");
	try
	{
		var section:*;
		
		section = Config.s_config.statisticForm;
		this.p_statisticForm.v_showChances.selected = section.showChances;
		this.p_statisticForm.v_removeSquadIcon.selected = section.removeSquadIcon;
		this.p_statisticForm_text.v_formatLeft.value = section.formatLeft;
		this.p_statisticForm_text.v_formatRight.value = section.formatRight;
		
		section = Config.s_config.statisticForm.clanIcon;
		this.p_statisticForm_icons.v_show.selected = section.show;
		this.p_statisticForm_icons.v_x.value = section.x;
		this.p_statisticForm_icons.v_y.value = section.y;
		this.p_statisticForm_icons.v_w.value = section.w;
		this.p_statisticForm_icons.v_h.value = section.h;
		this.p_statisticForm_icons.v_alpha.value = section.alpha;
	}
	catch (ex:Error)
	{
		debug("ERROR: RefreshStatisticFormPage(): " + ex.toString());
	}
}

private function RefreshPlayersPanelPage():void
{
	debug("RefreshPlayersPanelPage()");
	try
	{
		var section:*;
		
		section = Config.s_config.playersPanel;
		this.p_playersPanel.v_alpha.value = section.alpha;
		this.p_playersPanel.v_iconAlpha.value = section.iconAlpha;
		this.p_playersPanel.v_removeSquadIcon.selected = section.removeSquadIcon;
		
		section = Config.s_config.playersPanel.clanIcon;
		this.p_playersPanel_icons.v_show.selected = section.show;
		this.p_playersPanel_icons.v_x.value = section.x;
		this.p_playersPanel_icons.v_y.value = section.y;
		this.p_playersPanel_icons.v_w.value = section.w;
		this.p_playersPanel_icons.v_h.value = section.h;
		this.p_playersPanel_icons.v_alpha.value = section.alpha;

		section = Config.s_config.playersPanel.medium;
		this.p_playersPanel_medium.v_width.value = section.width;
		this.p_playersPanel_medium.v_formatLeft.value = section.formatLeft;
		this.p_playersPanel_medium.v_formatRight.value = section.formatRight;
		
		section = Config.s_config.playersPanel.medium2;
		this.p_playersPanel_medium2.v_width.value = section.width;
		this.p_playersPanel_medium2.v_formatLeft.value = section.formatLeft;
		this.p_playersPanel_medium2.v_formatRight.value = section.formatRight;
		
		section = Config.s_config.playersPanel.large;
		this.p_playersPanel_large.v_width.value = section.width;
		this.p_playersPanel_large.v_nickFormatLeft.value = section.nickFormatLeft;
		this.p_playersPanel_large.v_nickFormatRight.value = section.nickFormatRight;
		this.p_playersPanel_large.v_vehicleFormatLeft.value = section.vehicleFormatLeft;
		this.p_playersPanel_large.v_vehicleFormatRight.value = section.vehicleFormatRight;
	}
	catch (ex:Error)
	{
		debug("ERROR: RefreshPlayersPanelPage(): " + ex.toString());
	}
}

private function RefreshColorsPage():void
{
	debug("RefreshColorsPage()");
	try
	{
		var section:*;
		
		//section = Config.s_config.definition;
		//this.p_definition.author.value = section.author;
	}
	catch (ex:Error)
	{
		debug("ERROR: RefreshColorsPage(): " + ex.toString());
	}
}

private function RefreshTransparencyPage():void
{
	debug("RefreshTransparencyPage()");
	try
	{
		var section:*;
		
		//section = Config.s_config.definition;
		//this.p_definition.author.value = section.author;
	}
	catch (ex:Error)
	{
		debug("ERROR: RefreshTransparencyPage(): " + ex.toString());
	}
}

private function RefreshIconsetPage():void
{
	debug("RefreshIconsetPage()");
	try
	{
		var section:*;
		
		section = Config.s_config.iconset;
		this.p_iconSet.v_battleLoading.value = section.battleLoading;
		this.p_iconSet.v_statisticForm.value = section.statisticForm;
		this.p_iconSet.v_playersPanel.value = section.playersPanel;
		this.p_iconSet.v_vehicleMarker.value = section.vehicleMarker;
	}
	catch (ex:Error)
	{
		debug("ERROR: RefreshIconsetPage(): " + ex.toString());
	}
}

private function RefreshPlayersPage():void
{
	debug("RefreshPlayersPage()");
	try
	{
		var section:*;
		
		//section = Config.s_config.definition;
		//this.p_definition.author.value = section.author;
	}
	catch (ex:Error)
	{
		debug("ERROR: RefreshPlayersPage(): " + ex.toString());
	}
}

protected function updateValue(event:XVMValueEvent):void
{
	debug("updateValue");
	debug(JSON.stringify(event));
//	valueChanged_p(event.target as UIComponent);
}

protected function markerElementChanged(event:events.XVMValueEvent):void
{
//	RefreshMarkers();
}
