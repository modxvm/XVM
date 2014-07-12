package net.wg.gui.rally.controls
{
   import flash.display.Sprite;
   import net.wg.data.constants.Errors;
   
   public class RallyLockableSlotRenderer extends RallySlotRenderer
   {
      
      public function RallyLockableSlotRenderer() {
         super();
      }
      
      public var lockBackground:Sprite;
      
      override protected function onDispose() : void {
         this.lockBackground = null;
         super.onDispose();
      }
      
      override protected function configUI() : void {
         App.utils.asserter.assertNotNull(this.lockBackground,"lockBackground in " + name + Errors.CANT_NULL);
         super.configUI();
      }
   }
}
