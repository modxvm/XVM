package net.wg.infrastructure.interfaces
{
   import flash.events.IEventDispatcher;
   import flash.display.DisplayObject;
   
   public interface IManagedContainer extends IEventDispatcher
   {
      
      function updateStage(param1:Number, param2:Number) : void;
      
      function tryToSetFocus(param1:Boolean = false) : Boolean;
      
      function tryToUpdateContent() : void;
      
      function setFocusedView(param1:IManagedContent) : void;
      
      function getTopmostView() : IManagedContent;
      
      function addChild(param1:DisplayObject) : DisplayObject;
      
      function removeChild(param1:DisplayObject) : DisplayObject;
      
      function contains(param1:DisplayObject) : Boolean;
      
      function get type() : String;
      
      function set type(param1:String) : void;
      
      function get manageSize() : Boolean;
      
      function set manageSize(param1:Boolean) : void;
   }
}
