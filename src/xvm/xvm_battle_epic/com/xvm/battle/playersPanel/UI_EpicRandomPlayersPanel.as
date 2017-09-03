/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import net.wg.data.constants.generated.*;

    public class UI_EpicRandomPlayersPanel extends epicRandomPlayersPanelUI
    {
        override public function as_setPanelMode(param1:int):void
        {
            super.as_setPanelMode(param1);
            BattleState.playersPanelMode = state;
            BattleState.playersPanelWidthLeft = listLeft.getRenderersVisibleWidth();
            BattleState.playersPanelWidthRight = listRight.getRenderersVisibleWidth();
        }
    }
}
