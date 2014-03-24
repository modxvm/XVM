package net.wg.gui.prebattle.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;


   public class PrequeueWindowMeta extends AbstractWindowView
   {
          
      public function PrequeueWindowMeta() {
         super();
      }

      public var requestToEnqueue:Function = null;

      public var requestToLeave:Function = null;

      public var showFAQWindow:Function = null;

      public var isEnqueueBtnEnabled:Function = null;

      public var isLeaveBtnEnabled:Function = null;

      public function requestToEnqueueS() : void {
         App.utils.asserter.assertNotNull(this.requestToEnqueue,"requestToEnqueue" + Errors.CANT_NULL);
         this.requestToEnqueue();
      }

      public function requestToLeaveS() : void {
         App.utils.asserter.assertNotNull(this.requestToLeave,"requestToLeave" + Errors.CANT_NULL);
         this.requestToLeave();
      }

      public function showFAQWindowS() : void {
         App.utils.asserter.assertNotNull(this.showFAQWindow,"showFAQWindow" + Errors.CANT_NULL);
         this.showFAQWindow();
      }

      public function isEnqueueBtnEnabledS() : Boolean {
         App.utils.asserter.assertNotNull(this.isEnqueueBtnEnabled,"isEnqueueBtnEnabled" + Errors.CANT_NULL);
         return this.isEnqueueBtnEnabled();
      }

      public function isLeaveBtnEnabledS() : Boolean {
         App.utils.asserter.assertNotNull(this.isLeaveBtnEnabled,"isLeaveBtnEnabled" + Errors.CANT_NULL);
         return this.isLeaveBtnEnabled();
      }
   }

}