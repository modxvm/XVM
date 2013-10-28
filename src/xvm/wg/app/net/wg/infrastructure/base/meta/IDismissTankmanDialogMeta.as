package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IDismissTankmanDialogMeta extends IEventDispatcher
   {
          
      function sendControlNumberS(param1:String) : void;

      function as_enabledButton(param1:Boolean) : void;

      function as_tankMan(param1:Object) : void;

      function as_setQuestionForUser(param1:String) : void;

      function as_controlTextInput(param1:String) : void;
   }

}