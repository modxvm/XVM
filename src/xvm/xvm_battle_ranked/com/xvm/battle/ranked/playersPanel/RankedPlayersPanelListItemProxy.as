/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.ranked.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.BattleXvmMod;
    import com.xvm.battle.BattleXvmView;
    import com.xvm.battle.shared.playersPanel.PlayersPanelListItemProxyBase;
    import flash.events.MouseEvent;
    import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
    import net.wg.gui.battle.ranked.stats.components.playersPanel.list.PlayersPanelListItem;

    public class RankedPlayersPanelListItemProxy extends PlayersPanelListItemProxyBase
    {
        private static const RANK_ICON_AREA_WIDTH:int = 24;

        private var ui:PlayersPanelListItem;

        private var mopt_removeRankIcon:Boolean;

        public function RankedPlayersPanelListItemProxy(ui:PlayersPanelListItem, isLeftPanel:Boolean)
        {
            super(ui, isLeftPanel);
            this.ui = ui;
        }

        override protected function fix_state(state:int):int
        {
            return UI_RankedPlayersPanel.fix_state(state);
        }

        override protected function setup():void
        {
            if (isXVMEnabled)
            {
                // TODO: use separate option (removeRankIcon)
                mopt_removeRankIcon = Macros.FormatBooleanGlobal(mcfg.removeSquadIcon);
            }
            else
            {
                ui.rankIcon.alpha = 1;
            }
        }

        override protected function applyState():void
        {
            switch (state)
            {
                case PLAYERS_PANEL_STATE.FULL:
                case PLAYERS_PANEL_STATE.LONG:
                case PLAYERS_PANEL_STATE.MEDIUM:
                case PLAYERS_PANEL_STATE.SHORT:
                    // TODO: use separate option (removeRankIcon)
                    mopt_removeRankIcon = Macros.FormatBooleanGlobal(mcfg.removeSquadIcon);
                    break;
                default:
                    break;
            }
        }

        override protected function updateStandardFields():void
        {
            if (mopt_removeRankIcon)
            {
                ui.rankIcon.alpha = 0;
            }
            else
            {
                // TODO: use separate option (rankIconAlpha)
                ui.rankIcon.alpha = Macros.FormatNumber(mcfg.squadIconAlpha, currentPlayerState, 100) / 100.0;
            }
        }

        override protected function updatePositionsLeft(lastX:int):void
        {
            ui.x = -(lastX - (mopt_removeRankIcon ? 0 : RANK_ICON_AREA_WIDTH));
            //Logger.add("ui.x=" + ui.x + " ui.vehicleIcon.x=" + ui.vehicleIcon.x);
            ui.rankIcon.x = -ui.x;
        }

        override protected function updatePositionsRight(lastX:int):void
        {
            ui.x = -(lastX + (mopt_removeRankIcon ? 0 : RANK_ICON_AREA_WIDTH));
            ui.rankIcon.x = -ui.x - RANK_ICON_AREA_WIDTH;
        }

        override protected function createExtraFields():void
        {
            extraFieldsHidden.addEventListener(MouseEvent.MOUSE_MOVE, (BattleXvmMod.battlePageRanked.playersPanel as UI_RankedPlayersPanel).onMouseMoveHandler);
            extraFieldsHidden.addEventListener(MouseEvent.ROLL_OVER, (BattleXvmMod.battlePageRanked.playersPanel as UI_RankedPlayersPanel).onMouseRollOverHandler);
            extraFieldsHidden.addEventListener(MouseEvent.ROLL_OUT, (BattleXvmMod.battlePageRanked.playersPanel as UI_RankedPlayersPanel).onMouseRollOutHandler);
            BattleXvmView.battlePage.addChildAt(extraFieldsHidden, BattleXvmMod.battlePageRanked.getChildIndex(BattleXvmMod.battlePageRanked.playersPanel));
        }
    }
}
