package net.wg.gui.lobby.fortifications.utils
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import flash.display.DisplayObject;
    
    public interface IFortsControlsAligner
    {
        
        function centerControl(param1:IUIComponentEx) : void;
        
        function rightControl(param1:DisplayObject, param2:Number) : void;
    }
}
