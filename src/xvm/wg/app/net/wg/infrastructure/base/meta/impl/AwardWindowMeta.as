package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    import net.wg.data.VO.AwardWindowVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class AwardWindowMeta extends AbstractWindowView
    {
        
        public function AwardWindowMeta()
        {
            super();
        }
        
        public var onOKClick:Function = null;
        
        public function onOKClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onOKClick,"onOKClick" + Errors.CANT_NULL);
            this.onOKClick();
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:AwardWindowVO = new AwardWindowVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:AwardWindowVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
