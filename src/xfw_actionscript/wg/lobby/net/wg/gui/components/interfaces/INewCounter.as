package net.wg.gui.components.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObject;
    import flash.geom.Point;

    public interface INewCounter extends IDisposable
    {

        function setTarget(param1:DisplayObject, param2:String, param3:Point = null, param4:String = null, param5:Boolean = true, param6:Number = 0) : void;

        function updateHorizontalAlign(param1:String) : void;

        function updatePosition(param1:Point) : void;

        function setCount(param1:String) : void;
    }
}
