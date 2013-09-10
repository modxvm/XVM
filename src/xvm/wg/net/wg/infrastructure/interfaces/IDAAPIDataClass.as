package net.wg.infrastructure.interfaces 
{
    import net.wg.infrastructure.interfaces.entity.*;
    
    public interface IDAAPIDataClass extends net.wg.infrastructure.interfaces.entity.IDisposable
    {
        function fromHash(arg1:Object):void;

        function toHash():Object;
    }
}
