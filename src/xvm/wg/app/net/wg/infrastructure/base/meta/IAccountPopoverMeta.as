package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IAccountPopoverMeta extends IEventDispatcher
    {
        
        function openProfileS() : void;
        
        function openClanStatisticS() : void;
        
        function openCrewStatisticS() : void;
        
        function openReferralManagementS() : void;
        
        function as_setData(param1:Object, param2:Boolean, param3:Array, param4:Boolean, param5:Object, param6:Object) : void;
        
        function as_setClanEmblem(param1:String) : void;
        
        function as_setCrewEmblem(param1:String) : void;
        
        function as_setReferralData(param1:Object) : void;
    }
}
