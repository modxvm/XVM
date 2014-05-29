package net.wg.gui.utils
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.display.MovieClip;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;


   public class FrameWalker extends Object implements IDisposable
   {
          
      public function FrameWalker(param1:MovieClip, param2:int, param3:Boolean) {
         super();
         this._isInverted = param3;
         this._targetMC = param1;
         this._framesCount = param2;
         this._endFrame = this._isInverted?0:this._framesCount;
      }

      private var _callback:Function;

      private var _postEffKeyFrame:String;

      private var _startTime:Number = 0;

      private var _totalTime:Number = 0;

      private var _startFrame:Number = 0;

      private var _endFrame:Number = 0;

      private var _isInverted:Boolean = false;

      private var _intervalID:int = -1;

      private var _targetMC:MovieClip;

      private var _framesCount:int = 0;

      public function setTarget(param1:MovieClip) : void {
         this._targetMC = param1;
      }

      public function play(param1:String) : void {
         this._targetMC.gotoAndPlay(param1);
      }

      public function setPosAsPercent(param1:Number) : void {
         var param1:Number = Math.min(Math.max(param1,0),100);
         var _loc2_:int = this._framesCount * param1 / 100;
         this._targetMC.gotoAndStop(_loc2_);
      }

      public function setPosAsTime(param1:Number, param2:Number) : void {
         var _loc3_:* = 0;
         if(param1 > 0)
         {
            _loc3_ = !isNaN(param2)?int(param2 / param1 * this._framesCount):0;
            this._targetMC.gotoAndStop(this._isInverted?this._framesCount - _loc3_:_loc3_);
         }
         else
         {
            this._targetMC.gotoAndStop(this._isInverted?0:this._framesCount);
         }
      }

      public function start(param1:Number, param2:Number, param3:String=null, param4:Function=null) : void {
         var _loc5_:* = 0;
         this._callback = param4;
         if(this._intervalID != -1)
         {
            clearInterval(this._intervalID);
            this._intervalID = -1;
         }
         if(param1 > 0)
         {
            if(!isNaN(param2) && param2 >= param1)
            {
               this.walkEnd();
               return;
            }
            this._postEffKeyFrame = param3;
            this._startTime = getTimer();
            this._totalTime = (param1 - (!isNaN(param2)?param2:0)) * 1000;
            _loc5_ = !isNaN(param2)?int(param2 / param1 * this._framesCount):0;
            this._startFrame = this._isInverted?this._framesCount - _loc5_:_loc5_;
            this._targetMC.gotoAndStop(this._startFrame);
            this._intervalID = setInterval(this.run,param1 * 1000 / this._framesCount);
         }
         else
         {
            this.walkEnd();
         }
      }

      public function restartFromCurrentFrame(param1:Number) : void {
         if(this._intervalID != -1)
         {
            clearInterval(this._intervalID);
            this._intervalID = -1;
         }
         if(param1 > 0)
         {
            this._startTime = getTimer();
            this._startFrame = this._targetMC.currentFrame;
            if((this._isInverted) && this._startFrame == 0 || !this._isInverted && this._startFrame >= this._endFrame)
            {
               return;
            }
            this._totalTime = param1 * 1000;
            this._intervalID = setInterval(this.run,this._totalTime / this._framesCount);
         }
         else
         {
            this.walkEnd();
         }
      }

      public function stop() : void {
         if(this._intervalID != -1)
         {
            clearInterval(this._intervalID);
            this._intervalID = -1;
         }
      }

      private function run() : void {
         var _loc1_:Number = (getTimer() - this._startTime) / this._totalTime;
         if(_loc1_ >= 1)
         {
            clearInterval(this._intervalID);
            this._intervalID = -1;
            this.walkEnd();
         }
         else
         {
            this._targetMC.gotoAndStop(this.calculateFrameNumber(_loc1_));
         }
      }

      private function calculateFrameNumber(param1:Number) : int {
         var _loc2_:int = param1 * (this._endFrame - this._startFrame) + this._startFrame;
         return _loc2_;
      }

      private function walkEnd() : void {
         this._targetMC.gotoAndStop(this._endFrame);
         if(this._postEffKeyFrame)
         {
            this._targetMC.gotoAndPlay(this._postEffKeyFrame);
         }
         if(Boolean(this._callback))
         {
            this._callback.call();
         }
      }

      public function dispose() : void {
         this.stop();
         this._callback = null;
         this._targetMC = null;
      }
   }

}