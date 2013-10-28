package net.wg.gui.cyberSport.interfaces
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.entity.IDisposable;


   public interface IPerpageScrollList extends IEventDispatcher, IDisposable
   {
          
      function setData(param1:Array) : void;

      function appendData(param1:Array) : void;

      function setPagesMaximum(param1:uint) : void;
   }

}