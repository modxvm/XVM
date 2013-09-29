package net.wg.infrastructure.interfaces.entity 
{
    public interface IDraggable extends net.wg.infrastructure.interfaces.entity.IDragDropHitArea
    {
        function onStartDrag():void;

        function onDragging(arg1:Number, arg2:Number):void;

        function onEndDrag():void;

        function getDragType():String;
    }
}
