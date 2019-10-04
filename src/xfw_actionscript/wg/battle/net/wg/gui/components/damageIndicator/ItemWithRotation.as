package net.wg.gui.components.damageIndicator
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;

    public class ItemWithRotation extends MovieClip implements IDisposable
    {

        public var textField:TextField = null;

        public function ItemWithRotation()
        {
            super();
        }

        public function dispose() : void
        {
            this.textField = null;
        }
    }
}
