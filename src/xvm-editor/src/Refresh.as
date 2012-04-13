import utils.Config;

protected function RefreshConfig():void
{
	debug("RefreshConfig()");
	try
	{
		if (!Config.s_config)
			Config.s_config = DefaultConfig.config;

		//debug(JSON.stringify(Config.s_config));
		RefreshCommonPage();
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
		this.p_battle.v_mirroredVehicleIcons.value = section.mirroredVehicleIcons;
		this.p_battle.v_showPostmortemTips.value = section.showPostmortemTips;
		this.p_battle.v_removePanelsModeSwitcher.value = section.removePanelsModeSwitcher;
		this.p_battle.v_drawGrid.value = section.drawGrid;

		section = Config.s_config.rating;
		this.p_rating.v_showPlayersStatistics.value = section.showPlayersStatistics;
		this.p_rating.v_loadEnemyStatsInFogOfWar.value = section.loadEnemyStatsInFogOfWar;
	}
	catch (ex:Error)
	{
		debug("ERROR: RefreshCommonPage(): " + ex.toString());
	}
}

private function RefreshBattleLoadingPage():void
{
	debug("RefreshBattleLoadingPage()");
	try
	{
		var section:*;

		section = Config.s_config.battleLoading;
		this.p_battleLoading.v_showClock.value = section.showClock;
		this.p_battleLoading.v_showChances.value = section.showChances;
		this.p_battleLoading.v_removeSquadIcon.value = section.removeSquadIcon;
		this.p_battleLoading_text.v_formatLeft.value = section.formatLeft;
		this.p_battleLoading_text.v_formatRight.value = section.formatRight;

		section = Config.s_config.battleLoading.clanIcon;
		this.p_battleLoading_icons.v_show.value = section.show;
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
		this.p_statisticForm.v_showChances.value = section.showChances;
		this.p_statisticForm.v_removeSquadIcon.value = section.removeSquadIcon;
		this.p_statisticForm_text.v_formatLeft.value = section.formatLeft;
		this.p_statisticForm_text.v_formatRight.value = section.formatRight;

		section = Config.s_config.statisticForm.clanIcon;
		this.p_statisticForm_icons.v_show.value = section.show;
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
		this.p_playersPanel.v_removeSquadIcon.value = section.removeSquadIcon;

		section = Config.s_config.playersPanel.clanIcon;
		this.p_playersPanel_icons.v_show.value = section.show;
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

// Markers

public static var ElementControls:Object = {
	vehicleIcon: [ "m_vehicleIcon" ],
	healthBar: [ "m_healthBar" ],
	damageText: [ "m_damageText", "m_damageText_font", "m_damageText_shadow" ],
	contourIcon: [ "m_contourIcon" ],
	levelIcon: [ "m_levelIcon" ],
	actionMarker: [ "m_actionMarker" ],
	textFields: [ "m_textFields" ],

	m_vehicleIcon: [ "v_visible", "v_x", "v_y", "v_alpha", "v_maxScale", "v_scaleX", "v_scaleY"],
	m_healthBar: ["v_visible", "v_x", "v_y", "v_alpha", "v_color", "v_lcolor", "v_width", "v_height", "v_border_size",
		"v_border_color", "v_border_alpha", "v_fill_alpha", "v_damage_color", "v_damage_alpha", "v_damage_fade"],
	m_damageText: ["v_visible", "v_x", "v_y", "v_alpha", "v_color", "v_lcolor", "v_maxRange", "v_damageMessage", "v_blowupMessage"],
	m_damageText_font: [ "v_name", "v_size", "v_align", "v_bold" ],
	m_damageText_shadow: [ "v_size", "v_strength", "v_angle", "v_distance", "v_color", "v_alpha" ],
	m_contourIcon: ["v_visible", "v_x", "v_y", "v_alpha", "v_color", "v_amount" ],
	m_levelIcon: ["v_visible", "v_x", "v_y", "v_alpha" ],
	m_actionMarker: ["v_visible", "v_x", "v_y", "v_alpha" ],
	m_textFields: []
};

private function RefreshMarkersPage():void
{
	debug("RefreshMarkersPage()");
	try
	{
		var activeMarkerStates:Array = getActiveMarkerStates();

		var activeElement:* = getActiveMarkerElement();
		for each (var mname:String in ElementControls[activeElement.id])
		{
			for each (var mname2:String in ElementControls[mname])
			{
				//debug(mname + "." + mname2);
				for each (var state:String in activeMarkerStates)
				{
					//var conf:String = "markers." + state + "." + activeElement.id + "." + this[mname][mname2].config;   
					//debug("  " + conf + "=" + Config.GetValue(conf));
				}
			}
		}
	}
	catch (ex:Error)
	{
		debug("ERROR: RefreshMarkersPage(): " + ex.toString());
	}
}
