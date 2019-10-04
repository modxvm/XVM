package net.wg.mock.utils
{
    import net.wg.utils.IStyleSheetManager;
    import flash.text.TextField;

    public class MockStyleSheetManager extends Object implements IStyleSheetManager
    {

        public function MockStyleSheetManager()
        {
            super();
        }

        public function setForceFocusedStyle(param1:String) : String
        {
            return "";
        }

        public function setLinkStyle(param1:TextField) : void
        {
        }
    }
}
