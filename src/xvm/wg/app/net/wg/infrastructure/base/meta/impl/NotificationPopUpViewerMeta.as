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
      
      public var onClickAction:Function = null;
      
      public var onSecuritySettingsLinkClick:Function = null;
      
      public var getMessageActualTime:Function = null;
      
      public function setListClearS() : void {
         App.utils.asserter.assertNotNull(this.setListClear,"setListClear" + Errors.CANT_NULL);
         this.setListClear();
      }
      
      public function onMessageHidedS(param1:Boolean, param2:Boolean) : void {
         App.utils.asserter.assertNotNull(this.onMessageHided,"onMessageHided" + Errors.CANT_NULL);
         this.onMessageHided(param1,param2);
      }
      
      public function onClickActionS(param1:uint, param2:Number, param3:String) : void {
         App.utils.asserter.assertNotNull(this.onClickAction,"onClickAction" + Errors.CANT_NULL);
         this.onClickAction(param1,param2,param3);
      }
      
      public function onSecuritySettingsLinkClickS() : void {
         App.utils.asserter.assertNotNull(this.onSecuritySettingsLinkClick,"onSecuritySettingsLinkClick" + Errors.CANT_NULL);
         this.onSecuritySettingsLinkClick();
      }
      
      public function getMessageActualTimeS(param1:Number) : String {
         App.utils.asserter.assertNotNull(this.getMessageActualTime,"getMessageActualTime" + Errors.CANT_NULL);
         return this.getMessageActualTime(param1);
      }
   }
}
