package net.wg.utils
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    
    public interface IHelpLayout extends IDisposable
    {
        
        function create(param1:DisplayObject, param2:Object, param3:DisplayObjectContainer) : DisplayObject;
        
        function createBackground() : void;
        
        function destroyBackground() : void;
        
        function isShowed() : Boolean;
        
        function destroy(param1:DisplayObject) : void;
        
        function getProps(param1:Number, param2:Number, param3:String, param4:String, param5:Number, param6:Number, param7:Number) : Object;
        
        function get defConnectorLength() : Number;
    }
}
