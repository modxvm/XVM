package net.wg.gui.lobby.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;

    public class TextWrapper extends MovieClip implements IDisposable
    {

        public var tf:TextField = null;

        public function TextWrapper()
        {
            super();
        }

        public final function dispose() : void
        {
            this.tf = null;
        }

        public function updateTextWidth(param1:Number) : void
        {
            this.tf.width = param1;
        }
    }
}
