package net.wg.infrastructure.interfaces
{
   public interface IDAAPIComponent extends IDAAPIModule
   {
      
      function registerFlashComponentS(param1:IDAAPIModule, param2:String) : void;
      
      function unregisterFlashComponentS(param1:String) : void;
   }
}
