package net.wg.gui.lobby.profile.pages.technique
{
   import net.wg.infrastructure.base.meta.impl.ProfileTechniquePageMeta;
   import net.wg.gui.components.controls.CompactCheckBox;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;


   public class ProfileTechniquePage extends ProfileTechniquePageMeta
   {
          
      public function ProfileTechniquePage() {
         super();
      }

      private static const LAYOUT_INVALID:String = "layoutInv";

      public var checkBoxExistence:CompactCheckBox;

      override protected function configUI() : void {
         super.configUI();
         this.checkBoxExistence.addEventListener(Event.SELECT,this.checkBoxSelectHandler,false,0,true);
         this.checkBoxExistence.addEventListener(MouseEvent.MOUSE_OVER,this.checkBoxMouseOverHandler,false,0,true);
         this.checkBoxExistence.addEventListener(MouseEvent.MOUSE_OUT,this.checkBoxMouseOutHandler,false,0,true);
      }

      private function checkBoxMouseOverHandler(param1:MouseEvent) : void {
         App.toolTipMgr.showComplex(PROFILE.SECTION_TECHNIQUE_CHECKBOXHANGARVEHICLES_TOOLTIP);
      }

      private function checkBoxMouseOutHandler(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function checkBoxSelectHandler(param1:Event) : void {
         setIsInHangarSelectedS(this.checkBoxExistence.selected);
      }

      override protected function draw() : void {
         var _loc1_:TextField = null;
         var _loc2_:* = 0;
         var _loc3_:TextField = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         super.draw();
         if(isInvalid(LAYOUT_INVALID))
         {
            _loc1_ = battlesDropdown.txtLabel;
            _loc2_ = _loc1_.x + _loc1_.width - _loc1_.textWidth;
            _loc3_ = this.checkBoxExistence.textField;
            _loc4_ = _loc3_.x + _loc3_.textWidth;
            _loc5_ = 10;
            _loc6_ = battlesDropdown.x + _loc2_ - (this.checkBoxExistence.x + _loc4_ + _loc5_);
            if(_loc6_ < 0)
            {
               this.checkBoxExistence.x = this.checkBoxExistence.x + _loc6_;
            }
         }
      }

      override public function as_setInitData(param1:Object) : void {
         super.as_setInitData(param1);
         this.checkBoxExistence.label = param1.hangarVehiclesLabel;
         this.checkBoxExistence.selected = param1.isInHangarSelected;
         this.checkBoxExistence.validateNow();
         invalidate(LAYOUT_INVALID);
      }

      override protected function onDispose() : void {
         this.checkBoxExistence.removeEventListener(MouseEvent.MOUSE_OVER,this.checkBoxMouseOverHandler);
         this.checkBoxExistence.removeEventListener(MouseEvent.MOUSE_OUT,this.checkBoxMouseOutHandler);
         super.onDispose();
      }
   }

}