package net.wg.infrastructure.managers.utils.impl
{
    import net.wg.infrastructure.base.meta.impl.TweenManagerMeta;
    import net.wg.utils.ITweenManager;
    import net.wg.infrastructure.interfaces.ITween;
    import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
    import net.wg.utils.IClassFactory;
    import net.wg.data.constants.Linkages;
    
    public class TweenManager extends TweenManagerMeta implements ITweenManager
    {
        
        public function TweenManager() {
            super();
        }
        
        public function createNewTween(param1:ITweenPropertiesVO) : ITween {
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
    }
}
