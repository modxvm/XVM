package net.wg.infrastructure.helpers
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.display.DisplayObjectContainer;
   
   public interface ILibraryLoader extends IDisposable
   {
      
      function init(param1:DisplayObjectContainer) : void;
      
      function load(param1:Vector.<String>) : void;
   }
}
