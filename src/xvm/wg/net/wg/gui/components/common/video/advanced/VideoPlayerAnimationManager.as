package net.wg.gui.components.common.video.advanced 
{
    import fl.transitions.easing.*;
    import net.wg.gui.utils.*;
    import scaleform.clik.motion.*;
    
    public class VideoPlayerAnimationManager extends Object
    {
        public function VideoPlayerAnimationManager(arg1:net.wg.gui.components.common.video.advanced.AdvancedVideoPlayer)
        {
            this.tweenManager = new net.wg.gui.utils.ExcludeTweenManager();
            super();
            this.advancedVideoPlayer = arg1;
            return;
        }

        public function show(arg1:Number):void
        {
            this.tweenManager.unregisterAll();
            this.applyAnimation(arg1, showAlphaFinalValue, this.getShowAnimTweenSet);
            return;
        }

        public function hide(arg1:Number):void
        {
            this.tweenManager.unregisterAll();
            this.applyAnimation(arg1, hideAlphaFinalValue, this.getHideAnimTweenSet);
            return;
        }

        internal function applyAnimation(arg1:Number, arg2:Number, arg3:Function):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=false;
            var loc1:*=this.advancedVideoPlayer.titleBar;
            loc2 = this.advancedVideoPlayer.controlBar;
            loc3 = this.advancedVideoPlayer.progressBar;
            if (arg1 > 0) 
            {
                animationTweenObect.alpha = arg2;
                loc4 = true;
                this.tweenManager.registerAndLaunch(arg1, loc1, animationTweenObect, arg3());
                this.tweenManager.registerAndLaunch(arg1, loc2, animationTweenObect, arg3());
                if (loc3) 
                    this.tweenManager.registerAndLaunch(arg1, loc3, animationTweenObect, arg3());
            }
            else 
            {
                loc4 = arg2 > 0;
                loc1.alpha = arg2;
                loc2.alpha = arg2;
                if (loc3) 
                    loc3.alpha = arg2;
            }
            loc1.visible = loc4;
            loc2.visible = loc4;
            if (loc3) 
                loc3.visible = loc4;
            return;
        }

        internal function getShowAnimTweenSet():Object
        {
            return {"ease":fl.transitions.easing.Strong.easeOut, "onComplete":this.onShowTweenComplete};
        }

        internal function getHideAnimTweenSet():Object
        {
            return {"ease":fl.transitions.easing.Strong.easeOut, "onComplete":this.onHideTweenComplete};
        }

        internal function onHideTweenComplete(arg1:scaleform.clik.motion.Tween):void
        {
            this.tweenManager.unregister(arg1);
            arg1.target.visible = false;
            return;
        }

        internal function onShowTweenComplete(arg1:scaleform.clik.motion.Tween):void
        {
            this.tweenManager.unregister(arg1);
            return;
        }

        public function dispose():void
        {
            this.advancedVideoPlayer = null;
            if (this.tweenManager) 
            {
                this.tweenManager.dispose();
                this.tweenManager = null;
            }
            return;
        }

        internal static const animationTweenObect:Object={"alpha":1};

        internal static const showAlphaFinalValue:Number=1;

        internal static const hideAlphaFinalValue:Number=0;

        internal var advancedVideoPlayer:net.wg.gui.components.common.video.advanced.AdvancedVideoPlayer;

        internal var tweenManager:net.wg.gui.utils.ExcludeTweenManager;
    }
}
