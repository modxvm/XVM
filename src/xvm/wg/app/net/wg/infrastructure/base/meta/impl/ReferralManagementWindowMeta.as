package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.window.RefManagementWindowVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.gui.lobby.referralSystem.data.ComplexProgressIndicatorVO;
    
    public class ReferralManagementWindowMeta extends AbstractWindowView
    {
        
        public function ReferralManagementWindowMeta()
        {
            super();
        }
        
        public var onInvitesManagementLinkClick:Function = null;
        
        public var inviteIntoSquad:Function = null;
        
        public function onInvitesManagementLinkClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onInvitesManagementLinkClick,"onInvitesManagementLinkClick" + Errors.CANT_NULL);
            this.onInvitesManagementLinkClick();
        }
        
        public function inviteIntoSquadS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.inviteIntoSquad,"inviteIntoSquad" + Errors.CANT_NULL);
            this.inviteIntoSquad(param1);
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:RefManagementWindowVO = new RefManagementWindowVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:RefManagementWindowVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
        
        public function as_setProgressData(param1:Object) : void
        {
            var _loc2_:ComplexProgressIndicatorVO = new ComplexProgressIndicatorVO(param1);
            this.setProgressData(_loc2_);
        }
        
        protected function setProgressData(param1:ComplexProgressIndicatorVO) : void
        {
            var _loc2_:String = "as_setProgressData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
