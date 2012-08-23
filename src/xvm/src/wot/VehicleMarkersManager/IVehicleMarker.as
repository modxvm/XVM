/**
 * Defines the methods that all Vehicle Marker components must define.
 */

interface wot.VehicleMarkersManager.IVehicleMarker
{
    /**
     * called by Battle.pyc
     */

    function init(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt);
    function update();
    function updateMarkerSettings();
    function setSpeaking(value);
    function setEntityName(value);
    function updateHealth(curHealth);
    function updateState(newState, isImmediate);
    function showExInfo(show);
    function showActionMarker(actionState);

    // UICompinent // TODO: Cleanup, not all methods required.
    function onLoad();
    function get disabled();
    function set disabled(value);
    function get visible();
    function set visible(value);
    function get width();
    function set width(value);
    function get height();
    function set height(value);
    function setSize(width, height);
    function get focused();
    function set focused(value);
    function get displayFocus();
    function set displayFocus(value);
    function handleInput(details, pathToFocus);
    function invalidate();
    function validateNow();
    function toString();
    function configUI();
    function initSize();
    function draw();
    function changeFocus();
    function onMouseWheel(delta, target);
    function scrollWheel(delta);
}
