package net.wg.gui.battle.pveEvent.components.eventTimer.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.data.constants.InvalidationType;
    import flash.text.TextField;

    public class TimerPhase extends UIComponentEx
    {

        private static const SCORE_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

        public var numTf:TextField = null;

        public var totalTf:TextField = null;

        private var _score:int = -1;

        private var _total:int = -1;

        public function TimerPhase()
        {
            super();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(SCORE_VALIDATION))
            {
                this.numTf.text = this._score.toString();
                this.totalTf.text = this._total.toString();
            }
        }

        override protected function onDispose() : void
        {
            this.numTf = null;
            this.totalTf = null;
            super.onDispose();
        }

        public function setProgress(param1:int, param2:int) : void
        {
            if(this._score != param1 || this._total != param2)
            {
                this._score = param1;
                this._total = param2;
                invalidate(SCORE_VALIDATION);
            }
        }
    }
}
