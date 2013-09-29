package net.wg.infrastructure.interfaces 
{
    import __AS3__.vec.*;
    
    public interface IContextMenu
    {
        function build(arg1:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>, arg2:Number, arg3:Number):void;

        function setMemberItemData(arg1:Object):void;
    }
}
