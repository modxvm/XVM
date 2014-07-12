package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   
   public interface IViewStackContent extends IUpdatable, IFocusContainer
   {
      
      function canShowAutomatically() : Boolean;
   }
}
