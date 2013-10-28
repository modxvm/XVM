package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface ITutorialControlMeta extends IEventDispatcher
   {
          
      function restartS() : void;

      function refuseS() : void;

      function as_setup(param1:Object) : void;

      function as_setPlayerXPLevel(param1:int) : void;

      function as_setChapterInfo(param1:String, param2:String) : void;

      function as_clearChapterInfo() : void;

      function as_setRunMode() : void;

      function as_setRestartMode() : void;

      function as_setDisabled(param1:Boolean) : void;
   }

}