package net.wg.infrastructure.interfaces 
{
    import __AS3__.vec.*;
    
    public interface IContextItem
    {
        function get id():String;

        function get label():String;

        function get submenu():__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>;

        function get initData():Object;
    }
}
