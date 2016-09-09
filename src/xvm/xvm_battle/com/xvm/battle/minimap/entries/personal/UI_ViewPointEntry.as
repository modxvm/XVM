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
    import com.xvm.extraFields.*;
    import com.xvm.battle.vo.*;
    import net.wg.data.constants.*;

    public class UI_ViewPointEntry extends ViewPointEntry implements IMinimapVehicleEntry
    {
        private static const INVALID_UPDATE_XVM:int = InvalidationType.SYSTEM_FLAGS_BORDER << 10;

        private static const DEFAULT_VEHICLE_ICON_WIDTH:Number = 188;
        private static const DEFAULT_VEHICLE_ICON_HEIGHT:Number = 226;
        private static const DEFAULT_VEHICLE_ICON_SCALE:Number = 0.5;

        private var _vehicleID:Number;

        private var _extraFields:ExtraFieldsGroup = null;
        private var _extraFieldsAlt:ExtraFieldsGroup = null;

        public function UI_ViewPointEntry()
        {
            //Logger.add("UI_ViewPointEntry");
            super();

            _vehicleID = BattleGlobalData.playerVehicleID;

            MinimapEntriesLabelsHelper.init(this);
        }

        override protected function onDispose():void
        {
            MinimapEntriesLabelsHelper.dispose(this);
            super.onDispose();
        }

        override protected function draw():void
        {
            super.draw();
            if (isInvalid(INVALID_UPDATE_XVM))
            {
                var playerState:VOPlayerState = BattleState.get(_vehicleID);
                updateVehicleIcon(playerState);
                updateLabels(playerState);
            }
        }

        public function setVehicleID(vehicleID:Number):void
        {
            if (_vehicleID != vehicleID)
            {
                _vehicleID = vehicleID;
                invalidate(INVALID_UPDATE_XVM);
            }
        }

        // IMinimapVehicleEntry

        public function get extraFields():ExtraFieldsGroup
        {
            return _extraFields;
        }

        public function set extraFields(value:ExtraFieldsGroup):void
        {
            _extraFields = value;
        }

        public function get extraFieldsAlt():ExtraFieldsGroup
        {
            return _extraFieldsAlt;
        }

        public function set extraFieldsAlt(value:ExtraFieldsGroup):void
        {
            _extraFieldsAlt = value;
        }

        public function playerStateChanged(e:PlayerStateEvent):void
        {
            if (e.vehicleID == _vehicleID)
            {
                update();
            }
        }

        public function update():void
        {
            invalidate(INVALID_UPDATE_XVM);
        }

        public function onEnterFrame():void
        {
            MinimapEntriesLabelsHelper.onEnterFrameHandler(this);
        }

        // PRIVATE

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
            MinimapEntriesLabelsHelper.updateLabels(this, playerState);
        }
   }
}
