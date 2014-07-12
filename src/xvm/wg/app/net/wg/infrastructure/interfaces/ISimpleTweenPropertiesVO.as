package net.wg.infrastructure.interfaces
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.display.DisplayObject;
   
   public interface ISimpleTweenPropertiesVO extends IEventDispatcher, IDisposable
   {
      
      function getPosition() : int;
      
      function getDuration() : int;
      
      function getGlobalDelay() : int;
      
      function getLocalDelay() : int;
      
      function getTarget() : DisplayObject;
      
      function getActionAfterRemoveFromStage() : String;
      
      function getLoop() : Boolean;
      
      function getHandler() : ITweenHandler;
      
      function getPaused() : Boolean;
      
      function getX() : Number;
      
      function getY() : Number;
      
      function getScaleX() : Number;
      
      function getScaleY() : Number;
      
      function getAlpha() : Number;
      
      function getRotation() : Number;
      
      function getIsOnCodeBased() : Boolean;
      
      function getTweenIdx() : int;
   }
}
