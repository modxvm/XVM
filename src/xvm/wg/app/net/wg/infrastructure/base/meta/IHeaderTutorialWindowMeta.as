package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IHeaderTutorialWindowMeta extends IEventDispatcher
    {
        
        function goNextStepS() : void;
        
        function goPrevStepS() : void;
        
        function setStepS(param1:int) : void;
        
        function requestToLeaveS() : void;
        
        function as_setData(param1:Object) : void;
    }
}
