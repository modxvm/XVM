class net.wargaming.managers.VehicleActionManager
{
    static var __ACTIONS, __allActions;
    function VehicleActionManager()
    {
    } // End of the function
    static function getActionsObject()
    {
        if (net.wargaming.managers.VehicleActionManager.__ACTIONS == null)
        {
            __ACTIONS = new Object();
            net.wargaming.managers.VehicleActionManager.__ACTIONS.common = new Object();
            net.wargaming.managers.VehicleActionManager.__ACTIONS.myteam = new Object();
            net.wargaming.managers.VehicleActionManager.__ACTIONS.enemy = new Object();
            net.wargaming.managers.VehicleActionManager.__ACTIONS.enemy.hunting = 1;
        } // end if
        return (net.wargaming.managers.VehicleActionManager.__ACTIONS);
    } // End of the function
    static function getActions(team, bitMask)
    {
        return (net.wargaming.managers.VehicleActionManager.proccessActions(net.wargaming.managers.VehicleActionManager.getActionsObject().common, bitMask).concat(net.wargaming.managers.VehicleActionManager.proccessActions(net.wargaming.managers.VehicleActionManager.getActionsObject()[team], bitMask)));
    } // End of the function
    static function proccessActions(teamActions, bitMask)
    {
        var _loc3 = new Array();
        for (var _loc4 in teamActions)
        {
            var _loc1 = teamActions[_loc4];
            if (_loc1 & bitMask)
            {
                _loc3.push(_loc4);
            } // end if
        } // end of for...in
        return (_loc3);
    } // End of the function
    static function get allActions()
    {
        if (net.wargaming.managers.VehicleActionManager.__allActions == null)
        {
            __allActions = new Array();
            for (var _loc2 in net.wargaming.managers.VehicleActionManager.getActionsObject())
            {
                for (var _loc1 in net.wargaming.managers.VehicleActionManager.getActionsObject()[_loc2])
                {
                    net.wargaming.managers.VehicleActionManager.__allActions.push(_loc1);
                } // end of for...in
            } // end of for...in
        } // end if
        return (net.wargaming.managers.VehicleActionManager.__allActions);
    } // End of the function
} // End of Class
