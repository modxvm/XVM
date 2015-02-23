import com.xvm.Wrapper;

class wot.wrapper.VehicleMarkersManager.VehicleMarkerProxy extends net.wargaming.ingame.VehicleMarker
{
    private var m_team;

    function VehicleMarkerProxy()
    {
        super();

        //for (var i in this)
        //    com.xvm.Logger.add(i + " " + typeof(this[i]));

        var OVERRIDE_FUNCTIONS:Array = [
            // VehicleMarker
            "init",
            //"settingsUpdate",
            "update",
            "updateMarkerSettings",
            //"onSplashHidden",
            //"layoutParts",
            //"__get__colorsManager",
            //"__get__colorSchemeName",
            //"__get__vehicleDestroyed",
            //"__get__isEnabledExInfo",
            //"isSpeaking",
            "setSpeaking",
            //"getMarkerState",
            //"setMarkerState",
            "setEntityName",
            "updateHealth",
            "updateState",
            "showExInfo",
            "showActionMarker",
            //"getPartVisibility",
            //"getNameText",
            //"getHelthText",
            //"getHealthPercents",
            //"configUI",
            //"draw",
            //"setupIconLoader",
            //"populateData",
            //"setVehicleClass",
            //"initMarkerLabel",
            //"updateMarkerLabel",
            //"_centeringIcon",
            //"_onCompleteLoad",
            //"_getVehicleClassName",
            //"__get__exInfo",
            //"__set__exInfo",
            //"__get__markerSettings",
            //"__set__markerSettings",

            // UIComponent
            "onLoad",
            //"__get__disabled",
            //"__set__disabled",
            //"__get__visible",
            //"__set__visible",
            //"__get__width",
            //"__set__width",
            //"__get__height",
            //"__set__height",
            //"setSize",
            //"__get__focused",
            //"__set__focused",
            //"__get__displayFocus",
            //"__set__displayFocus",
            //"handleInput",
            //"invalidate",
            //"validateNow",
            //"toString",
            //"initSize",
            //"changeFocus",
            //"onMouseWheel",
            //"scrollWheel",

            // MovieClip
            "onEnterFrame",
            "gotoAndStop",

            // XVM
            "setMarkerState"
        ];
        Wrapper.override(this, new wot.VehicleMarkersManager.VehicleMarkerProxy(this, super), OVERRIDE_FUNCTIONS);
    }
}
