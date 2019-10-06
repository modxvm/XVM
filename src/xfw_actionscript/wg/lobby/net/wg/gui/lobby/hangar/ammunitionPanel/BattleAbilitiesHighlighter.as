package net.wg.gui.lobby.hangar.ammunitionPanel
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.MovieClip;
    import scaleform.clik.constants.InvalidationType;

    public class BattleAbilitiesHighlighter extends UIComponentEx
    {

        private static const ALERT_MC_EXTRA_WIDTH:int = 6;

        public var hit:MovieClip = null;

        public var alertMC:MovieClip = null;

        private var _originalAlertW:int = -1;

        public function BattleAbilitiesHighlighter()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._originalAlertW = this.alertMC.width;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.hit.width = _width;
                this.alertMC.scaleX = (_width + ALERT_MC_EXTRA_WIDTH) / this._originalAlertW;
            }
        }

        override protected function onDispose() : void
        {
            this.hit = null;
            this.alertMC = null;
            super.onDispose();
        }
    }
}
