package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IHangarMeta extends IEventDispatcher
   {
          
      function onEscapeS() : void;

      function checkMoneyS() : void;

      function showHelpLayoutS() : void;

      function closeHelpLayoutS() : void;

      function toggleGUIEditorS() : void;

      function as_readyToFight(param1:Boolean, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean, param9:Boolean) : void;

      function as_showHelpLayout() : void;

      function as_closeHelpLayout() : void;

      function as_setIsIGR(param1:Boolean, param2:String) : void;
   }

}