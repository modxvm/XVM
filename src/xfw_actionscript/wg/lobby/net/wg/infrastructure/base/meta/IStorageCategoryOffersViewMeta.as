package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IStorageCategoryOffersViewMeta extends IEventDispatcher
    {

        function navigateToStoreS() : void;

        function openOfferWindowS(param1:int) : void;

        function as_setTotalClicksText(param1:String) : void;
    }
}
