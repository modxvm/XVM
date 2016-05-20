intrinsic class net.wargaming.ingame.TeamBasesPanel extends gfx.core.UIComponent
{
    var _itemRenderer;
    var _rendererHeight;
    var _rendererWidth;
    var _needRedOffset;
    //var captureBars:Array, indexByID:Object;

    function TeamBasesPanel();
    function init(needRedOffset);
    function add(id, sortWeight, colorFeature, title, points, rate, timeLeft, vehiclesCount);
    function remove(id);
    function stopCapture(id, points);
    function updateCaptureData(id, points, rate, timeLeft, vehiclesCount);
    function getPoints(id);
    function setCaptured(id, title);
    function clear();
    function createCaptureBar(index, initProps);
    function buildIndexByIDCache();
    function configUI();
    function draw();
    function updateColors();
}
