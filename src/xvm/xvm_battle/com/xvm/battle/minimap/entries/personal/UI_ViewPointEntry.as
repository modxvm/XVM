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

    public class UI_ViewPointEntry extends ViewPointEntry
    {
        private static const INVALID_UPDATE_XVM:int = InvalidationType.SYSTEM_FLAGS_BORDER << 10;

        private static const DEFAULT_VEHICLE_ICON_WIDTH:Number = 188;
        private static const DEFAULT_VEHICLE_ICON_HEIGHT:Number = 226;
        private static const DEFAULT_VEHICLE_ICON_SCALE:Number = 0.5;

        public function UI_ViewPointEntry()
        {
            //Logger.add("UI_ViewPointEntry");
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
            if (isInvalid(INVALID_UPDATE_XVM))
            {
                var playerState:VOPlayerState = BattleState.get(BattleGlobalData.playerVehicleID);
                updateVehicleIcon(playerState);
                updateLabels(playerState);
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

        private function updateVehicleIcon(playerState:VOPlayerState):void
        {
            arrowPlaceholder.alpha = Macros.FormatNumber(UI_Minimap.cfg.selfIconAlpha, playerState, 100) / 100.0;
            var iconScale:Number = Macros.FormatNumber(UI_Minimap.cfg.selfIconScale, playerState, 1);
            arrowPlaceholder.x = -DEFAULT_VEHICLE_ICON_WIDTH * iconScale / 4.0;
            arrowPlaceholder.y = -DEFAULT_VEHICLE_ICON_HEIGHT * iconScale / 2.0 + 11 * iconScale;
            arrowPlaceholder.scaleX = arrowPlaceholder.scaleY = DEFAULT_VEHICLE_ICON_SCALE * iconScale;
        }

        private function updateLabels(playerState:VOPlayerState):void
        {
            // TODO
        }
   }
}
