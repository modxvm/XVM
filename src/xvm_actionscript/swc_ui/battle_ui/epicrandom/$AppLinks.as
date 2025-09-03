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

import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list.PlayersPanelListLeft; PlayersPanelListLeft;
import net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list.PlayersPanelListRight; PlayersPanelListRight;
import net.wg.gui.battle.epicRandom.battleloading.EpicRandomBattleLoadingForm; EpicRandomBattleLoadingForm;
import net.wg.gui.battle.epicRandom.views.EpicRandomPage; EpicRandomPage;
import net.wg.gui.battle.epicRandom.battleloading.renderers.TableEpicRandomPlayerItemRenderer; TableEpicRandomPlayerItemRenderer;
import net.wg.gui.battle.epicRandom.battleloading.renderers.TipEpicRandomPlayerItemRenderer; TipEpicRandomPlayerItemRenderer;

/**
 * UIs
 */

// epicRandomBattleLoading.swf
epicRandomBattleLoadingUI;

// epicRandomFullStats.swf
CLIENT::LESTA {
epicRandomFullStatsUI;
}

// epicRandomPlayersPanel.swf
EpicRandomPlayersPanelListItemLeftUI;
EpicRandomPlayersPanelListItemRightUI;
epicRandomPlayersPanelUI;

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
