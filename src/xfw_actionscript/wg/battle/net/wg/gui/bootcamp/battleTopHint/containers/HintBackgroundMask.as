package net.wg.gui.bootcamp.battleTopHint.containers
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class HintBackgroundMask extends MovieClip implements IDisposable
    {

        public var mc:MovieClip = null;

        public function HintBackgroundMask()
        {
            super();
        }

        public final function dispose() : void
        {
            this.mc = null;
        }

        public function updateBackground(param1:int, param2:int) : void
        {
            this.mc.width = param1;
            this.mc.x = param2;
        }
    }
}
