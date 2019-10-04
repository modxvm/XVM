package net.wg.gui.components.hintPanel
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;

    public class KeyViewer extends Sprite implements IDisposable
    {

        private static const TEXTFIELD_PADDING:int = 5;

        private static const KEY_LEFT_SIDE:int = 17;

        private static const KEY_RIGHT_SIDE:int = 17;

        public var keyTF:TextField = null;

        public var buttonBgMc:Sprite = null;

        public function KeyViewer()
        {
            super();
            this.keyTF.autoSize = TextFieldAutoSize.LEFT;
            this.keyTF.x = KEY_LEFT_SIDE;
        }

        public final function dispose() : void
        {
            this.keyTF = null;
            this.buttonBgMc = null;
        }

        public function setKey(param1:String) : void
        {
            this.keyTF.text = param1;
            this.keyTF.width = this.keyTF.textWidth + TEXTFIELD_PADDING | 0;
            this.buttonBgMc.width = this.keyTF.width + KEY_LEFT_SIDE + KEY_RIGHT_SIDE;
        }
    }
}
