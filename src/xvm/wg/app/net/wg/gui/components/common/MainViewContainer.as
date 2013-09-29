package net.wg.gui.components.common 
{
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.motion.*;
    
    public class MainViewContainer extends net.wg.gui.components.common.ManagedContainer
    {
        public function MainViewContainer()
        {
            super();
            return;
        }

        public override function addChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject
        {
            var loc1:*=null;
            arg1 = super.addChild(arg1);
            if (_modalBg) 
            {
                setChildIndex(arg1, getChildIndex(_modalBg));
                loc1 = new scaleform.clik.motion.Tween(ANIMATION_DURATION, _modalBg, {"alpha":0}, {"paused":false, "onComplete":this.onModalTweenEnd});
            }
            return arg1;
        }

        public override function removeChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject
        {
            arg1 = super.removeChild(arg1);
            this.createModalBg();
            return arg1;
        }

        public override function getTopmostView():flash.display.DisplayObject
        {
            var loc2:*=0;
            var loc3:*=null;
            var loc1:*=null;
            loc2 = (numChildren - 1);
            while (loc2 >= 0) 
            {
                loc3 = getChildAt(loc2);
                if (loc3 is net.wg.infrastructure.interfaces.IView) 
                {
                    loc1 = loc3;
                    break;
                }
                --loc2;
            }
            return loc1;
        }

        protected override function createModalBg():void
        {
            if (_modalBg == null) 
            {
                _modalBg = flash.display.MovieClip(App.utils.classFactory.getObject(net.wg.data.constants.Linkages.VIEW_LOAD_CURTAIN));
                if (_modalBg == null) 
                {
                    DebugUtils.LOG_DEBUG("Error until getting ");
                    return;
                }
            }
            _modalBg.width = App.appWidth;
            _modalBg.height = App.appHeight;
            addChildAt(_modalBg, numChildren > 0 ? (numChildren - 1) : 0);
            return;
        }

        internal function onModalTweenEnd(arg1:scaleform.clik.motion.Tween=null):void
        {
            super.superRemoveChild(_modalBg);
            _modalBg = null;
            return;
        }

        internal static const ANIMATION_DURATION:int=500;
    }
}
