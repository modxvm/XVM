package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;


   public interface IDAAPIDataClass extends IDisposable
   {
          
      function fromHash(param1:Object) : void;

      function toHash() : Object;
   }

}