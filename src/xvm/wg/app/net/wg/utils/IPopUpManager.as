package net.wg.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public interface IPopUpManager
   {
      
      function show(param1:DisplayObject, param2:Number = 0, param3:Number = 0, param4:DisplayObjectContainer = null) : void;
      
      function create(param1:String, param2:Object, param3:DisplayObjectContainer = null) : DisplayObject;
      
      function remove(param1:DisplayObject) : void;
      
      function removeAll() : void;
      
      function contains(param1:DisplayObject) : Boolean;
      
      function get popupCanvas() : DisplayObjectContainer;
   }
}
