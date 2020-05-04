package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface ISE20BannerMeta extends IEventDispatcher
    {

        function onClickS() : void;

        function as_show(param1:Boolean, param2:Boolean) : void;

        function as_setData(param1:Object) : void;
    }
}
