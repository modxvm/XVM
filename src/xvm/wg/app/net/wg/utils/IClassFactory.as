package net.wg.utils 
{
    public interface IClassFactory
    {
        function getClass(arg1:String):Class;

        function getObject(arg1:String, arg2:Object=null):Object;

        function getComponent(arg1:String, arg2:Class, arg3:Object=null):*;
    }
}
