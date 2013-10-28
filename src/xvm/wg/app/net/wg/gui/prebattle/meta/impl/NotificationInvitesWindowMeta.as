package net.wg.gui.prebattle.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;


   public class NotificationInvitesWindowMeta extends AbstractWindowView
   {
          
      public function NotificationInvitesWindowMeta() {
         super();
      }

      public var requestInvites:Function = null;

      public var selectedInvite:Function = null;

      public function requestInvitesS() : void {
         App.utils.asserter.assertNotNull(this.requestInvites,"requestInvites" + Errors.CANT_NULL);
         this.requestInvites();
      }

      public function selectedInviteS(param1:Object) : void {
         App.utils.asserter.assertNotNull(this.selectedInvite,"selectedInvite" + Errors.CANT_NULL);
         this.selectedInvite(param1);
      }
   }

}