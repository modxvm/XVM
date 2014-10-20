package net.wg.gui.lobby.techtree
{
    import net.wg.gui.components.controls.ContextMenu;
    import net.wg.gui.events.ContextMenuEvent;
    import net.wg.gui.lobby.techtree.nodes.Renderer;
    import net.wg.infrastructure.interfaces.IContextItem;
    import net.wg.data.components.ContextItem;
    import net.wg.gui.lobby.techtree.constants.ActionName;
    import net.wg.data.VO.SeparateItem;
    import net.wg.gui.lobby.techtree.nodes.ResearchItem;
    
    public class MenuHandler extends Object
    {
        
        public function MenuHandler()
        {
            super();
            this.currentMenu = null;
        }
        
        private static var instance:MenuHandler;
        
        public static function getInstance() : MenuHandler
        {
            if(instance == null)
            {
                instance = new MenuHandler();
            }
            return instance;
        }
        
        private var currentMenu:ContextMenu;
        
        public function hideMenu() : void
        {
            if(this.currentMenu)
            {
                this.currentMenu.removeEventListener(ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE,this.handleMenuReleaseOutside);
                this.currentMenu.removeEventListener(ContextMenuEvent.ON_ITEM_SELECT,this.handleVehicleMenuAction);
                this.currentMenu.removeEventListener(ContextMenuEvent.ON_ITEM_SELECT,this.handleItemMenuAction);
            }
            if(App.contextMenuMgr != null)
            {
                App.contextMenuMgr.hide();
            }
            this.currentMenu = null;
        }
        
        public function showNationTreeMenu(param1:Renderer) : void
        {
            var _loc2_:Vector.<IContextItem> = Vector.<IContextItem>([new ContextItem(ActionName.VEHICLE_INFO,MENU.CONTEXTMENU_VEHICLEINFOEX),new ContextItem(ActionName.SHOW_VEHICLE_STATS,MENU.CONTEXTMENU_SHOWVEHICLESTATISTICS,{"enabled":param1.isWasInBattle()}),new SeparateItem(),new ContextItem(ActionName.UNLOCK,MENU.CONTEXTMENU_UNLOCK,{"enabled":!param1.isPremium() && param1.isAvailable4Unlock()}),new ContextItem(ActionName.BUY,MENU.CONTEXTMENU_BUY,{"enabled":param1.isAvailable4Buy()}),new ContextItem(ActionName.SELL,param1.isRented()?MENU.CONTEXTMENU_VEHICLEREMOVE:MENU.CONTEXTMENU_SELL,{"enabled":param1.isAvailable4Sell()}),new SeparateItem(),new ContextItem(ActionName.SELECT_VEHICLE,MENU.CONTEXTMENU_SELECTVEHICLEINHANGAR,{"enabled":param1.inInventory() && param1.isVehicleCanBeChanged()})]);
            var _loc3_:ContextMenu = this.showMenu(param1,_loc2_);
            if(_loc3_ != null)
            {
                _loc3_.setMemberItemData(param1);
                _loc3_.addEventListener(ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE,this.handleMenuReleaseOutside,false,0,true);
                _loc3_.addEventListener(ContextMenuEvent.ON_ITEM_SELECT,this.handleVehicleMenuAction,false,0,true);
            }
        }
        
        public function showResearchRootMenu(param1:Renderer) : void
        {
            this.showNationTreeMenu(param1);
        }
        
        public function showResearchItemMenu(param1:ResearchItem) : void
        {
            var _loc2_:Vector.<IContextItem> = Vector.<IContextItem>([new ContextItem(ActionName.MODULE_INFO,MENU.CONTEXTMENU_MODULEINFO),new SeparateItem(),new ContextItem(ActionName.UNLOCK,MENU.CONTEXTMENU_UNLOCK,{"enabled":param1.isAvailable4Unlock()})]);
            if(param1.isUnlocked())
            {
                if((param1.inInventory()) || (param1.isInstalled()))
                {
                    _loc2_.push(new ContextItem(ActionName.EQUIP,MENU.CONTEXTMENU_EQUIP,{"enabled":param1.isAvailable4Install()}),new SeparateItem(),new ContextItem(ActionName.SELL,MENU.CONTEXTMENU_SELLFROMINVENTORY,{"enabled":!param1.isInstalled()}));
                }
                else
                {
                    _loc2_.push(new ContextItem(ActionName.BUY_AND_EQUIP,MENU.CONTEXTMENU_BUYANDEQUIP,{"enabled":param1.isAvailable4Buy()}),new SeparateItem(),new ContextItem(ActionName.SELL,MENU.CONTEXTMENU_SELLFROMINVENTORY,{"enabled":param1.isAvailable4Sell()}));
                }
            }
            else
            {
                _loc2_.push(new ContextItem(ActionName.BUY_AND_EQUIP,MENU.CONTEXTMENU_BUYANDEQUIP,{"enabled":false}),new SeparateItem(),new ContextItem(ActionName.SELL,MENU.CONTEXTMENU_SELLFROMINVENTORY,{"enabled":false}));
            }
            var _loc3_:ContextMenu = this.showMenu(param1,_loc2_);
            if(_loc3_ != null)
            {
                _loc3_.setMemberItemData(param1);
                _loc3_.addEventListener(ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE,this.handleMenuReleaseOutside,false,0,true);
                _loc3_.addEventListener(ContextMenuEvent.ON_ITEM_SELECT,this.handleItemMenuAction,false,0,true);
            }
        }
        
        private function showMenu(param1:Renderer, param2:Vector.<IContextItem>) : ContextMenu
        {
            this.hideMenu();
            return App.contextMenuMgr != null?ContextMenu(App.contextMenuMgr.show(param2,param1)):null;
        }
        
        private function handleMenuReleaseOutside(param1:ContextMenuEvent) : void
        {
            this.hideMenu();
        }
        
        private function handleVehicleMenuAction(param1:ContextMenuEvent) : void
        {
            var _loc2_:String = param1.id;
            var _loc3_:Renderer = param1.memberItemData as Renderer;
            if(_loc3_ != null)
            {
                switch(_loc2_)
                {
                    case ActionName.VEHICLE_INFO:
                        _loc3_.click2Info();
                        break;
                    case ActionName.UNLOCK:
                        _loc3_.click2Unlock();
                        break;
                    case ActionName.BUY:
                        _loc3_.click2Buy();
                        break;
                    case ActionName.SELL:
                        _loc3_.click2Sell();
                        break;
                    case ActionName.SELECT_VEHICLE:
                        _loc3_.click2SelectInHangar();
                        break;
                    case ActionName.SHOW_VEHICLE_STATS:
                        _loc3_.click2ShowVehicleStats();
                        break;
                }
            }
            this.hideMenu();
        }
        
        private function handleItemMenuAction(param1:ContextMenuEvent) : void
        {
            var _loc2_:String = param1.id;
            var _loc3_:ResearchItem = param1.memberItemData as ResearchItem;
            if(_loc3_ != null)
            {
                switch(_loc2_)
                {
                    case ActionName.MODULE_INFO:
                        _loc3_.click2Info();
                        break;
                    case ActionName.UNLOCK:
                        _loc3_.click2Unlock();
                        break;
                    case ActionName.BUY_AND_EQUIP:
                        _loc3_.click2Buy();
                        break;
                    case ActionName.EQUIP:
                        _loc3_.click2Install();
                        break;
                    case ActionName.SELL:
                        _loc3_.click2Sell();
                        break;
                }
            }
            this.hideMenu();
        }
    }
}
