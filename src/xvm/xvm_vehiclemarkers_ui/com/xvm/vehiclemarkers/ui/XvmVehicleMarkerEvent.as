/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui
{
    import com.xvm.*;
    import com.xvm.battle.vo.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;

    public class XvmVehicleMarkerEvent extends Event
    {
        public static const INIT:String = "VM_INIT";
        public static const UPDATE:String = "VM_UPDATE";
        public static const UPDATE_HEALTH:String = "VM_UPDATE_HEALTH";
        public static const UPDATE_STATE:String = "VM_UPDATE_STATE";
        public static const SET_SPEAKING:String = "VM_SET_SPEAKING";
        public static const EX_INFO:String = "VM_EX_INFO";

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

        override public function clone():Event
        {
            return new XvmVehicleMarkerEvent(type, playerState, exInfo, userData);
        }
    }
}

