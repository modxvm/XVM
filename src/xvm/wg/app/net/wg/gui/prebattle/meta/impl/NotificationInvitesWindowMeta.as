package net.wg.gui.prebattle.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class NotificationInvitesWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function NotificationInvitesWindowMeta()
        {
            super();
            return;
        }

        public function requestInvitesS():void
        {
            App.utils.asserter.assertNotNull(this.requestInvites, "requestInvites" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestInvites();
            return;
        }

        public function selectedInviteS(arg1:Object):void
        {
            App.utils.asserter.assertNotNull(this.selectedInvite, "selectedInvite" + net.wg.data.constants.Errors.CANT_NULL);
            this.selectedInvite(arg1);
            return;
        }

        public var requestInvites:Function=null;

        public var selectedInvite:Function=null;
    }
}
