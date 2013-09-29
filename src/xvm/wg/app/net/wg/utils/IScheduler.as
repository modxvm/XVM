package net.wg.utils 
{
    import net.wg.infrastructure.interfaces.entity.*;
    
    public interface IScheduler extends net.wg.infrastructure.interfaces.entity.IDisposable
    {
        function scheduleTask(arg1:Function, arg2:Number, ... rest):void;

        function envokeInNextFrame(arg1:Function, ... rest):void;

        function cancelTask(arg1:Function):void;

        function cancelAll():void;
    }
}
