package net.wg.gui.prebattle.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class PrebattleWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function PrebattleWindowMeta()
        {
            super();
            return;
        }

        public function requestToReadyS(arg1:Boolean):void
        {
            App.utils.asserter.assertNotNull(this.requestToReady, "requestToReady" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestToReady(arg1);
            return;
        }

        public function requestToLeaveS():void
        {
            App.utils.asserter.assertNotNull(this.requestToLeave, "requestToLeave" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestToLeave();
            return;
        }

        public function showPrebattleSendInvitesWindowS():void
        {
            App.utils.asserter.assertNotNull(this.showPrebattleSendInvitesWindow, "showPrebattleSendInvitesWindow" + net.wg.data.constants.Errors.CANT_NULL);
            this.showPrebattleSendInvitesWindow();
            return;
        }

        public function showFAQWindowS():void
        {
            App.utils.asserter.assertNotNull(this.showFAQWindow, "showFAQWindow" + net.wg.data.constants.Errors.CANT_NULL);
            this.showFAQWindow();
            return;
        }

        public function canSendInviteS():Boolean
        {
            App.utils.asserter.assertNotNull(this.canSendInvite, "canSendInvite" + net.wg.data.constants.Errors.CANT_NULL);
            return this.canSendInvite();
        }

        public function canKickPlayerS():Boolean
        {
            App.utils.asserter.assertNotNull(this.canKickPlayer, "canKickPlayer" + net.wg.data.constants.Errors.CANT_NULL);
            return this.canKickPlayer();
        }

        public function isPlayerReadyS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isPlayerReady, "isPlayerReady" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isPlayerReady();
        }

        public function isPlayerCreatorS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isPlayerCreator, "isPlayerCreator" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isPlayerCreator();
        }

        public function isReadyBtnEnabledS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isReadyBtnEnabled, "isReadyBtnEnabled" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isReadyBtnEnabled();
        }

        public function isLeaveBtnEnabledS():Boolean
        {
            App.utils.asserter.assertNotNull(this.isLeaveBtnEnabled, "isLeaveBtnEnabled" + net.wg.data.constants.Errors.CANT_NULL);
            return this.isLeaveBtnEnabled();
        }

        public function getClientIDS():Number
        {
            App.utils.asserter.assertNotNull(this.getClientID, "getClientID" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getClientID();
        }

        public var requestToReady:Function=null;

        public var requestToLeave:Function=null;

        public var showPrebattleSendInvitesWindow:Function=null;

        public var showFAQWindow:Function=null;

        public var canSendInvite:Function=null;

        public var canKickPlayer:Function=null;

        public var isPlayerReady:Function=null;

        public var isPlayerCreator:Function=null;

        public var isReadyBtnEnabled:Function=null;

        public var isLeaveBtnEnabled:Function=null;

        public var getClientID:Function=null;
    }
}
