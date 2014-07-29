package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IPopoverManagerMeta extends IEventDispatcher
    {
        
        function requestShowPopoverS(param1:String, param2:Number, param3:Number, param4:Object) : void;
        
        function requestHidePopoverS() : void;
        
        function as_onPopoverDestroy() : void;
    }
}
