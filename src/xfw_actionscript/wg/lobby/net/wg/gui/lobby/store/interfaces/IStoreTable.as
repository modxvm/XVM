package net.wg.gui.lobby.store.interfaces
{
    import net.wg.infrastructure.base.meta.IStoreTableMeta;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import net.wg.infrastructure.interfaces.IUIComponentEx;

    public interface IStoreTable extends IStoreTableMeta, IDAAPIModule, IUIComponentEx
    {

        function setVehicleRendererLinkage(param1:String) : void;

        function setModuleRendererLinkage(param1:String) : void;

        function updateHeaderCountTitle(param1:String) : void;

        function updateVehicleCompareAvailable(param1:Boolean) : void;

        function updateTradeInAvailable(param1:Boolean) : void;

        function updateActionAvailable(param1:Boolean) : void;

        function set scrollPosition(param1:int) : void;

        function get isViewVisible() : Boolean;

        function set isViewVisible(param1:Boolean) : void;
    }
}
