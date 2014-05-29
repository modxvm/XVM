package net.wg.infrastructure.interfaces
{
   import __AS3__.vec.Vector;


   public interface ITweenTypesDuration
   {
          
      function get types() : Vector.<String>;

      function set types(param1:Vector.<String>) : void;

      function get duration() : int;

      function set duration(param1:int) : void;
   }

}