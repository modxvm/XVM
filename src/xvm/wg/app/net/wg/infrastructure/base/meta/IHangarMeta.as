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
      
      function as_setCrewEnabled(param1:Boolean) : void;
      
      function as_setCarouselEnabled(param1:Boolean) : void;
      
      function as_setupAmmunitionPanel(param1:String, param2:String, param3:Boolean, param4:Boolean) : void;
      
      function as_setControlsVisible(param1:Boolean) : void;
      
      function as_showHelpLayout() : void;
      
      function as_closeHelpLayout() : void;
      
      function as_setIsIGR(param1:Boolean, param2:String) : void;
   }
}
