class net.wargaming.ingame.VehicleActionMarker extends gfx.core.UIComponent
{
    var currentRenderer, getNextHighestDepth, attachMovie;
    function VehicleActionMarker()
    {
        super();
    } // End of the function
    function showAction(actionName)
    {
        var _loc2 = _actionRendererMap[actionName];
        if (_loc2 != undefined && _loc2.length > 0)
        {
            currentRenderer = this.createActionRenderer(_loc2);
        } // end if
    } // End of the function
    function configUI()
    {
        currentRenderer = null;
        super.configUI();
    } // End of the function
    function removeActionRenderer()
    {
        if (currentRenderer == null)
        {
            return;
        } // end if
        currentRenderer.removeMovieClip();
        currentRenderer = null;
    } // End of the function
    function createActionRenderer(itemRenderer)
    {
        this.removeActionRenderer();
        var _loc3 = this.getNextHighestDepth();
        var _loc2 = this.attachMovie(itemRenderer, "renderer" + _loc3, _loc3, {_x: 0, _y: 0});
        if (_loc2 == null)
        {
            return (null);
        } // end if
        return (_loc2);
    } // End of the function
    var _actionRendererMap = {attack: "", help_me: ""};
} // End of Class
