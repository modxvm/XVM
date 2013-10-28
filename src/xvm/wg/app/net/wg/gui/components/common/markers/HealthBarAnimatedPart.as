package net.wg.gui.components.common.markers
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import net.wg.gui.events.TimelineEvent;
   import flash.events.Event;


   public class HealthBarAnimatedPart extends UIComponent
   {
          
      public function HealthBarAnimatedPart() {
         super();
         stop();
         visible = false;
      }

      public static const SHOW:String = "show";

      public static const HIDE:String = "hide";

      public static const SPLASH_DURATION:Number = 1000;

      public static const SHOW_STATE:String = "show";

      public static const ACTIVE_STATE:String = "active";

      public static const HIDE_STATE:String = "hide";

      public static const INACTIVE_STATE:String = "inactive";

      public static const IMITATION_STATE:String = "imitationDamage";

      protected var tweenState:String = "inactive";

      public var animate_mc:MovieClip;

      override protected function configUI() : void {
         super.configUI();
         addEventListener(TimelineEvent.TWEEN_COMPLETE,this.onTimelineTweenComplete);
      }

      public function playShowTween() : void {
         var _loc1_:String = this.tweenState;
         switch(this.tweenState)
         {
            case INACTIVE_STATE:
               visible = true;
               this.tweenState = SHOW_STATE;
               break;
            case ACTIVE_STATE:
               this.onTweenComplete(true);
               break;
            case HIDE_STATE:
               this.tweenState = SHOW_STATE;
               break;
         }
         if(_loc1_ != this.tweenState)
         {
            this.setState();
         }
      }

      protected function setState() : void {
         gotoAndPlay(this.tweenState);
      }

      private function onTimelineTweenComplete(param1:TimelineEvent) : void {
         this.onTweenComplete(param1.isShow);
      }

      public function onTweenComplete(param1:Boolean) : void {
         if(param1)
         {
            this.tweenState = ACTIVE_STATE;
            App.utils.scheduler.scheduleTask(this.playHideTween,SPLASH_DURATION);
            dispatchEvent(new Event(SHOW));
         }
         else
         {
            this.tweenState = INACTIVE_STATE;
            visible = false;
            dispatchEvent(new Event(HIDE));
         }
      }

      public function playHideTween() : void {
         this.tweenState = HIDE_STATE;
         gotoAndPlay(this.tweenState);
      }

      public function setAnimationType(param1:String) : void {
         if(this.animate_mc)
         {
            this.animate_mc.gotoAndStop(param1);
         }
      }
   }

}