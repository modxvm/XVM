/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.epicrandom.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import net.wg.data.constants.generated.*;
    import net.wg.infrastructure.interfaces.IDAAPIDataClass;

    public class UI_EpicRandomPlayersPanel extends epicRandomPlayersPanelUI
    {
        private static const OFFSET:int = 70;

        override protected function setListsState(state:int):void
        {
            super.setListsState(state);
            updateBattleStatePlayersPanelData();
        }

        override protected function applyVehicleData(param1:IDAAPIDataClass):void
        {
            super.applyVehicleData(param1);
            updateBattleStatePlayersPanelData();
        }

        // PRIVATE

        private function updateBattleStatePlayersPanelData():void
        {
            BattleState.playersPanelMode = state == PLAYERS_PANEL_STATE.EPIC_RANDOM_THREE_COLUMN_HIDDEN ? PLAYERS_PANEL_STATE.HIDDEN : state;
            BattleState.playersPanelWidthLeft = listLeft.getRenderersVisibleWidth() - OFFSET;
            BattleState.playersPanelWidthRight = listRight.getRenderersVisibleWidth() - OFFSET;
        }
    }
}
