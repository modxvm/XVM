intrinsic class net.wargaming.ingame.TeamBasesPanel extends gfx.core.UIComponent
{
    var captureBars:Array, indexByID:Object;
    
    function add(id, sortWeight, colorFeature, title, points);
    function remove(id);
    function stopCapture(id, points);
    function updatePoints(id, points);
    function getPoints(id);
    function clear();
    function createCaptureBar(index, initProps);
    function draw();
    function updateColors();
}