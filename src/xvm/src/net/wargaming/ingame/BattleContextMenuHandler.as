class net.wargaming.ingame.BattleContextMenuHandler
{
    static var currentContext, currentMenu;
    function BattleContextMenuHandler()
    {
    } // End of the function
    static function showMenu(context, data, menu, forceShow)
    {
        if (net.wargaming.ingame.BattleContextMenuHandler.hitTestToCurrentMenu())
        {
            return;
        } // end if
        if ((data.uid > -1 || forceShow) && !data.himself)
        {
            currentContext = context;
            menu = net.wargaming.managers.ContextMenuManager.__get__instance().show(menu, false, data);
            menu.addEventListener("action", net.wargaming.ingame.BattleContextMenuHandler, "handleMenuAction");
            currentMenu = menu;
            if (net.wargaming.ingame.BattleContextMenuHandler.currentMenu._x + net.wargaming.ingame.BattleContextMenuHandler.currentMenu._width > Stage.width + 20)
            {
                net.wargaming.ingame.BattleContextMenuHandler.currentMenu._x = net.wargaming.ingame.BattleContextMenuHandler.currentMenu._x - (net.wargaming.ingame.BattleContextMenuHandler.currentMenu._width + 20);
            } // end if
            if (net.wargaming.ingame.BattleContextMenuHandler.currentMenu._y + net.wargaming.ingame.BattleContextMenuHandler.currentMenu._height > Stage.height + 20)
            {
                net.wargaming.ingame.BattleContextMenuHandler.currentMenu._y = net.wargaming.ingame.BattleContextMenuHandler.currentMenu._y - (net.wargaming.ingame.BattleContextMenuHandler.currentMenu._height + 20);
            } // end if
        }
        else
        {
            net.wargaming.ingame.BattleContextMenuHandler.hideMenu();
        } // end else if
    } // End of the function
    static function hideMenu()
    {
        net.wargaming.managers.ContextMenuManager.__get__instance().hide();
    } // End of the function
    static function hitTestToCurrentMenu()
    {
        if (net.wargaming.ingame.BattleContextMenuHandler.currentMenu != null)
        {
            return (net.wargaming.ingame.BattleContextMenuHandler.currentMenu.hitTest(_root._xmouse, _root._ymouse, true));
        } // end if
        return (false);
    } // End of the function
    static function handleMenuAction(event)
    {
        var _loc2 = event.id;
        var _loc1 = event.data;
        switch (_loc2)
        {
            case "addToFriends":
            {
                gfx.io.GameDelegate.call("Battle.UsersRoster.AddToFriends", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "removeFromFriends":
            {
                gfx.io.GameDelegate.call("Battle.UsersRoster.RemoveFromFriends", [_loc1.uid]);
                break;
            } 
            case "addToIgnored":
            {
                gfx.io.GameDelegate.call("Battle.UsersRoster.AddToIgnored", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "removeFromIgnored":
            {
                gfx.io.GameDelegate.call("Battle.UsersRoster.RemoveFromIgnored", [_loc1.uid]);
                break;
            } 
            case "setMuted":
            {
                gfx.io.GameDelegate.call("Battle.UsersRoster.AddMuted", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "unsetMuted":
            {
                gfx.io.GameDelegate.call("Battle.UsersRoster.RemoveMuted", [_loc1.uid]);
                break;
            } 
            case "offend":
            {
                gfx.io.GameDelegate.call("Battle.UsersRoster.AppealOffend", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "notFairPlay":
            {
                gfx.io.GameDelegate.call("Battle.UsersRoster.AppealNotFairPlay", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "teamKill":
            {
                gfx.io.GameDelegate.call("Battle.UsersRoster.AppealTeamkill", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "bot":
            {
                gfx.io.GameDelegate.call("Battle.UsersRoster.AppealBot", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "copyToClipBoard":
            {
                if (net.wargaming.ingame.BattleContextMenuHandler.currentContext.copyUserNameToClipboard)
                {
                    net.wargaming.ingame.BattleContextMenuHandler.currentContext.copyUserNameToClipboard(_loc1.userName);
                } // end if
                break;
            } 
            default:
            {
                if (net.wargaming.ingame.BattleContextMenuHandler.currentContext.handleMenuAction)
                {
                    net.wargaming.ingame.BattleContextMenuHandler.currentContext.handleMenuAction(_loc2, _loc1);
                } // end if
            } 
        } // End of switch
    } // End of the function
} // End of Class
