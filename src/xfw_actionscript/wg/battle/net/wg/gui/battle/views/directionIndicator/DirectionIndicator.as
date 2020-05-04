package net.wg.gui.battle.views.directionIndicator
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.IRootAppMainContent;
    import flash.display.MovieClip;
    import scaleform.clik.motion.Tween;

    public class DirectionIndicator extends Sprite implements IRootAppMainContent
    {

        public var indicator:DirectionIndicatorImage = null;

        public var distance:BaseValueIndicator = null;

        public var eventIcon:MovieClip = null;

        protected var shape:String = null;

        private var _hideTween:Tween = null;

        private var _inTween:Tween = null;

        private var _tweenTime:int = 0;

        public function DirectionIndicator()
        {
            super();
        }

        public function setBlinking(param1:Boolean, param2:int = 0) : void
        {
            if(param1)
            {
                this._tweenTime = param2 >> 1;
                if(!this._inTween)
                {
                    this._hideTween = new Tween(this._tweenTime,this,{"alpha":0},{"onComplete":this.onFadeOutTweenComplete});
                    this._hideTween.fastTransform = false;
                    this._hideTween.paused = true;
                    this._inTween = new Tween(this._tweenTime,this,{"alpha":1},{"onComplete":this.onFadeInTweenComplete});
                    this._inTween.fastTransform = false;
                    this._inTween.paused = true;
                }
                else
                {
                    this._hideTween.duration = this._tweenTime;
                    this._inTween.duration = this._tweenTime;
                }
                this.onFadeInTweenComplete();
            }
            else
            {
                if(this._inTween)
                {
                    this._inTween.paused = true;
                    this._hideTween.paused = true;
                }
                this.alpha = 1;
            }
        }

        private function onFadeInTweenComplete() : void
        {
            this._inTween.paused = true;
            this._hideTween.position = 0;
            this._hideTween.paused = false;
        }

        private function onFadeOutTweenComplete() : void
        {
            this._hideTween.paused = true;
            this._inTween.position = 0;
            this._inTween.paused = false;
        }

        public function setShape(param1:String) : void
        {
            if(!param1 || param1 == this.shape)
            {
                return;
            }
            this.indicator.setShape(param1);
            this.distance.setShape(param1);
            this.shape = param1;
            if(this.eventIcon != null)
            {
                this.eventIcon.visible = param1 == DirectionIndicatorShape.SHAPE_EVENT_KILL || param1 == DirectionIndicatorShape.SHAPE_EVENT_CAPTUREA || param1 == DirectionIndicatorShape.SHAPE_EVENT_CAPTUREB || param1 == DirectionIndicatorShape.SHAPE_EVENT_CAPTUREC || param1 == DirectionIndicatorShape.SHAPE_EVENT_CAPTUREBASE || param1 == DirectionIndicatorShape.SHAPE_EVENT_OURBASE || param1 == DirectionIndicatorShape.SHAPE_EVENT_ATTACK || param1 == DirectionIndicatorShape.SHAPE_EVENT_ATTACK_RED || param1 == DirectionIndicatorShape.SHAPE_EVENT_ATTACK_RECTANGLE;
                this.eventIcon.gotoAndStop(param1);
            }
        }

        public function setDistance(param1:String) : void
        {
            this.distance.setValue(param1);
        }

        public final function dispose() : void
        {
            if(this._inTween)
            {
                this._inTween.paused = true;
                this._inTween.dispose();
                this._inTween = null;
            }
            if(this._hideTween)
            {
                this._hideTween.paused = true;
                this._hideTween.dispose();
                this._hideTween = null;
            }
            this.indicator.dispose();
            this.distance.dispose();
            this.indicator = null;
            this.distance = null;
            this.eventIcon = null;
        }
    }
}
