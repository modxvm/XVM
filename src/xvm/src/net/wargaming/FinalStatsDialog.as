class net.wargaming.FinalStatsDialog extends net.wargaming.Dialog
{
    var closeBtn;
    function FinalStatsDialog()
    {
        super();
    } // End of the function
    static function handleCloseWindow(event)
    {
        fscommand("battle.leave");
        gfx.controls.Dialog.hide(-1);
    } // End of the function
    static function show()
    {
        var _loc3 = {_title: "", _formSource: "FinalStatisticForm.swf", _formType: "swf", _offsetTop: 5, _offsetBottom: 15, _offsetLeft: 7, _offsetRight: 8, allowResize: false};
        var _loc2 = net.wargaming.Dialog.show(_root, net.wargaming.FinalStatsDialog.menuSource, _loc3, true);
        _loc2.addEventListener("close", net.wargaming.FinalStatsDialog, "handleCloseWindow");
        return (_loc2);
    } // End of the function
    function configUI()
    {
        if (closeBtn)
        {
            closeBtn.__set__focused(true);
        } // end if
    } // End of the function
    function StatsDialog()
    {
        super();
    } // End of the function
    static var menuSource = "Window";
} // End of Class
