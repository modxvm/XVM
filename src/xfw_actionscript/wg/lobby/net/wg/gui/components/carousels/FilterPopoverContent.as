package net.wg.gui.components.carousels
{
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.carousels.controls.VehicleRolesTileList;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.utils.IClassFactory;
    import scaleform.clik.constants.DirectionMode;
    import net.wg.gui.components.controls.events.RendererEvent;
    import flash.events.Event;
    import scaleform.clik.interfaces.IListItemRenderer;
    import net.wg.gui.components.carousels.data.BaseRendererStateVO;
    import net.wg.gui.components.carousels.events.FiltersTileListEvent;

    public class FilterPopoverContent extends VehiclesFilterPopoverContent
    {

        private static const VEHICLE_ROLES_TITLE_OFFSET:int = -5;

        private static const VEHICLE_ROLES_LIST_GAP:int = -2;

        private static const VEHICLE_ROLES_LIST_BOTTOM_OFFSET:int = 7;

        private static const RADIOBUTTON_TILE_WIDTH:uint = 220;

        private static const RADIOBUTTON_TILE_HEIGHT:uint = 23;

        private static const LINKAGE_RADIOBUTTON_RENDERER:String = "RadioButtonRendererUI";

        public var titleVehicleRoles:ISoundButtonEx = null;

        public var listVehicleRoles:VehicleRolesTileList = null;

        public function FilterPopoverContent()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.titleVehicleRoles.useHtmlText = true;
            this.titleVehicleRoles.toggle = true;
            this.titleVehicleRoles.addEventListener(ButtonEvent.CLICK,this.onTitleVehicleRolesClickHandler);
            var _loc1_:IClassFactory = App.utils.classFactory;
            this.listVehicleRoles.itemRenderer = _loc1_.getClass(LINKAGE_RADIOBUTTON_RENDERER);
            this.listVehicleRoles.tileWidth = RADIOBUTTON_TILE_WIDTH;
            this.listVehicleRoles.tileHeight = RADIOBUTTON_TILE_HEIGHT;
            this.listVehicleRoles.directionMode = DirectionMode.HORIZONTAL;
            this.listVehicleRoles.verticalGap = VEHICLE_ROLES_LIST_GAP;
            this.listVehicleRoles.addEventListener(RendererEvent.ITEM_CLICK,this.onVehicleRoleItemClickHandler);
            this.listVehicleRoles.addEventListener(Event.RESIZE,this.onListResizeHandler);
        }

        override protected function onDispose() : void
        {
            this.listVehicleRoles.removeEventListener(RendererEvent.ITEM_CLICK,this.onVehicleRoleItemClickHandler);
            this.listVehicleRoles.removeEventListener(Event.RESIZE,this.onListResizeHandler);
            this.listVehicleRoles.dispose();
            this.listVehicleRoles = null;
            this.titleVehicleRoles.removeEventListener(ButtonEvent.CLICK,this.onTitleVehicleRolesClickHandler);
            this.titleVehicleRoles.dispose();
            this.titleVehicleRoles = null;
            super.onDispose();
        }

        override protected function updateSize() : void
        {
            var _loc1_:int = listVehicleType.y + listVehicleType.height + LIST_OFFSET;
            if(initData.rolesSectionVisible)
            {
                this.titleVehicleRoles.y = _loc1_ + VEHICLE_ROLES_TITLE_OFFSET;
                _loc1_ = this.titleVehicleRoles.y + this.titleVehicleRoles.height;
                if(this.titleVehicleRoles.selected)
                {
                    this.listVehicleRoles.y = _loc1_ + LABEL_OFFSET;
                    _loc1_ = this.listVehicleRoles.y + this.listVehicleRoles.height + VEHICLE_ROLES_LIST_BOTTOM_OFFSET;
                }
                _loc1_ = _loc1_ + LIST_OFFSET;
            }
            setSize(width,getNewHeight(_loc1_));
            dispatchEvent(new Event(Event.RESIZE));
        }

        override protected function updateState() : void
        {
            var _loc1_:IListItemRenderer = null;
            var _loc2_:BaseRendererStateVO = null;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            super.updateState();
            if(initData.rolesSectionVisible)
            {
                _loc3_ = stateData.rolesStates.length;
                _loc4_ = 0;
                while(_loc4_ < _loc3_)
                {
                    _loc1_ = this.listVehicleRoles.getRendererAt(_loc4_);
                    _loc2_ = stateData.rolesStates[_loc4_];
                    _loc1_.selected = _loc2_.selected;
                    _loc1_.visible = _loc2_.visible;
                    _loc4_++;
                }
                this.listVehicleRoles.invalidateLayout();
            }
        }

        override protected function updateData() : void
        {
            super.updateData();
            this.titleVehicleRoles.label = initData.rolesLabel;
            this.titleVehicleRoles.visible = initData.rolesSectionVisible;
            this.titleVehicleRoles.selected = !initData.rolesSectionCollapsed;
            this.listVehicleRoles.dataProvider = initData.roles;
            this.listVehicleRoles.visible = initData.rolesSectionVisible && !initData.rolesSectionCollapsed;
        }

        private function onListResizeHandler(param1:Event) : void
        {
            invalidateSize();
        }

        private function onVehicleRoleItemClickHandler(param1:RendererEvent) : void
        {
            dispatchEvent(new FiltersTileListEvent(FiltersTileListEvent.ITEM_CLICK,initData.rolesSectionId,param1.index));
        }

        private function onTitleVehicleRolesClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new FiltersTileListEvent(FiltersTileListEvent.ITEM_CLICK,initData.rolesSectionId,this.listVehicleRoles.length));
            this.listVehicleRoles.visible = this.titleVehicleRoles.selected;
            invalidateSize();
        }
    }
}
