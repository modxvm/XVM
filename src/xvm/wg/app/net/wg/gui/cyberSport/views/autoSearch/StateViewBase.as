package net.wg.gui.cyberSport.views.autoSearch
{
   import flash.display.Sprite;
   import net.wg.gui.cyberSport.interfaces.ICSAutoSearchMainView;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.cyberSport.vo.AutoSearchVO;
   import flash.display.InteractiveObject;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import flash.events.Event;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import scaleform.clik.ui.InputDetails;
   import flash.ui.Keyboard;
   import scaleform.clik.constants.InputValue;


   public class StateViewBase extends Sprite implements ICSAutoSearchMainView
   {
          
      public function StateViewBase() {
         super();
         if((this.sec) && (this.min) && (this.timerSeparator))
         {
            this.timerSeparator.mouseEnabled = this.sec.mouseEnabled = this.min.mouseEnabled = false;
         }
         if(this.mainField)
         {
            this.mainField.mouseEnabled = false;
         }
         if(this.submitButton)
         {
            this.submitButton.addEventListener(ButtonEvent.CLICK,this.submitButtonOnClick);
            this.submitButton.mouseEnabled = true;
         }
         if(this.cancelButton)
         {
            this.cancelButton.addEventListener(ButtonEvent.CLICK,this.cancelButtonOnClick);
            this.cancelButton.mouseEnabled = true;
         }
         addEventListener(InputEvent.INPUT,this.handleInput);
      }

      public static const UPDATE_TIMER:String = "csUpdateTimer";

      public var sec:TextField;

      public var min:TextField;

      public var timerSeparator:TextField;

      public var mainField:TextField;

      public var submitButton:SoundButtonEx;

      public var cancelButton:SoundButtonEx;

      protected var model:AutoSearchVO;

      protected var currentState:String;

      protected var _time:int = 0;

      public function getComponentForFocus() : InteractiveObject {
         if(this.visible)
         {
            if(this.submitButton)
            {
               return this.submitButton;
            }
            if(this.cancelButton)
            {
               return this.cancelButton;
            }
         }
         return null;
      }

      public function enableButton(param1:Boolean) : void {
         if((visible) && (this.cancelButton) && (this.cancelButton.visible))
         {
            this.cancelButton.enabled = param1;
         }
      }

      public function stopTimer() : void {
         App.utils.scheduler.cancelTask(this.onTimer);
         this._time = 0;
      }

      public final function dispose() : void {
         this.onDispose();
      }

      protected function onDispose() : void {
         App.utils.scheduler.cancelTask(this.onTimer);
         if(this.model)
         {
            this.model.dispose();
            this.model = null;
         }
         if(this.submitButton)
         {
            this.submitButton.removeEventListener(ButtonEvent.CLICK,this.submitButtonOnClick);
            this.submitButton.dispose();
         }
         if(this.cancelButton)
         {
            this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.cancelButtonOnClick);
            this.cancelButton.dispose();
         }
         removeEventListener(InputEvent.INPUT,this.handleInput);
      }

      public function set changeState(param1:AutoSearchVO) : void {
         if(param1 == null)
         {
            return;
         }
         this.model = param1;
         this.visibleState();
      }

      protected function updateView() : void {
         this.stopTimer();
         this._time = this.model.countDownSeconds;
      }

      protected function contextMessage(param1:String) : void {
         if(param1 == null || param1 == "")
         {
            DebugUtils.LOG_ERROR(name," contextMessage = NULL");
         }
      }

      protected function startTimer() : void {
         App.utils.scheduler.scheduleTask(this.onTimer,1000);
      }

      protected function onTimer() : void {
         this._time++;
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.TIMER_TICK,null);
      }

      protected function formatTime(param1:int) : Object {
         var _loc2_:uint = Math.floor(param1);
         var _loc3_:uint = Math.floor(_loc2_ / 3600);
         var _loc4_:uint = (_loc2_ - _loc3_ * 3600) / 60;
         var _loc5_:uint = _loc2_ - _loc3_ * 3600 - _loc4_ * 60;
         var _loc6_:String = (_loc4_ < 10?"0":"") + _loc4_;
         var _loc7_:String = (_loc5_ < 10?"0":"") + _loc5_;
         return {
            "hours":String(_loc3_),
            "minutes":_loc6_,
            "seconds":_loc7_
         }
         ;
      }

      protected function updateTime() : void {
         var _loc1_:Object = null;
         if((this.min) && (this.sec))
         {
            _loc1_ = this.formatTime(this._time);
            this.min.text = _loc1_.minutes;
            this.sec.text = _loc1_.seconds;
            dispatchEvent(new Event(UPDATE_TIMER,true));
         }
      }

      private function visibleState() : void {
         visible = this.model.state == this.currentState;
         if(visible)
         {
            this.enableButton(true);
            this.updateView();
         }
      }

      protected function submitButtonOnClick(param1:ButtonEvent) : void {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.AUTO_SEARCH_APPLY_BTN,this.currentState));
      }

      protected function cancelButtonOnClick(param1:ButtonEvent=null) : void {
         dispatchEvent(new CSComponentEvent(CSComponentEvent.AUTO_SEARCH_CANCEL_BTN,this.currentState));
      }

      public function handleInput(param1:InputEvent) : void {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if((this.cancelButton) && (_loc2_.code == Keyboard.ESCAPE) && _loc2_.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            this.cancelButtonOnClick();
         }
      }
   }

}