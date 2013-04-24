import com.xvm.Wrapper;

class wot.wrapper.VehicleMarkersManager.VehicleMarkerProxy extends net.wargaming.ingame.VehicleMarker
{
    private var m_team;

    function VehicleMarkerProxy()
    {
        super();

        var OVERRIDE_FUNCTIONS:Array = [
            "onEnterFrame",
            "gotoAndStop",
            "__get__visible",
            "__set__visible",
            "__get__disabled",
            "__set__disabled",
            "init",
            "update",
            "updateMarkerSettings",
            "setSpeaking",
            "setEntityName",
            "updateHealth",
            "updateState",
            "showExInfo",
            "showActionMarker",
            "settingsUpdate",
            "onLoad",
            "configUI",
            "setSize",
            "validateNow",
            "invalidate",
            "setMarkerState",
            "__get__exInfo",
            "__set__exInfo",
            "__get_markerSettings",
            "__set_markerSettings",
            "__get__width",
            "__set__width",
            "__get__height",
            "__set__height",
            "__get__focused",
            "__set__focused",
            "__get__displayFocus",
            "__set__displayFocus",
            "handleInput",
            "toString",
            "initSize",
            "draw",
            "changeFocus",
            "onMouseWheel",
            "scrollWheel"
        ];
        for (var i in this)
        {
            
            com.xvm.Logger.add(i + " " + typeof(this[i]));
        }
        Wrapper.override(this, new wot.VehicleMarkersManager.VehicleMarkerProxy(this, super), OVERRIDE_FUNCTIONS);
    }
}
