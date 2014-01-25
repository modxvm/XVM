package net.wg.gui.tutorial.controls
{
   import net.wg.gui.components.controls.SoundButton;


   public class HintVideoItemRenderer extends HintBaseItemRenderer
   {
          
      public function HintVideoItemRenderer() {
         super();
      }

      public var button:SoundButton;

      override protected function drawData() : void {
         super.drawData();
         this.button.label = _data.label;
         this.button.validateNow();
      }
   }

}