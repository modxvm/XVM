package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.base.meta.IWindowViewMeta;


   public interface IAbstractWindowView extends IWindowViewMeta, IView
   {
          
      function handleWindowMinimize() : void;

      function get canDrag() : Boolean;

      function get showWindowBg() : Boolean;

      function get canMinimize() : Boolean;

      function get canResize() : Boolean;

      function get canClose() : Boolean;

      function get enabledCloseBtn() : Boolean;

      function get isCentered() : Boolean;

      function get isModal() : Boolean;

      function get window() : IWindow;

      function set window(param1:IWindow) : void;

      function get geometry() : IWindowGeometry;
   }

}