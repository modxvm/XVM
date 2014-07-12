package scaleform.clik.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IScrollBar extends IUIComponent, IDisposable
   {
      
      function get position() : Number;
      
      function set position(param1:Number) : void;
   }
}
