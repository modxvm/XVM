package scaleform.clik.interfaces 
{
    import net.wg.infrastructure.interfaces.entity.*;
    
    public interface IScrollBar extends scaleform.clik.interfaces.IUIComponent, net.wg.infrastructure.interfaces.entity.IDisposable
    {
        function get position():Number;

        function set position(arg1:Number):void;
    }
}
