package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.data.constants.Errors;


   public class RssNewsFeedMeta extends BaseDAAPIComponent
   {
          
      public function RssNewsFeedMeta() {
         super();
      }

      public var openBrowser:Function = null;

      public function openBrowserS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.openBrowser,"openBrowser" + Errors.CANT_NULL);
         this.openBrowser(param1);
      }
   }

}