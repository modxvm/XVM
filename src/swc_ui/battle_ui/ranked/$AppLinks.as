package
{

internal class $AppLinks
{

/**
 *  @private
 *  This class is used to link additional classes into wg_*.swc
 *  beyond those that are found by dependecy analysis starting
 *  from the classes specified in manifest.xml.
 */

import net.wg.gui.battle.ranked.stats.components.playersPanel.list.PlayersPanelListLeft; PlayersPanelListLeft;
import net.wg.gui.battle.ranked.stats.components.playersPanel.list.PlayersPanelListRight; PlayersPanelListRight;
import net.wg.gui.battle.ranked.battleloading.BattleLoadingForm; BattleLoadingForm;

/**
 * UIs
 */

// rankedBattleLoading.swf
RankedBattleLoadingUI;

// rankedFullStats.swf
RankedFullStatsUI;

// rankedPlayersPanel.swf
RankedPlayersPanelListItemLeftUI;
RankedPlayersPanelListItemRightUI;
RankedPlayersPanelUI;

// teamBasesPanel.swf
teamBasesPanelUI;
TeamCaptureBarUI;

// minimap.swf
minimapUI;

// minimapEntriesLibrary.swf
CellFlashEntry;
DeadPointEntry;
VideoCameraEntry;
ViewPointEntry;
ViewRangeCirclesEntry;
VehicleEntry;
CLIENT::WG {
ArcadeCameraEntry;
StrategicCameraEntry;
}
CLIENT::LESTA {
DirectionEntry;
RectangleAreaMinimapEntry;
}

// sixthSense.swf
sixthSenseUI;

}

}
