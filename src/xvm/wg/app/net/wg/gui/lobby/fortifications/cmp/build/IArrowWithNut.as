package net.wg.gui.lobby.fortifications.cmp.build
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.ITweenAnimatorHandler;
   
   public interface IArrowWithNut extends IUIComponentEx, ITweenAnimatorHandler
   {
      
      function show() : void;
      
      function hide() : void;
      
      function get content() : IUIComponentEx;
      
      function set content(param1:IUIComponentEx) : void;
      
      function get isShowed() : Boolean;
      
      function get isExport() : Boolean;
      
      function set isExport(param1:Boolean) : void;
   }
}
