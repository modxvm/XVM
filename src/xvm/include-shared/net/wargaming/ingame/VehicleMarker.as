intrinsic class net.wargaming.ingame.VehicleMarker extends gfx.core.UIComponent implements wot.VehicleMarkersManager.IVehicleMarker
{
    function init(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt, entityType);
    function update();
    function updateMarkerSettings();
    function setSpeaking(value);
    function setEntityName(value);
    function updateHealth(curHealth, flag, damageType);
    function updateState(newState, isImmediate);
    function showExInfo(show);
    function showActionMarker(actionState);
}
