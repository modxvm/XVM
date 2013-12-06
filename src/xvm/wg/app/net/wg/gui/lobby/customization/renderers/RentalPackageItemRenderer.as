package net.wg.gui.lobby.customization.renderers
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.RadioButton;
   import flash.events.MouseEvent;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.SoundTypes;


   public class RentalPackageItemRenderer extends SoundListItemRenderer
   {
          
      public function RentalPackageItemRenderer() {
         super();
         soundType = SoundTypes.RNDR_NORMAL;
         soundId = SoundTypes.SECTION_RENDERER;
      }

      public var rbtn:RadioButton;

      override public function setData(param1:Object) : void {
         super.data = param1;
         invalidateData();
      }

      override public function set selected(param1:Boolean) : void {
         super.selected = param1;
         this.rbtn.selected = param1;
      }

      override public function set label(param1:String) : void {
         super.label = param1;
         this.rbtn.label = param1;
      }

      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         mouseEnabled = true;
      }

      override protected function configUI() : void {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }

      override protected function draw() : void {
         if(isInvalid(InvalidationType.DATA))
         {
            visible = !(data == null);
            this.enabled = (enabled) && (data?data.enabled:false);
         }
         super.draw();
      }

      override public function dispose() : void {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         super.dispose();
      }

      private function onRollOver(param1:MouseEvent) : void {
         if((data) && (data.isIGR))
         {
            App.toolTipMgr.showComplex(TOOLTIPS.CUSTOMIZATION_CAMOUFLAGE_IGR);
         }
      }

      private function onRollOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }
   }

}