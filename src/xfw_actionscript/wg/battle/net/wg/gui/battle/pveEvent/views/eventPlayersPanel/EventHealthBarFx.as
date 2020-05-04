package net.wg.gui.battle.pveEvent.views.eventPlayersPanel
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.common.FrameStateCmpnt;

    public class EventHealthBarFx extends MovieClip implements IDisposable
    {

        private static const SQUAD_LABEL:String = "squad";

        private static const REGULAR_LABEL:String = "regular";

        private static const FX_FRAME:int = 2;

        public var barFX:FrameStateCmpnt = null;

        public function EventHealthBarFx()
        {
            super();
        }

        public function setSquadState(param1:Boolean) : void
        {
            this.barFX.frameLabel = param1?SQUAD_LABEL:REGULAR_LABEL;
        }

        public function playAnim() : void
        {
            gotoAndPlay(FX_FRAME);
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        private function onDispose() : void
        {
            this.barFX.dispose();
            this.barFX = null;
        }
    }
}
