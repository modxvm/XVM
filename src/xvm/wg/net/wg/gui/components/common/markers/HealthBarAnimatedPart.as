package net.wg.gui.components.common.markers 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.events.*;
    import scaleform.clik.core.*;
    
    public class HealthBarAnimatedPart extends scaleform.clik.core.UIComponent
    {
        public function HealthBarAnimatedPart()
        {
            super();
            stop();
            visible = false;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            addEventListener(net.wg.gui.events.TimelineEvent.TWEEN_COMPLETE, this.onTimelineTweenComplete);
            return;
        }

        public function playShowTween():void
        {
            var loc1:*=this.tweenState;
            var loc2:*=this.tweenState;
            switch (loc2) 
            {
                case INACTIVE_STATE:
                {
                    visible = true;
                    this.tweenState = SHOW_STATE;
                    break;
                }
                case ACTIVE_STATE:
                {
                    this.onTweenComplete(true);
                    break;
                }
                case HIDE_STATE:
                {
                    this.tweenState = SHOW_STATE;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (loc1 != this.tweenState) 
            {
                this.setState();
            }
            return;
        }

        protected function setState():void
        {
            gotoAndPlay(this.tweenState);
            return;
        }

        internal function onTimelineTweenComplete(arg1:net.wg.gui.events.TimelineEvent):void
        {
            this.onTweenComplete(arg1.isShow);
            return;
        }

        public function onTweenComplete(arg1:Boolean):void
        {
            if (arg1) 
            {
                this.tweenState = ACTIVE_STATE;
                App.utils.scheduler.scheduleTask(this.playHideTween, SPLASH_DURATION);
                dispatchEvent(new flash.events.Event(SHOW));
            }
            else 
            {
                this.tweenState = INACTIVE_STATE;
                visible = false;
                dispatchEvent(new flash.events.Event(HIDE));
            }
            return;
        }

        public function playHideTween():void
        {
            this.tweenState = HIDE_STATE;
            gotoAndPlay(this.tweenState);
            return;
        }

        public function setAnimationType(arg1:String):void
        {
            if (this.animate_mc) 
            {
                this.animate_mc.gotoAndStop(arg1);
            }
            return;
        }

        public static const SHOW:String="show";

        public static const HIDE:String="hide";

        public static const SPLASH_DURATION:Number=1000;

        public static const SHOW_STATE:String="show";

        public static const ACTIVE_STATE:String="active";

        public static const HIDE_STATE:String="hide";

        public static const INACTIVE_STATE:String="inactive";

        public static const IMITATION_STATE:String="imitationDamage";

        protected var tweenState:String="inactive";

        public var animate_mc:flash.display.MovieClip;
    }
}
