package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IDAAPIEntity;
   
   public interface IDAAPIDataClass extends IDisposable, IDAAPIEntity
   {
      
      function fromHash(param1:Object) : void;
      
      function toHash() : Object;
   }
}
