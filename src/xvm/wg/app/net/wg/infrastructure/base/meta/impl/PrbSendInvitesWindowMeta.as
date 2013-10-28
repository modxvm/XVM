package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;


   public class PrbSendInvitesWindowMeta extends AbstractWindowView
   {
          
      public function PrbSendInvitesWindowMeta() {
         super();
      }

      public var showError:Function = null;

      public var searchToken:Function = null;

      public var setOnlineFlag:Function = null;

      public var sendInvites:Function = null;

      public function showErrorS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.showError,"showError" + Errors.CANT_NULL);
         this.showError(param1);
      }

      public function searchTokenS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.searchToken,"searchToken" + Errors.CANT_NULL);
         this.searchToken(param1);
      }

      public function setOnlineFlagS(param1:Boolean) : void {
         App.utils.asserter.assertNotNull(this.setOnlineFlag,"setOnlineFlag" + Errors.CANT_NULL);
         this.setOnlineFlag(param1);
      }

      public function sendInvitesS(param1:Array, param2:String) : void {
         App.utils.asserter.assertNotNull(this.sendInvites,"sendInvites" + Errors.CANT_NULL);
         this.sendInvites(param1,param2);
      }
   }

}