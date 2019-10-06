package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IVehiclePreviewMeta extends IEventDispatcher
    {

        function closeViewS() : void;

        function onBackClickS() : void;

        function onBuyOrResearchClickS() : void;

        function onOpenInfoTabS(param1:int) : void;

        function onCompareClickS() : void;

        function as_setStaticData(param1:Object) : void;

        function as_updateInfoData(param1:Object) : void;

        function as_updateVehicleStatus(param1:String) : void;

        function as_updateBuyingPanel(param1:Object) : void;
    }
}
