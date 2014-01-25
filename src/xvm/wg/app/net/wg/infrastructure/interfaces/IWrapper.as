package net.wg.infrastructure.interfaces
{


   public interface IWrapper extends IManagedContent
   {
          
      function set wrapperContent(param1:IAbstractWrapperView) : void;

      function get wrapperContent() : IAbstractWrapperView;
   }

}