package net.wg.gui.bootcamp.battleTopHint.containers
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class HintBackground extends MovieClip implements IDisposable
    {

        private static const WIDTH_CENTER_OFFSET:int = 972;

        private static const BACK_BORDER:int = 2;

        public var bgMask:HintBackgroundMask = null;

        public var bg:MovieClip = null;

        public function HintBackground()
        {
            super();
        }

        public final function dispose() : void
        {
            if(this.bgMask)
            {
                this.bgMask.dispose();
                this.bgMask = null;
            }
            this.bg = null;
        }

        public function updateStage(param1:int, param2:int) : void
        {
            this.bg.x = -(param1 - WIDTH_CENTER_OFFSET >> 1);
            this.bg.width = param1 + BACK_BORDER;
            if(this.bgMask)
            {
                this.bgMask.updateBackground(this.bg.width,this.bg.x);
            }
        }
    }
}
