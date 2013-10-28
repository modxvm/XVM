package net.wg.gui.components.controls
{
   import scaleform.clik.controls.Button;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import net.wg.data.constants.SoundManagerStates;
   import flash.utils.Timer;


   public class SoundButton extends Button implements ISoundable
   {
          
      public function SoundButton() {
         super();
      }

      private var _soundType:String = "normal";

      public var soundId:String = "";

      public var hitMc:MovieClip;

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
   }

}