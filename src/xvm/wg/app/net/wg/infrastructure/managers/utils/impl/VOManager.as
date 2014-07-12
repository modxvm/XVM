package net.wg.infrastructure.managers.utils.impl
{
    import net.wg.utils.IVOManager;
    import net.wg.infrastructure.interfaces.IWalletStatusVO;
    import net.wg.data.VO.WalletStatusVO;
    
    public class VOManager extends Object implements IVOManager
    {
        
        public function VOManager() {
            super();
            this._walletStatusVO = new WalletStatusVO();
        }
        
        private var _walletStatusVO:IWalletStatusVO;
        
        public function dispose() : void {
            this._walletStatusVO.dispose();
            this._walletStatusVO = null;
        }
        
        public function get walletStatusVO() : IWalletStatusVO {
            return this._walletStatusVO;
        }
    }
}
