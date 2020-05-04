package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.MovieClip;

    public class ClipContainer extends ResultAppearMovieClip implements IDisposable
    {

        private static const PERSONAl_FRAME:int = 1;

        private static const CREW_FRAME:int = 2;

        public var mc:MovieClip = null;

        public function ClipContainer()
        {
            super();
        }

        public function init(param1:Boolean) : void
        {
            this.mc.gotoAndStop(param1?CREW_FRAME:PERSONAl_FRAME);
        }

        public final function dispose() : void
        {
            this.mc = null;
        }
    }
}
