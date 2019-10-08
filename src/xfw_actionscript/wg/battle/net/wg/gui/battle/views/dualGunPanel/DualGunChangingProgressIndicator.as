package net.wg.gui.battle.views.dualGunPanel
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class DualGunChangingProgressIndicator extends MovieClip implements IDisposable
    {

        private static const GUN_CHANGING_IDLE_LABEL:String = "idle";

        private static const GUN_CHANGING_PROCESS_LABEL:String = "reloading";

        private static const GUN_CHANGING_READY_LABEL:String = "onReady";

        private static const TRIGGER_VALUE_DECREASE:int = 0;

        private static const TRIGGER_VALUE_INCREASE:int = 1;

        private static const START_ANGLE:int = -90;

        private static const END_ANGLE:int = 0;

        private static const START_ANIMATION_DURATION:int = 160;

        private static const END_ANIMATION_DURATION:int = 60;

        public var _previousValue:Number = 1.7976931348623157E308;

        public var content:MovieClip;

        private var _isActive:Boolean;

        public function DualGunChangingProgressIndicator()
        {
            super();
        }

        private static function clamp(param1:Number, param2:Number, param3:Number) : Number
        {
            return param1 < param2?param2:param1 > param3?param3:param1;
        }

        public final function dispose() : void
        {
            this.content = null;
        }

        public function setActive(param1:Boolean) : void
        {
            this._isActive = param1;
            this.visible = param1;
            if(!param1)
            {
                this.content.gotoAndStop(GUN_CHANGING_IDLE_LABEL);
            }
        }

        public function updateProgress(param1:Number, param2:Number) : void
        {
            if(!this._isActive)
            {
                return;
            }
            if(this.checkStateChanged(param1,param2,TRIGGER_VALUE_INCREASE))
            {
                this.content.gotoAndPlay(GUN_CHANGING_IDLE_LABEL);
                this.content.rotation = START_ANGLE;
            }
            else
            {
                if(this.checkStateChanged(param1,END_ANIMATION_DURATION,TRIGGER_VALUE_DECREASE))
                {
                    this.content.gotoAndPlay(GUN_CHANGING_READY_LABEL);
                }
                else if(this.checkStateChanged(param1,param2,TRIGGER_VALUE_DECREASE))
                {
                    this.content.gotoAndPlay(GUN_CHANGING_PROCESS_LABEL);
                }
                this.updateRotation(param1,param2);
            }
            this._previousValue = param1;
        }

        private function updateRotation(param1:Number, param2:Number) : void
        {
            var _loc3_:* = NaN;
            var _loc4_:* = NaN;
            _loc3_ = param2 - START_ANIMATION_DURATION - END_ANIMATION_DURATION;
            _loc4_ = param2 - param1 - START_ANIMATION_DURATION;
            var _loc5_:Number = clamp(_loc4_ / _loc3_,0,1);
            this.content.rotation = START_ANGLE + _loc5_ * (END_ANGLE - START_ANGLE);
        }

        private function checkStateChanged(param1:Number, param2:Number, param3:int) : Boolean
        {
            if(param3 == TRIGGER_VALUE_INCREASE)
            {
                return this._previousValue < param2 && param1 >= param2;
            }
            return this._previousValue > param2 && param1 <= param2;
        }
    }
}
