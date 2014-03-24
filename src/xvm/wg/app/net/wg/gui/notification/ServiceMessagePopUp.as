package net.wg.gui.notification
{
   import net.wg.gui.utils.ExcludeTweenManager;
   import scaleform.clik.motion.Tween;
   import net.wg.gui.notification.vo.PopUpNotificationInfoVO;
   import flash.events.Event;


   public class ServiceMessagePopUp extends ServiceMessage
   {
          
      public function ServiceMessagePopUp() {
         this.tweenManager = new ExcludeTweenManager();
         super();
      }

      public static const HIDING_INVALID:String = "hidingInv";

      public static const HIDED:String = "hided";

      private static const HIDE:int = 0;

      private static const SHOW:int = 1;

      private static const NONE:int = -1;

      private static const SHOW_ANIMATION_SPEED:uint = 150;

      private var _livingTime:Number = NaN;

      private var _hidingAnimationSpeed:Number = NaN;

      private var tweenManager:ExcludeTweenManager;

      public var isLayoutInitialized:Boolean;

      private var _allowHiding:int = -1;

      private var hideTween:Tween;

      private var livingTimeComplete:Boolean;

      override protected function configUI() : void {
         super.configUI();
         textField.selectable = false;
         if(!isNaN(this._livingTime))
         {
            App.utils.scheduler.scheduleTask(this.hideTask,this._livingTime);
         }
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(HIDING_INVALID))
         {
            if(this._allowHiding == SHOW)
            {
               this.hideTween = this.tweenManager.registerAndLaunch(SHOW_ANIMATION_SPEED,this,{"alpha":1},{"onComplete":this.onShowTweenComplete});
               this.hideTween.fastTransform = false;
            }
            else
            {
               if(this._allowHiding == HIDE && (this.livingTimeComplete))
               {
                  this.launchHideAnimation();
               }
            }
         }
      }

      override public function set data(param1:Object) : void {
         super.data = param1;
         var _loc2_:PopUpNotificationInfoVO = PopUpNotificationInfoVO(param1);
         this.livingTime = _loc2_.lifeTime;
         this.hidingAnimationSpeed = _loc2_.hidingAnimationSpeed;
      }

      private function hideTask() : void {
         this.livingTimeComplete = true;
         if(!isNaN(this._hidingAnimationSpeed))
         {
            if(this._allowHiding != SHOW)
            {
               this.launchHideAnimation();
            }
         }
         else
         {
            dispatchEvent(new Event(HIDED));
         }
      }

      private function launchHideAnimation() : void {
         this.hideTween = this.tweenManager.registerAndLaunch(this._hidingAnimationSpeed,this,{"alpha":0},{"onComplete":this.onHideTweenComplete});
         this.hideTween.fastTransform = false;
      }

      private function onHideTweenComplete(param1:Tween) : void {
         this.tweenManager.unregister(param1);
         dispatchEvent(new Event(HIDED));
      }

      private function onShowTweenComplete(param1:Tween) : void {
         this.tweenManager.unregister(param1);
      }

      public function get livingTime() : Number {
         return this._livingTime;
      }

      public function set livingTime(param1:Number) : void {
         this._livingTime = param1;
      }

      public function set hidingAnimationSpeed(param1:Number) : void {
         this._hidingAnimationSpeed = param1;
      }

      public function get hidingAnimationSpeed() : Number {
         return this._hidingAnimationSpeed;
      }

      override protected function onDispose() : void {
         App.utils.scheduler.cancelTask(this.hideTask);
         if(this.tweenManager)
         {
            this.tweenManager.dispose();
            this.tweenManager = null;
         }
         if(this.hideTween)
         {
            this.hideTween = null;
         }
         super.onDispose();
      }

      public function set allowHiding(param1:Boolean) : void {
         if(!(this._allowHiding == SHOW) || !(this._allowHiding == HIDE))
         {
            this._allowHiding = param1?SHOW:HIDE;
            invalidate(HIDING_INVALID);
         }
      }
   }

}