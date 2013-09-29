package net.wg.gui.lobby.hangar.maintenance 
{
    import flash.events.*;
    import flash.geom.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.hangar.maintenance.events.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    
    public class MaintenanceDropDown extends net.wg.gui.components.controls.DropdownMenu
    {
        public function MaintenanceDropDown()
        {
            super();
            return;
        }

        protected override function showDropdown():void
        {
            super.showDropdown();
            var loc1:*=parent.parent.globalToLocal(new flash.geom.Point(_dropdownRef.x, _dropdownRef.y));
            var loc2:*=App.utils.events;
            loc2.disableDisposingForObj(_dropdownRef);
            parent.parent.addChild(_dropdownRef);
            _dropdownRef.x = loc1.x;
            _dropdownRef.y = loc1.y;
            loc2.enableDisposingForObj(_dropdownRef);
            loc2.addEvent(_dropdownRef, net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER, this.handleOnEquipmentRendererOver, false, 0, true);
            return;
        }

        internal function handleOnEquipmentRendererOver(arg1:net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver):void
        {
            dispatchEvent(new net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver(net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER, arg1.moduleID, arg1.modulePrices, arg1.inventoryCount, arg1.vehicleCount, arg1.moduleIndex));
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOut(arg1);
            if (!arg1.buttonDown) 
            {
                if (!enabled) 
                {
                    return;
                }
                setState("out");
            }
            return;
        }

        protected override function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOver(arg1);
            if (!arg1.buttonDown) 
            {
                if (!enabled) 
                {
                    return;
                }
                setState("over");
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                enabled = _dataProvider.length > 0;
            }
            return;
        }
    }
}
