package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IReferralManagementWindowMeta extends IEventDispatcher
    {
        
        function onInvitesManagementLinkClickS() : void;
        
        function inviteIntoSquadS(param1:Number) : void;
        
        function as_setData(param1:Object) : void;
        
        function as_setTableData(param1:Array) : void;
        
        function as_setProgressData(param1:Object) : void;
    }
}
