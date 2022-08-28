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

    public class UI_ViewRangeCirclesEntry extends ViewRangeCirclesEntry
    {
        static private var _visionRadius:Number;
        static private var _stereoscope_exists:Boolean;
        static private var _stereoscope_enabled:Boolean;

        private var _entryDeleted:Boolean = false;

        private var _circlesEnabled:Boolean;

        private var _circles:Circles;
        private var _circlesAlt:Circles;

        static public function get visionRadius():Number
        {
            return _visionRadius;
        }

        static public function get stereoscope_exists():Boolean
        {
            return _stereoscope_exists;
        }

        static public function get stereoscope_enabled():Boolean
        {
            return _stereoscope_enabled;
        }

        public function UI_ViewRangeCirclesEntry()
        {
            //Logger.add("UI_ViewRangeCirclesEntry");
            super();
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init();
        }

        private function _init():void
        {
            _circlesEnabled = Config.config.minimap.circlesEnabled;
            if (_circlesEnabled)
            {
                Xfw.addCommandListener(XvmCommands.AS_MOVING_STATE_CHANGED, onMovingStateChanged);
                Xfw.addCommandListener(XvmCommands.AS_STEREOSCOPE_TOGGLED, onStereoscopeToggled);
                Xfw.addCommandListener(XvmCommands.AS_CHANGING_SHELL, onChangingShell);
                Xvm.addEventListener(PlayerStateEvent.CURRENT_VEHICLE_DESTROYED, updateCirclesVisibility);
                Xvm.addEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, updateCirclesVisibility);

                UI_ViewRangeCirclesEntry._stereoscope_exists = UI_ViewRangeCirclesEntry._stereoscope_enabled = BattleGlobalData.minimapCirclesData.view_stereoscope == true;

                _circles = new Circles(Config.config.minimap.circles);
                //circles.visible = false;
                addChild(_circles);
                _circlesAlt = new Circles(Config.config.minimapAlt.circles);
                _circlesAlt.visible = false;
                addChild(_circlesAlt);
            }
        }

        /*!!!TODO!!!
        override public function dispose():void
        {
            if (!_entryDeleted)
            {
                xvm_delEntry();
            }
            super.dispose();
        }
        */

        override public function as_addDrawRange(param1:Number, param2:Number, param3:Number):void
        {
            if (_entryDeleted)
            {
                Logger.add("WARNING: as_addDrawRange() on deleted VehicleEntry");
                return;
            }

            if (!_circlesEnabled)
            {
                super.as_addDrawRange(param1, param2, param3);
            }
        }

        override public function as_addDynamicViewRange(color:Number, alpha:Number, visionRadius:Number):void
        {
            if (_entryDeleted)
            {
                Logger.add("WARNING: as_addDynamicViewRange() on deleted VehicleEntry");
                return;
            }

            //Logger.add("as_addDynamicViewRange: " + visionRadius);
            if (!_circlesEnabled)
            {
                super.as_addDynamicViewRange(color, alpha, visionRadius);
            }
            else
            {
                UI_ViewRangeCirclesEntry._visionRadius = visionRadius;
                _circles.update();
                _circlesAlt.update();
            }
        }

        override public function as_addMaxViewRage(param1:Number, param2:Number, param3:Number):void
        {
            if (_entryDeleted)
            {
                Logger.add("WARNING: as_addMaxViewRage() on deleted VehicleEntry");
                return;
            }

            if (!_circlesEnabled)
            {
                super.as_addMaxViewRage(param1, param2, param3);
            }
        }

        override public function as_updateDynRange(visionRadius:Number):void
        {
            if (_entryDeleted)
            {
                Logger.add("WARNING: as_updateDynRange() on deleted VehicleEntry");
                return;
            }

            //Logger.add("as_updateDynRange: " + visionRadius);
            if (!_circlesEnabled)
            {
                super.as_updateDynRange(visionRadius);
            }
            else
            {
                try
                {
                    UI_ViewRangeCirclesEntry._visionRadius = visionRadius;
                    _circles.update();
                    _circlesAlt.update();
                }
                catch (ex:Error)
                {
                    Logger.err(ex);
                }
            }
        }

        // DAAPI

        public function xvm_delEntry():void
        {
            _entryDeleted = true;

            Xfw.removeCommandListener(XvmCommands.AS_MOVING_STATE_CHANGED, onMovingStateChanged);
            Xfw.removeCommandListener(XvmCommands.AS_STEREOSCOPE_TOGGLED, onStereoscopeToggled);
            Xfw.removeCommandListener(XvmCommands.AS_CHANGING_SHELL, onChangingShell);
            Xvm.removeEventListener(PlayerStateEvent.CURRENT_VEHICLE_DESTROYED, updateCirclesVisibility);
            Xvm.removeEventListener(PlayerStateEvent.ON_MINIMAP_ALT_MODE_CHANGED, updateCirclesVisibility);

            if (_circles)
            {
                _circles.dispose();
                _circles = null;
            }

            if (_circlesAlt)
            {
                _circlesAlt.dispose();
                _circlesAlt = null;
            }
        }

        // PRIVATE

        private function updateCirclesVisibility():void
        {
            var playerState:VOPlayerState = BattleState.get(BattleGlobalData.playerVehicleID);
            if (playerState.isDead)
            {
                _circles.visible = false;
                _circlesAlt.visible = false;
            }
            else
            {
                var isAltMode:Boolean = UI_Minimap.instance.isAltMode;
                _circles.visible = !isAltMode;
                _circlesAlt.visible = isAltMode;
            }
        }

        private function onMovingStateChanged(isMoving:Boolean):void
        {
            //Logger.add("onMovingStateChanged: " + isMoving);
            var moving_state:int = isMoving ? MinimapEntriesConstants.MOVING_STATE_MOVING : MinimapEntriesConstants.MOVING_STATE_STOPPED;
            _circles.updateCirclesMovingState(moving_state);
            _circlesAlt.updateCirclesMovingState(moving_state);
        }

        private function onStereoscopeToggled(isOn:int):void
        {
            //Logger.add("onStereoscopeToggled: " + isOn);
            try
            {
                // workaround for stereoscope
                if (!UI_ViewRangeCirclesEntry._stereoscope_exists)
                    UI_ViewRangeCirclesEntry._stereoscope_exists = true;

                UI_ViewRangeCirclesEntry._stereoscope_enabled = isOn != 0;

                _circles.update();
                _circlesAlt.update();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function onChangingShell(shellCD:int):void
        {
            _circles.updateArtilleryRange(shellCD);
            _circlesAlt.updateArtilleryRange(shellCD);
        }
    }
}
