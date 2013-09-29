package net.wg.infrastructure.interfaces 
{
    public interface IDAAPIComponent extends net.wg.infrastructure.interfaces.IDAAPIModule
    {
        function registerFlashComponentS(arg1:net.wg.infrastructure.interfaces.IDAAPIModule, arg2:String):void;

        function unregisterFlashComponentS(arg1:String):void;
    }
}
