package net.wg.gui.cyberSport.controls
{


   public class ButtonDnmIcon extends ButtonIconLoader
   {
          
      public function ButtonDnmIcon() {
         super();
      }

      override protected function configUI() : void {
         super.configUI();
      }

      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         this.alpha = param1?1:0.5;
      }

      override protected function onDispose() : void {
         super.onDispose();
      }
   }

}