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
        private var _useStandardLabels:Boolean;

        public function UI_VehicleEntry()
        {
            //Logger.add("UI_VehicleEntry | UI_VehicleEntry");
            _useStandardLabels = Macros.FormatBooleanGlobal(Config.config.minimap.useStandardLabels, false);
            _useStandardLabels = true; // TODO
            if (!_useStandardLabels)
            {
                Xvm.addEventListener(PlayerStateEvent.CHANGED, playerStateChanged);
                Xvm.addEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, update);
            }
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(PlayerStateEvent.CHANGED, playerStateChanged);
            Xvm.removeEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, update);
            super.onDispose();
        }

        override protected function draw():void
        {
            super.draw();
            if (!_useStandardLabels)
            {
                if (isInvalid(VehicleMinimapEntry.INVALID_VEHICLE_LABEL))
                {
                    vehicleNameTextFieldAlt.visible = false;
                    vehicleNameTextFieldClassic.visible = true;
                    var playerState:VOPlayerState = BattleState.get(vehicleID);
                    vehicleNameTextFieldClassic.htmlText = Macros.Format(UI_Minimap.cfg.labels.formats[0].format, playerState);
                }
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
    }
}
