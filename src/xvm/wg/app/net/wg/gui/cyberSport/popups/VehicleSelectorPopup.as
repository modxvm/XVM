package net.wg.gui.cyberSport.popups
{
   import net.wg.infrastructure.base.meta.impl.VehicleSelectorPopupMeta;
   import net.wg.infrastructure.base.meta.IVehicleSelectorPopupMeta;
   import net.wg.gui.cyberSport.controls.VehicleSelector;
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.text.TextField;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorFilterEvent;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorEvent;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.cyberSport.vo.VehicleSelectorFilterVO;
   import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;


   public class VehicleSelectorPopup extends VehicleSelectorPopupMeta implements IVehicleSelectorPopupMeta
   {
          
      public function VehicleSelectorPopup() {
         this.selectedItems = [];
         super();
         isModal = true;
         this.infoTF.mouseEnabled = false;
      }

      public var selector:VehicleSelector;

      public var selectButton:SoundButtonEx;

      public var cancelButton:SoundButtonEx;

      public var infoTF:TextField;

      private var selectedItems:Array;

      override protected function configUI() : void {
         super.configUI();
         this.selector.addEventListener(VehicleSelectorFilterEvent.CHANGE,this.onFiltersChanged);
         this.selector.addEventListener(VehicleSelectorEvent.SELECTION_CHANGED,this.onSelectionChanged);
         this.selectButton.addEventListener(ButtonEvent.CLICK,this.onSelectClick);
         this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onCancelClick);
      }

      private function onSelectionChanged(param1:VehicleSelectorEvent) : void {
         this.selectedItems = param1.selectedDescriptors;
         this.selectButton.enabled = this.selectedItems.length > 0;
         if(param1.forceSelect)
         {
            onSelectVehiclesS(this.selectedItems);
         }
      }

      private function onFiltersChanged(param1:VehicleSelectorFilterEvent) : void {
         onFiltersUpdateS(param1.nation,param1.vehicleType,param1.isMain);
      }

      private function onCancelClick(param1:ButtonEvent) : void {
         onWindowClose();
      }

      private function onSelectClick(param1:ButtonEvent) : void {
         onSelectVehiclesS(this.selectedItems);
      }

      override protected function draw() : void {
         super.draw();
      }

      public function as_setFiltersData(param1:Object) : void {
         this.selector.setFiltersData(new VehicleSelectorFilterVO(param1));
      }

      public function as_setListData(param1:Array, param2:Array) : void {
         var _loc4_:* = 0;
         var _loc3_:Array = [];
         for each (_loc4_ in param1)
         {
            _loc3_.push(new VehicleSelectorItemVO(_loc4_,true));
         }
         this.selector.setupSelectionOverrides(param2);
         this.selector.setListItems(_loc3_);
      }

      public function as_setListMode(param1:Boolean) : void {
         this.selector.multiSelection = param1;
      }

      public function as_setInfoText(param1:String) : void {
         this.infoTF.text = param1;
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         window.useBottomBtns = true;
         window.title = CYBERSPORT.WINDOW_VEHICLESELECTOR_TITLE;
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.selector.removeEventListener(VehicleSelectorFilterEvent.CHANGE,this.onFiltersChanged);
         this.selector.removeEventListener(VehicleSelectorEvent.SELECTION_CHANGED,this.onSelectionChanged);
         this.selectButton.removeEventListener(ButtonEvent.CLICK,this.onSelectClick);
         this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onCancelClick);
         this.selector.dispose();
         this.selectButton.dispose();
         this.cancelButton.dispose();
      }
   }

}