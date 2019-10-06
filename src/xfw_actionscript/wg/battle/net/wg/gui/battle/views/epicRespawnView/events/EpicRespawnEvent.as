package net.wg.gui.battle.views.epicRespawnView.events
{
    import flash.events.Event;
    import flash.geom.Point;

    public class EpicRespawnEvent extends Event
    {

        public static const SELECTED_LANE_CHANGED:String = "respawnSelectedLaneChanged";

        public static const DEPLOYMENT_BUTTON_READY:String = "respawnDeploymentButtonReady";

        public static const VIEW_CHANGED:String = "respawnViewChanged";

        public static const RESPAWN_MAP_MOUSE_OVER:String = "respawnMapMouseOver";

        public static const RESPAWN_LOCATION_UPDATE:String = "respawnLocationUpdate";

        public static const LANE_STATE_CHANGED:String = "respawnLaneStateChanged";

        private var _lane:int = -1;

        private var _laneState:Boolean = false;

        private var _respawnLocations:Vector.<Point> = null;

        private var _additionalInfo:String = "";

        public function EpicRespawnEvent(param1:String, param2:int = -1, param3:Boolean = false, param4:Vector.<Point> = null, param5:Boolean = false, param6:Boolean = false)
        {
            super(param1,param5,param6);
            this._lane = param2;
            this._laneState = param3;
            this._respawnLocations = param4;
        }

        override public function clone() : Event
        {
            return new EpicRespawnEvent(type,this._lane,this._laneState,this._respawnLocations,bubbles,cancelable);
        }

        public function get additionalInfo() : String
        {
            return this._additionalInfo;
        }

        public function set additionalInfo(param1:String) : void
        {
            this._additionalInfo = param1;
        }

        public function get lane() : int
        {
            return this._lane;
        }

        public function get laneBlocked() : Boolean
        {
            return this._laneState;
        }

        public function get respawnLocations() : Vector.<Point>
        {
            return this._respawnLocations;
        }
    }
}
