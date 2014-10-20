package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.SmartPopOverView;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.header.vo.AccountPopoverReferralBlockVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class AccountPopoverMeta extends SmartPopOverView
    {
        
        public function AccountPopoverMeta()
        {
            super();
        }
        
        public var openProfile:Function = null;
        
        public var openClanStatistic:Function = null;
        
        public var openCrewStatistic:Function = null;
        
        public var openReferralManagement:Function = null;
        
        public function openProfileS() : void
        {
            App.utils.asserter.assertNotNull(this.openProfile,"openProfile" + Errors.CANT_NULL);
            this.openProfile();
        }
        
        public function openClanStatisticS() : void
        {
            App.utils.asserter.assertNotNull(this.openClanStatistic,"openClanStatistic" + Errors.CANT_NULL);
            this.openClanStatistic();
        }
        
        public function openCrewStatisticS() : void
        {
            App.utils.asserter.assertNotNull(this.openCrewStatistic,"openCrewStatistic" + Errors.CANT_NULL);
            this.openCrewStatistic();
        }
        
        public function openReferralManagementS() : void
        {
            App.utils.asserter.assertNotNull(this.openReferralManagement,"openReferralManagement" + Errors.CANT_NULL);
            this.openReferralManagement();
        }
        
        public function as_setReferralData(param1:Object) : void
        {
            var _loc2_:AccountPopoverReferralBlockVO = new AccountPopoverReferralBlockVO(param1);
            this.setReferralData(_loc2_);
        }
        
        protected function setReferralData(param1:AccountPopoverReferralBlockVO) : void
        {
            var _loc2_:String = "as_setReferralData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
