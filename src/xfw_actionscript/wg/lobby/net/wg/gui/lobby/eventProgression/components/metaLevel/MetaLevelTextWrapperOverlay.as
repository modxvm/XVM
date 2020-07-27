package net.wg.gui.lobby.eventProgression.components.metaLevel
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;

    public class MetaLevelTextWrapperOverlay extends MovieClip implements IDisposable
    {

        public var tf:TextField;

        public var eraser:MovieClip;

        public function MetaLevelTextWrapperOverlay()
        {
            super();
        }

        public final function dispose() : void
        {
            this.tf = null;
            this.eraser = null;
        }

        public function updateSize() : void
        {
            if(this.eraser)
            {
                this.eraser.width = this.tf.width;
                this.eraser.height = this.tf.height;
            }
        }
    }
}
