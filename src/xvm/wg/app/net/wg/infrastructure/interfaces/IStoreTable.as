package net.wg.infrastructure.interfaces
{
    import net.wg.infrastructure.base.meta.IStoreTableMeta;
    
    public interface IStoreTable extends IStoreTableMeta, IDAAPIModule, IUIComponentEx
    {
        
        function setVehicleRendererLinkage(param1:String) : void;
        
        function setModuleRendererLinkage(param1:String) : void;
        
        function updateHeaderCountTitle(param1:String) : void;
        
        function get rightOrientedCount() : Boolean;
        
        function set rightOrientedCount(param1:Boolean) : void;
    }
}
