package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   import flash.display.DisplayObject;
   
   public interface IAbstractTweenMeta extends IEventDispatcher
   {
      
      function initialiazeS(param1:ITweenPropertiesVO) : void;
      
      function creatTweenPYS(param1:DisplayObject) : void;
      
      function getPausedS() : Boolean;
      
      function setPausedS(param1:Boolean) : void;
      
      function getLoopS() : Boolean;
      
      function setLoopS(param1:Boolean) : void;
      
      function getDurationS() : uint;
      
      function setDurationS(param1:uint) : void;
      
      function getPositionS() : uint;
      
      function setPositionS(param1:uint) : void;
      
      function getDelayS() : uint;
      
      function setDelayS(param1:uint) : void;
      
      function resetAnimS() : void;
      
      function getTweenIdxS() : uint;
      
      function getIsCompleteS() : Boolean;
      
      function getTargetDisplayObject() : DisplayObject;
      
      function onAnimComplete() : void;
      
      function onAnimStart() : void;
   }
}
