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
    import com.xvm.battle.minimap.*;
    import com.xvm.battle.vo.*;

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
                Xvm.addEventListener(EntryInfoChangeEvent.INFO_CHANGED, playerStateChanged);
            }
        }

        override protected function draw():void
        {
            super.draw();
            if(!_useStandartLabels)
            {
                vehicleNameTextFieldAlt.visible = false;
                vehicleNameTextFieldClassic.visible = true;
                var playerState:VOPlayerState = BattleState.get(vehicleID);
                var res:Object = Macros.Format(Config.config.minimap.labels.formats[0].format, playerState);
                _formattedString = String(res);
                vehicleNameTextFieldClassic.htmlText = _formattedString;
            }
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(EntryInfoChangeEvent.INFO_CHANGED, playerStateChanged);
            super.onDispose();
        }

        // PRIVATE

        private function playerStateChanged(e:EntryInfoChangeEvent):void
        {
            if (e.vehicleID == vehicleID)
            {
                var res:Object = Macros.Format(Config.config.minimap.labels.formats[0].format, e.playerState);
                _formattedString = String(res);
                vehicleNameTextFieldClassic.visible = true;
                vehicleNameTextFieldClassic.htmlText = _formattedString;
            }
        }
    }
}
