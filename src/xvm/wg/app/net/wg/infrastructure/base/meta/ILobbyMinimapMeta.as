package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface ILobbyMinimapMeta extends IEventDispatcher
    {
        
        function as_changeMap(param1:String) : void;
        
        function as_addPoint(param1:Number, param2:Number, param3:String, param4:String, param5:String) : void;
        
        function as_clear() : void;
    }
}
