package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDroppable;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import __AS3__.vec.Vector;
   import flash.display.InteractiveObject;


   public interface IDragDropListDelegate extends IDroppable, IDisposable
   {
          
      function setPairedDropLists(param1:Vector.<InteractiveObject>) : void;
   }

}