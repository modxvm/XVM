package net.wg.infrastructure.interfaces
{
   import flash.events.IEventDispatcher;
   import scaleform.clik.interfaces.IUIComponent;
   import flash.display.Loader;
   import flash.display.DisplayObject;


   public interface IView extends IDAAPIModule, IEventDispatcher, IUIComponent
   {
          
      function get as_token() : String;

      function set as_token(param1:String) : void;

      function get as_alias() : String;

      function set as_alias(param1:String) : void;

      function get as_name() : String;

      function set as_name(param1:String) : void;

      function get as_config() : Object;

      function set as_config(param1:Object) : void;

      function get loader() : Loader;

      function set loader(param1:Loader) : void;

      function getSubContainer() : IManagedContainer;

      function playShowTween(param1:DisplayObject, param2:Function=null) : Boolean;

      function playHideTween(param1:DisplayObject, param2:Function=null) : Boolean;

      function setFocus() : void;

      function removeFocus() : void;

      function setViewSize(param1:Number, param2:Number) : void;

      function updateStage(param1:Number, param2:Number) : void;
   }

}