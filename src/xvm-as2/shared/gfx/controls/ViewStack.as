class gfx.controls.ViewStack extends gfx.core.UIComponent
{
    var cachedViews, currentView;
    function show(linkage, cache);
    function precache(linkages);
    function get targetGroup();
    function set targetGroup(value);
    function createView(linkage, cache);
    function changeView(event);
}
