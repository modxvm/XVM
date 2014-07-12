package net.wg.gui.components.advanced
{
   public class ButtonDnmIcon extends ButtonIconLoader
   {
      
      public function ButtonDnmIcon() {
         super();
      }
      
      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         this.alpha = param1?1:0.5;
      }
      
      override protected function configUI() : void {
         super.configUI();
      }
      
      override protected function onDispose() : void {
         super.onDispose();
      }
   }
}
