package net.wg.infrastructure.managers.utils.impl
{
    import net.wg.infrastructure.base.meta.impl.TweenManagerMeta;
    import net.wg.utils.ITweenManager;
    import net.wg.infrastructure.base.meta.ITweenManagerMeta;
    import net.wg.infrastructure.managers.ITweenManagerHelper;
    import net.wg.infrastructure.interfaces.ITween;
    import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
    import net.wg.utils.IClassFactory;
    import net.wg.data.constants.Linkages;
    import net.wg.data.TweenConstraintsVO;
    
    public class TweenManager extends TweenManagerMeta implements ITweenManager, ITweenManagerMeta
    {
        
        public function TweenManager()
        {
            super();
        }
        
        private var tweenMgrHelper:ITweenManagerHelper;
        
        public function createNewTween(param1:ITweenPropertiesVO) : ITween
        {
            var _loc2_:Class = null;
            var _loc3_:IClassFactory = App.utils.classFactory;
            if(param1.getIsOnCodeBased())
            {
                _loc2_ = _loc3_.getClass(Linkages.PYTHON_TWEEN);
            }
            else
            {
                _loc2_ = _loc3_.getClass(Linkages.FLASH_TWEEN);
            }
            var _loc4_:ITween = new _loc2_(param1);
            createTweenS(_loc4_);
            return _loc4_;
        }
        
        public function getTweenManagerHelper() : ITweenManagerHelper
        {
            var _loc1_:* = "tweenManagerHelper is not created.  TweenManager.as_setDataFromXml wasn\'t called " + "or TweenManager was already  disposed";
            App.utils.asserter.assertNotNull(this.tweenMgrHelper,_loc1_);
            return this.tweenMgrHelper;
        }
        
        override protected function setDataFromXml(param1:TweenConstraintsVO) : void
        {
            this.tweenMgrHelper = new TweenManagerHelper(param1);
        }
        
        override protected function onDispose() : void
        {
            if(this.tweenMgrHelper != null)
            {
                this.tweenMgrHelper.dispose();
            }
            this.tweenMgrHelper = null;
            super.onDispose();
        }
    }
}
