import com.xvm.Wrapper;

class wot.wrapper.VehicleMarkersManager.VehicleMarkerProxy extends net.wargaming.ingame.VehicleMarker
{
    private var m_team;

    function VehicleMarkerProxy()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            // VehicleMarker
            "init",
            "update",
            "updateMarkerSettings",
            "setSpeaking",
            "setEntityName",
            "updateHealth",
            "updateState",
            "showExInfo",
            "showActionMarker",

            // UIComponent
            "onLoad",

            // MovieClip
            "onEnterFrame",
            "gotoAndStop",

            // XVM
            "setMarkerStateXvm"
        ];
        Wrapper.override(this, new wot.VehicleMarkersManager.VehicleMarkerProxy(this, super), OVERRIDE_FUNCTIONS);
    }
}
