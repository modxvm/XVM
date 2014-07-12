package net.wg.gui.lobby.fortifications.cmp
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.base.meta.IFortMainViewMeta;
   import net.wg.gui.lobby.fortifications.cmp.main.IMainHeader;
   import net.wg.gui.lobby.fortifications.cmp.main.IMainFooter;
   import net.wg.gui.lobby.fortifications.cmp.build.IFortBuildingCmp;
   
   public interface IFortMainView extends IUIComponentEx, IViewStackContent, IFortMainViewMeta
   {
      
      function get header() : IMainHeader;
      
      function set header(param1:IMainHeader) : void;
      
      function get footer() : IMainFooter;
      
      function set footer(param1:IMainFooter) : void;
      
      function get buildings() : IFortBuildingCmp;
      
      function set buildings(param1:IFortBuildingCmp) : void;
   }
}
