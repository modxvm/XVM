package net.wg.gui.utils 
{
    import flash.display.*;
    import flash.utils.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class FrameWalker extends Object implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function FrameWalker(arg1:flash.display.MovieClip, arg2:int, arg3:Boolean)
        {
            super();
            this._isInverted = arg3;
            this._targetMC = arg1;
            this._framesCount = arg2;
            this._endFrame = this._isInverted ? 0 : this._framesCount;
            return;
        }

        public function setTarget(arg1:flash.display.MovieClip):void
        {
            this._targetMC = arg1;
            return;
        }

        public function play(arg1:String):void
        {
            this._targetMC.gotoAndPlay(arg1);
            return;
        }

        public function setPosAsPercent(arg1:Number):void
        {
            arg1 = Math.min(Math.max(arg1, 0), 100);
            var loc1:*=this._framesCount * arg1 / 100;
            this._targetMC.gotoAndStop(loc1);
            return;
        }

        public function setPosAsTime(arg1:Number, arg2:Number):void
        {
            var loc1:*=0;
            if (arg1 > 0) 
            {
                loc1 = isNaN(arg2) ? 0 : int(arg2 / arg1 * this._framesCount);
                this._targetMC.gotoAndStop(this._isInverted ? this._framesCount - loc1 : loc1);
            }
            else 
                this._targetMC.gotoAndStop(this._isInverted ? 0 : this._framesCount);
            return;
        }

        public function start(arg1:Number, arg2:Number, arg3:String=null, arg4:Function=null):void
        {
            var loc1:*=0;
            this._callback = arg4;
            if (this._intervalID != -1) 
            {
                trace("Warning! FrameWalker still works");
                flash.utils.clearInterval(this._intervalID);
                this._intervalID = -1;
            }
            if (arg1 > 0) 
            {
                if (!isNaN(arg2) && arg2 >= arg1) 
                {
                    this.walkEnd();
                    return;
                }
                this._postEffKeyFrame = arg3;
                this._startTime = flash.utils.getTimer();
                this._totalTime = (arg1 - (isNaN(arg2) ? 0 : arg2)) * 1000;
                loc1 = isNaN(arg2) ? 0 : int(arg2 / arg1 * this._framesCount);
                this._startFrame = this._isInverted ? this._framesCount - loc1 : loc1;
                this._targetMC.gotoAndStop(this._startFrame);
                this._intervalID = flash.utils.setInterval(this.run, arg1 * 1000 / this._framesCount);
            }
            else 
                this.walkEnd();
            return;
        }

        public function restartFromCurrentFrame(arg1:Number):void
        {
            if (this._intervalID != -1) 
            {
                trace("Warning! FrameWalker still works");
                flash.utils.clearInterval(this._intervalID);
                this._intervalID = -1;
            }
            if (arg1 > 0) 
            {
                this._startTime = flash.utils.getTimer();
                this._startFrame = this._targetMC.currentFrame;
                if (this._isInverted && this._startFrame == 0 || !this._isInverted && this._startFrame >= this._endFrame) 
                    return;
                this._totalTime = arg1 * 1000;
                this._intervalID = flash.utils.setInterval(this.run, this._totalTime / this._framesCount);
            }
            else 
                this.walkEnd();
            return;
        }

        public function stop():void
        {
            if (this._intervalID != -1) 
            {
                flash.utils.clearInterval(this._intervalID);
                this._intervalID = -1;
            }
            return;
        }

        internal function run():void
        {
            var loc1:*=(flash.utils.getTimer() - this._startTime) / this._totalTime;
            if (loc1 >= 1) 
            {
                flash.utils.clearInterval(this._intervalID);
                this._intervalID = -1;
                this.walkEnd();
            }
            else 
                this._targetMC.gotoAndStop(this.calculateFrameNumber(loc1));
            return;
        }

        internal function calculateFrameNumber(arg1:Number):int
        {
            var loc1:*=arg1 * (this._endFrame - this._startFrame) + this._startFrame;
            return loc1;
        }

        internal function walkEnd():void
        {
            this._targetMC.gotoAndStop(this._endFrame);
            if (this._postEffKeyFrame) 
                this._targetMC.gotoAndPlay(this._postEffKeyFrame);
            if (Boolean(this._callback)) 
                this._callback.call();
            return;
        }

        public function dispose():void
        {
            this.stop();
            this._callback = null;
            this._targetMC = null;
            return;
        }

        internal var _callback:Function;

        internal var _postEffKeyFrame:String;

        internal var _startTime:Number=0;

        internal var _totalTime:Number=0;

        internal var _startFrame:Number=0;

        internal var _endFrame:Number=0;

        internal var _isInverted:Boolean=false;

        internal var _intervalID:int=-1;

        internal var _targetMC:flash.display.MovieClip;

        internal var _framesCount:int=0;
    }
}
