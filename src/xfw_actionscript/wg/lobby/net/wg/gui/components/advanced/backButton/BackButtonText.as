package net.wg.gui.components.advanced.backButton
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;

    public class BackButtonText extends Sprite implements IDisposable
    {

        public var textField:TextField = null;

        public function BackButtonText()
        {
            super();
        }

        public function dispose() : void
        {
            this.textField = null;
        }
    }
}
