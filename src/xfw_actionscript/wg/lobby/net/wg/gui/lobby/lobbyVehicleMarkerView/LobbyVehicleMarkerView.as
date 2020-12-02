package net.wg.gui.lobby.lobbyVehicleMarkerView
{
    import net.wg.infrastructure.base.meta.impl.LobbyVehicleMarkerViewMeta;
    import net.wg.infrastructure.base.meta.ILobbyVehicleMarkerViewMeta;
    import net.wg.gui.components.common.lobbyVehicleMarkers.LobbyVehicleMarkers;
    import flash.display.DisplayObject;
    import net.wg.data.constants.Linkages;

    public class LobbyVehicleMarkerView extends LobbyVehicleMarkerViewMeta implements ILobbyVehicleMarkerViewMeta
    {

        private var _marker:LobbyVehicleMarkers;

        public function LobbyVehicleMarkerView()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.removeMarker();
            super.onDispose();
        }

        override protected function allowHandleInput() : Boolean
        {
            return false;
        }

        public function as_createMarker(param1:String, param2:String) : DisplayObject
        {
            this._marker = App.instance.utils.classFactory.getComponent(Linkages.LOBBY_VEH_MARKER,LobbyVehicleMarkers);
            this._marker.setVehicleInfo(param1,param2);
            addChild(this._marker);
            return this._marker;
        }

        public function as_removeMarker() : void
        {
            this.removeMarker();
        }

        public function removeMarker() : void
        {
            if(this._marker)
            {
                removeChild(this._marker);
                this._marker.dispose();
                this._marker = null;
            }
        }
    }
}
