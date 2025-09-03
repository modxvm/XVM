/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.minimap.entries.personal
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.shared.minimap.*;
    import com.xvm.battle.shared.minimap.entries.*;
    import com.xvm.battle.vo.*;
    import net.wg.data.constants.*;

    public class UI_VideoCameraEntry extends VideoCameraEntry
    {
        private static const INVALID_UPDATE_XVM:int = InvalidationType.SYSTEM_FLAGS_BORDER << 10;

        private var _entryDeleted:Boolean = false;

        public function UI_VideoCameraEntry()
        {
            //Logger.add("UI_VideoCameraEntry");
            super();
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init();
        }

        private function _init():void
        {
            // Workaround: Label stays at creation point some time before first move.
            // It makes unpleasant label positioning at map center.
            x = MinimapEntriesConstants.OFFMAP_COORDINATE;
            y = MinimapEntriesConstants.OFFMAP_COORDINATE;

            Xvm.addEventListener(PlayerStateEvent.CHANGED, playerStateChanged);
            Xvm.addEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, update);
        }

        override protected function onDispose():void
        {
            if (!_entryDeleted)
            {
                xvm_delEntry();
            }
            super.onDispose();
        }

        override protected function draw() : void
        {
            if (_entryDeleted)
            {
                Logger.add("WARNING: draw() on deleted VideoCameraEntry");
                return;
            }

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

        // DAAPI

        public function xvm_delEntry():void
        {
            _entryDeleted = true;

            Xvm.removeEventListener(PlayerStateEvent.CHANGED, playerStateChanged);
            Xvm.removeEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, update);
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
