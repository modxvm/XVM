package net.wg.infrastructure.managers
{
    import net.wg.infrastructure.base.meta.IContextMenuManagerMeta;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.interfaces.IContextMenuListener;
    import net.wg.infrastructure.interfaces.IContextMenu;
    import net.wg.infrastructure.interfaces.IContextItem;
    import net.wg.infrastructure.interfaces.IUserContextMenuGenerator;
    
    public interface IContextMenuManager extends IContextMenuManagerMeta, IDisposable
    {
        
        function showNewWrapper(param1:String, param2:String, param3:DisplayObject, param4:Object = null, param5:IContextMenuListener = null) : void;
        
        function showNew(param1:String, param2:String, param3:DisplayObject, param4:Object = null) : void;
        
        function show(param1:Vector.<IContextItem>, param2:DisplayObject, param3:Function = null, param4:Object = null) : IContextMenu;
        
        function showUserContextMenu(param1:DisplayObject, param2:Object, param3:IUserContextMenuGenerator, param4:Function = null) : IContextMenu;
        
        function hide() : void;
        
        function canGiveLeadershipTo(param1:Number) : Boolean;
        
        function canInviteThe(param1:Number) : Boolean;
        
        function showFortificationCtxMenu(param1:DisplayObject, param2:Vector.<IContextItem>, param3:Object = null) : IContextMenu;
    }
}
