package net.wg.infrastructure.managers
{
   import net.wg.infrastructure.base.meta.IWaitingViewMeta;


   public interface IWaitingView extends IWaitingViewMeta
   {
          
      function get isVisible() : Boolean;
   }

}