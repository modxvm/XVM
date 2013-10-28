package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.data.constants.Errors;


   public class NotificationListButtonMeta extends BaseDAAPIComponent
   {
          
      public function NotificationListButtonMeta() {
         super();
      }

      public var handleClick:Function = null;

      public function handleClickS() : void {
         App.utils.asserter.assertNotNull(this.handleClick,"handleClick" + Errors.CANT_NULL);
         this.handleClick();
      }
   }

}