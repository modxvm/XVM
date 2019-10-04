package net.wg.gui.battle.views.battleEndWarning.containers
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;

    public class Timer extends Sprite implements IDisposable
    {

        public var infoText:TextField = null;

        public var timeText:TextField = null;

        public function Timer()
        {
            super();
            this.infoText.autoSize = TextFieldAutoSize.LEFT;
        }

        public function dispose() : void
        {
            this.infoText = null;
            this.timeText = null;
        }
    }
}
