package net.wg.infrastructure.managers
{
    import net.wg.infrastructure.base.meta.ILoaderManagerMeta;
    
    public interface ILoaderManager extends ILoaderManagerMeta
    {
        
        function stopLoadingByAliases(param1:Array) : Array;
    }
}
