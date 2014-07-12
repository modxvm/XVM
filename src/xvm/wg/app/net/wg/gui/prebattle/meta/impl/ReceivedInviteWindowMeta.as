package net.wg.gui.prebattle.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;
   
   public class ReceivedInviteWindowMeta extends AbstractWindowView
   {
      
      public function ReceivedInviteWindowMeta() {
         super();
      }
      
      public var acceptInvite:Function = null;
      
      public var declineInvite:Function = null;
      
      public var cancelInvite:Function = null;
      
      public function acceptInviteS() : void {
         App.utils.asserter.assertNotNull(this.acceptInvite,"acceptInvite" + Errors.CANT_NULL);
         this.acceptInvite();
      }
      
      public function declineInviteS() : void {
         App.utils.asserter.assertNotNull(this.declineInvite,"declineInvite" + Errors.CANT_NULL);
         this.declineInvite();
      }
      
      public function cancelInviteS() : void {
         App.utils.asserter.assertNotNull(this.cancelInvite,"cancelInvite" + Errors.CANT_NULL);
         this.cancelInvite();
      }
   }
}
