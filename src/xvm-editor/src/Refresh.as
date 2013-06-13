import components.DefaultComponent;

import utils.Config;
import utils.ConfigUtilsEditor;
import utils.DefaultConfig;
import utils.Utils;

protected function RefreshCurrentPage():void
{
    debug("RefreshCurrentPage()");
    try
    {
        var pg:Object = vsTabs.selectedChild;

        if (!Config.s_config)
            Config.s_config = DefaultConfig.config;

        var now: Date = new Date();

        //debug(JSONx.stringify(Config.s_config));

        if (pg == pgCommon)
            RefreshCommonPage();
        else if (pg == pgLogin)
            RefreshLoginPage();
        else if (pg == pgHangar)
            RefreshHangarPage();
        if (pg == pgBattle)
            RefreshBattlePage();
        else if (pg == pgHitLog)
            RefreshHitLogPage();
        else if (pg == pgCaptureBar)
            RefreshCaptureBarPage();
        else if (pg == pgMinimap)
            RefreshMinimapPage();
        else if (pg == pgBattleLoading)
            RefreshBattleLoadingPage();
        else if (pg == pgStatisticForm)
            RefreshStatisticFormPage();
        else if (pg == pgPlayersPanel1)
            RefreshPlayersPanel1Page();
        else if (pg == pgPlayersPanel2)
            RefreshPlayersPanel2Page();
        else if (pg == pgFinalStatistic)
            RefreshFinalStatisticPage();
        else if (pg == pgColors1)
            RefreshColorsPage1();
        else if (pg == pgColors2)
            RefreshColorsPage2();
        else if (pg == pgTransparency)
            RefreshTransparencyPage();
        else if (pg == pgTexts)
            RefreshTextsPage();
        else if (pg == pgMisc)
            RefreshMiscPage();
        else if (pg == pgVehicleNames)
            RefreshVehicleNamesPage();
        else if (pg == pgMarkers)
            RefreshMarkersPage();

        debug("  " + utils.Utils.elapsedMSec(now, new Date()) + " msec");

        if (preview)
            preview.update();
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshCurrentPage()");
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

        section = Config.s_config.rating;
        this.p_rating.v_showPlayersStatistics.value = section.showPlayersStatistics;
        this.p_rating.v_enableUserInfoStatistics.value = section.enableUserInfoStatistics;
        this.p_rating.v_enableCompanyStatistics.value = section.enableCompanyStatistics;
        this.p_rating.v_loadEnemyStatsInFogOfWar.value = section.loadEnemyStatsInFogOfWar;
        this.p_rating.v_enableStatisticsLog.value = section.enableStatisticsLog;
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshCommonPage()");
    }
}

private function RefreshLoginPage():void
{
    debug("RefreshLoginPage()");
    try
    {
        var section:*;

        section = Config.s_config.login.pingServers;
        this.p_pingServers_login.v_enabled.value = section.enabled;
        this.p_pingServers_login.v_updateInterval.value = section.updateInterval;
        this.p_pingServers_login.v_x.value = section.x;
        this.p_pingServers_login.v_y.value = section.y;
        this.p_pingServers_login.v_alpha.value = section.alpha;
        this.p_pingServers_login.v_delimiter.value = section.delimiter;
        this.p_pingServers_login.v_maxRows.value = section.maxRows;
        this.p_pingServers_login.v_columnGap.value = section.columnGap;
        this.p_pingServers_login.v_fontStyle_name.value = section.fontStyle.name;
        this.p_pingServers_login.v_fontStyle_size.value = section.fontStyle.size;
        this.p_pingServers_login.v_fontStyle_bold.value = section.fontStyle.bold;
        this.p_pingServers_login.v_fontStyle_italic.value = section.fontStyle.italic;
        this.p_pingServers_login.v_fontStyle_color_great.value = section.fontStyle.color.great;
        this.p_pingServers_login.v_fontStyle_color_good.value = section.fontStyle.color.good;
        this.p_pingServers_login.v_fontStyle_color_poor.value = section.fontStyle.color.poor;
        this.p_pingServers_login.v_fontStyle_color_bad.value = section.fontStyle.color.bad;
        this.p_pingServers_login.v_threshold_great.value = section.threshold.great;
        this.p_pingServers_login.v_threshold_good.value = section.threshold.good;
        this.p_pingServers_login.v_threshold_poor.value = section.threshold.poor;
        this.p_pingServers_login.v_shadow_enabled.value = section.shadow.enabled;
        this.p_pingServers_login.v_shadow_color.value = section.shadow.color;
        this.p_pingServers_login.v_shadow_distance.value = section.shadow.distance;
        this.p_pingServers_login.v_shadow_angle.value = section.shadow.angle;
        this.p_pingServers_login.v_shadow_alpha.value = section.shadow.alpha;
        this.p_pingServers_login.v_shadow_blur.value = section.shadow.blur;
        this.p_pingServers_login.v_shadow_strength.value = section.shadow.strength;
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshLoginPage()");
    }
}

private function RefreshHangarPage():void
{
    debug("RefreshHangarPage()");
    try
    {
        var section:*;

        section = Config.s_config.hangar;
        this.p_hangar.v_hideTutorial.value = section.hideTutorial;

        section = Config.s_config.userInfo;
        this.p_hangar.v_showEColumn.value = section.showEColumn;

        section = Config.s_config.squad;
        this.p_hangar.v_enabled.value = section.enabled;
        this.p_hangar.v_romanNumbers.value = section.romanNumbers;
        this.p_hangar.v_showClan.value = section.showClan;
        this.p_hangar.v_leftLvlBorder.value = section.leftLvlBorder;
        this.p_hangar.v_rightLvlBorder.value = section.rightLvlBorder;

        section = Config.s_config.hangar.pingServers;
        this.p_pingServers_hangar.v_enabled.value = section.enabled;
        this.p_pingServers_hangar.v_updateInterval.value = section.updateInterval;
        this.p_pingServers_hangar.v_x.value = section.x;
        this.p_pingServers_hangar.v_y.value = section.y;
        this.p_pingServers_hangar.v_alpha.value = section.alpha;
        this.p_pingServers_hangar.v_delimiter.value = section.delimiter;
        this.p_pingServers_hangar.v_maxRows.value = section.maxRows;
        this.p_pingServers_hangar.v_columnGap.value = section.columnGap;
        this.p_pingServers_hangar.v_fontStyle_name.value = section.fontStyle.name;
        this.p_pingServers_hangar.v_fontStyle_size.value = section.fontStyle.size;
        this.p_pingServers_hangar.v_fontStyle_bold.value = section.fontStyle.bold;
        this.p_pingServers_hangar.v_fontStyle_italic.value = section.fontStyle.italic;
        this.p_pingServers_hangar.v_fontStyle_color_great.value = section.fontStyle.color.great;
        this.p_pingServers_hangar.v_fontStyle_color_good.value = section.fontStyle.color.good;
        this.p_pingServers_hangar.v_fontStyle_color_poor.value = section.fontStyle.color.poor;
        this.p_pingServers_hangar.v_fontStyle_color_bad.value = section.fontStyle.color.bad;
        this.p_pingServers_hangar.v_threshold_great.value = section.threshold.great;
        this.p_pingServers_hangar.v_threshold_good.value = section.threshold.good;
        this.p_pingServers_hangar.v_threshold_poor.value = section.threshold.poor;
        this.p_pingServers_hangar.v_shadow_enabled.value = section.shadow.enabled;
        this.p_pingServers_hangar.v_shadow_color.value = section.shadow.color;
        this.p_pingServers_hangar.v_shadow_distance.value = section.shadow.distance;
        this.p_pingServers_hangar.v_shadow_angle.value = section.shadow.angle;
        this.p_pingServers_hangar.v_shadow_alpha.value = section.shadow.alpha;
        this.p_pingServers_hangar.v_shadow_blur.value = section.shadow.blur;
        this.p_pingServers_hangar.v_shadow_strength.value = section.shadow.strength;
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshHangarPage()");
    }
}

private function RefreshBattlePage():void
{
    debug("RefreshBattlePage()");
    try
    {
        var section:*;

        section = Config.s_config.battle;
        this.p_battle.v_mirroredVehicleIcons.value = section.mirroredVehicleIcons;
        this.p_battle.v_showPostmortemTips.value = section.showPostmortemTips;
        this.p_battle.v_removePanelsModeSwitcher.value = section.removePanelsModeSwitcher;
        this.p_battle.v_highlightVehicleIcon.value = section.highlightVehicleIcon;
        this.p_battle.v_useStandardMarkers.value = section.useStandardMarkers;
        this.p_battle.v_clockFormat.value = section.clockFormat;
        this.p_battle.v_clanIconsFolder.value = section.clanIconsFolder;

        section = Config.s_config.fragCorrelation;
        this.p_fragCorrelation.v_hideTeamTextFields.value = section.hideTeamTextFields;
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshBattlePage()");
    }
}

private function RefreshHitLogPage():void
{
    debug("RefreshHitLogPage()");
    try
    {
        var section:*;

        section = Config.s_config.hitLog;
        this.p_hitLog.v_visible.value = section.visible;
        this.p_hitLog.v_x.value = section.x;
        this.p_hitLog.v_y.value = section.y;
        this.p_hitLog.v_h.value = section.h;
        this.p_hitLog.v_w.value = section.w;
        this.p_hitLog.v_lines.value = section.lines;
        this.p_hitLog.v_direction.value = section.direction;
        this.p_hitLog.v_insertOrder.value = section.insertOrder;
        this.p_hitLog.v_groupHitsByPlayer.value = section.groupHitsByPlayer;
        this.p_hitLog.v_deadMarker.value = section.deadMarker;
        this.p_hitLog.v_blowupMarker.value = section.blowupMarker;
        this.p_hitLog.v_defaultHeader.value = section.defaultHeader;
        this.p_hitLog.v_formatHeader.value = section.formatHeader;
        this.p_hitLog.v_formatHistory.value = section.formatHistory;
        this.p_hitLog.v_shadow_size.value = section.shadow.size;
        this.p_hitLog.v_shadow_strength.value = section.shadow.strength;
        this.p_hitLog.v_shadow_angle.value = section.shadow.angle;
        this.p_hitLog.v_shadow_distance.value = section.shadow.distance;
        this.p_hitLog.v_shadow_color.value = section.shadow.color;
        this.p_hitLog.v_shadow_alpha.value = section.shadow.alpha;
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshHitLogPage()");
    }
}

private function RefreshCaptureBarPage():void
{
    debug("RefreshCaptureBarPage()");
    try
    {
        var section:*;

        section = Config.s_config.captureBar;
        this.p_captureBar.v_enabled.value = section.enabled;
        this.p_captureBar.v_primaryTitleOffset.value = section.primaryTitleOffset;
        this.p_captureBar.v_appendPlus.value = section.appendPlus;
        this.p_captureBar.v_ally_primaryTitleFormat.value = section.ally.primaryTitleFormat;
        this.p_captureBar.v_ally_secondaryTitleFormat.value = section.ally.secondaryTitleFormat;
        this.p_captureBar.v_ally_captureDoneFormat.value = section.ally.captureDoneFormat;
        this.p_captureBar.v_ally_extra.value = section.ally.extra;
        this.p_captureBar.v_ally_shadow_color.value = section.ally.shadow.color;
        this.p_captureBar.v_ally_shadow_alpha.value = section.ally.shadow.alpha;
        this.p_captureBar.v_ally_shadow_blur.value = section.ally.shadow.blur;
        this.p_captureBar.v_ally_shadow_strength.value = section.ally.shadow.strength;
        this.p_captureBar.v_enemy_primaryTitleFormat.value = section.enemy.primaryTitleFormat;
        this.p_captureBar.v_enemy_secondaryTitleFormat.value = section.enemy.secondaryTitleFormat;
        this.p_captureBar.v_enemy_captureDoneFormat.value = section.enemy.captureDoneFormat;
        this.p_captureBar.v_enemy_extra.value = section.enemy.extra;
        this.p_captureBar.v_enemy_shadow_color.value = section.enemy.shadow.color;
        this.p_captureBar.v_enemy_shadow_alpha.value = section.enemy.shadow.alpha;
        this.p_captureBar.v_enemy_shadow_blur.value = section.enemy.shadow.blur;
        this.p_captureBar.v_enemy_shadow_strength.value = section.enemy.shadow.strength;
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshCaptureBarPage()");
    }
}

private function RefreshMinimapPage():void
{
    debug("RefreshMinimapPage()");
    try
    {
        var section:*;

        section = Config.s_config.minimap;
        this.p_minimap.v_enabled.value = section.enabled;
        this.p_minimap.v_mapBackgroundImageAlpha.value = section.mapBackgroundImageAlpha;
        this.p_minimap.v_selfIconAlpha.value = section.selfIconAlpha;
        this.p_minimap.v_cameraAlpha.value = section.cameraAlpha;
        this.p_minimap.v_iconScale.value = section.iconScale;
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshMinimapPage()");
    }
}

private function RefreshBattleLoadingPage():void
{
    debug("RefreshBattleLoadingPage()");
    try
    {
        var section:*;

        section = Config.s_config.battleLoading;
        this.p_battleLoading.v_clockFormat.value = section.clockFormat;
        this.p_battleLoading.v_showChances.value = section.showChances;
        this.p_battleLoading.v_showChancesExp.value = section.showChancesExp;
        this.p_battleLoading.v_removeSquadIcon.value = section.removeSquadIcon;
        this.p_battleLoading_text.v_formatLeft.value = section.formatLeft;
        this.p_battleLoading_text.v_formatRight.value = section.formatRight;

        section = Config.s_config.battleLoading.clanIcon;
        this.p_battleLoading_icons.v_show.value = section.show;
        this.p_battleLoading_icons.v_x.value = section.x;
        this.p_battleLoading_icons.v_y.value = section.y;
        this.p_battleLoading_icons.v_xr.value = section.xr;
        this.p_battleLoading_icons.v_yr.value = section.yr;
        this.p_battleLoading_icons.v_w.value = section.w;
        this.p_battleLoading_icons.v_h.value = section.h;
        this.p_battleLoading_icons.v_alpha.value = section.alpha;
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshBattleLoadingPage()");
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
        this.p_statisticForm.v_showChancesExp.value = section.showChancesExp;
        this.p_statisticForm.v_removeSquadIcon.value = section.removeSquadIcon;
        this.p_statisticForm_text.v_formatLeft.value = section.formatLeft;
        this.p_statisticForm_text.v_formatRight.value = section.formatRight;

        section = Config.s_config.statisticForm.clanIcon;
        this.p_statisticForm_icons.v_show.value = section.show;
        this.p_statisticForm_icons.v_x.value = section.x;
        this.p_statisticForm_icons.v_y.value = section.y;
        this.p_statisticForm_icons.v_xr.value = section.xr;
        this.p_statisticForm_icons.v_yr.value = section.yr;
        this.p_statisticForm_icons.v_w.value = section.w;
        this.p_statisticForm_icons.v_h.value = section.h;
        this.p_statisticForm_icons.v_alpha.value = section.alpha;
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshStatisticFormPage()");
    }
}

private function RefreshPlayersPanel1Page():void
{
    debug("RefreshPlayersPanel1Page()");
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
        this.p_playersPanel_icons.v_xr.value = section.xr;
        this.p_playersPanel_icons.v_yr.value = section.yr;
        this.p_playersPanel_icons.v_w.value = section.w;
        this.p_playersPanel_icons.v_h.value = section.h;
        this.p_playersPanel_icons.v_alpha.value = section.alpha;

        section = Config.s_config.playersPanel.enemySpottedMarker;
        this.p_playersPanel_enemySpotted.v_enabled.value = section.enabled;
        this.p_playersPanel_enemySpotted.v_Xoffset.value = section.Xoffset;
        this.p_playersPanel_enemySpotted.v_Yoffset.value = section.Yoffset;
        this.p_playersPanel_enemySpotted.v_format_neverSeen.value = section.format.neverSeen;
        this.p_playersPanel_enemySpotted.v_format_lost.value = section.format.lost; 
        this.p_playersPanel_enemySpotted.v_format_revealed.value = section.format.revealed;
        this.p_playersPanel_enemySpotted.v_format_dead.value = section.format.dead;
        this.p_playersPanel_enemySpotted.v_format_artillery_neverSeen.value = section.format.artillery.neverSeen;
        this.p_playersPanel_enemySpotted.v_format_artillery_lost.value = section.format.artillery.lost;
        this.p_playersPanel_enemySpotted.v_format_artillery_revealed.value = section.format.artillery.revealed;
        this.p_playersPanel_enemySpotted.v_format_artillery_dead.value = section.format.artillery.dead;
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshPlayersPanel1Page()");
    }
}

private function RefreshPlayersPanel2Page():void
{
    debug("RefreshPlayersPanel2Page()");
    try
    {
        var section:*;

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
        error(ex.toString(), "RefreshPlayersPanel2Page()");
    }
}

private function RefreshFinalStatisticPage():void
{
    debug("RefreshFinalStatisticPage()");
    try
    {
        var section:*;

        section = Config.s_config.finalStatistic;
        this.p_finalStatistic.v_startPage.value = section.startPage;
        this.p_finalStatistic.v_sortColumn.value = section.sortColumn;
        this.p_finalStatistic.v_showChances.value = section.showChances;
        this.p_finalStatistic.v_showChancesExp.value = section.showChancesExp;
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshFinalStatisticPage()");
    }
}

private function RefreshColorsPage1():void
{
    debug("RefreshColorsPage1()");
    try
    {
        var section:Object;
        if (accColors1.selectedChild == nc_systemColors && p_systemColors != null)
        {
            section = Config.s_config.colors.system;
            if (p_systemColors.v_ally_alive != null)
                p_systemColors.v_ally_alive.value = section.ally_alive;
            if (p_systemColors.v_ally_dead != null)
                p_systemColors.v_ally_dead.value = section.ally_dead;
            if (p_systemColors.v_ally_blowedup != null)
                p_systemColors.v_ally_blowedup.value = section.ally_blowedup;
            if (p_systemColors.v_squadman_alive != null)
                p_systemColors.v_squadman_alive.value = section.squadman_alive;
            if (p_systemColors.v_squadman_dead != null)
                p_systemColors.v_squadman_dead.value = section.squadman_dead;
            if (p_systemColors.v_squadman_blowedup != null)
                p_systemColors.v_squadman_blowedup.value = section.squadman_blowedup;
            if (p_systemColors.v_teamKiller_alive != null)
                p_systemColors.v_teamKiller_alive.value = section.teamKiller_alive;
            if (p_systemColors.v_teamKiller_dead != null)
                p_systemColors.v_teamKiller_dead.value = section.teamKiller_dead;
            if (p_systemColors.v_teamKiller_blowedup != null)
                p_systemColors.v_teamKiller_blowedup.value = section.teamKiller_blowedup;
            if (p_systemColors.v_enemy_alive != null)
                p_systemColors.v_enemy_alive.value = section.enemy_alive;
            if (p_systemColors.v_enemy_dead != null)
                p_systemColors.v_enemy_dead.value = section.enemy_dead;
            if (p_systemColors.v_enemy_blowedup != null)
                p_systemColors.v_enemy_blowedup.value = section.enemy_blowedup;
        }
        else if (accColors1.selectedChild == nc_damageColors && p_damageColors != null)
        {
            section = Config.s_config.colors.damage;
            if (p_damageColors.v_ally_ally_hit != null)
                p_damageColors.v_ally_ally_hit.value = section.ally_ally_hit;
            if (p_damageColors.v_ally_ally_kill != null)
                p_damageColors.v_ally_ally_kill.value = section.ally_ally_kill;
            if (p_damageColors.v_ally_ally_blowup != null)
                p_damageColors.v_ally_ally_blowup.value = section.ally_ally_blowup;
            if (p_damageColors.v_ally_squadman_hit != null)
                p_damageColors.v_ally_squadman_hit.value = section.ally_squadman_hit;
            if (p_damageColors.v_ally_squadman_kill != null)
                p_damageColors.v_ally_squadman_kill.value = section.ally_squadman_kill;
            if (p_damageColors.v_ally_squadman_blowup != null)
                p_damageColors.v_ally_squadman_blowup.value = section.ally_squadman_blowup;
            if (p_damageColors.v_ally_enemy_hit != null)
                p_damageColors.v_ally_enemy_hit.value = section.ally_enemy_hit;
            if (p_damageColors.v_ally_enemy_kill != null)
                p_damageColors.v_ally_enemy_kill.value = section.ally_enemy_kill;
            if (p_damageColors.v_ally_enemy_blowup != null)
                p_damageColors.v_ally_enemy_blowup.value = section.ally_enemy_blowup;
            if (p_damageColors.v_ally_allytk_hit != null)
                p_damageColors.v_ally_allytk_hit.value = section.ally_allytk_hit;
            if (p_damageColors.v_ally_allytk_kill != null)
                p_damageColors.v_ally_allytk_kill.value = section.ally_allytk_kill;
            if (p_damageColors.v_ally_allytk_blowup != null)
                p_damageColors.v_ally_allytk_blowup.value = section.ally_allytk_blowup;
            if (p_damageColors.v_ally_enemytk_hit != null)
                p_damageColors.v_ally_enemytk_hit.value = section.ally_enemytk_hit;
            if (p_damageColors.v_ally_enemytk_kill != null)
                p_damageColors.v_ally_enemytk_kill.value = section.ally_enemytk_kill;
            if (p_damageColors.v_ally_enemytk_blowup != null)
                p_damageColors.v_ally_enemytk_blowup.value = section.ally_enemytk_blowup;
            if (p_damageColors.v_squadman_ally_hit != null)
                p_damageColors.v_squadman_ally_hit.value = section.squadman_ally_hit;
            if (p_damageColors.v_squadman_ally_kill != null)
                p_damageColors.v_squadman_ally_kill.value = section.squadman_ally_kill;
            if (p_damageColors.v_squadman_ally_blowup != null)
                p_damageColors.v_squadman_ally_blowup.value = section.squadman_ally_blowup;
            if (p_damageColors.v_squadman_squadman_hit != null)
                p_damageColors.v_squadman_squadman_hit.value = section.squadman_squadman_hit;
            if (p_damageColors.v_squadman_squadman_kill != null)
                p_damageColors.v_squadman_squadman_kill.value = section.squadman_squadman_kill;
            if (p_damageColors.v_squadman_squadman_blowup != null)
                p_damageColors.v_squadman_squadman_blowup.value = section.squadman_squadman_blowup;
            if (p_damageColors.v_squadman_enemy_hit != null)
                p_damageColors.v_squadman_enemy_hit.value = section.squadman_enemy_hit;
            if (p_damageColors.v_squadman_enemy_kill != null)
                p_damageColors.v_squadman_enemy_kill.value = section.squadman_enemy_kill;
            if (p_damageColors.v_squadman_enemy_blowup != null)
                p_damageColors.v_squadman_enemy_blowup.value = section.squadman_enemy_blowup;
            if (p_damageColors.v_squadman_allytk_hit != null)
                p_damageColors.v_squadman_allytk_hit.value = section.squadman_allytk_hit;
            if (p_damageColors.v_squadman_allytk_kill != null)
                p_damageColors.v_squadman_allytk_kill.value = section.squadman_allytk_kill;
            if (p_damageColors.v_squadman_allytk_blowup != null)
                p_damageColors.v_squadman_allytk_blowup.value = section.squadman_allytk_blowup;
            if (p_damageColors.v_squadman_enemytk_hit != null)
                p_damageColors.v_squadman_enemytk_hit.value = section.squadman_enemytk_hit;
            if (p_damageColors.v_squadman_enemytk_kill != null)
                p_damageColors.v_squadman_enemytk_kill.value = section.squadman_enemytk_kill;
            if (p_damageColors.v_squadman_enemytk_blowup != null)
                p_damageColors.v_squadman_enemytk_blowup.value = section.squadman_enemytk_blowup;
            if (p_damageColors.v_enemy_ally_hit != null)
                p_damageColors.v_enemy_ally_hit.value = section.enemy_ally_hit;
            if (p_damageColors.v_enemy_ally_kill != null)
                p_damageColors.v_enemy_ally_kill.value = section.enemy_ally_kill;
            if (p_damageColors.v_enemy_ally_blowup != null)
                p_damageColors.v_enemy_ally_blowup.value = section.enemy_ally_blowup;
            if (p_damageColors.v_enemy_squadman_hit != null)
                p_damageColors.v_enemy_squadman_hit.value = section.enemy_squadman_hit;
            if (p_damageColors.v_enemy_squadman_kill != null)
                p_damageColors.v_enemy_squadman_kill.value = section.enemy_squadman_kill;
            if (p_damageColors.v_enemy_squadman_blowup != null)
                p_damageColors.v_enemy_squadman_blowup.value = section.enemy_squadman_blowup;
            if (p_damageColors.v_enemy_enemy_hit != null)
                p_damageColors.v_enemy_enemy_hit.value = section.enemy_enemy_hit;
            if (p_damageColors.v_enemy_enemy_kill != null)
                p_damageColors.v_enemy_enemy_kill.value = section.enemy_enemy_kill;
            if (p_damageColors.v_enemy_enemy_blowup != null)
                p_damageColors.v_enemy_enemy_blowup.value = section.enemy_enemy_blowup;
            if (p_damageColors.v_enemy_allytk_hit != null)
                p_damageColors.v_enemy_allytk_hit.value = section.enemy_allytk_hit;
            if (p_damageColors.v_enemy_allytk_kill != null)
                p_damageColors.v_enemy_allytk_kill.value = section.enemy_allytk_kill;
            if (p_damageColors.v_enemy_allytk_blowup != null)
                p_damageColors.v_enemy_allytk_blowup.value = section.enemy_allytk_blowup;
            if (p_damageColors.v_enemy_enemytk_hit != null)
                p_damageColors.v_enemy_enemytk_hit.value = section.enemy_enemytk_hit;
            if (p_damageColors.v_enemy_enemytk_kill != null)
                p_damageColors.v_enemy_enemytk_kill.value = section.enemy_enemytk_kill;
            if (p_damageColors.v_enemy_enemytk_blowup != null)
                p_damageColors.v_enemy_enemytk_blowup.value = section.enemy_enemytk_blowup;
            if (p_damageColors.v_unknown_ally_hit != null)
                p_damageColors.v_unknown_ally_hit.value = section.unknown_ally_hit;
            if (p_damageColors.v_unknown_ally_kill != null)
                p_damageColors.v_unknown_ally_kill.value = section.unknown_ally_kill;
            if (p_damageColors.v_unknown_ally_blowup != null)
                p_damageColors.v_unknown_ally_blowup.value = section.unknown_ally_blowup;
            if (p_damageColors.v_unknown_squadman_hit != null)
                p_damageColors.v_unknown_squadman_hit.value = section.unknown_squadman_hit;
            if (p_damageColors.v_unknown_squadman_kill != null)
                p_damageColors.v_unknown_squadman_kill.value = section.unknown_squadman_kill;
            if (p_damageColors.v_unknown_squadman_blowup != null)
                p_damageColors.v_unknown_squadman_blowup.value = section.unknown_squadman_blowup;
            if (p_damageColors.v_unknown_enemy_hit != null)
                p_damageColors.v_unknown_enemy_hit.value = section.unknown_enemy_hit;
            if (p_damageColors.v_unknown_enemy_kill != null)
                p_damageColors.v_unknown_enemy_kill.value = section.unknown_enemy_kill;
            if (p_damageColors.v_unknown_enemy_blowup != null)
                p_damageColors.v_unknown_enemy_blowup.value = section.unknown_enemy_blowup;
            if (p_damageColors.v_unknown_allytk_hit != null)
                p_damageColors.v_unknown_allytk_hit.value = section.unknown_allytk_hit;
            if (p_damageColors.v_unknown_allytk_kill != null)
                p_damageColors.v_unknown_allytk_kill.value = section.unknown_allytk_kill;
            if (p_damageColors.v_unknown_allytk_blowup != null)
                p_damageColors.v_unknown_allytk_blowup.value = section.unknown_allytk_blowup;
            if (p_damageColors.v_unknown_enemytk_hit != null)
                p_damageColors.v_unknown_enemytk_hit.value = section.unknown_enemytk_hit;
            if (p_damageColors.v_unknown_enemytk_kill != null)
                p_damageColors.v_unknown_enemytk_kill.value = section.unknown_enemytk_kill;
            if (p_damageColors.v_unknown_enemytk_blowup != null)
                p_damageColors.v_unknown_enemytk_blowup.value = section.unknown_enemytk_blowup;
            if (p_damageColors.v_player_ally_hit != null)
                p_damageColors.v_player_ally_hit.value = section.player_ally_hit;
            if (p_damageColors.v_player_ally_kill != null)
                p_damageColors.v_player_ally_kill.value = section.player_ally_kill;
            if (p_damageColors.v_player_ally_blowup != null)
                p_damageColors.v_player_ally_blowup.value = section.player_ally_blowup;
            if (p_damageColors.v_player_squadman_hit != null)
                p_damageColors.v_player_squadman_hit.value = section.player_squadman_hit;
            if (p_damageColors.v_player_squadman_kill != null)
                p_damageColors.v_player_squadman_kill.value = section.player_squadman_kill;
            if (p_damageColors.v_player_squadman_blowup != null)
                p_damageColors.v_player_squadman_blowup.value = section.player_squadman_blowup;
            if (p_damageColors.v_player_enemy_hit != null)
                p_damageColors.v_player_enemy_hit.value = section.player_enemy_hit;
            if (p_damageColors.v_player_enemy_kill != null)
                p_damageColors.v_player_enemy_kill.value = section.player_enemy_kill;
            if (p_damageColors.v_player_enemy_blowup != null)
                p_damageColors.v_player_enemy_blowup.value = section.player_enemy_blowup;
            if (p_damageColors.v_player_allytk_hit != null)
                p_damageColors.v_player_allytk_hit.value = section.player_allytk_hit;
            if (p_damageColors.v_player_allytk_kill != null)
                p_damageColors.v_player_allytk_kill.value = section.player_allytk_kill;
            if (p_damageColors.v_player_allytk_blowup != null)
                p_damageColors.v_player_allytk_blowup.value = section.player_allytk_blowup;
            if (p_damageColors.v_player_enemytk_hit != null)
                p_damageColors.v_player_enemytk_hit.value = section.player_enemytk_hit;
            if (p_damageColors.v_player_enemytk_kill != null)
                p_damageColors.v_player_enemytk_kill.value = section.player_enemytk_kill;
            if (p_damageColors.v_player_enemytk_blowup != null)
                p_damageColors.v_player_enemytk_blowup.value = section.player_enemytk_blowup;
        }
        else if (accColors1.selectedChild == nc_damageKindColors && p_damageKindColors != null)
        {
            section = Config.s_config.colors.dmg_kind;
            if (p_damageKindColors.v_attack != null)
            	p_damageKindColors.v_attack.value = section.attack;
            if (p_damageKindColors.v_fire != null)
            	p_damageKindColors.v_fire.value = section.fire;
            if (p_damageKindColors.v_ramming != null)
            	p_damageKindColors.v_ramming.value = section.ramming;
            if (p_damageKindColors.v_world_collision != null)
            	p_damageKindColors.v_world_collision.value = section.world_collision;
            if (p_damageKindColors.v_other != null)
            	p_damageKindColors.v_other.value = section.other;
        }
        else if (accColors1.selectedChild == nc_vtypeColors && p_vtypeColors != null)
        {
            section = Config.s_config.colors.vtype;
            if (p_vtypeColors.v_LT != null)
                p_vtypeColors.v_LT.value = section.LT;
            if (p_vtypeColors.v_MT != null)
                p_vtypeColors.v_MT.value = section.MT;
            if (p_vtypeColors.v_HT != null)
                p_vtypeColors.v_HT.value = section.HT;
            if (p_vtypeColors.v_SPG != null)
                p_vtypeColors.v_SPG.value = section.SPG;
            if (p_vtypeColors.v_TD != null)
                p_vtypeColors.v_TD.value = section.TD;
            if (p_vtypeColors.v_premium != null)
                p_vtypeColors.v_premium.value = section.premium;
            if (p_vtypeColors.v_usePremiumColor != null)
                p_vtypeColors.v_usePremiumColor.value = section.usePremiumColor;
        }
        else if (accColors1.selectedChild == nc_colors_hp && p_colors_hp != null)
            p_colors_hp.RefreshSource();
        else if (accColors1.selectedChild == nc_colors_hp_ratio && p_colors_hp_ratio != null)
            p_colors_hp_ratio.RefreshSource();
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshColorsPage1()");
    }
}

private function RefreshColorsPage2():void
{
    debug("RefreshColorsPage2()");
    try
    {
        var section:Object;
        if (accColors2.selectedChild == nc_colors_x && p_colors_x != null)
            p_colors_x.RefreshSource();
        else if (accColors2.selectedChild == nc_colors_eff && p_colors_eff != null)
            p_colors_eff.RefreshSource();
        else if (accColors2.selectedChild == nc_colors_wn && p_colors_wn != null)
            p_colors_wn.RefreshSource();
        else if (accColors2.selectedChild == nc_colors_rating && p_colors_rating != null)
            p_colors_rating.RefreshSource();
        else if (accColors2.selectedChild == nc_colors_twr && p_colors_twr != null)
            p_colors_twr.RefreshSource();
        else if (accColors2.selectedChild == nc_colors_kb && p_colors_kb != null)
            p_colors_kb.RefreshSource();
        else if (accColors2.selectedChild == nc_colors_tbattles && p_colors_tbattles != null)
            p_colors_tbattles.RefreshSource();
        else if (accColors2.selectedChild == nc_colors_e && p_colors_e != null)
            p_colors_e.RefreshSource();
        else if (accColors2.selectedChild == nc_colors_tdb && p_colors_tdb != null)
            p_colors_tdb.RefreshSource();
        else if (accColors2.selectedChild == nc_colors_tdv && p_colors_tdv != null)
            p_colors_tdv.RefreshSource();
        else if (accColors2.selectedChild == nc_colors_tfb && p_colors_tfb != null)
            p_colors_tfb.RefreshSource();
        else if (accColors2.selectedChild == nc_colors_tsb && p_colors_tsb != null)
            p_colors_tsb.RefreshSource();
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshColorsPage2()");
    }
}

private function RefreshTransparencyPage():void
{
    debug("RefreshTransparencyPage()");
    try
    {
        if (accTransparency.selectedChild == nc_alpha_hp && p_alpha_hp != null)
            p_alpha_hp.RefreshSource();
        else if (accTransparency.selectedChild == nc_alpha_hp_ratio && p_alpha_hp_ratio != null)
            p_alpha_hp_ratio.RefreshSource();
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshTransparencyPage()");
    }
}

private function RefreshTextsPage():void
{
    debug("RefreshTextsPage()");
    try
    {
        var section:*;

        section = Config.s_config.turretMarkers;
        this.p_turretMarkers.v_highVulnerability.value = section.highVulnerability;
        this.p_turretMarkers.v_lowVulnerability.value = section.lowVulnerability;

        section = Config.s_config.texts.vtype;
        this.p_vtypeTexts.v_LT.value = section.LT;
        this.p_vtypeTexts.v_MT.value = section.MT;
        this.p_vtypeTexts.v_HT.value = section.HT;
        this.p_vtypeTexts.v_TD.value = section.TD;
        this.p_vtypeTexts.v_SPG.value = section.SPG;
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshTextsPage()");
    }
}

private function RefreshMiscPage():void
{
    debug("RefreshMiscPage()");
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
        error(ex.toString(), "RefreshMiscPage()");
    }
}

private function RefreshVehicleNamesPage():void
{
    debug("RefreshVehicleNamesPage()");
    try
    {
        p_vehicleNames.RefreshSource();
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshVehicleNamesPage()");
    }
}

// Markers

public const ElementControls:Object = {
    vehicleIcon: [ "m_vehicleIcon" ],
    healthBar: [ "m_healthBar" ],
    damageText: [ "m_damageText", "m_damageText_font", "m_damageText_shadow" ],
    contourIcon: [ "m_contourIcon" ],
    clanIcon: [ "m_clanIcon" ],
    levelIcon: [ "m_levelIcon" ],
    actionMarker: [ "m_actionMarker" ],

    m_vehicleIcon: [ "v_visible", "v_showSpeaker", "v_x", "v_y", "v_alpha", "v_maxScale", "v_scaleX", "v_scaleY" ],
    m_healthBar: [ "v_visible", "v_x", "v_y", "v_alpha", "v_color", "v_lcolor", "v_width", "v_height", "v_border_size",
        "v_border_color", "v_border_alpha", "v_fill_alpha", "v_damage_color", "v_damage_alpha", "v_damage_fade" ],
    m_damageText: [ "v_visible", "v_x", "v_y", "v_alpha", "v_color", "v_speed", "v_maxRange", "v_damageMessage", "v_blowupMessage" ],
    m_damageText_font: [ "v_name", "v_size", "v_align", "v_bold", "v_italic" ],
    m_damageText_shadow: [ "v_size", "v_strength", "v_angle", "v_distance", "v_color", "v_alpha" ],
    m_contourIcon: ["v_visible", "v_x", "v_y", "v_alpha", "v_color", "v_amount" ],
    m_clanIcon: ["v_visible", "v_x", "v_y", "v_w", "v_h", "v_alpha" ],
    m_levelIcon: ["v_visible", "v_x", "v_y", "v_alpha" ],
    m_actionMarker: ["v_visible", "v_x", "v_y", "v_alpha" ]
};

private function RefreshMarkersPage():void
{
    debug("RefreshMarkersPage()");
    try
    {
        var activeElement:* = getActiveMarkerElement();

        if (!activeElement)
            return;

        if (activeElement == textFields)
        {
            RefreshTextFields();
            return;
        }

        var activeMarkerStates:Array = getActiveMarkerStates();

        for each (var mname:String in ElementControls[activeElement.id])
        {
            for each (var mname2:String in ElementControls[mname])
            {
                if (this[mname] == null)
                    continue;
                var control:DefaultComponent = this[mname][mname2] as DefaultComponent;

                //debug(mname + "." + mname2);
                var valueSet: Boolean = false;
                var value:*;
                var valueOk: Boolean = true;
                for each (var state:String in activeMarkerStates)
                {
                    var conf:String = "markers." + state + "." + activeElement.id + "." + control.config;
                    //debug("  " + conf + "=" + Config.GetValue(conf));
                    //values.push(Config.GetValue(conf));
                    if (!valueSet)
                    {
                        valueSet = true;
                        value = ConfigUtilsEditor.GetValue(conf);
                    }
                    else
                    {
                        if (value != ConfigUtilsEditor.GetValue(conf))
                        {
                            valueOk = false;
                            break;
                        }
                    }
                }

                control.conflict = !valueOk;
                control.value = value;
            }
        }
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshMarkersPage()");
    }
}

private function RefreshTextFields():void
{
    debug("RefreshTextFields()");
    try
    {
        if (m_textFieldList != null)
            m_textFieldList.RefreshSource(getActiveMarkerStates());
    }
    catch (ex:Error)
    {
        error(ex.toString(), "RefreshTextFields()");
    }
}
