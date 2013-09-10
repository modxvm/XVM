package net.wg.infrastructure.interfaces.entity 
{
    import __AS3__.vec.*;
    import flash.display.*;
    
    public interface IDroppable extends net.wg.infrastructure.interfaces.entity.IDragDropHitArea
    {
        function onBeforeDrop(arg1:flash.display.InteractiveObject, arg2:flash.display.InteractiveObject):void;

        function onStartDrop(arg1:flash.display.InteractiveObject, arg2:flash.display.InteractiveObject, arg3:Number, arg4:Number):void;

        function onEndDrop(arg1:flash.display.InteractiveObject, arg2:flash.display.InteractiveObject, arg3:flash.display.InteractiveObject):void;

        function onAfterDrop(arg1:flash.display.InteractiveObject, arg2:flash.display.InteractiveObject):void;

        function getDropGroup():__AS3__.vec.Vector.<flash.display.InteractiveObject>;
    }
}
