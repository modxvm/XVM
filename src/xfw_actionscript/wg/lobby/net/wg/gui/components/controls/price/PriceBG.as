package net.wg.gui.components.controls.price
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.Sprite;

    public class PriceBG extends MovieClip implements IDisposable
    {

        public var hit:Sprite = null;

        public function PriceBG()
        {
            super();
        }

        public function dispose() : void
        {
            this.hit = null;
        }
    }
}
