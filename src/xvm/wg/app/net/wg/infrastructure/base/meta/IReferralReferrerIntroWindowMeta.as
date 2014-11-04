package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IReferralReferrerIntroWindowMeta extends IEventDispatcher
    {
        
        function onClickApplyButtonS() : void;
        
        function onClickHrefLinkS() : void;
        
        function as_setData(param1:Object) : void;
    }
}
