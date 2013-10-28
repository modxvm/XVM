package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.data.constants.Errors;


   public class NotificationsListMeta extends AbstractView
   {
          
      public function NotificationsListMeta() {
         super();
      }

      public var onWindowClose:Function = null;

      public var onMessageShowMore:Function = null;

      public var onSecuritySettingsLinkClick:Function = null;

      public function onWindowCloseS() : void {
         App.utils.asserter.assertNotNull(this.onWindowClose,"onWindowClose" + Errors.CANT_NULL);
         this.onWindowClose();
      }

      public function onMessageShowMoreS(param1:Object) : void {
         App.utils.asserter.assertNotNull(this.onMessageShowMore,"onMessageShowMore" + Errors.CANT_NULL);
         this.onMessageShowMore(param1);
      }

      public function onSecuritySettingsLinkClickS() : void {
         App.utils.asserter.assertNotNull(this.onSecuritySettingsLinkClick,"onSecuritySettingsLinkClick" + Errors.CANT_NULL);
         this.onSecuritySettingsLinkClick();
      }
   }

}