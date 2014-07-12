package net.wg.data.managers.impl
{
   import net.wg.infrastructure.base.meta.impl.FlashTweenMeta;
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.base.meta.IFlashTweenMeta;
   import flash.display.DisplayObject;
   import net.wg.data.VO.TweenPropertiesVO;
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   
   public class FlashTween extends FlashTweenMeta implements ITween, IFlashTweenMeta
   {
      
      public function FlashTween(param1:ITweenPropertiesVO) {
         super();
         props = param1;
      }
      
      override public function getTargetDisplayObject() : DisplayObject {
         return TweenPropertiesVO(props).getTarget();
      }
      
      public function moveOnPosition(param1:int) : void {
         var _loc2_:MovieClip = MovieClip(TweenPropertiesVO(props).getTarget());
         var _loc3_:int = Math.round(_loc2_.totalFrames * param1 / 100);
         _loc2_.gotoAndStop(_loc3_);
      }
   }
}
