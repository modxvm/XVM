package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.SmartPopOverView;
    import net.wg.gui.lobby.header.vo.AccountPopoverMainVO;
    import net.wg.gui.lobby.header.vo.AccountClanPopoverBlockVO;
    import net.wg.gui.lobby.header.vo.AccountPopoverReferralBlockVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class AccountPopoverMeta extends SmartPopOverView
    {

        public var openBoostersWindow:Function;

        public var openClanResearch:Function;

        public var openRequestWindow:Function;

        public var openInviteWindow:Function;

        public var openClanStatistic:Function;

        public var openReferralManagement:Function;

        public var openBadgesWindow:Function;

        private var _accountPopoverMainVO:AccountPopoverMainVO;

        private var _accountClanPopoverBlockVO:AccountClanPopoverBlockVO;

        private var _accountPopoverReferralBlockVO:AccountPopoverReferralBlockVO;

        public function AccountPopoverMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._accountPopoverMainVO)
            {
                this._accountPopoverMainVO.dispose();
                this._accountPopoverMainVO = null;
            }
            if(this._accountClanPopoverBlockVO)
            {
                this._accountClanPopoverBlockVO.dispose();
                this._accountClanPopoverBlockVO = null;
            }
            if(this._accountPopoverReferralBlockVO)
            {
                this._accountPopoverReferralBlockVO.dispose();
                this._accountPopoverReferralBlockVO = null;
            }
            super.onDispose();
        }

        public function openBoostersWindowS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.openBoostersWindow,"openBoostersWindow" + Errors.CANT_NULL);
            this.openBoostersWindow(param1);
        }

        public function openClanResearchS() : void
        {
            App.utils.asserter.assertNotNull(this.openClanResearch,"openClanResearch" + Errors.CANT_NULL);
            this.openClanResearch();
        }

        public function openRequestWindowS() : void
        {
            App.utils.asserter.assertNotNull(this.openRequestWindow,"openRequestWindow" + Errors.CANT_NULL);
            this.openRequestWindow();
        }

        public function openInviteWindowS() : void
        {
            App.utils.asserter.assertNotNull(this.openInviteWindow,"openInviteWindow" + Errors.CANT_NULL);
            this.openInviteWindow();
        }

        public function openClanStatisticS() : void
        {
            App.utils.asserter.assertNotNull(this.openClanStatistic,"openClanStatistic" + Errors.CANT_NULL);
            this.openClanStatistic();
        }

        public function openReferralManagementS() : void
        {
            App.utils.asserter.assertNotNull(this.openReferralManagement,"openReferralManagement" + Errors.CANT_NULL);
            this.openReferralManagement();
        }

        public function openBadgesWindowS() : void
        {
            App.utils.asserter.assertNotNull(this.openBadgesWindow,"openBadgesWindow" + Errors.CANT_NULL);
            this.openBadgesWindow();
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:AccountPopoverMainVO = this._accountPopoverMainVO;
            this._accountPopoverMainVO = new AccountPopoverMainVO(param1);
            this.setData(this._accountPopoverMainVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setClanData(param1:Object) : void
        {
            var _loc2_:AccountClanPopoverBlockVO = this._accountClanPopoverBlockVO;
            this._accountClanPopoverBlockVO = new AccountClanPopoverBlockVO(param1);
            this.setClanData(this._accountClanPopoverBlockVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setReferralData(param1:Object) : void
        {
            var _loc2_:AccountPopoverReferralBlockVO = this._accountPopoverReferralBlockVO;
            this._accountPopoverReferralBlockVO = new AccountPopoverReferralBlockVO(param1);
            this.setReferralData(this._accountPopoverReferralBlockVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:AccountPopoverMainVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setClanData(param1:AccountClanPopoverBlockVO) : void
        {
            var _loc2_:String = "as_setClanData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setReferralData(param1:AccountPopoverReferralBlockVO) : void
        {
            var _loc2_:String = "as_setReferralData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
