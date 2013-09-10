package scaleform.clik.interfaces 
{
    import flash.events.*;
    
    public interface IDataProvider
    {
        function get length():uint;

        function requestItemAt(arg1:uint, arg2:Function=null):Object;

        function requestItemRange(arg1:int, arg2:int, arg3:Function=null):Array;

        function indexOf(arg1:Object, arg2:Function=null):int;

        function cleanUp():void;

        function invalidate(arg1:uint=0):void;

        function addEventListener(arg1:String, arg2:Function, arg3:Boolean=false, arg4:int=0, arg5:Boolean=false):void;

        function removeEventListener(arg1:String, arg2:Function, arg3:Boolean=false):void;

        function dispatchEvent(arg1:flash.events.Event):Boolean;

        function hasEventListener(arg1:String):Boolean;

        function willTrigger(arg1:String):Boolean;
    }
}
