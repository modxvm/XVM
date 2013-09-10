package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IColorSchemeManagerMeta extends flash.events.IEventDispatcher
    {
        function getColorSchemeS(arg1:String):Object;

        function as_update():void;
    }
}
