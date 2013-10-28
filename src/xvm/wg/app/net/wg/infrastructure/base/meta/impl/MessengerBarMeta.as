package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.data.constants.Errors;


   public class MessengerBarMeta extends BaseDAAPIComponent
   {
          
      public function MessengerBarMeta() {
         super();
      }

      public var channelButtonClick:Function = null;

      public var contactsButtonClick:Function = null;

      public function channelButtonClickS() : void {
         App.utils.asserter.assertNotNull(this.channelButtonClick,"channelButtonClick" + Errors.CANT_NULL);
         this.channelButtonClick();
      }

      public function contactsButtonClickS() : void {
         App.utils.asserter.assertNotNull(this.contactsButtonClick,"contactsButtonClick" + Errors.CANT_NULL);
         this.contactsButtonClick();
      }
   }

}