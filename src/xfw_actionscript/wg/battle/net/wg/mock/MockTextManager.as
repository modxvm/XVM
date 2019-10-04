package net.wg.mock
{
    import net.wg.utils.ITextManager;
    import flash.text.TextField;

    public class MockTextManager extends Object implements ITextManager
    {

        public function MockTextManager()
        {
            super();
        }

        public function createTextField() : TextField
        {
            return null;
        }

        public function getTextStyleById(param1:String, param2:String) : String
        {
            return "";
        }

        public function setDefTextSelection(param1:TextField) : void
        {
        }
    }
}
