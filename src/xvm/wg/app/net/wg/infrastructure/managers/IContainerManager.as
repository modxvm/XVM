package net.wg.infrastructure.managers
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.base.meta.ILoaderManagerMeta;
   import net.wg.infrastructure.interfaces.IManagedContainer;
   import net.wg.infrastructure.interfaces.IView;


   public interface IContainerManager extends IEventDispatcher
   {
      function get loader():ILoaderManagerMeta;
      function set loader(param1:ILoaderManagerMeta) : void;

      function registerContainer(param1:IManagedContainer) : void;

      function updateStage(param1:Number, param2:Number) : void;

      function get lastFocusedView() : IView;

      function set lastFocusedView(param1:IView) : void;
   }

}