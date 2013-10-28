package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.data.constants.Errors;


   public class NotificationPopUpViewerMeta extends BaseDAAPIComponent
   {
          
      public function NotificationPopUpViewerMeta() {
         super();
      }

      public var setListClear:Function = null;

      public var onMessageHided:Function = null;

      public var onMessageShowMore:Function = null;

      public var onSecuritySettingsLinkClick:Function = null;

      public function setListClearS() : void {
         App.utils.asserter.assertNotNull(this.setListClear,"setListClear" + Errors.CANT_NULL);
         this.setListClear();
      }

      public function onMessageHidedS(param1:Boolean, param2:Boolean) : void {
         App.utils.asserter.assertNotNull(this.onMessageHided,"onMessageHided" + Errors.CANT_NULL);
         this.onMessageHided(param1,param2);
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