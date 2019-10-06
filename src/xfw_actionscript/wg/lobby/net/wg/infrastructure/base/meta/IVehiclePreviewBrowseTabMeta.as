package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IVehiclePreviewBrowseTabMeta extends IEventDispatcher
    {

        function setActiveStateS(param1:Boolean) : void;

        function as_setData(param1:String, param2:Boolean, param3:Array) : void;
    }
}
