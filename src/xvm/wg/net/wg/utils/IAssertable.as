package net.wg.utils 
{
    public interface IAssertable
    {
        function assert(arg1:Boolean, arg2:String, arg3:Class=null):void;

        function assertNotNull(arg1:Object, arg2:String, arg3:Class=null):void;

        function assertNull(arg1:Object, arg2:String, arg3:Class=null):void;
    }
}
