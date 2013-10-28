package net.wg.gui.messenger.windows
{
   import flash.display.Sprite;
   import scaleform.clik.utils.Constraints;


   public class LazyChannelWindow extends BaseChannelWindow
   {
          
      public function LazyChannelWindow() {
         super();
      }

      public var background:Sprite;

      override protected function configUI() : void {
         super.configUI();
         constraints.addElement("background",this.background,Constraints.ALL);
      }
   }

}