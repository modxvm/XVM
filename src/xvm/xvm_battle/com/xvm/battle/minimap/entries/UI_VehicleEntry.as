/**
 * XVM
 * @author s_sorochich
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.minimap.entries
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.minimap.*;
    import com.xvm.battle.vo.*;
    import net.wg.gui.battle.views.minimap.components.entries.vehicle.*;

    public class UI_VehicleEntry extends VehicleEntry
    {
        private var _formattedString:String = "";
        private var _useStandartLabels:Boolean;

        public function UI_VehicleEntry()
        {
            //Logger.add("UI_VehicleEntry | UI_VehicleEntry");
            _useStandartLabels = Macros.FormatBooleanGlobal(Config.config.minimap.useStandardLabels, false);
            if (!_useStandartLabels)
            {
                Xvm.addEventListener(PlayerStateEvent.CHANGED, playerStateChanged);
            }
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(PlayerStateEvent.CHANGED, playerStateChanged);
            super.onDispose();
        }

        override protected function draw():void
        {
            super.draw();
            if (!_useStandartLabels)
            {
                if (isInvalid(VehicleMinimapEntry.INVALID_VEHICLE_LABEL))
                {
                    vehicleNameTextFieldAlt.visible = false;
                    vehicleNameTextFieldClassic.visible = true;
                    var playerState:VOPlayerState = BattleState.get(vehicleID);
                    vehicleNameTextFieldClassic.htmlText = Macros.Format(Config.config.minimap.labels.formats[0].format, playerState);
                }
            }
        }

        // PRIVATE

        private function playerStateChanged(e:PlayerStateEvent):void
        {
            if (e.vehicleID == vehicleID)
            {
                invalidate(VehicleMinimapEntry.INVALID_VEHICLE_LABEL);
            }
        }
    }
}
