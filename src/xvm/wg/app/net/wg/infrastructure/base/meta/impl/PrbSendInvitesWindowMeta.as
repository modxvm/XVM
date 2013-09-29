package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class PrbSendInvitesWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function PrbSendInvitesWindowMeta()
        {
            super();
            return;
        }

        public function showErrorS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.showError, "showError" + net.wg.data.constants.Errors.CANT_NULL);
            this.showError(arg1);
            return;
        }

        public function searchTokenS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.searchToken, "searchToken" + net.wg.data.constants.Errors.CANT_NULL);
            this.searchToken(arg1);
            return;
        }

        public function setOnlineFlagS(arg1:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.setOnlineFlag, "setOnlineFlag" + net.wg.data.constants.Errors.CANT_NULL);
            this.setOnlineFlag(arg1);
            return;
        }

        public function sendInvitesS(arg1:Array, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.sendInvites, "sendInvites" + net.wg.data.constants.Errors.CANT_NULL);
            this.sendInvites(arg1, arg2);
            return;
        }

        public var showError:Function=null;

        public var searchToken:Function=null;

        public var setOnlineFlag:Function=null;

        public var sendInvites:Function=null;
    }
}
