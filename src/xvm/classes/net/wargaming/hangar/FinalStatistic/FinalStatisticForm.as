intrinsic class net.wargaming.hangar.FinalStatistic.FinalStatisticForm extends gfx.core.UIComponent
{
    function get data();
    function FinalStatisticForm();
    function setCommonData(data);

/*    var _parent, __arenaUniqueId, tabs_mc, view_mc, vehicleSelector, __get__arenaUniqueId, __get__data;
    function FinalStatisticForm()
    {
        super();
        _global.ASSetPropFlags(net.wargaming.hangar.FinalStatistic.FinalStatisticForm.prototype, ["requestCommonData", "selectVehicle"], 6, 1);
    } // End of the function
    function configUI()
    {
        super.configUI();
        __arenaUniqueId = _parent._parent.arenaUniqueId;
        this.delayedRefresh();
    } // End of the function
    function showWaiting(message, params)
    {
        if (_parent._parent.showWaiting)
        {
            _parent._parent.showWaiting(message, params);
        } // end if
    } // End of the function
    function hideWaiting()
    {
        if (_parent._parent.hideWaiting)
        {
            _parent._parent.hideWaiting();
        } // end if
    } // End of the function
    function get arenaUniqueId()
    {
        return (__arenaUniqueId);
    } // End of the function
    function get data()
    {
        return (__data);
    } // End of the function
    function delayedRefresh()
    {
        if (requestCommonData == null)
        {
            __delayId = setTimeout(this, "delayedRefresh", 50);
        }
        else
        {
            if (__delayId > -1)
            {
                clearTimeout(__delayId);
            } // end if
            this.requestCommonData(__arenaUniqueId);
        } // end else if
    } // End of the function
    function setCommonData(data)
    {
        this.hideWaiting();
        if (data)
        {
            __data = data;
            tabs_mc.dataProvider = [{label: "#menu:finalStatistic/tabs/commonStats", data: "CommonStats"}, {label: "#menu:finalStatistic/tabs/teamStats", data: "TeamStats"}, {label: "#menu:finalStatistic/tabs/detailsStats", data: "DetailsStats"}];
            tabs_mc.drawLayout();
            view_mc.changeView();
            Selection.setFocus(tabs_mc);
            vehicleSelector.__set__data(data);
        }
        else
        {
            _parent.gotoAndStop("noData");
        } // end else if
    } // End of the function
    static function addBlankLines(label, labelTF, targetTFs)
    {
        var _loc6 = labelTF.getTextFormat().getTextExtent(label, labelTF._width);
        var _loc5 = Math.floor(_loc6.textFieldHeight / (_loc6.ascent + _loc6.descent));
        var _loc4 = 0;
        var _loc1 = 0;
        var _loc2;
        for (var _loc4 = 0; _loc4 < _loc5 - 1; ++_loc4)
        {
            for (var _loc1 = 0; _loc1 < targetTFs.length; ++_loc1)
            {
                _loc2 = targetTFs[_loc1];
                _loc2.htmlText = _loc2.htmlText + "\n";
            } // end of for
        } // end of for
    } // End of the function
    var STATS_LABELS_KEY = "#battle_results:team/stats/labels";
    var requestCommonData = null;
    var selectVehicle = null;
    var __data = null;
    var __delayId = -1;*/
}
