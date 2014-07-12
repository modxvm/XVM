package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IWalletStatusVO extends IDisposable, IGlobalVO
   {
      
      function set goldStatus(param1:uint) : void;
      
      function get goldStatus() : uint;
      
      function set freeXpStatus(param1:uint) : void;
      
      function get freeXpStatus() : uint;
   }
}
