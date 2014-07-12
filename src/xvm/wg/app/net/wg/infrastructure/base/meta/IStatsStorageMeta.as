package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IStatsStorageMeta extends IEventDispatcher
   {
      
      function as_setExperience(param1:Number) : void;
      
      function as_setTankmanId(param1:Number) : void;
      
      function as_setCredits(param1:Number) : void;
      
      function as_setGold(param1:Number) : void;
      
      function as_setPremium(param1:Boolean) : void;
      
      function as_setVehicle(param1:Number) : void;
      
      function as_setPlayerSpeaking(param1:Number, param2:Boolean, param3:Boolean) : void;
      
      function as_setAccountAttrs(param1:Number) : void;
      
      function as_setDenunciationsCount(param1:Number) : void;
      
      function as_setNations(param1:Array) : void;
   }
}
