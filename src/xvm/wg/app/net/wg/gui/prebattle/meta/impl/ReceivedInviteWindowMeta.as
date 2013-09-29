package net.wg.gui.prebattle.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ReceivedInviteWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function ReceivedInviteWindowMeta()
        {
            super();
            return;
        }

        public function acceptInviteS():void
        {
            App.utils.asserter.assertNotNull(this.acceptInvite, "acceptInvite" + net.wg.data.constants.Errors.CANT_NULL);
            this.acceptInvite();
            return;
        }

        public function declineInviteS():void
        {
            App.utils.asserter.assertNotNull(this.declineInvite, "declineInvite" + net.wg.data.constants.Errors.CANT_NULL);
            this.declineInvite();
            return;
        }

        public function cancelInviteS():void
        {
            App.utils.asserter.assertNotNull(this.cancelInvite, "cancelInvite" + net.wg.data.constants.Errors.CANT_NULL);
            this.cancelInvite();
            return;
        }

        public var acceptInvite:Function=null;

        public var declineInvite:Function=null;

        public var cancelInvite:Function=null;
    }
}
