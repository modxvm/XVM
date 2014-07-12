package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class LobbyMessengerMeta extends AbstractWindowView
    {
        
        public function LobbyMessengerMeta() {
            super();
        }
        
        public var requestOnRefreshMemberList:Function = null;
        
        public function requestOnRefreshMemberListS() : void {
            App.utils.asserter.assertNotNull(this.requestOnRefreshMemberList,"requestOnRefreshMemberList" + Errors.CANT_NULL);
            this.requestOnRefreshMemberList();
        }
        
        public var requestRolePlayer:Function = null;
        
        public function requestRolePlayerS() : void {
            App.utils.asserter.assertNotNull(this.requestRolePlayer,"requestRolePlayer" + Errors.CANT_NULL);
            this.requestRolePlayer();
        }
        
        public var requestToReadyBtn:Function = null;
        
        public function requestToReadyBtnS(param1:Boolean) : void {
            App.utils.asserter.assertNotNull(this.requestToReadyBtn,"requestToReadyBtn" + Errors.CANT_NULL);
            this.requestToReadyBtn(param1);
        }
        
        public var requestToLeaveBtn:Function = null;
        
        public function requestToLeaveBtnS() : void {
            App.utils.asserter.assertNotNull(this.requestToLeaveBtn,"requestToLeaveBtn" + Errors.CANT_NULL);
            this.requestToLeaveBtn();
        }
        
        public var showPrebattleSendInvitesWindow:Function = null;
        
        public function showPrebattleSendInvitesWindowS() : void {
            App.utils.asserter.assertNotNull(this.showPrebattleSendInvitesWindow,"showPrebattleSendInvitesWindow" + Errors.CANT_NULL);
            this.showPrebattleSendInvitesWindow();
        }
    }
}
