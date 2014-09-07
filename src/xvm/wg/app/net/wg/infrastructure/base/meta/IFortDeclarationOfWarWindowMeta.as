package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortDeclarationOfWarWindowMeta extends IEventDispatcher
    {
        
        function onDirectonChosenS(param1:int) : void;
        
        function onDirectionSelectedS() : void;
        
        function as_setupHeader(param1:String, param2:String) : void;
        
        function as_setupClans(param1:Object, param2:Object) : void;
        
        function as_setDirections(param1:Array) : void;
        
        function as_selectDirection(param1:int) : void;
    }
}
