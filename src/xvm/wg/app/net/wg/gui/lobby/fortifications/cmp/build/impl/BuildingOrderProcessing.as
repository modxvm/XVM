package net.wg.gui.lobby.fortifications.cmp.build.impl
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.text.TextField;


   public class BuildingOrderProcessing extends MovieClip implements IDisposable
   {
          
      public function BuildingOrderProcessing() {
         super();
      }

      public var timeOver:TextField;

      public function dispose() : void {
         this.timeOver = null;
         graphics.clear();
      }

      public function setTime(param1:String) : void {
         this.timeOver.text = param1;
      }
   }

}