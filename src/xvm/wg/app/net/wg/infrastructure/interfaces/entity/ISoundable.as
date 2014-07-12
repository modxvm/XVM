package net.wg.infrastructure.interfaces.entity
{
   import flash.events.IEventDispatcher;
   
   public interface ISoundable extends IEventDispatcher
   {
      
      function getSoundType() : String;
      
      function getSoundId() : String;
      
      function getStateOverSnd() : String;
      
      function getStateOutSnd() : String;
      
      function getStatePressSnd() : String;
   }
}
