intrinsic class net.wargaming.ingame.VehicleMarker extends gfx.core.UIComponent implements wot.VehicleMarkersManager.IVehicleMarker
{
    // BEGIN
    // TODO: remove 
    public var levelIcon:MovieClip;
    public var iconLoader:net.wargaming.controls.UILoaderAlt;
    public var vNameField:TextField;
    public var pNameField:TextField;
    public var actionMarker:MovieClip;
    public var marker:MovieClip;
    public var healthBar:MovieClip;
    public var bgShadow:MovieClip;
    static var s_showExInfo;
    // END

    function init(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt);
    function update();
    function updateMarkerSettings();
    function setSpeaking(value);
    function setEntityName(value);
    function updateHealth(curHealth);
    function updateState(newState, isImmediate);
    function showExInfo(show);
    function showActionMarker(actionState);
}
