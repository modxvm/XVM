class net.wargaming.BattleLoading extends gfx.core.UIComponent
{
    var mapBG;
    function BattleLoading()
    {
        super();
    } // End of the function
    function configUI()
    {
        super.configUI();
        gfx.io.GameDelegate.addCallBack("loading.setMapBG", this, "setMapBG");
        gfx.io.GameDelegate.call("loading.getData", []);
        mapBG.addEventListener("complete", this, "positionBG");
    } // End of the function
    function positionBG()
    {
        this.setSize(Stage.width, Stage.height);
        mapBG.__set__autoSize(true);
        mapBG.__set__visible(true);
    } // End of the function
    function setMapBG(imgsource)
    {
        mapBG.__set__visible(false);
        mapBG.__set__source(imgsource);
    } // End of the function
    function setSize(width, height)
    {
        var _loc2 = 1.600000;
        var _loc3 = height - 1200;
        if (1920 + _loc3 * _loc2 - width >= 0)
        {
            mapBG.__set__height(height);
            mapBG.__set__width(1920 + Math.round(_loc3 * _loc2));
        }
        else
        {
            var _loc4 = width - 1920;
            mapBG.__set__width(width);
            mapBG.__set__height(1200 + Math.round(_loc4 / _loc2));
        } // end else if
        mapBG._x = Math.round((1024 - mapBG.__get__width()) / 2);
        mapBG._y = Math.round((768 - mapBG.__get__height()) / 2);
    } // End of the function
} // End of Class
