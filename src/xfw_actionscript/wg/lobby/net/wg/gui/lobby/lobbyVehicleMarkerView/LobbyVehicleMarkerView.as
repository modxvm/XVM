package net.wg.gui.lobby.lobbyVehicleMarkerView
{
    import net.wg.infrastructure.base.meta.impl.LobbyVehicleMarkerViewMeta;
    import net.wg.infrastructure.base.meta.ILobbyVehicleMarkerViewMeta;
    import net.wg.gui.components.common.lobbyVehicleMarkers.LobbyVehicleMarkers;
    import net.wg.utils.IClassFactory;
    import flash.display.DisplayObject;
    import net.wg.data.constants.Linkages;

    public class LobbyVehicleMarkerView extends LobbyVehicleMarkerViewMeta implements ILobbyVehicleMarkerViewMeta
    {

        private var _vehicleMarkers:Vector.<LobbyVehicleMarkers>;

        private var _classFactory:IClassFactory;

        public function LobbyVehicleMarkerView()
        {
            this._vehicleMarkers = new Vector.<LobbyVehicleMarkers>(0);
            this._classFactory = App.utils.classFactory;
            super();
        }

        override protected function onDispose() : void
        {
            var _loc1_:LobbyVehicleMarkers = null;
            for each(_loc1_ in this._vehicleMarkers)
            {
                removeChild(_loc1_);
                _loc1_.dispose();
            }
            this._vehicleMarkers.fixed = false;
            this._vehicleMarkers.splice(0,this._vehicleMarkers.length);
            this._vehicleMarkers = null;
            this._classFactory = null;
            super.onDispose();
        }

        override protected function allowHandleInput() : Boolean
        {
            return false;
        }

        public function as_createMarker(param1:String, param2:String, param3:int, param4:int) : DisplayObject
        {
            var _loc5_:LobbyVehicleMarkers = this._classFactory.getComponent(Linkages.LOBBY_VEH_MARKER,LobbyVehicleMarkers);
            _loc5_.gotoAndStop(param4);
            _loc5_.setVehicleInfo(param1,param2);
            _loc5_.id = param3;
            this._vehicleMarkers.push(_loc5_);
            addChild(_loc5_);
            return _loc5_;
        }

        public function as_removeMarker(param1:int) : void
        {
            this.removeMarker(param1);
        }

        public function removeMarker(param1:int) : void
        {
            var _loc2_:LobbyVehicleMarkers = null;
            var _loc3_:int = this._vehicleMarkers.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                if(this._vehicleMarkers[_loc4_].id == param1)
                {
                    _loc2_ = this._vehicleMarkers[_loc4_];
                    removeChild(_loc2_);
                    _loc2_.dispose();
                    this._vehicleMarkers.splice(_loc4_,1);
                    break;
                }
                _loc4_++;
            }
        }
    }
}
