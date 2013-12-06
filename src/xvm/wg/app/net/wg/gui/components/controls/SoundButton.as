package net.wg.gui.components.controls
{
   import scaleform.clik.controls.Button;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import net.wg.data.constants.SoundManagerStates;
   import flash.utils.Timer;
   import flash.events.MouseEvent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;


   public class SoundButton extends Button implements ISoundable
   {
          
      public function SoundButton() {
         super();
      }

      private static const INPUT_LOCK_DURATION:Number = 20;

      private var _soundType:String = "normal";

      public var soundId:String = "";

      public var hitMc:MovieClip;

      protected var mouseHandlingLocked:Boolean = false;

      protected var keyboardHandlingLocked:Boolean = false;

      public function get soundType() : String {
         return this._soundType;
      }

      public function set soundType(param1:String) : void {
         if((param1) && !(param1 == this._soundType))
         {
            this._soundType = param1;
         }
      }

      override public function toString() : String {
         return "[WG SoundButton " + name + "]";
      }

      override public function dispose() : void {
         this.hitMc = null;
         if(_repeatTimer != null)
         {
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat,false);
            _repeatTimer.stop();
         }
         if(App.soundMgr)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         App.utils.scheduler.cancelTask(this.unlockKeyboardHandling);
         App.utils.scheduler.cancelTask(this.unlockMouseHandling);
         super.dispose();
      }

      public final function getSoundType() : String {
         return this.soundType;
      }

      public final function getSoundId() : String {
         return this.soundId;
      }

      public final function getStateOverSnd() : String {
         return SoundManagerStates.SND_OVER;
      }

      public final function getStateOutSnd() : String {
         return SoundManagerStates.SND_OUT;
      }

      public final function getStatePressSnd() : String {
         return SoundManagerStates.SND_PRESS;
      }

      public function beginButtonRepeat() : void {
         if((autoRepeat) && _repeatTimer == null)
         {
            _repeatTimer = new Timer(repeatDelay,1);
            _repeatTimer.addEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat,false,0,true);
            _repeatTimer.start();
         }
      }

      override public function set enabled(param1:Boolean) : void {
         if(param1 == enabled)
         {
            return;
         }
         if((this.focusable) && (this.focused) && !param1)
         {
            this.focused = 0;
         }
         super.enabled = param1;
      }

      override protected function configUI() : void {
         super.configUI();
         if(this.hitMc != null)
         {
            this.hitArea = this.hitMc;
         }
         buttonMode = true;
         if(App.soundMgr != null)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
         if(textField)
         {
            textField.mouseEnabled = false;
         }
      }

      override protected function draw() : void {
         super.draw();
      }

      override protected function handleMouseRelease(param1:MouseEvent) : void {
         var _loc5_:ButtonEvent = null;
         _autoRepeatEvent = null;
         if(!enabled)
         {
            return;
         }
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null?0:_loc2_.mouseIdx;
         var _loc4_:uint = _loc2_ == null?0:_loc2_.buttonIdx;
         if(_loc4_ != 0)
         {
            return;
         }
         _mouseDown = _mouseDown ^ 1 << _loc3_;
         if(_mouseDown == 0 && (_repeatTimer))
         {
            _repeatTimer.stop();
            _repeatTimer.reset();
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat);
            _repeatTimer.removeEventListener(TimerEvent.TIMER,handleRepeat);
            _repeatTimer = null;
         }
         setState("release");
         handleClick(_loc3_);
         if(!_isRepeating && !this.mouseHandlingLocked)
         {
            _loc5_ = new ButtonEvent(ButtonEvent.CLICK,true,false,_loc3_,_loc4_,false,false);
            dispatchEvent(_loc5_);
            this.keyboardHandlingLocked = true;
            App.utils.scheduler.scheduleTask(this.unlockKeyboardHandling,INPUT_LOCK_DURATION);
         }
         _isRepeating = false;
      }

      override protected function handleRelease(param1:uint=0) : void {
         var _loc2_:ButtonEvent = null;
         if(!enabled)
         {
            return;
         }
         setState(focusIndicator == null?"release":"kb_release");
         if(_repeatTimer)
         {
            _repeatTimer.stop();
            _repeatTimer.reset();
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat);
            _repeatTimer.removeEventListener(TimerEvent.TIMER,handleRepeat);
            _repeatTimer = null;
         }
         handleClick(param1);
         _pressedByKeyboard = false;
         if(!_isRepeating && !this.keyboardHandlingLocked)
         {
            _loc2_ = new ButtonEvent(ButtonEvent.CLICK,true,false,param1,0,true,false);
            dispatchEvent(_loc2_);
            this.mouseHandlingLocked = true;
            App.utils.scheduler.scheduleTask(this.unlockMouseHandling,INPUT_LOCK_DURATION);
         }
         _isRepeating = false;
      }

      private function unlockMouseHandling() : void {
         this.mouseHandlingLocked = false;
      }

      private function unlockKeyboardHandling() : void {
         this.keyboardHandlingLocked = false;
      }
   }

}