package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDroppable;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.display.InteractiveObject;
   
   public interface IDropListDelegate extends IDroppable, IDisposable
   {
      
      function setPairedDropLists(param1:Vector.<InteractiveObject>) : void;
   }
}
