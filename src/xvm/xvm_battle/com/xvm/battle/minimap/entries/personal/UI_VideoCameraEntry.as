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
    import com.xvm.battle.minimap.entries.*;
    import com.xvm.battle.vo.*;
    import net.wg.data.constants.*;

    public class UI_VideoCameraEntry extends VideoCameraEntry
    {
        private static const INVALID_UPDATE_XVM:int = InvalidationType.SYSTEM_FLAGS_BORDER << 10;

        public function UI_VideoCameraEntry()
        {
            //Logger.add("UI_VideoCameraEntry");
            super();

            // Workaround: Label stays at creation point some time before first move.
            // It makes unpleasant label positioning at map center.
            x = MinimapEntriesConstants.OFFMAP_COORDINATE;
            y = MinimapEntriesConstants.OFFMAP_COORDINATE;

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
            try
            {
                if (isInvalid(INVALID_UPDATE_XVM))
                {
                    var playerState:VOPlayerState = BattleState.get(BattleGlobalData.playerVehicleID);
                    updateDirectionAlpha(playerState);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
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
        }
    }
}
