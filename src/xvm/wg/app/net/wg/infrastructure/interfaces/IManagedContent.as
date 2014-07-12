package net.wg.infrastructure.interfaces
{
   import flash.events.IEventDispatcher;
   import scaleform.clik.interfaces.IUIComponent;
   
   public interface IManagedContent extends IEventDispatcher, IUIComponent
   {
      
      function get isModal() : Boolean;
      
      function get modalAlpha() : Number;
      
      function get sourceView() : IView;
      
      function get containerContent() : IManagedContent;
   }
}
