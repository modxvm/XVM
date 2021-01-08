/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.classic.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.BattleXvmMod;
    import com.xvm.battle.BattleXvmView;
    import com.xvm.battle.shared.playersPanel.PlayersPanelListItemProxyBase;
    import flash.events.MouseEvent;
    import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
    import net.wg.gui.battle.random.views.BattlePage;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListItem;

    public class PlayersPanelListItemProxy extends PlayersPanelListItemProxyBase
    {
        private static const SQUAD_ITEMS_AREA_WIDTH:int = 25;

        private static const DOG_TAG_OFFSET:int = -30;

        private var ui:PlayersPanelListItem;

        private var mopt_removeSquadIcon:Boolean;

        public function PlayersPanelListItemProxy(ui:PlayersPanelListItem, isLeftPanel:Boolean)
        {
            this.ui = ui;
            super(ui, isLeftPanel);
        }

        override protected function fix_state(state:int):int
        {
            return UI_PlayersPanel.fix_state(state);
        }

        override protected function setup():void
        {
            if (isXVMEnabled)
            {
                mopt_removeSquadIcon = Macros.FormatBooleanGlobal(mcfg.removeSquadIcon);
            }
            else
            {
                ui.dynamicSquad.squadIcon.alpha = 1;
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
                    mopt_removeSquadIcon = Macros.FormatBooleanGlobal(mcfg.removeSquadIcon);
                    break;
                default:
                    break;
            }
        }

        override protected function updateStandardFields():void
        {
            if (mopt_removeSquadIcon)
            {
                ui.dynamicSquad.squadIcon.alpha = 0;
            }
            else
            {
                ui.dynamicSquad.squadIcon.alpha = Macros.FormatNumber(mcfg.squadIconAlpha, currentPlayerState, 100) / 100.0;
            }
        }

        override protected function updatePositionsLeft(lastX:int):void
        {
            ui.x = -(lastX - (mopt_removeSquadIcon ? 0 : SQUAD_ITEMS_AREA_WIDTH));
            //Logger.add("ui.x=" + ui.x + " ui.vehicleIcon.x=" + ui.vehicleIcon.x);
            ui.dynamicSquad.x = -ui.x;
        }

        override protected function updatePositionsRight(lastX:int):void
        {
            ui.x = -(lastX + (mopt_removeSquadIcon ? 0 : SQUAD_ITEMS_AREA_WIDTH));
            ui.dynamicSquad.x = -ui.x;
            ui.dogTag.x = -ui.x + (mopt_removeSquadIcon ? 0 : DOG_TAG_OFFSET);
        }

        override protected function createExtraFields():void
        {
            var battlePageClassic:BattlePage = BattleXvmMod.battlePageClassic;
            var playersPanel:UI_PlayersPanel = battlePageClassic.playersPanel as UI_PlayersPanel;
            extraFieldsHidden.addEventListener(MouseEvent.MOUSE_MOVE, playersPanel.onMouseMoveHandler);
            extraFieldsHidden.addEventListener(MouseEvent.ROLL_OVER, playersPanel.onMouseRollOverHandler);
            extraFieldsHidden.addEventListener(MouseEvent.ROLL_OUT, playersPanel.onMouseRollOutHandler);
            BattleXvmView.battlePage.addChildAt(extraFieldsHidden, battlePageClassic.getChildIndex(playersPanel));
        }
    }
}
