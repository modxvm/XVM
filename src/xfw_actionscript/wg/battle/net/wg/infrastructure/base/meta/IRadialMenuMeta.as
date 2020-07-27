package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IRadialMenuMeta extends IEventDispatcher
    {

        function onSelectS() : void;

        function onActionS(param1:String) : void;

        function onHideCompletedS() : void;

        function as_buildData(param1:Array) : void;

        function as_show(param1:String, param2:Array, param3:Array) : void;

        function as_hide(param1:Boolean) : void;
    }
}
