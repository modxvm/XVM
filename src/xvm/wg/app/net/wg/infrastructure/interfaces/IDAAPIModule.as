package net.wg.infrastructure.interfaces 
{
    import net.wg.infrastructure.base.meta.*;
    
    public interface IDAAPIModule extends net.wg.infrastructure.base.meta.IBaseDAAPIModuleMeta
    {
        function get disposed():Boolean;
    }
}
