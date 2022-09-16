/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 * @author s_sorochich
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.shared.minimap.entries.vehicle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.shared.minimap.*;
    import com.xvm.battle.shared.minimap.entries.*;
    import com.xvm.battle.vo.*;
    import com.xvm.extraFields.*;
    import net.wg.gui.battle.views.minimap.components.entries.vehicle.*;

    public class UI_VehicleEntry extends VehicleEntry implements IMinimapVehicleEntry
    {
        private static const DEFAULT_VEHICLE_ICON_WIDTH:Number = 16;
        private static const DEFAULT_VEHICLE_ICON_HEIGHT:Number = 20;
        private static const DEFAULT_VEHICLE_ICON_SCALE:Number = 0.4;

        private var _entryDeleted:Boolean = false;

        private var _labelsEnabled:Boolean;
        private var _isControlMode:Boolean = false;

        private var _extraFields:ExtraFieldsGroup = null;
        private var _extraFieldsAlt:ExtraFieldsGroup = null;

        public function UI_VehicleEntry()
        {
            //Logger.add("UI_VehicleEntry.ctor()");
            super();

            _labelsEnabled = Config.config.minimap.labelsEnabled;
            MinimapEntriesLabelsHelper.init(this);
        }

        override protected function onDispose():void
        {
            if (!_entryDeleted)
            {
                xvm_delEntry();
            }
            super.onDispose();
        }

        override protected function draw():void
        {
            if (_entryDeleted)
            {
                Logger.add("WARNING: draw() on deleted VehicleEntry");
                return;
            }

            super.draw();

            if (_labelsEnabled)
            {
                if (isInvalid(VehicleMinimapEntry.INVALID_VEHICLE_LABEL))
                {
                    var playerState:VOPlayerState = BattleState.get(vehicleID);
                    var isVisible:Boolean = _isControlMode || !playerState ? false : playerState.spottedStatus && playerState.spottedStatus != "neverSeen";
                    if (visible != isVisible)
                    {
                        visible = isVisible;
                    }
                    if (isVisible)
                    {
                        updateVehicleIcon(playerState);
                        updateLabels(playerState);
                    }
                    else
                    {
                        hideLabels();
                    }
                }
            }
        }

        // DAAPI

        public function xvm_delEntry():void
        {
            _entryDeleted = true;

            MinimapEntriesLabelsHelper.dispose(this);
        }

        public function xvm_setControlMode(value:Boolean):void
        {
            _isControlMode = value;
            if (value == false)
            {
                x = MinimapEntriesLabelsHelper.viewPointEntryX;
                y = MinimapEntriesLabelsHelper.viewPointEntryY;
            }
            invalidate(VehicleMinimapEntry.INVALID_VEHICLE_LABEL);
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
            if (e.vehicleID == vehicleID)
            {
                update();
            }
        }

        public function update():void
        {
            invalidate(VehicleMinimapEntry.INVALID_VEHICLE_LABEL);
        }

        public function onEnterFrame():void
        {
            MinimapEntriesLabelsHelper.onEnterFrameHandler(this);
        }

        // PRIVATE

        private function updateVehicleIcon(playerState:VOPlayerState):void
        {
            var currVehAnimation:VehicleAnimationMinimapEntry = XfwUtils.getPrivateField(this, "xfw_currVehicleAnimation");
            var iconScale:Number = Macros.FormatNumber(UI_Minimap.cfg.iconScale, playerState, 1);
            if (currVehAnimation != deadAnimation)
            {
                if (currVehAnimation != deadPermanentAnimation)
                {
                    currVehAnimation.x = -DEFAULT_VEHICLE_ICON_WIDTH * iconScale / 2.0;
                    currVehAnimation.y = -DEFAULT_VEHICLE_ICON_HEIGHT * iconScale / 2.0;
                }
                currVehAnimation.alpha = Macros.FormatNumber(UI_Minimap.cfg.iconAlpha, playerState, 100) / 100.0;
            }
            else
            {
                currVehAnimation.alpha = Macros.FormatNumber(UI_Minimap.cfg.deadAnimationAlpha, playerState, 100) / 100.0;
            }
            currVehAnimation.scaleX = currVehAnimation.scaleY = DEFAULT_VEHICLE_ICON_SCALE * iconScale;
        }

        private function updateLabels(playerState:VOPlayerState):void
        {
            vehicleNameTextFieldAlt.visible = false;
            vehicleNameTextFieldClassic.visible = false;
            MinimapEntriesLabelsHelper.updateLabels(this, playerState);
        }

        private function hideLabels():void
        {
            if (extraFields)
            {
                extraFields.visible = false;
            }
            if (extraFieldsAlt)
            {
                extraFieldsAlt.visible = false;
            }
        }
    }
}
