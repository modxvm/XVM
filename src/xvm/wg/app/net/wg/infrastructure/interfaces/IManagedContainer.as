package net.wg.infrastructure.interfaces
{
   import flash.events.IEventDispatcher;
   import flash.display.DisplayObject;


   public interface IManagedContainer extends IEventDispatcher
   {
          
      function get type() : String;

      function set type(param1:String) : void;

      function get manageSize() : Boolean;

      function set manageSize(param1:Boolean) : void;

      function updateStage(param1:Number, param2:Number) : void;

      function setFocused(param1:Boolean=false) : Boolean;

      function setFocusedView(param1:DisplayObject) : void;

      function addChild(param1:DisplayObject) : DisplayObject;

      function removeChild(param1:DisplayObject) : DisplayObject;

      function contains(param1:DisplayObject) : Boolean;
   }

}