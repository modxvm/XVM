package net.wg.gui.lobby.techtree 
{
    import __AS3__.vec.*;
    import net.wg.data.VO.*;
    import net.wg.data.components.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.nodes.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class MenuHandler extends Object
    {
        public function MenuHandler()
        {
            super();
            this.currentMenu = null;
            return;
        }

        public function hideMenu():void
        {
            if (this.currentMenu) 
            {
                this.currentMenu.removeEventListener(net.wg.gui.events.ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE, this.handleMenuReleaseOutside);
                this.currentMenu.removeEventListener(net.wg.gui.events.ContextMenuEvent.ON_ITEM_SELECT, this.handleVehicleMenuAction);
                this.currentMenu.removeEventListener(net.wg.gui.events.ContextMenuEvent.ON_ITEM_SELECT, this.handleItemMenuAction);
            }
            if (App.contextMenuMgr != null) 
                App.contextMenuMgr.hide();
            this.currentMenu = null;
            return;
        }

        public function showNationTreeMenu(arg1:net.wg.gui.lobby.techtree.nodes.Renderer):void
        {
            var loc1:*=Vector.<net.wg.infrastructure.interfaces.IContextItem>([new net.wg.data.components.ContextItem(net.wg.gui.lobby.techtree.constants.ActionName.VEHICLE_INFO, MENU.CONTEXTMENU_VEHICLEINFOEX), new net.wg.data.VO.SeparateItem(), new net.wg.data.components.ContextItem(net.wg.gui.lobby.techtree.constants.ActionName.UNLOCK, MENU.CONTEXTMENU_UNLOCK, {"enabled":!arg1.isPremium() && arg1.isAvailable4Unlock()}), new net.wg.data.components.ContextItem(net.wg.gui.lobby.techtree.constants.ActionName.BUY, MENU.CONTEXTMENU_BUY, {"enabled":arg1.isAvailable4Buy()}), new net.wg.data.VO.SeparateItem(), new net.wg.data.components.ContextItem(net.wg.gui.lobby.techtree.constants.ActionName.SELL, MENU.CONTEXTMENU_SELL, {"enabled":arg1.isAvailable4Sell()})]);
            var loc2:*=this.showMenu(arg1, loc1);
            if (loc2 != null) 
            {
                loc2.setMemberItemData(arg1);
                loc2.addEventListener(net.wg.gui.events.ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE, this.handleMenuReleaseOutside, false, 0, true);
                loc2.addEventListener(net.wg.gui.events.ContextMenuEvent.ON_ITEM_SELECT, this.handleVehicleMenuAction, false, 0, true);
            }
            return;
        }

        public function showResearchRootMenu(arg1:net.wg.gui.lobby.techtree.nodes.Renderer):void
        {
            this.showNationTreeMenu(arg1);
            return;
        }

        public function showResearchItemMenu(arg1:net.wg.gui.lobby.techtree.nodes.ResearchItem):void
        {
            var loc1:*=Vector.<net.wg.infrastructure.interfaces.IContextItem>([new net.wg.data.components.ContextItem(net.wg.gui.lobby.techtree.constants.ActionName.MODULE_INFO, MENU.CONTEXTMENU_MODULEINFO), new net.wg.data.VO.SeparateItem(), new net.wg.data.components.ContextItem(net.wg.gui.lobby.techtree.constants.ActionName.UNLOCK, MENU.CONTEXTMENU_UNLOCK, {"enabled":arg1.isAvailable4Unlock()})]);
            if (arg1.isUnlocked()) 
                if (arg1.inInventory() || arg1.isInstalled()) 
                    loc1.push(new net.wg.data.components.ContextItem(net.wg.gui.lobby.techtree.constants.ActionName.EQUIP, MENU.CONTEXTMENU_EQUIP, {"enabled":arg1.isAvailable4Install()}), new net.wg.data.VO.SeparateItem(), new net.wg.data.components.ContextItem(net.wg.gui.lobby.techtree.constants.ActionName.SELL, MENU.CONTEXTMENU_SELLFROMINVENTORY, {"enabled":!arg1.isInstalled()}));
                else 
                    loc1.push(new net.wg.data.components.ContextItem(net.wg.gui.lobby.techtree.constants.ActionName.BUY_AND_EQUIP, MENU.CONTEXTMENU_BUYANDEQUIP, {"enabled":arg1.isAvailable4Buy()}), new net.wg.data.VO.SeparateItem(), new net.wg.data.components.ContextItem(net.wg.gui.lobby.techtree.constants.ActionName.SELL, MENU.CONTEXTMENU_SELLFROMINVENTORY, {"enabled":arg1.isAvailable4Sell()}));
            else 
                loc1.push(new net.wg.data.components.ContextItem(net.wg.gui.lobby.techtree.constants.ActionName.BUY_AND_EQUIP, MENU.CONTEXTMENU_BUYANDEQUIP, {"enabled":false}), new net.wg.data.VO.SeparateItem(), new net.wg.data.components.ContextItem(net.wg.gui.lobby.techtree.constants.ActionName.SELL, MENU.CONTEXTMENU_SELLFROMINVENTORY, {"enabled":false}));
            var loc2:*=this.showMenu(arg1, loc1);
            if (loc2 != null) 
            {
                loc2.setMemberItemData(arg1);
                loc2.addEventListener(net.wg.gui.events.ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE, this.handleMenuReleaseOutside, false, 0, true);
                loc2.addEventListener(net.wg.gui.events.ContextMenuEvent.ON_ITEM_SELECT, this.handleItemMenuAction, false, 0, true);
            }
            return;
        }

        internal function showMenu(arg1:net.wg.gui.lobby.techtree.nodes.Renderer, arg2:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>):net.wg.gui.components.controls.ContextMenu
        {
            this.hideMenu();
            return App.contextMenuMgr == null ? null : net.wg.gui.components.controls.ContextMenu(App.contextMenuMgr.show(arg2, arg1));
        }

        internal function handleMenuReleaseOutside(arg1:net.wg.gui.events.ContextMenuEvent):void
        {
            this.hideMenu();
            return;
        }

        internal function handleVehicleMenuAction(arg1:net.wg.gui.events.ContextMenuEvent):void
        {
            var loc1:*=arg1.id;
            var loc2:*=arg1.memberItemData as net.wg.gui.lobby.techtree.nodes.Renderer;
            if (loc2 != null) 
            {
                var loc3:*=loc1;
                switch (loc3) 
                {
                    case net.wg.gui.lobby.techtree.constants.ActionName.VEHICLE_INFO:
                        loc2.click2Info();
                        break;
                    case net.wg.gui.lobby.techtree.constants.ActionName.UNLOCK:
                        loc2.click2Unlock();
                        break;
                    case net.wg.gui.lobby.techtree.constants.ActionName.BUY:
                        loc2.click2Buy();
                        break;
                    case net.wg.gui.lobby.techtree.constants.ActionName.SELL:
                        loc2.click2Sell();
                        break;
                }
            }
            this.hideMenu();
            return;
        }

        internal function handleItemMenuAction(arg1:net.wg.gui.events.ContextMenuEvent):void
        {
            var loc1:*=arg1.id;
            var loc2:*=arg1.memberItemData as net.wg.gui.lobby.techtree.nodes.ResearchItem;
            if (loc2 != null) 
            {
                var loc3:*=loc1;
                switch (loc3) 
                {
                    case net.wg.gui.lobby.techtree.constants.ActionName.MODULE_INFO:
                        loc2.click2Info();
                        break;
                    case net.wg.gui.lobby.techtree.constants.ActionName.UNLOCK:
                        loc2.click2Unlock();
                        break;
                    case net.wg.gui.lobby.techtree.constants.ActionName.BUY_AND_EQUIP:
                        loc2.click2Buy();
                        break;
                    case net.wg.gui.lobby.techtree.constants.ActionName.EQUIP:
                        loc2.click2Install();
                        break;
                    case net.wg.gui.lobby.techtree.constants.ActionName.SELL:
                        loc2.click2Sell();
                        break;
                }
            }
            this.hideMenu();
            return;
        }

        public static function getInstance():net.wg.gui.lobby.techtree.MenuHandler
        {
            if (instance == null) 
                instance = new MenuHandler();
            return instance;
        }

        internal var currentMenu:net.wg.gui.components.controls.ContextMenu;

        internal static var instance:net.wg.gui.lobby.techtree.MenuHandler;
    }
}
