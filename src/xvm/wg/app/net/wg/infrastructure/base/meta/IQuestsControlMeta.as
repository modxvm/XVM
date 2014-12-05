package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IQuestsControlMeta extends IEventDispatcher
    {
        
        function showQuestsWindowS() : void;
        
        function as_isShowAlertIcon(param1:Boolean, param2:Boolean) : void;
        
        function as_setData(param1:Object) : void;
    }
}
