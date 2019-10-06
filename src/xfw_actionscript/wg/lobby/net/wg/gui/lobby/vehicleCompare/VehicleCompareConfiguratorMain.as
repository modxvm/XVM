package net.wg.gui.lobby.vehicleCompare
{
    import net.wg.infrastructure.base.meta.impl.VehicleCompareConfiguratorMainMeta;
    import net.wg.infrastructure.base.meta.IVehicleCompareConfiguratorMainMeta;
    import net.wg.gui.components.advanced.ViewStack;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.events.ViewStackEvent;
    import net.wg.data.constants.generated.VEHICLE_COMPARE_CONSTANTS;
    import net.wg.infrastructure.base.BaseDAAPIComponent;

    public class VehicleCompareConfiguratorMain extends VehicleCompareConfiguratorMainMeta implements IVehicleCompareConfiguratorMainMeta
    {

        private static const INV_BACKGROUND_SIZE:String = "InvBackgroundSize";

        public var viewStack:ViewStack = null;

        private var _currentAlias:String = null;

        public function VehicleCompareConfiguratorMain()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            setBackground(RES_ICONS.MAPS_ICONS_LOBBY_SETTINGS_BLURED_BG);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                UIComponentEx(this.viewStack.currentView).setSize(width,height);
                invalidate(INV_BACKGROUND_SIZE);
            }
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.viewStack.cache = true;
            this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
        }

        override protected function onDispose() : void
        {
            this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
            this.viewStack.dispose();
            this.viewStack = null;
            super.onDispose();
        }

        override protected function onEscapeKeyDown() : void
        {
            var _loc1_:VehicleCompareConfiguratorBaseView = VehicleCompareConfiguratorBaseView(this.viewStack.currentView);
            _loc1_.onCloseViewS();
        }

        public function as_showView(param1:String) : void
        {
            var _loc2_:String = null;
            switch(param1)
            {
                case VEHICLE_COMPARE_CONSTANTS.VEHICLE_CONFIGURATOR_VIEW:
                    _loc2_ = VEHICLE_COMPARE_CONSTANTS.VEHICLE_CONFIGURATOR_VIEW_LINKAGE;
                    break;
                case VEHICLE_COMPARE_CONSTANTS.VEHICLE_MODULES_VIEW:
                default:
                    _loc2_ = VEHICLE_COMPARE_CONSTANTS.VEHICLE_MODULES_VIEW_LINKAGE;
            }
            this.viewStack.show(_loc2_,_loc2_);
        }

        private function onViewStackViewChangedHandler(param1:ViewStackEvent) : void
        {
            switch(param1.viewId)
            {
                case VEHICLE_COMPARE_CONSTANTS.VEHICLE_CONFIGURATOR_VIEW_LINKAGE:
                    this._currentAlias = VEHICLE_COMPARE_CONSTANTS.VEHICLE_CONFIGURATOR_VIEW;
                    break;
                case VEHICLE_COMPARE_CONSTANTS.VEHICLE_MODULES_VIEW_LINKAGE:
                default:
                    this._currentAlias = VEHICLE_COMPARE_CONSTANTS.VEHICLE_MODULES_VIEW;
            }
            if(!isFlashComponentRegisteredS(this._currentAlias))
            {
                registerFlashComponentS(BaseDAAPIComponent(param1.view),this._currentAlias);
            }
            invalidateSize();
        }
    }
}
