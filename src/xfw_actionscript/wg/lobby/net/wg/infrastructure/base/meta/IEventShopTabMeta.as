package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventShopTabMeta extends IEventDispatcher
    {

        function closeViewS() : void;

        function onItemsBannerClickS() : void;

        function onMainBannerClickS() : void;

        function onPackBannerClickS(param1:int) : void;

        function as_setPackBannersData(param1:Object, param2:Object) : void;

        function as_setVisible(param1:Boolean) : void;

        function as_setExpireDate(param1:String) : void;
    }
}
