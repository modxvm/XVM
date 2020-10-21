package net.wg.gui.battle.components
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.MovieClip;
    import net.wg.gui.battle.components.interfaces.ICoolDownCompleteHandler;
    import net.wg.utils.IScheduler;
    import net.wg.data.constants.Time;

    public class CoolDownTimer extends Object implements IDisposable
    {

        private var _reversed:Boolean = false;

        private var _isReverse:Boolean = false;

        private var _totalFrames:uint;

        private var _currentFrame:uint;

        private var _progressValues:Vector.<int> = null;

        private var _context:MovieClip = null;

        private var _coolDownHandler:ICoolDownCompleteHandler = null;

        private var _scheduler:IScheduler;

        public function CoolDownTimer(param1:MovieClip)
        {
            this._scheduler = App.utils.scheduler;
            super();
            this._context = param1;
        }

        public final function dispose() : void
        {
            this._scheduler.cancelTask(this.run);
            this._scheduler = null;
            this._context.stop();
            this._context = null;
            this._progressValues = null;
            this._coolDownHandler = null;
        }

        public function end() : void
        {
            this._scheduler.cancelTask(this.run);
        }

        public function moveToFrame(param1:int) : void
        {
            this._context.gotoAndStop(this._progressValues[this._isReverse?this._totalFrames - param1:param1]);
        }

        public function restartFromCurrentFrame(param1:Number) : void
        {
            var _loc3_:* = NaN;
            this.end();
            var _loc2_:int = (this._reversed?this._currentFrame:this._totalFrames - this._currentFrame) + 1;
            if(_loc2_ > 0)
            {
                _loc3_ = param1 * Time.MILLISECOND_IN_SECOND / _loc2_;
                this._scheduler.scheduleRepeatableTask(this.run,_loc3_,int.MAX_VALUE);
            }
            this.run();
        }

        public function setFrames(param1:Number, param2:Number) : void
        {
            this._totalFrames = param2 - param1;
            this._progressValues = new Vector.<int>(this._totalFrames + 1,true);
            var _loc3_:uint = 0;
            while(_loc3_ <= this._totalFrames)
            {
                this._progressValues[_loc3_] = param1 + _loc3_;
                _loc3_++;
            }
        }

        public function setPositionAsPercent(param1:Number) : void
        {
            this.end();
            this._currentFrame = Math.floor(this._progressValues.length * 0.01 * param1);
            this.moveToFrame(this._currentFrame);
        }

        public function start(param1:Number, param2:ICoolDownCompleteHandler, param3:int, param4:Number, param5:Boolean = false, param6:Boolean = false) : void
        {
            var _loc8_:* = NaN;
            this.end();
            this._reversed = param5;
            if(param6)
            {
                this._currentFrame = this._reversed?this._totalFrames:0;
            }
            else
            {
                this._currentFrame = param3;
            }
            this._coolDownHandler = param2;
            var _loc7_:int = (this._reversed?this._currentFrame:this._totalFrames - this._currentFrame) + 1;
            if(_loc7_ > 0)
            {
                _loc8_ = param1 * Time.MILLISECOND_IN_SECOND / _loc7_ / param4;
                this._scheduler.scheduleRepeatableTask(this.run,_loc8_,int.MAX_VALUE);
            }
            this.run();
        }

        private function run() : void
        {
            if(this._currentFrame < 0 || this._currentFrame >= this._progressValues.length)
            {
                this.end();
                this._coolDownHandler.onCoolDownComplete();
                return;
            }
            this.moveToFrame(this._currentFrame);
            if(this._reversed)
            {
                this._currentFrame--;
            }
            else
            {
                this._currentFrame++;
            }
        }

        public function get currentFrame() : int
        {
            return this._currentFrame;
        }

        public function setReverse() : void
        {
            this._isReverse = !this._isReverse;
        }
    }
}
