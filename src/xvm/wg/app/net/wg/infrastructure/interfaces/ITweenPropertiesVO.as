package net.wg.infrastructure.interfaces
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.display.DisplayObject;


   public interface ITweenPropertiesVO extends IEventDispatcher, IDisposable
   {
          
      function get position() : int;

      function set position(param1:int) : void;

      function get duration() : int;

      function set duration(param1:int) : void;

      function get delay() : int;

      function set delay(param1:int) : void;

      function get target() : DisplayObject;

      function set target(param1:DisplayObject) : void;

      function get actionAfterRemoveFromStage() : String;

      function set actionAfterRemoveFromStage(param1:String) : void;

      function get loop() : Boolean;

      function set loop(param1:Boolean) : void;

      function get onComplete() : Function;

      function set onComplete(param1:Function) : void;

      function get paused() : Boolean;

      function set paused(param1:Boolean) : void;

      function get x() : Number;

      function set x(param1:Number) : void;

      function get y() : Number;

      function set y(param1:Number) : void;

      function get scaleX() : Number;

      function set scaleX(param1:Number) : void;

      function get scaleY() : Number;

      function set scaleY(param1:Number) : void;

      function get alpha() : Number;

      function set alpha(param1:Number) : void;

      function get rotation() : Number;

      function set rotation(param1:Number) : void;

      function get argsForOnComplete() : Object;

      function set argsForOnComplete(param1:Object) : void;
   }

}