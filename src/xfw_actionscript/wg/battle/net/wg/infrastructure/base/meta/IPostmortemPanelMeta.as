package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IPostmortemPanelMeta extends IEventDispatcher
    {

        function as_setDeadReasonInfo(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:String) : void;

        function as_showDeadReason() : void;

        function as_setPlayerInfo(param1:String) : void;
    }
}
