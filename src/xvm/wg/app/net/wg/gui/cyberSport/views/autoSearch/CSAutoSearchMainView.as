package net.wg.gui.cyberSport.views.autoSearch
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.cyberSport.interfaces.ICSAutoSearchMainView;
   import net.wg.gui.components.common.waiting.WaitingMc;
   import net.wg.gui.cyberSport.vo.AutoSearchVO;
   import flash.events.Event;
   import scaleform.clik.events.InputEvent;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import flash.display.InteractiveObject;
   import scaleform.clik.constants.InvalidationType;


   public class CSAutoSearchMainView extends UIComponent implements ICSAutoSearchMainView
   {
          
      public function CSAutoSearchMainView() {
         super();
         this.views = [];
         this.views.push(this.searchCommands,this.searchEnemy,this.waitingPlayer,this.confirmationState,this.errorState);
         this.viewsLength = this.views.length;
         var _loc1_:* = 0;
         while(_loc1_ < this.viewsLength)
         {
            InteractiveObject(this.views[_loc1_]).addEventListener(StateViewBase.UPDATE_TIMER,this.csUpdateTimerHandler);
            _loc1_++;
         }
         this.waitingCmp.play();
      }

      private static const FRAME_ANIMATION:uint = 7;

      public var waitingCmp:WaitingMc;

      public var searchCommands:SearchCommands;

      public var searchEnemy:SearchEnemy;

      public var waitingPlayer:WaitingPlayers;

      public var confirmationState:ConfirmationReadinessStatus;

      public var errorState:ErrorState;

      private var views:Array = null;

      private var viewsLength:uint = 0;

      private var model:AutoSearchVO;

      private var frameCount:Number = 7;

      private function csUpdateTimerHandler(param1:Event) : void {
         this.initWheelBehaviour();
      }

      public function enableButton(param1:Boolean) : void {
         var _loc2_:* = 0;
         while(_loc2_ < this.viewsLength)
         {
            ICSAutoSearchMainView(this.views[_loc2_]).enableButton(param1);
            _loc2_++;
         }
      }

      public function set changeState(param1:AutoSearchVO) : void {
         if(param1 == null)
         {
            return;
         }
         this.model = param1;
         invalidateData();
         this.initWheelBehaviour();
      }

      public function updateFocus() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this.viewsLength)
         {
            ICSAutoSearchMainView(this.views[_loc1_]).updateFocus();
            _loc1_++;
         }
      }

      override public function handleInput(param1:InputEvent) : void {
         var _loc2_:ICSAutoSearchMainView = null;
         var _loc3_:* = 0;
         while(_loc3_ < this.viewsLength)
         {
            _loc2_ = this.views[_loc3_];
            if((_loc2_) && (_loc2_.visible))
            {
               _loc2_.handleInput(param1);
            }
            _loc3_++;
         }
      }

      public function stopTimer() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this.viewsLength)
         {
            ICSAutoSearchMainView(this.views[_loc1_]).stopTimer();
            _loc1_++;
         }
      }

      private function initWheelBehaviour() : void {
         if(this.model.state == CYBER_SPORT_ALIASES.AUTO_SEARCH_CONFIRMATION_STATE)
         {
            this.waitingCmp.stop();
            this.frameCount = FRAME_ANIMATION;
            this.updateWaiting();
         }
         else
         {
            if(this.model.state == CYBER_SPORT_ALIASES.AUTO_SEARCH_ERROR_STATE)
            {
               this.waitingCmp.stop();
            }
            else
            {
               this.waitingCmp.play();
            }
         }
      }

      private function updateWaiting() : void {
         this.addEventListener(Event.ENTER_FRAME,this.wheelReversHandler);
      }

      private function wheelReversHandler(param1:Event) : void {
         var _loc2_:* = NaN;
         if(this.frameCount <= 0)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.wheelReversHandler);
         }
         else
         {
            _loc2_ = this.waitingCmp.currentFrame-1;
            if(_loc2_ <= 0)
            {
               _loc2_ = this.waitingCmp.totalFrames-1;
            }
            this.waitingCmp.gotoAndStop(_loc2_);
            this.frameCount--;
         }
      }

      override public function dispose() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this.viewsLength)
         {
            ICSAutoSearchMainView(this.views[_loc1_]).dispose();
            InteractiveObject(this.views[_loc1_]).removeEventListener(StateViewBase.UPDATE_TIMER,this.csUpdateTimerHandler);
            _loc1_++;
         }
         super.dispose();
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.initStates();
         }
      }

      private function initStates() : void {
         var _loc1_:uint = 0;
         while(_loc1_ < this.viewsLength)
         {
            StateViewBase(this.views[_loc1_]).changeState = this.model;
            _loc1_++;
         }
      }
   }

}