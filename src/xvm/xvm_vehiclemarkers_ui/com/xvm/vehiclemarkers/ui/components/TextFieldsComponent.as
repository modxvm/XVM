/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.battle.vo.*;
    import com.xvm.extraFields.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vehiclemarkers.ui.*;
    import flash.geom.*;
    import flash.text.*;

    public class TextFieldsComponent extends VehicleMarkerComponentBase
    {
        private var extraFieldsHolders:Object;
        private var isAlly:Boolean;
        private var exInfoDirty:Boolean;
        private var lastState:String;
        private var currentPlayerState:VOPlayerState;

        public function TextFieldsComponent(marker:XvmVehicleMarker)
        {
            super(marker);
        }

        override protected function init(e:XvmVehicleMarkerEvent):void
        {
            if (this.initialized)
                return;
            var playerState:VOPlayerState = e.playerState;
            isAlly = playerState.isAlly;
            exInfoDirty = true;
            lastState = null;
            extraFieldsHolders = { };
            super.init(e);
        }

        override protected function onDispose():void
        {
            if (extraFieldsHolders)
            {
                for each (var state:String in XvmVehicleMarkerState.getAllStates(isAlly))
                {
                    if (extraFieldsHolders[state])
                    {
                        marker.removeChild(extraFieldsHolders[state]);
                    }
                }
                extraFieldsHolders = null;
            }
            super.onDispose();
        }

        override protected function update(e:XvmVehicleMarkerEvent):void
        {
            //Logger.addObject(e, 1, "update: " + (currentPlayerState ? currentPlayerState.playerName : "null"));
            super.update(e);
            if (extraFieldsHolders)
            {
                updateExtraFieldsVisibility(e.playerState, e.exInfo);
                extraFieldsHolders[lastState].update(e.playerState, 0, 0, -15.5); // -15.5 is used for configs compatibility
                exInfoDirty = true;
            }
        }

        override protected function onExInfo(e:XvmVehicleMarkerEvent):void
        {
            if (extraFieldsHolders)
            {
                if (exInfoDirty)
                {
                    update(e);
                    exInfoDirty = false;
                }
                else
                {
                    updateExtraFieldsVisibility(e.playerState, e.exInfo);
                }
            }
        }

        // PRIVATE

        private function initState(state:String, playerState:VOPlayerState):ExtraFields
        {
            var cfg:CMarkers4 = XvmVehicleMarkerState.getConfig(state);
            var extraFields:ExtraFields = new ExtraFields(cfg.textFields, true, getColorSchemeName, null, new Rectangle(0, 0, 140, 100), null,
                TextFormatAlign.CENTER, CTextFormat.GetDefaultConfigForMarkers());
            extraFieldsHolders[state] = extraFields;
            marker.addChild(extraFields);
            return extraFields;
        }

        private function updateExtraFieldsVisibility(playerState:VOPlayerState, exInfo:Boolean):void
        {
            //Xvm.swfProfilerBegin("TextFieldsComponent.updateExtraFieldsVisibility()");
            currentPlayerState = playerState;
            var currentState:String = XvmVehicleMarkerState.getCurrentState(playerState, exInfo);
            var extraFields:ExtraFields = extraFieldsHolders[lastState];
            if (lastState != currentState)
            {
                if (extraFields)
                {
                    extraFields.visible = false;
                }
                extraFields = extraFieldsHolders[currentState];
                if (extraFields == null)
                {
                    extraFields = initState(currentState, playerState);
                    var exState:String = XvmVehicleMarkerState.getCurrentState(playerState, !exInfo);
                    initState(exState, playerState);
                }
                extraFields.visible = true;
                lastState = currentState;
            }
            //Xvm.swfProfilerEnd("TextFieldsComponent.updateExtraFieldsVisibility()");
        }

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
            //Logger.add("getColorSchemeName: " + schemeName);
            return schemeName;
        }
    }
}
