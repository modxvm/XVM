package net.wg.infrastructure.interfaces
{
   import scaleform.clik.interfaces.IUIComponent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IDisplayable;


   public interface IUIComponentEx extends IUIComponent, IDisposable, IDisplayable
   {
          
      function get name() : String;
   }

}