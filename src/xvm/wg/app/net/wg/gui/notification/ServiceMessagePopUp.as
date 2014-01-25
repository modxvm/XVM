package net.wg.gui.notification
{
   import net.wg.gui.utils.ExcludeTweenManager;
   import scaleform.clik.motion.Tween;
   import flash.events.Event;


   public class ServiceMessagePopUp extends ServiceMessage
   {
          
      public function ServiceMessagePopUp() {
         this.tweenManager = new ExcludeTweenManager();
         super();
      }

      public static const HIDED:String = "hided";

      private var _livingTime:Number = NaN;

      private var _animationSpeed:Number = NaN;

      private var tweenManager:ExcludeTweenManager;

      override protected function configUI() : void {
         super.configUI();
         textField.selectable = false;
         if(!isNaN(this._livingTime))
         {
            App.utils.scheduler.scheduleTask(this.startMessageHiding,this._livingTime);
         }
      }

      private function startMessageHiding() : void {
         var _loc1_:Tween = null;
         if(!isNaN(this._animationSpeed))
         {
            _loc1_ = this.tweenManager.registerAndLaunch(this._animationSpeed,this,{"alpha":0},{"onComplete":this.onHideTweenComplete});
            _loc1_.fastTransform = false;
         }
         else
         {
            dispatchEvent(new Event(HIDED));
         }
      }

      private function onHideTweenComplete(param1:Tween) : void {
         this.tweenManager.unregister(param1);
         dispatchEvent(new Event(HIDED));
      }

      public function get livingTime() : Number {
         return this._livingTime;
      }

      public function set livingTime(param1:Number) : void {
         this._livingTime = param1;
      }

      public function set animationSpeed(param1:Number) : void {
         this._animationSpeed = param1;
      }

      public function get animationSpeed() : Number {
         return this._animationSpeed;
      }

      override protected function onDispose() : void {
         App.utils.scheduler.cancelTask(this.startMessageHiding);
         if(this.tweenManager)
         {
            this.tweenManager.dispose();
            this.tweenManager = null;
         }
         super.onDispose();
      }
   }

}