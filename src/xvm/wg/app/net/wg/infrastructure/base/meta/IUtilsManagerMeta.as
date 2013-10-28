package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IUtilsManagerMeta extends IEventDispatcher
   {
          
      function getNationNamesS() : Array;

      function getNationIndicesS() : Object;

      function getGUINationsS() : Array;
   }

}