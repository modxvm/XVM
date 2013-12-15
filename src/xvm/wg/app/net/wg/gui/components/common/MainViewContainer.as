package net.wg.gui.components.common
{
   import scaleform.clik.motion.Tween;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.IView;


   public class MainViewContainer extends ManagedContainer
   {
          
      public function MainViewContainer() {
         super();
      }

      private static const ANIMATION_DURATION:int = 500;

      private var bgFadingTween:Tween = null;

      override public function addChild(param1:DisplayObject) : DisplayObject {
         var param1:DisplayObject = super.addChild(param1);
         return param1;
      }

      override public function removeChild(param1:DisplayObject) : DisplayObject {
         var param1:DisplayObject = super.removeChild(param1);
         this.updateOrCreateModalBg();
         return param1;
      }

      override public function getTopmostView() : Sprite {
         var _loc2_:* = 0;
         var _loc3_:DisplayObject = null;
         var _loc1_:Sprite = null;
         _loc2_ = numChildren-1;
         while(_loc2_ >= 0)
         {
            _loc3_ = getChildAt(_loc2_);
            if(_loc3_  is  IView)
            {
               _loc1_ = Sprite(_loc3_);
               break;
            }
            _loc2_--;
         }
         return _loc1_;
      }

      override public function dispose() : void {
         super.dispose();
         if(this.bgFadingTween != null)
         {
            this.bgFadingTween.dispose();
            this.bgFadingTween = null;
         }
      }

      override protected function updateOrCreateModalBg() : void {
          
      }

      private function onModalTweenEnd(param1:Tween=null) : void {
          
      }
   }

}