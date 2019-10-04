package net.wg.gui.lobby.epicBattles.components.infoView
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;

    public class TutorialLine extends Sprite implements IDisposable
    {

        public var lineTF:TextField = null;

        public function TutorialLine()
        {
            super();
        }

        public final function dispose() : void
        {
            this.lineTF = null;
        }
    }
}
