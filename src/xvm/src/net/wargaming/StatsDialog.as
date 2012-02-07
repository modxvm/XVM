class net.wargaming.StatsDialog extends net.wargaming.Dialog
{
    var closeBtn;
    function StatsDialog()
    {
        super();
    } // End of the function
    static function show()
    {
        var _loc2 = net.wargaming.Dialog.show(_root, net.wargaming.StatsDialog.menuSource, {}, true);
        return (_loc2);
    } // End of the function
    function configUI()
    {
        if (closeBtn)
        {
            closeBtn.__set__focused(true);
        } // end if
    } // End of the function
    static var menuSource = "statistic";
} // End of Class
