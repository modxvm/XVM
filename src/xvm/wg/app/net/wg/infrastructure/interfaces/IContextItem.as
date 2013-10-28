package net.wg.infrastructure.interfaces
{
   import __AS3__.vec.Vector;


   public interface IContextItem
   {
          
      function get id() : String;

      function get label() : String;

      function get submenu() : Vector.<IContextItem>;

      function get initData() : Object;
   }

}