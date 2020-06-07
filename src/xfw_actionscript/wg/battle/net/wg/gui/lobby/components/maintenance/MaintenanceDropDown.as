package net.wg.gui.lobby.components.maintenance
{
    import net.wg.gui.components.controls.DropdownMenu;
    import net.wg.gui.lobby.components.maintenance.events.OnEquipmentRendererOver;
    import flash.events.MouseEvent;
    import net.wg.data.constants.ComponentState;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    import flash.geom.Point;

    public class MaintenanceDropDown extends DropdownMenu
    {

        public function MaintenanceDropDown()
        {
            super();
        }

        override protected function showDropdown() : void
        {
            super.showDropdown();
            if(_dropdownRef)
            {
                parent.parent.addChild(_dropdownRef);
                _dropdownRef.addEventListener(OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER,this.handleOnEquipmentRendererOver,false,0,true);
                this.updateDDPosition(null);
            }
        }

        override protected function onDispose() : void
        {
            if(_dropdownRef)
            {
                _dropdownRef.removeEventListener(OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER,this.handleOnEquipmentRendererOver);
            }
            super.onDispose();
        }

        private function handleOnEquipmentRendererOver(param1:OnEquipmentRendererOver) : void
        {
            dispatchEvent(new OnEquipmentRendererOver(OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER,param1.moduleID,param1.modulePrices,param1.inventoryCount,param1.vehicleCount,param1.moduleIndex));
        }

        override protected function handleMouseRollOut(param1:MouseEvent) : void
        {
            super.handleMouseRollOut(param1);
            if(!param1.buttonDown)
            {
                if(!enabled)
                {
                    return;
                }
                setState(ComponentState.OUT);
            }
        }

        override protected function handleMouseRollOver(param1:MouseEvent) : void
        {
            super.handleMouseRollOver(param1);
            if(!param1.buttonDown)
            {
                if(!enabled)
                {
                    return;
                }
                setState(ComponentState.OVER);
            }
        }

        override protected function draw() : void
        {
            super.draw();
            if(_dataProvider && isInvalid(InvalidationType.DATA))
            {
                enabled = _dataProvider.length > 0;
            }
        }

        override protected function updateDDPosition(param1:Event) : void
        {
            var _loc2_:Point = null;
            if(_dropdownRef)
            {
                super.updateDDPosition(param1);
                _dropdownRef.x = _dropdownRef.x * App.appScale;
                _dropdownRef.y = _dropdownRef.y * App.appScale;
                _loc2_ = parent.parent.parent.globalToLocal(new Point(_dropdownRef.x,_dropdownRef.y));
                _dropdownRef.x = _loc2_.x;
                _dropdownRef.y = _loc2_.y;
            }
        }
    }
}
