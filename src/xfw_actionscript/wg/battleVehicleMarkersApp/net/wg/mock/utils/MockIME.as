package net.wg.mock.utils
{
    import net.wg.utils.IIME;
    import net.wg.infrastructure.interfaces.ISimpleManagedContainer;

    public class MockIME extends Object implements IIME
    {

        public function MockIME()
        {
            super();
        }

        public function dispose() : void
        {
        }

        public function getContainer() : ISimpleManagedContainer
        {
            return null;
        }

        public function init(param1:Boolean) : void
        {
        }

        public function onLangBarResize(param1:Number, param2:Number) : void
        {
        }

        public function setVisible(param1:Boolean) : void
        {
        }
    }
}
