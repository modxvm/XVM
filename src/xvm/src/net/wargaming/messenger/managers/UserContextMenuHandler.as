class net.wargaming.messenger.managers.UserContextMenuHandler
{
    static var currentContext, currentMenu;
    function UserContextMenuHandler()
    {
    } // End of the function
    static function showMenu(context, data, menu, forceShow)
    {
        if (net.wargaming.messenger.managers.UserContextMenuHandler.hitTestToCurrentMenu())
        {
            return;
        } // end if
        if ((data.uid > -1 || forceShow) && !data.himself)
        {
            currentContext = context;
            menu = net.wargaming.managers.ContextMenuManager.__get__instance().show(menu, false, data);
            menu.addEventListener("action", net.wargaming.messenger.managers.UserContextMenuHandler, "handleMenuAction");
            currentMenu = menu;
        }
        else
        {
            net.wargaming.messenger.managers.UserContextMenuHandler.hideMenu();
        } // end else if
    } // End of the function
    static function hideMenu()
    {
        net.wargaming.managers.ContextMenuManager.__get__instance().hide();
    } // End of the function
    static function hitTestToCurrentMenu()
    {
        if (net.wargaming.messenger.managers.UserContextMenuHandler.currentMenu != null)
        {
            return (net.wargaming.messenger.managers.UserContextMenuHandler.currentMenu.hitTest(_root._xmouse, _root._ymouse, true));
        } // end if
        return (false);
    } // End of the function
    static function handleMenuAction(event)
    {
        var _loc2 = event.id;
        var _loc1 = event.data;
        switch (_loc2)
        {
            case "userInfo":
            {
                gfx.io.GameDelegate.call("Messenger.UserInfo.Request", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "moneyTransfer":
            {
                gfx.io.GameDelegate.call("common.showMoneyTransfer", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "createPrivateChannel":
            {
                gfx.io.GameDelegate.call("Messenger.UsersRoster.CreatePrivateChannel", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "addToFriends":
            {
                gfx.io.GameDelegate.call("Messenger.UsersRoster.AddToFriends", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "setMuted":
            {
                gfx.io.GameDelegate.call("Messenger.UsersRoster.SetMuted", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "removeFromFriends":
            {
                gfx.io.GameDelegate.call("Messenger.UsersRoster.RemoveFromFriends", [_loc1.uid]);
                break;
            } 
            case "unsetMuted":
            {
                gfx.io.GameDelegate.call("Messenger.UsersRoster.UnsetMuted", [_loc1.uid]);
                break;
            } 
            case "addToIgnored":
            {
                gfx.io.GameDelegate.call("Messenger.UsersRoster.AddToIgnored", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "removeFromIgnored":
            {
                gfx.io.GameDelegate.call("Messenger.UsersRoster.RemoveFromIgnored", [_loc1.uid]);
                break;
            } 
            case "offend":
            {
                gfx.io.GameDelegate.call("Messenger.UsersRoster.AppealOffend", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "notFairPlay":
            {
                gfx.io.GameDelegate.call("Messenger.UsersRoster.AppealNotFairPlay", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "teamKill":
            {
                gfx.io.GameDelegate.call("Messenger.UsersRoster.AppealTeamkill", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "bot":
            {
                gfx.io.GameDelegate.call("Messenger.UsersRoster.AppealBot", [_loc1.uid, _loc1.userName]);
                break;
            } 
            case "copyToClipBoard":
            {
                var _loc3 = _loc1.userName;
                if (net.wargaming.messenger.managers.UserContextMenuHandler.currentContext.copyUserNameToClipboard)
                {
                    net.wargaming.messenger.managers.UserContextMenuHandler.currentContext.copyUserNameToClipboard(_loc3);
                } // end if
                break;
            } 
            default:
            {
                if (net.wargaming.messenger.managers.UserContextMenuHandler.currentContext.handleMenuAction)
                {
                    net.wargaming.messenger.managers.UserContextMenuHandler.currentContext.handleMenuAction(_loc2, _loc1);
                } // end if
            } 
        } // End of switch
    } // End of the function
} // End of Class
