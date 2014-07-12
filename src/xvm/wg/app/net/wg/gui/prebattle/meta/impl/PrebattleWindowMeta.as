package net.wg.gui.prebattle.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class PrebattleWindowMeta extends AbstractWindowView
    {
        
        public function PrebattleWindowMeta() {
            super();
        }
        
        public var requestToReady:Function = null;
        
        public var requestToLeave:Function = null;
        
        public var showPrebattleSendInvitesWindow:Function = null;
        
        public var showFAQWindow:Function = null;
        
        public var canSendInvite:Function = null;
        
        public var canKickPlayer:Function = null;
        
        public var isPlayerReady:Function = null;
        
        public var isPlayerCreator:Function = null;
        
        public var isReadyBtnEnabled:Function = null;
        
        public var isLeaveBtnEnabled:Function = null;
        
        public var getClientID:Function = null;
        
        public function requestToReadyS(param1:Boolean) : void {
            App.utils.asserter.assertNotNull(this.requestToReady,"requestToReady" + Errors.CANT_NULL);
            this.requestToReady(param1);
        }
        
        public function requestToLeaveS() : void {
            App.utils.asserter.assertNotNull(this.requestToLeave,"requestToLeave" + Errors.CANT_NULL);
            this.requestToLeave();
        }
        
        public function showPrebattleSendInvitesWindowS() : void {
            App.utils.asserter.assertNotNull(this.showPrebattleSendInvitesWindow,"showPrebattleSendInvitesWindow" + Errors.CANT_NULL);
            this.showPrebattleSendInvitesWindow();
        }
        
        public function showFAQWindowS() : void {
            App.utils.asserter.assertNotNull(this.showFAQWindow,"showFAQWindow" + Errors.CANT_NULL);
            this.showFAQWindow();
        }
        
        public function canSendInviteS() : Boolean {
            App.utils.asserter.assertNotNull(this.canSendInvite,"canSendInvite" + Errors.CANT_NULL);
            return this.canSendInvite();
        }
        
        public function canKickPlayerS() : Boolean {
            App.utils.asserter.assertNotNull(this.canKickPlayer,"canKickPlayer" + Errors.CANT_NULL);
            return this.canKickPlayer();
        }
        
        public function isPlayerReadyS() : Boolean {
            App.utils.asserter.assertNotNull(this.isPlayerReady,"isPlayerReady" + Errors.CANT_NULL);
            return this.isPlayerReady();
        }
        
        public function isPlayerCreatorS() : Boolean {
            App.utils.asserter.assertNotNull(this.isPlayerCreator,"isPlayerCreator" + Errors.CANT_NULL);
            return this.isPlayerCreator();
        }
        
        public function isReadyBtnEnabledS() : Boolean {
            App.utils.asserter.assertNotNull(this.isReadyBtnEnabled,"isReadyBtnEnabled" + Errors.CANT_NULL);
            return this.isReadyBtnEnabled();
        }
        
        public function isLeaveBtnEnabledS() : Boolean {
            App.utils.asserter.assertNotNull(this.isLeaveBtnEnabled,"isLeaveBtnEnabled" + Errors.CANT_NULL);
            return this.isLeaveBtnEnabled();
        }
        
        public function getClientIDS() : Number {
            App.utils.asserter.assertNotNull(this.getClientID,"getClientID" + Errors.CANT_NULL);
            return this.getClientID();
        }
    }
}
