package net.wg.infrastructure.interfaces 
{
    import flash.display.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public interface ICursor extends net.wg.infrastructure.base.meta.ICursorMeta, net.wg.infrastructure.interfaces.IView
    {
        function useResizeCursor(arg1:flash.display.InteractiveObject):void;

        function unUseResizeCursor(arg1:flash.display.InteractiveObject):void;

        function registerDragging(arg1:net.wg.infrastructure.interfaces.entity.IDragDropHitArea, arg2:String=null):void;

        function unRegisterDragging(arg1:net.wg.infrastructure.interfaces.entity.IDragDropHitArea):void;

        function attachToCursor(arg1:flash.display.Sprite, arg2:Number, arg3:Number):void;

        function getAttachedSprite():flash.display.Sprite;

        function detachFromCursor():void;

        function resetCursor():void;

        function setCursor(arg1:String):void;
    }
}
