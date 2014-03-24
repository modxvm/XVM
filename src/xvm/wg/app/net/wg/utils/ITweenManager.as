package net.wg.utils
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   import flash.display.DisplayObject;


   public interface ITweenManager extends IDisposable
   {
          
      function createNewTween(param1:ITweenPropertiesVO) : ITween;

      function disposeTweenS(param1:ITween) : void;

      function disposeAllS() : void;

      function createPropsForAlpha(param1:DisplayObject, param2:uint, param3:Number, param4:uint) : ITweenPropertiesVO;
   }

}