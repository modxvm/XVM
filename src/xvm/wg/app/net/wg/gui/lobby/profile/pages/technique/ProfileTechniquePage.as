package net.wg.gui.lobby.profile.pages.technique
{
   import net.wg.infrastructure.base.meta.impl.ProfileTechniquePageMeta;
   import net.wg.gui.components.controls.CheckBox;
   import flash.events.Event;
   import flash.events.MouseEvent;


   public class ProfileTechniquePage extends ProfileTechniquePageMeta
   {
          
      public function ProfileTechniquePage() {
         super();
      }

      public var checkBoxExistence:CheckBox;

      override protected function configUI() : void {
         super.configUI();
         this.checkBoxExistence.addEventListener(Event.SELECT,this.checkBoxSelectHandler,false,0,true);
         this.checkBoxExistence.addEventListener(MouseEvent.MOUSE_OVER,this.checkBoxMouseOverHandler,false,0,true);
         this.checkBoxExistence.addEventListener(MouseEvent.MOUSE_OUT,this.checkBoxMouseOutHandler,false,0,true);
         emptyScreen.text = App.utils.locale.makeString(PROFILE.SECTION_TECHNIQUE_PAGE_EMPTYSCREENLABEL);
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
         super.draw();
      }

      override public function as_setInitData(param1:Object) : void {
         super.as_setInitData(param1);
         this.checkBoxExistence.label = param1.hangarVehiclesLabel;
         this.checkBoxExistence.selected = param1.isInHangarSelected;
      }

      override protected function onDispose() : void {
         this.checkBoxExistence.removeEventListener(MouseEvent.MOUSE_OVER,this.checkBoxMouseOverHandler);
         this.checkBoxExistence.removeEventListener(MouseEvent.MOUSE_OUT,this.checkBoxMouseOutHandler);
         super.onDispose();
      }
   }

}