package net.wg.gui.components.common
{
   import scaleform.clik.motion.Tween;
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.IView;
   import flash.display.MovieClip;
   import net.wg.data.constants.Linkages;


   public class MainViewContainer extends ManagedContainer
   {
          
      public function MainViewContainer() {
         super();
      }

      private static const ANIMATION_DURATION:int = 500;

      private var bgFadingTween:Tween = null;

      override public function addChild(param1:DisplayObject) : DisplayObject {
         var param1:DisplayObject = super.addChild(param1);
         if(_modalBg)
         {
            setChildIndex(param1,getChildIndex(_modalBg));
            if(!this.bgFadingTween)
            {
               this.bgFadingTween = new Tween(ANIMATION_DURATION,_modalBg,{"alpha":0},
                  {
                     "paused":false,
                     "onComplete":this.onModalTweenEnd
                  }
               );
            }
            else
            {
               this.bgFadingTween.reset();
               this.bgFadingTween.paused = false;
            }
         }
         return param1;
      }

      override public function removeChild(param1:DisplayObject) : DisplayObject {
         var param1:DisplayObject = super.removeChild(param1);
         this.createModalBg();
         return param1;
      }

      override public function getTopmostView() : DisplayObject {
         var _loc2_:* = 0;
         var _loc3_:DisplayObject = null;
         var _loc1_:DisplayObject = null;
         _loc2_ = numChildren-1;
         while(_loc2_ >= 0)
         {
            _loc3_ = getChildAt(_loc2_);
            if(_loc3_  is  IView)
            {
               _loc1_ = _loc3_;
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

      override protected function createModalBg() : void {
         if(_modalBg == null)
         {
            _modalBg = MovieClip(App.utils.classFactory.getObject(Linkages.VIEW_LOAD_CURTAIN));
            if(_modalBg == null)
            {
               DebugUtils.LOG_DEBUG("Error until getting ");
               return;
            }
         }
         _modalBg.width = App.appWidth;
         _modalBg.height = App.appHeight;
         addChildAt(_modalBg,numChildren > 0?numChildren-1:0);
      }

      private function onModalTweenEnd(param1:Tween=null) : void {
         super.superRemoveChild(_modalBg);
         _modalBg = null;
      }
   }

}