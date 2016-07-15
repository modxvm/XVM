/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui
{
    import com.xvm.*;
    import com.xvm.battle.vo.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;

    public dynamic class XvmVehicleMarkerEvent extends Event
    {
        public static const INIT:String = "INIT";
        public static const UPDATE:String = "UPDATE";
        public static const UPDATE_HEALTH:String = "UPDATE_HEALTH";
        public static const SET_SPEAKING:String = "SET_SPEAKING";

        private var _playerState:VOPlayerState;
        private var _exInfo:Boolean;
        private var _cfg:CMarkers4;
        private var _userData:Object;

        public function get playerState():VOPlayerState
        {
            return _playerState;
        }

        public function get exInfo():Boolean
        {
            return _exInfo;
        }

        public function get cfg():CMarkers4
        {
            return _cfg;
        }

        public function get userData():Object
        {
            return _userData;
        }

        public function XvmVehicleMarkerEvent(type:String, playerState:VOPlayerState, exInfo:Boolean, userData:Object = null)
        {
            super(type);
            _playerState = playerState;
            _exInfo = exInfo;
            _cfg = XvmVehicleMarkerState.getCurrentConfig(playerState, exInfo);
            _userData = userData;
        }
    }
}

