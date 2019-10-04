package net.wg.gui.lobby.sessionStats.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;

    public class SessionStatsAnimatedNumberCounter extends Sprite implements IDisposable
    {

        public var txt:TextField = null;

        public function SessionStatsAnimatedNumberCounter()
        {
            super();
            this.txt.autoSize = TextFieldAutoSize.LEFT;
            this.txt.multiline = true;
        }

        public function set text(param1:String) : void
        {
            this.txt.htmlText = param1;
        }

        public final function dispose() : void
        {
            this.txt = null;
        }
    }
}
