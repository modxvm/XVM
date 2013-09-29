package net.wg.utils 
{
    import flash.display.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public interface IHelpLayout extends net.wg.infrastructure.interfaces.entity.IDisposable
    {
        function create(arg1:flash.display.DisplayObject, arg2:Object, arg3:flash.display.DisplayObjectContainer):flash.display.DisplayObject;

        function createBackground():void;

        function destroyBackground():void;

        function isShowed():Boolean;

        function destroy(arg1:flash.display.DisplayObject):void;

        function getProps(arg1:Number, arg2:Number, arg3:String, arg4:String, arg5:Number, arg6:Number):Object;
    }
}
