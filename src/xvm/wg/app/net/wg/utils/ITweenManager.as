package net.wg.utils
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   
   public interface ITweenManager extends IDisposable
   {
      
      function createNewTween(param1:ITweenPropertiesVO) : ITween;
      
      function disposeTweenS(param1:ITween) : void;
      
      function disposeAllS() : void;
   }
}
