package net.wg.infrastructure.managers 
{
    public interface IEnvironmentManager
    {
        function quit():void;

        function logoff():void;

        function useEventSystem():void;

        function useExternallInterface():void;

        function addCallback(arg1:String, arg2:Function):void;

        function call(... rest):*;

        function envoke(arg1:String):*;

        function setLastResult(arg1:Object):void;
    }
}
