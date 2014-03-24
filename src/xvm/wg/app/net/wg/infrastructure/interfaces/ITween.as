package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.base.meta.ITweenMeta;


   public interface ITween extends ITweenMeta, IDAAPIComponent
   {
          
      function setOnAnimComplete(param1:Function, param2:Object=null) : void;
   }

}