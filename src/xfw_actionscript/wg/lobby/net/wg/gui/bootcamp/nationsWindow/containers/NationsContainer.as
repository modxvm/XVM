package net.wg.gui.bootcamp.nationsWindow.containers
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class NationsContainer extends MovieClip implements IDisposable
    {

        public var maskSquare:MovieClip = null;

        public function NationsContainer()
        {
            super();
        }

        override public function get height() : Number
        {
            return this.maskSquare.height;
        }

        override public function get width() : Number
        {
            return this.maskSquare.width;
        }

        public final function dispose() : void
        {
            this.maskSquare = null;
        }
    }
}
