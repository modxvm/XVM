package net.wg.utils
{
   public interface IClassFactory
   {
      
      function getClass(param1:String) : Class;
      
      function getObject(param1:String, param2:Object = null) : Object;
      
      function getComponent(param1:String, param2:Class, param3:Object = null) : *;
   }
}
