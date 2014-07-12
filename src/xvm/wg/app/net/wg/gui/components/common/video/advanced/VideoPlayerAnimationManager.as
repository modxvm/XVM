package net.wg.gui.components.common.video.advanced
{
    import net.wg.gui.utils.ExcludeTweenManager;
    import fl.transitions.easing.Strong;
    import scaleform.clik.motion.Tween;
    
    public class VideoPlayerAnimationManager extends Object
    {
        
        public function VideoPlayerAnimationManager(param1:AdvancedVideoPlayer) {
            this.tweenManager = new ExcludeTweenManager();
            super();
            this.advancedVideoPlayer = param1;
        }
        
        private static var animationTweenObect:Object;
        
        private static var showAlphaFinalValue:Number = 1;
        
        private static var hideAlphaFinalValue:Number = 0;
        
        private var advancedVideoPlayer:AdvancedVideoPlayer;
        
        private var tweenManager:ExcludeTweenManager;
        
        public function show(param1:Number) : void {
            this.tweenManager.unregisterAll();
            this.applyAnimation(param1,showAlphaFinalValue,this.getShowAnimTweenSet);
        }
        
        public function hide(param1:Number) : void {
            this.tweenManager.unregisterAll();
            this.applyAnimation(param1,hideAlphaFinalValue,this.getHideAnimTweenSet);
        }
        
        private function applyAnimation(param1:Number, param2:Number, param3:Function) : void {
            var _loc5_:VideoPlayerControlBar = null;
            var _loc6_:AbstractPlayerProgressBar = null;
            var _loc7_:* = false;
            var _loc4_:VideoPlayerTitleBar = this.advancedVideoPlayer.titleBar;
            _loc5_ = this.advancedVideoPlayer.controlBar;
            _loc6_ = this.advancedVideoPlayer.progressBar;
            if(param1 > 0)
            {
                animationTweenObect.alpha = param2;
                _loc7_ = true;
                this.tweenManager.registerAndLaunch(param1,_loc4_,animationTweenObect,param3());
                this.tweenManager.registerAndLaunch(param1,_loc5_,animationTweenObect,param3());
                if(_loc6_)
                {
                    this.tweenManager.registerAndLaunch(param1,_loc6_,animationTweenObect,param3());
                }
            }
            else
            {
                _loc7_ = param2 > 0;
                _loc4_.alpha = param2;
                _loc5_.alpha = param2;
                if(_loc6_)
                {
                    _loc6_.alpha = param2;
                }
            }
            _loc4_.visible = _loc7_;
            _loc5_.visible = _loc7_;
            if(_loc6_)
            {
                _loc6_.visible = _loc7_;
            }
        }
        
        private function getShowAnimTweenSet() : Object {
            return {
                "ease":Strong.easeOut,
                "onComplete":this.onShowTweenComplete
            };
    }
    
    private function getHideAnimTweenSet() : Object {
        return {
            "ease":Strong.easeOut,
            "onComplete":this.onHideTweenComplete
        };
}

private function onHideTweenComplete(param1:Tween) : void {
    param1.target.visible = false;
    this.tweenManager.unregister(param1);
}

private function onShowTweenComplete(param1:Tween) : void {
    this.tweenManager.unregister(param1);
}

public function dispose() : void {
    this.advancedVideoPlayer = null;
    if(this.tweenManager)
    {
        this.tweenManager.dispose();
        this.tweenManager = null;
    }
}
}
}
