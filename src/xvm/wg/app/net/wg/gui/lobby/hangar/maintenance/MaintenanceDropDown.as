package net.wg.gui.lobby.hangar.maintenance
{
   import net.wg.gui.components.controls.DropdownMenu;
   import flash.geom.Point;
   import net.wg.utils.IEventCollector;
   import net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver;
   import flash.events.MouseEvent;
   import scaleform.clik.constants.InvalidationType;


   public class MaintenanceDropDown extends DropdownMenu
   {
          
      public function MaintenanceDropDown() {
         super();
      }

      override protected function showDropdown() : void {
         super.showDropdown();
         var _loc1_:Point = parent.parent.globalToLocal(new Point(_dropdownRef.x,_dropdownRef.y));
         var _loc2_:IEventCollector = App.utils.events;
         _loc2_.disableDisposingForObj(_dropdownRef);
         parent.parent.addChild(_dropdownRef);
         _dropdownRef.x = _loc1_.x;
         _dropdownRef.y = _loc1_.y;
         _loc2_.enableDisposingForObj(_dropdownRef);
         _loc2_.addEvent(_dropdownRef,OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER,this.handleOnEquipmentRendererOver,false,0,true);
      }

      private function handleOnEquipmentRendererOver(param1:OnEquipmentRendererOver) : void {
         dispatchEvent(new OnEquipmentRendererOver(OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER,param1.moduleID,param1.modulePrices,param1.inventoryCount,param1.vehicleCount,param1.moduleIndex));
      }

      override protected function handleMouseRollOut(param1:MouseEvent) : void {
         super.handleMouseRollOut(param1);
         if(!param1.buttonDown)
         {
            if(!enabled)
            {
               return;
            }
            setState("out");
         }
      }

      override protected function handleMouseRollOver(param1:MouseEvent) : void {
         super.handleMouseRollOver(param1);
         if(!param1.buttonDown)
         {
            if(!enabled)
            {
               return;
            }
            setState("over");
         }
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            enabled = _dataProvider.length > 0;
         }
      }
   }

}