package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ILobbyMenuMeta extends IEventDispatcher
   {
      
      function settingsClickS() : void;
      
      function cancelClickS() : void;
      
      function refuseTrainingS() : void;
      
      function logoffClickS() : void;
      
      function quitClickS() : void;
   }
}
