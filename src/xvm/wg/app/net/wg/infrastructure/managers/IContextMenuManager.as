package net.wg.infrastructure.managers 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public interface IContextMenuManager extends net.wg.infrastructure.interfaces.entity.IDisposable
    {
        function show(arg1:__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>, arg2:flash.display.DisplayObject, arg3:Function=null, arg4:Object=null):net.wg.infrastructure.interfaces.IContextMenu;

        function showUserContextMenu(arg1:flash.display.DisplayObject, arg2:Object, arg3:net.wg.infrastructure.interfaces.IUserContextMenuGenerator, arg4:Function=null):net.wg.infrastructure.interfaces.IContextMenu;

        function hide():void;
    }
}
