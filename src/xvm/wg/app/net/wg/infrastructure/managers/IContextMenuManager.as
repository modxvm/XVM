package net.wg.infrastructure.managers
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IContextMenu;
    import net.wg.infrastructure.interfaces.IContextItem;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.interfaces.IUserContextMenuGenerator;
    import net.wg.data.daapi.ContextMenuVehicleVo;
    import net.wg.infrastructure.interfaces.IVehicleContextMenuGenerator;
    
    public interface IContextMenuManager extends IDisposable
    {
        
        function show(param1:Vector.<IContextItem>, param2:DisplayObject, param3:Function = null, param4:Object = null) : IContextMenu;
        
        function showUserContextMenu(param1:DisplayObject, param2:Object, param3:IUserContextMenuGenerator, param4:Function = null) : IContextMenu;
        
        function showVehicleContextMenu(param1:DisplayObject, param2:ContextMenuVehicleVo, param3:IVehicleContextMenuGenerator, param4:Function = null) : IContextMenu;
        
        function hide() : void;
        
        function getContextMenuVehicleDataByInvCD(param1:Number) : Object;
        
        function canGiveLeadershipTo(param1:Number) : Boolean;
        
        function canInviteThe(param1:Number) : Boolean;
        
        function showFortificationCtxMenu(param1:DisplayObject, param2:Vector.<IContextItem>, param3:Object = null) : IContextMenu;
    }
}
