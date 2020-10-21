package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventStylesShopTabMeta extends IEventDispatcher
    {

        function closeViewS() : void;

        function onTankClickS(param1:int) : void;

        function onBannerClickS(param1:int) : void;

        function as_setData(param1:Object) : void;

        function as_setVisible(param1:Boolean) : void;
    }
}
