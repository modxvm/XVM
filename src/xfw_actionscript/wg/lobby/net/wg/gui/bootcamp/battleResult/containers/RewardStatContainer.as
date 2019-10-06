package net.wg.gui.bootcamp.battleResult.containers
{
    import net.wg.gui.bootcamp.containers.AnimatedSpriteContainer;
    import net.wg.gui.bootcamp.battleResult.data.BattleItemRendrerVO;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class RewardStatContainer extends AnimatedSpriteContainer
    {

        private var _tipData:BattleItemRendrerVO;

        public function RewardStatContainer()
        {
            super();
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this._tipData = null;
            super.onDispose();
        }

        public function setTipData(param1:BattleItemRendrerVO) : void
        {
            this._tipData = param1;
            if(!hasEventListener(MouseEvent.ROLL_OVER))
            {
                addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
                addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            }
        }

        private function onRollOverHandler(param1:Event) : void
        {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.BOOTCAMP_AWARD_MEDAL,null,this._tipData.label,this._tipData.description,this._tipData.iconTooltip);
        }

        private function onRollOutHandler(param1:Event) : void
        {
            App.toolTipMgr.hide();
        }
    }
}
