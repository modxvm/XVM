package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortCreateDirectionWindowMeta extends IEventDispatcher
    {
        
        function openNewDirectionS() : void;
        
        function closeDirectionS(param1:Number) : void;
        
        function as_setDescription(param1:String) : void;
        
        function as_setupButton(param1:Boolean, param2:Boolean, param3:String, param4:String) : void;
        
        function as_setDirections(param1:Array) : void;
    }
}
