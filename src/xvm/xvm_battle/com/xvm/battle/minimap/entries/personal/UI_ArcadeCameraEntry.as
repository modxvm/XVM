/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.minimap.entries.personal
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.minimap.*;
    import com.xvm.battle.vo.*;
    import net.wg.data.constants.*;

    public class UI_ArcadeCameraEntry extends ArcadeCameraEntry
    {
        private static const INVALID_UPDATE_XVM:int = InvalidationType.SYSTEM_FLAGS_BORDER << 10;

        public function UI_ArcadeCameraEntry()
        {
            //Logger.add("UI_ArcadeCameraEntry");
            super();
            Xvm.addEventListener(PlayerStateEvent.CHANGED, playerStateChanged);
            Xvm.addEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, update);
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(PlayerStateEvent.CHANGED, playerStateChanged);
            Xvm.removeEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, update);
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if (isInvalid(INVALID_UPDATE_XVM))
            {
                var playerState:VOPlayerState = BattleState.get(BattleGlobalData.playerVehicleID);
                updateDirectionAlpha(playerState);
            }
        }

        // PRIVATE

        private function update():void
        {
            invalidate(INVALID_UPDATE_XVM);
        }

        private function playerStateChanged(e:PlayerStateEvent):void
        {
            if (e.vehicleID == BattleGlobalData.playerVehicleID)
            {
                update();
            }
        }

        private function updateDirectionAlpha(playerState:VOPlayerState):void
        {
            directionPlaceholder.alpha = Macros.FormatNumber(UI_Minimap.cfg.directionTriangleAlpha, playerState, 100) / 100.0;
            directionLinePlaceholder.alpha = Macros.FormatNumber(UI_Minimap.cfg.directionLineAlpha, playerState, 100) / 100.0;
        }
    }
}
