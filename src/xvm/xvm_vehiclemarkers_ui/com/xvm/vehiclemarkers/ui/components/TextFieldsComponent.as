/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.vo.*;
    import com.xvm.extraFields.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vehiclemarkers.ui.*;
    import flash.display.*;
    import flash.geom.*;

    public class TextFieldsComponent extends VehicleMarkerComponentBase
    {
        private var extraFieldsHolders:Object;
        private var isAlly:Boolean;
        private var currentPlayerState:VOPlayerState;

        public function TextFieldsComponent(marker:XvmVehicleMarker)
        {
            super(marker);
        }

        override protected function init(e:XvmVehicleMarkerEvent):void
        {
            var playerState:VOPlayerState = e.playerState;
            isAlly = playerState.isAlly;
            extraFieldsHolders = { };
            for each (var state:String in XvmVehicleMarkerState.getAllStates(isAlly))
            {
                var cfg:CMarkers4 = XvmVehicleMarkerState.getConfig(state);
                var extraFields:ExtraFields = new ExtraFields(cfg.textFields, true, getColorSchemeName, null, new Rectangle(0, 0, 140, 100));
                extraFieldsHolders[state] = extraFields;
                marker.addChild(extraFields);
            }
            super.init(e);
        }

        override public function dispose():void
        {
            if (extraFieldsHolders != null)
            {
                for each (var state:String in XvmVehicleMarkerState.getAllStates(isAlly))
                {
                    marker.removeChild(extraFieldsHolders[state]);
                }
                extraFieldsHolders = null;
            }
            super.dispose();
        }

        override protected function update(e:XvmVehicleMarkerEvent):void
        {
            super.update(e);

            if (extraFieldsHolders != null)
            {
                var playerState:VOPlayerState = e.playerState;
                currentPlayerState = playerState;
                var currentState:String = XvmVehicleMarkerState.getCurrentState(playerState, e.exInfo);
                for each (var state:String in XvmVehicleMarkerState.getAllStates(isAlly))
                {
                    var extraFields:ExtraFields = extraFieldsHolders[state];
                    if (state != currentState)
                    {
                        extraFields.visible = false;
                    }
                    else
                    {
                        extraFields.visible = true;
                        extraFields.update(playerState);
                    }
                }
            }
        }

        // PRIVATE

        // from net.wg.gui.battle.views.stats.constants::PlayerStatusSchemeName
        public static const NORMAL:String = "normal";
        public static const TEAM_KILLER:String = "teamkiller";
        public static const SQUAD_PERSONAL:String = "squad";
        public static const SELECTED:String = "selected";
        public static const DEAD_POSTFIX:String = "_dead";
        public static const OFFLINE_POSTFIX:String = "_offline";
        private function getColorSchemeName():String
        {
            var schemeName:String =
                currentPlayerState.isCurrentPlayer ? SELECTED
                : currentPlayerState.isSquadPersonal ? SQUAD_PERSONAL
                : currentPlayerState.isTeamKiller ? TEAM_KILLER
                : NORMAL;
            if (currentPlayerState.isDead)
            {
                schemeName += DEAD_POSTFIX;
            }
            if (currentPlayerState.isOffline)
            {
                schemeName += OFFLINE_POSTFIX;
            }
            return schemeName;
        }
    }
}
