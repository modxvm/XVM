package net.wg.utils
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    
    public interface IHelpLayout extends IDisposable
    {
        
        function create(param1:DisplayObject, param2:Object, param3:DisplayObjectContainer) : DisplayObject;
        
        function createBackground() : void;
        
        function destroyBackground() : void;
        
        function isShowed() : Boolean;
        
        function destroy(param1:DisplayObject) : void;
        
        function getProps(param1:Rectangle, param2:String, param3:String) : Object;
    }
}
