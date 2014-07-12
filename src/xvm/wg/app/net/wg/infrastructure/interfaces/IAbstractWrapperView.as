package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.base.meta.IWrapperViewMeta;
   
   public interface IAbstractWrapperView extends IWrapperViewMeta, IView
   {
      
      function get wrapperLinkage() : String;
      
      function set wrapper(param1:IWrapper) : void;
      
      function get wrapper() : IWrapper;
   }
}
