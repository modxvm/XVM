/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.vo.*;
    import com.xvm.extraFields.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vehiclemarkers.ui.*;
    import flash.geom.*;
    import flash.text.*;

    public final class TextFieldsComponent extends VehicleMarkerComponentBase implements IVehicleMarkerComponent
    {
        // from net.wg.gui.battle.views.stats.constants::PlayerStatusSchemeName
        private static const NORMAL:String = "normal";
        private static const TEAM_KILLER:String = "teamkiller";
        private static const SQUAD_PERSONAL:String = "squad";
        private static const SELECTED:String = "selected";
        private static const DEAD_POSTFIX:String = "_dead";
        private static const OFFLINE_POSTFIX:String = "_offline";

        private var extraFieldsHolders:Object;
        private var isAlly:Boolean;
        private var exInfoDirty:Boolean;
        private var lastState:String;
        private var currentPlayerState:VOPlayerState;
		private var isPrevStickyAndOutOfScreen:Boolean = false;

        public final function TextFieldsComponent(marker:XvmVehicleMarker)
        {
            super(marker);
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

        public final function init(e:XvmVehicleMarkerEvent):void
        {
            if (!this.initialized)
            {
                this.initialized = true;
                isAlly = e.playerState.isAlly;
                exInfoDirty = true;
                lastState = null;
                extraFieldsHolders = { };
            }
        }

        [Inline]
        public final function onExInfo(e:XvmVehicleMarkerEvent):void
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

        public final function update(e:XvmVehicleMarkerEvent):void
        {
            if (extraFieldsHolders)
            {
                var playerState:VOPlayerState = e.playerState;
                updateExtraFieldsVisibility(playerState, e.exInfo);
                extraFieldsHolders[lastState].update(playerState, 0, 0, -15.5); // -15.5 is used for configs compatibility
                exInfoDirty = true;
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
            currentPlayerState = playerState;
			var isStickyAndOutOfScreen:Boolean = marker.isStickyAndOutOfScreen;
            var currentState:String = XvmVehicleMarkerState.getCurrentState(playerState, exInfo);
            var extraFields:ExtraFields = extraFieldsHolders[lastState];
            if ((lastState != currentState) || (isPrevStickyAndOutOfScreen != isStickyAndOutOfScreen))
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
                extraFields.visible = true && !isStickyAndOutOfScreen;
                lastState = currentState;
				isPrevStickyAndOutOfScreen = isStickyAndOutOfScreen;
            }
        }

        private function getColorSchemeName():String
        {
            var schemeName:Vector.<String> = new Vector.<String>[
                currentPlayerState.isCurrentPlayer ? SELECTED
                : currentPlayerState.isSquadPersonal ? SQUAD_PERSONAL
                : currentPlayerState.isTeamKiller ? TEAM_KILLER
                : NORMAL
            ];
            if (currentPlayerState.isDead)
            {
                schemeName.push(DEAD_POSTFIX);
            }
            if (currentPlayerState.isOffline)
            {
                schemeName.push(OFFLINE_POSTFIX);
            }
            return schemeName.join("");
        }
    }
}
