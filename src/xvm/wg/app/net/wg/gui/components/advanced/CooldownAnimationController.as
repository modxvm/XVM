package net.wg.gui.components.advanced
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;


   public class CooldownAnimationController extends UIComponent
   {
          
      public function CooldownAnimationController() {
         super();
      }

      private static const DELTA_OF_PIXELS_FOR_ANIMATION:int = 47;

      private static const VERTICAL_PADDING:int = 5;

      private static const STEP:int = 1;

      public var maskMc:MovieClip;

      private var _cooldownPeriod:Number;

      private var _currentProgress:int = 0;

      private var _isDischarging:Boolean = true;

      public function startCooldown(param1:Number, param2:Number) : void {
         this._cooldownPeriod = param2 / DELTA_OF_PIXELS_FOR_ANIMATION;
         if(this._isDischarging)
         {
            this._currentProgress = DELTA_OF_PIXELS_FOR_ANIMATION - Math.round(param1 / param2 * DELTA_OF_PIXELS_FOR_ANIMATION);
         }
         else
         {
            this._currentProgress = Math.round(param1 / param2 * DELTA_OF_PIXELS_FOR_ANIMATION);
         }
         App.utils.scheduler.scheduleTask(this.updateAnimation,this._cooldownPeriod);
      }

      private function updateAnimation() : void {
         if(this._isDischarging)
         {
            if(this._currentProgress > 0)
            {
               this._currentProgress--;
               this.maskMc.height = Math.round(VERTICAL_PADDING + this._currentProgress);
               App.utils.scheduler.scheduleTask(this.updateAnimation,this._cooldownPeriod);
            }
         }
         else
         {
            if(this._currentProgress < DELTA_OF_PIXELS_FOR_ANIMATION)
            {
               this._currentProgress++;
               this.maskMc.height = Math.round(VERTICAL_PADDING + this._currentProgress);
               App.utils.scheduler.scheduleTask(this.updateAnimation,this._cooldownPeriod);
            }
         }
      }
   }

}