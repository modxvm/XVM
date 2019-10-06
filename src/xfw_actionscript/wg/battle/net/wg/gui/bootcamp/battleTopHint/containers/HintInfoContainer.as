package net.wg.gui.bootcamp.battleTopHint.containers
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;

    public class HintInfoContainer extends Sprite implements IDisposable
    {

        public var txt:TextField = null;

        public function HintInfoContainer()
        {
            super();
            this.txt.autoSize = TextFieldAutoSize.CENTER;
        }

        public final function dispose() : void
        {
            this.txt = null;
        }

        public function setHintText(param1:String) : void
        {
            this.txt.text = param1;
        }
    }
}
