package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventStylesTradeMeta extends IEventDispatcher
    {

        function closeViewS() : void;

        function onBackClickS() : void;

        function onBuyClickS() : void;

        function onUseClickS() : void;

        function showBlurS() : void;

        function hideBlurS() : void;

        function onBannerClickS(param1:int) : void;

        function onSelectS(param1:int) : void;

        function onBundleClickS() : void;

        function as_setData(param1:Object) : void;

        function as_getDataProvider() : Object;

        function as_setVisible(param1:Boolean) : void;
    }
}
