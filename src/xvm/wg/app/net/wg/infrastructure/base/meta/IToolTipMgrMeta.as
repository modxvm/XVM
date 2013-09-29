package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IToolTipMgrMeta extends flash.events.IEventDispatcher
    {
        function onCreateComplexTooltipS(arg1:String, arg2:String):void;

        function onCreateTypedTooltipS(arg1:String, arg2:Array, arg3:String):void;

        function as_show(arg1:Object, arg2:String):void;
    }
}
