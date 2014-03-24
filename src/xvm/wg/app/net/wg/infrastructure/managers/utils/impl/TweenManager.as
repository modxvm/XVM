package net.wg.infrastructure.managers.utils.impl
{
   import net.wg.infrastructure.base.meta.impl.TweenManagerMeta;
   import net.wg.utils.ITweenManager;
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   import net.wg.data.constants.Linkages;
   import flash.display.DisplayObject;
   import net.wg.data.VO.TweenPropertiesVO;


   public class TweenManager extends TweenManagerMeta implements ITweenManager
   {
          
      public function TweenManager() {
         super();
      }

      public function createNewTween(param1:ITweenPropertiesVO) : ITween {
         var _loc2_:Class = App.utils.classFactory.getClass(Linkages.TWEEN);
         var _loc3_:ITween = new _loc2_(param1);
         createTweenS(_loc3_);
         return _loc3_;
      }

      public function createPropsForAlpha(param1:DisplayObject, param2:uint, param3:Number, param4:uint) : ITweenPropertiesVO {
         var _loc5_:ITweenPropertiesVO = new TweenPropertiesVO(
            {
               "target":param1,
               "duration":param2,
               "delay":param4,
               "alpha":param3,
               "loop":true,
               "paused":false
            }
         );
         return _loc5_;
      }
   }

}