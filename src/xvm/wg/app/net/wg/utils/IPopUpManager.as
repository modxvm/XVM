package net.wg.utils 
{
    import flash.display.*;
    
    public interface IPopUpManager
    {
        function show(arg1:flash.display.DisplayObject, arg2:Number=0, arg3:Number=0, arg4:flash.display.DisplayObjectContainer=null):void;

        function create(arg1:String, arg2:Object, arg3:flash.display.DisplayObjectContainer=null):flash.display.DisplayObject;

        function remove(arg1:flash.display.DisplayObject):void;

        function removeAll():void;

        function contains(arg1:flash.display.DisplayObject):Boolean;

        function get popupCanvas():flash.display.DisplayObjectContainer;
    }
}
