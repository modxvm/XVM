package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.data.constants.Errors;
   
   public class ViewPresenterMeta extends AbstractView
   {
      
      public function ViewPresenterMeta() {
         super();
      }
      
      public var showView:Function = null;
      
      public function showViewS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.showView,"showView" + Errors.CANT_NULL);
         this.showView(param1);
      }
   }
}
