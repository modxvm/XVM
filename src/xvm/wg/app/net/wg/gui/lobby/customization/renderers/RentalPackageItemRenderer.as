package net.wg.gui.lobby.customization.renderers
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.RadioButton;
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

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            visible = !(data == null);
         }
      }
   }

}