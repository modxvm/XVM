package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    import net.wg.data.VO.RefSysReferralsIntroVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class ReferralReferralsIntroWindowMeta extends AbstractWindowView
    {
        
        public function ReferralReferralsIntroWindowMeta()
        {
            super();
        }
        
        public var onClickApplyBtn:Function = null;
        
        public function onClickApplyBtnS() : void
        {
            App.utils.asserter.assertNotNull(this.onClickApplyBtn,"onClickApplyBtn" + Errors.CANT_NULL);
            this.onClickApplyBtn();
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:RefSysReferralsIntroVO = new RefSysReferralsIntroVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:RefSysReferralsIntroVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
