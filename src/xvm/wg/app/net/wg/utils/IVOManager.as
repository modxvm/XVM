package net.wg.utils
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.IWalletStatusVO;
   
   public interface IVOManager extends IDisposable
   {
      
      function get walletStatusVO() : IWalletStatusVO;
   }
}
