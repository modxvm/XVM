/**
 * XVM
 * @author s_sorochich
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.minimap.entries.vehicle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.minimap.*;
    import com.xvm.battle.minimap.entries.*;
    import com.xvm.battle.vo.*;
    import com.xvm.extraFields.*;
    import flash.events.*;
    import net.wg.gui.battle.views.minimap.components.entries.vehicle.*;

    public class UI_VehicleEntry extends VehicleEntry
    {
        private static const DEFAULT_VEHICLE_ICON_WIDTH:Number = 16;
        private static const DEFAULT_VEHICLE_ICON_HEIGHT:Number = 20;
        private static const DEFAULT_VEHICLE_ICON_SCALE:Number = 0.4;

        private var _formattedString:String = "";
        private var _useStandardLabels:Boolean;

        private var extraFields:ExtraFieldsGroup = null;
        private var extraFieldsAlt:ExtraFieldsGroup = null;

        public function UI_VehicleEntry()
        {
            //Logger.add("UI_VehicleEntry");
            super();

            // Workaround: Label stays at creation point some time before first move.
            // It makes unpleasant label positioning at map center.
            x = MinimapEntriesConstants.OFFMAP_COORDINATE;
            y = MinimapEntriesConstants.OFFMAP_COORDINATE;

            _useStandardLabels = Macros.FormatBooleanGlobal(Config.config.minimap.useStandardLabels, false);
            if (!_useStandardLabels)
            {
                Xvm.addEventListener(PlayerStateEvent.CHANGED, playerStateChanged);
                Xvm.addEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, update);
                addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);

                createExtraFields();
            }
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(PlayerStateEvent.CHANGED, playerStateChanged);
            Xvm.removeEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, update);
            removeEventListener(Event.ENTER_FRAME, onEnterFrame);

            disposeExtraFields();

            super.onDispose();
        }

        override protected function draw():void
        {
            super.draw();
            if (!_useStandardLabels)
            {
                if (isInvalid(VehicleMinimapEntry.INVALID_VEHICLE_LABEL))
                {
                    var playerState:VOPlayerState = BattleState.get(vehicleID);
                    visible = playerState.spottedStatus && playerState.spottedStatus != "neverSeen";
                    if (visible)
                    {
                        updateVehicleIcon(playerState);
                        updateLabels(playerState);
                    }
                }
            }
        }

        private function onEnterFrame():void
        {
            if (extraFields)
            {
                extraFields.x = x;
                extraFields.y = y;
            }
            if (extraFieldsAlt)
            {
                extraFieldsAlt.x = x;
                extraFieldsAlt.y = y;
            }
        }

        // PRIVATE

        private function update():void
        {
            invalidate(VehicleMinimapEntry.INVALID_VEHICLE_LABEL);
        }

        private function playerStateChanged(e:PlayerStateEvent):void
        {
            if (e.vehicleID == vehicleID)
            {
                update();
            }
        }

        private function updateVehicleIcon(playerState:VOPlayerState):void
        {
            xfw_currVehicleAnimation.alpha = Macros.FormatNumber(UI_Minimap.cfg.iconAlpha, playerState, 100) / 100.0;
            var iconScale:Number = Macros.FormatNumber(UI_Minimap.cfg.iconScale, playerState, 1);
            xfw_currVehicleAnimation.x = -DEFAULT_VEHICLE_ICON_WIDTH * iconScale / 2.0;
            xfw_currVehicleAnimation.y = -DEFAULT_VEHICLE_ICON_HEIGHT * iconScale / 2.0;
            xfw_currVehicleAnimation.scaleX = xfw_currVehicleAnimation.scaleY = DEFAULT_VEHICLE_ICON_SCALE * iconScale;
        }

        private function updateLabels(playerState:VOPlayerState):void
        {
            vehicleNameTextFieldAlt.visible = false;
            vehicleNameTextFieldClassic.visible = false;
            updateExtraFields(playerState);
        }

        // extra fields

        private function createExtraFields():void
        {
            var formats:Array = Config.config.minimap.labels.formats;
            if (formats && formats.length)
            {
                extraFields = new ExtraFieldsGroup(UI_Minimap.instance, formats);
            }
            formats = Config.config.minimapAlt.labels.formats;
            if (formats && formats.length)
            {
                extraFieldsAlt = new ExtraFieldsGroup(UI_Minimap.instance, formats);
            }
        }

        private function disposeExtraFields():void
        {
            if (extraFields)
            {
                extraFields.dispose();
                extraFields = null;
            }
            if (extraFieldsAlt)
            {
                extraFieldsAlt.dispose();
                extraFieldsAlt = null;
            }
        }

        private function updateExtraFields(playerState:VOPlayerState):void
        {
            var isAltMode:Boolean = UI_Minimap.instance.isAltMode;
            if (extraFields)
            {
                extraFields.visible = !isAltMode;
                if (!isAltMode)
                {
                    extraFields.update(playerState, 0);
                }
            }
            if (extraFieldsAlt)
            {
                extraFieldsAlt.visible = isAltMode;
                if (isAltMode)
                {
                    extraFieldsAlt.update(playerState, 0);
                }
            }
        }
    }
}
