package net.wg.gui.lobby.fortifications.cmp.build.impl
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.text.TextField;
   import net.wg.gui.lobby.fortifications.data.BuildingProgressLblVO;
   
   public class ProgressTotalLabels extends MovieClip implements IDisposable
   {
      
      public function ProgressTotalLabels() {
         super();
      }
      
      public var currentValue:TextField;
      
      public var totalValue:TextField;
      
      public var separator:TextField;
      
      private var model:BuildingProgressLblVO;
      
      public function dispose() : void {
         if(this.model)
         {
            this.model.dispose();
            this.model = null;
         }
      }
      
      public function set setData(param1:BuildingProgressLblVO) : void {
         this.model = param1;
         this.currentValue.htmlText = this.model.currentValue;
         this.totalValue.htmlText = this.model.totalValue;
         this.separator.htmlText = this.model.separator;
      }
   }
}
