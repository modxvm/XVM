package net.wg.mock.utils
{
    import net.wg.utils.IVOManager;
    import net.wg.infrastructure.interfaces.IWalletStatusVO;

    public class MockVOManager extends Object implements IVOManager
    {

        public function MockVOManager()
        {
            super();
        }

        public function dispose() : void
        {
        }

        public function get walletStatusVO() : IWalletStatusVO
        {
            return null;
        }
    }
}
