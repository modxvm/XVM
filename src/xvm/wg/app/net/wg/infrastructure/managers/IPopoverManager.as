package net.wg.infrastructure.managers
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IPopOverCaller;
    import net.wg.infrastructure.interfaces.IClosePopoverCallback;
    
    public interface IPopoverManager extends IDisposable
    {
        
        function show(param1:IPopOverCaller, param2:String, param3:Object = null, param4:IClosePopoverCallback = null) : void;
        
        function hide() : void;
        
        function get popoverCaller() : IPopOverCaller;
    }
}
