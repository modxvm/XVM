package net.wg.gui.battle.pveEvent.views.eventPlayersPanel
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import net.wg.gui.components.common.FrameStateCmpnt;
    import flash.display.MovieClip;

    public class EventHealthBar extends BattleUIComponent
    {

        private static const SQUAD_LABEL:String = "squad";

        private static const REGULAR_LABEL:String = "regular";

        public var fx:EventHealthBarFx = null;

        public var hpBar:FrameStateCmpnt = null;

        public var hpMask:MovieClip = null;

        public var fxMask:MovieClip = null;

        public function EventHealthBar()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.fx.dispose();
            this.fx = null;
            this.hpBar.dispose();
            this.hpBar = null;
            this.hpMask = null;
            this.fxMask = null;
            super.onDispose();
        }

        public function getHpMaskWidth() : Number
        {
            return this.hpMask.width;
        }

        public function playFx(param1:Number, param2:Number) : void
        {
            if(param1 > param2)
            {
                this.fxMask.x = param2;
                this.fxMask.width = param1 - param2;
            }
            else
            {
                this.fxMask.x = param1;
                this.fxMask.width = param2 - param1;
            }
            this.fx.playAnim();
        }

        public function setSquadState(param1:Boolean) : void
        {
            this.fx.setSquadState(param1);
            if(_baseDisposed)
            {
                return;
            }
            this.hpBar.frameLabel = param1?SQUAD_LABEL:REGULAR_LABEL;
        }
    }
}
