package net.wg.gui.login 
{
    import flash.geom.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public interface ISparksManager extends net.wg.infrastructure.interfaces.entity.IDisposable
    {
        function resetZone(arg1:flash.geom.Rectangle):void;

        function createSparks():void;
    }
}
