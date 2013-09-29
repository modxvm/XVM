package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    import net.wg.infrastructure.interfaces.*;
    
    public interface ILoaderManagerMeta extends flash.events.IEventDispatcher
    {
        function viewLoadedS(arg1:String, arg2:net.wg.infrastructure.interfaces.IView):void;

        function viewLoadErrorS(arg1:String, arg2:String, arg3:String):void;

        function viewInitializationErrorS(arg1:String, arg2:Object, arg3:String):void;

        function as_loadView(arg1:Object, arg2:String, arg3:String, arg4:String):void;
    }
}
