package net.wg.gui.lobby.vehicleBuyWindow
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.gui.utils.ExcludeTweenManager;
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.IWindow;
   import flash.display.DisplayObject;
   import scaleform.clik.motion.Tween;
   import fl.transitions.easing.Strong;
   
   public class VehicleBuyWindowAnimManager extends Object implements IDisposable
   {
      
      public function VehicleBuyWindowAnimManager(param1:VehicleBuyWindow) {
         super();
         this.animTarget = param1;
      }
      
      private var animTarget:VehicleBuyWindow;
      
      private var footerOpenedY:int;
      
      private var footerClosedY:int;
      
      private var windowClosedHeight:uint;
      
      private var windowOpenedHeight:uint;
      
      private var darkBackgroundCloseHeight:uint;
      
      private var darkBackgroundOpenHeight:uint;
      
      private var maskCloseHeight:uint;
      
      private var maskOpenHeight:uint;
      
      private var _duration:uint = 400;
      
      private var initialized:Boolean;
      
      private var margin:uint = 0;
      
      private var windowClosedHeightMargin:uint = 2;
      
      private var excludeTween:ExcludeTweenManager;
      
      public function launch(param1:Boolean, param2:Boolean) : void {
         var _loc3_:* = 0;
         var _loc4_:* = NaN;
         if(!this.initialized)
         {
            this.initialize();
            this.initialized = true;
         }
         if(param1)
         {
            _loc3_ = Math.round((App.appHeight - this.windowOpenedHeight) / 2);
            this.tweenToY(this.animTarget.footerMc,this.footerOpenedY,param2);
            this.tweenToY(MovieClip(this.animTarget.window),_loc3_,param2);
            this.tweenToAlpha(this.animTarget.bodyMc,1,param2);
            this.tweenToHeight(this.animTarget.window.getBackground(),this.windowOpenedHeight,param2);
            this.tweenToHeight(this.animTarget.backgroundMc,this.darkBackgroundOpenHeight,param2);
            this.tweenToHeight(this.animTarget.bodyMaskMc,this.maskOpenHeight,param2);
         }
         else
         {
            _loc4_ = Math.round((App.appHeight - this.windowClosedHeight) / 2);
            this.tweenToY(this.animTarget.footerMc,this.footerClosedY,param2);
            this.tweenToY(MovieClip(this.animTarget.window),_loc4_,param2);
            this.tweenToAlpha(this.animTarget.bodyMc,0,param2);
            this.tweenToHeight(this.animTarget.window.getBackground(),this.windowClosedHeight,param2);
            this.tweenToHeight(this.animTarget.backgroundMc,this.darkBackgroundCloseHeight,param2);
            this.tweenToHeight(this.animTarget.bodyMaskMc,this.maskCloseHeight,param2);
         }
      }
      
      public function dispose() : void {
         this.animTarget = null;
         if(this.excludeTween)
         {
            this.excludeTween.dispose();
            this.excludeTween = null;
         }
      }
      
      private function initialize() : void {
         var _loc1_:FooterMc = this.animTarget.footerMc;
         this.footerOpenedY = _loc1_.y;
         this.footerClosedY = this.animTarget.bodyMc.y;
         var _loc2_:IWindow = IWindow(this.animTarget.window);
         this.darkBackgroundOpenHeight = this.animTarget.backgroundMc.height;
         this.darkBackgroundCloseHeight = this.footerClosedY + _loc1_.submitBtn.y - this.margin;
         this.windowOpenedHeight = _loc2_.getBackground().height;
         this.windowClosedHeight = this.footerClosedY + _loc1_.height + _loc2_.sourceView.y + (_loc2_.getBackground().height - _loc2_.sourceView.y - _loc2_.sourceView.height) + this.windowClosedHeightMargin;
         this.maskCloseHeight = 1;
         this.maskOpenHeight = this.animTarget.bodyMaskMc.height;
         this.excludeTween = new ExcludeTweenManager();
      }
      
      private function tweenToY(param1:MovieClip, param2:int, param3:Boolean) : void {
         var _loc4_:Object = null;
         if(param3)
         {
            param1.y = param2;
         }
         else
         {
            _loc4_ = {};
            _loc4_.y = param2;
            this.excludeTween.registerAndLaunch(this._duration,param1,_loc4_,this.getDefaultTweenSet());
         }
      }
      
      private function tweenToAlpha(param1:MovieClip, param2:Number, param3:Boolean) : void {
         var _loc4_:Object = null;
         if(param3)
         {
            param1.alpha = param2;
         }
         else
         {
            _loc4_ = {};
            _loc4_.alpha = param2;
            this.excludeTween.registerAndLaunch(this._duration,param1,_loc4_,this.getDefaultTweenSet());
         }
      }
      
      private function tweenToHeight(param1:DisplayObject, param2:Number, param3:Boolean) : void {
         var _loc4_:Object = null;
         if(param3)
         {
            param1.height = param2;
         }
         else
         {
            _loc4_ = {};
            _loc4_.height = param2;
            this.excludeTween.registerAndLaunch(this._duration,param1,_loc4_,this.getDefaultTweenSet());
         }
      }
      
      private function onTweenComplete(param1:Tween) : void {
         this.excludeTween.unregister(param1);
      }
      
      private function getDefaultTweenSet() : Object {
         var _loc1_:Object = {};
         _loc1_.ease = Strong.easeOut;
         _loc1_.onComplete = this.onTweenComplete;
         return _loc1_;
      }
   }
}
