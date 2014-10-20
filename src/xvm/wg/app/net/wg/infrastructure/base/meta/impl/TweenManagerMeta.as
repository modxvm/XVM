package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.infrastructure.interfaces.ITween;
    import net.wg.data.constants.Errors;
    import net.wg.data.TweenConstraintsVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class TweenManagerMeta extends BaseDAAPIComponent
    {
        
        public function TweenManagerMeta()
        {
            super();
        }
        
        public var createTween:Function = null;
        
        public var disposeTween:Function = null;
        
        public var disposeAll:Function = null;
        
        public function createTweenS(param1:ITween) : void
        {
            App.utils.asserter.assertNotNull(this.createTween,"createTween" + Errors.CANT_NULL);
            this.createTween(param1);
        }
        
        public function disposeTweenS(param1:ITween) : void
        {
            App.utils.asserter.assertNotNull(this.disposeTween,"disposeTween" + Errors.CANT_NULL);
            this.disposeTween(param1);
        }
        
        public function disposeAllS() : void
        {
            App.utils.asserter.assertNotNull(this.disposeAll,"disposeAll" + Errors.CANT_NULL);
            this.disposeAll();
        }
        
        public function as_setDataFromXml(param1:Object) : void
        {
            var _loc2_:TweenConstraintsVO = new TweenConstraintsVO(param1);
            this.setDataFromXml(_loc2_);
        }
        
        protected function setDataFromXml(param1:TweenConstraintsVO) : void
        {
            var _loc2_:String = "as_setDataFromXml" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
