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
        public static const UPDATEHEALTH:String = "EVENT_UPDATEHEALTH";

        private var _playerState:VOPlayerState;
        private var _cfg:CMarkers4;

        public function get playerState():VOPlayerState
        {
            return _playerState;
        }

        public function get cfg():CMarkers4
        {
            return _cfg;
        }

        public function XvmVehicleMarkerEvent(type:String, playerState:VOPlayerState, exInfo:Boolean)
        {
            super(type);
            _playerState = playerState;
            var c1:CMarkers = Config.config.markers;
            var c2:CMarkers2 = playerState.isAlly ? c1.ally : c1.enemy;
            var c3:CMarkers3 = playerState.isAlive ? c2.alive : c2.dead;
            _cfg = exInfo ? c3.extended : c3.normal;
        }
    }
}

