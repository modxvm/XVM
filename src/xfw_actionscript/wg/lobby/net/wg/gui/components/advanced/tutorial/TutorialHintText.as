package net.wg.gui.components.advanced.tutorial
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;

    public class TutorialHintText extends Sprite implements IDisposable
    {

        public var hintTF:TextField = null;

        public function TutorialHintText()
        {
            super();
        }

        public function dispose() : void
        {
            this.hintTF = null;
        }
    }
}
