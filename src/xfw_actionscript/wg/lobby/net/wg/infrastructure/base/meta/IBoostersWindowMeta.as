package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IBoostersWindowMeta extends IEventDispatcher
    {

        function requestBoostersArrayS(param1:int) : void;

        function onBoosterActionBtnClickS(param1:Number, param2:String) : void;

        function onFiltersChangeS(param1:int) : void;

        function onResetFiltersS() : void;

        function as_setData(param1:Object) : void;

        function as_setStaticData(param1:Object) : void;

        function as_setListData(param1:Array, param2:Boolean) : void;
    }
}
