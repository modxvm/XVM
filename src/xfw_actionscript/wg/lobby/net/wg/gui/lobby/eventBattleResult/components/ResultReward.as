package net.wg.gui.lobby.eventBattleResult.components
{
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventBattleResult.data.ResultRewardVO;
    import net.wg.data.constants.Values;

    public class ResultReward extends RewardValuesAnimation
    {

        public var content:ResultRewardContent = null;

        public var bg:MovieClip = null;

        private var _data:ResultRewardVO = null;

        public function ResultReward()
        {
            super();
        }

        public function setSizeFrame(param1:int) : void
        {
            this.bg.gotoAndStop(param1);
        }

        public function setData(param1:ResultRewardVO) : void
        {
            this._data = param1;
            this.content.setData(Values.ZERO,Values.ZERO,Values.ZERO);
            this.content.setTooltips(param1.creditsTooltip,param1.expTooltip,param1.freeXPTooltip);
        }

        override protected function setAnimationProgress(param1:Number) : void
        {
            if(this._data == null)
            {
                return;
            }
            this.content.setData(int(this._data.credits * param1),int(this._data.exp * param1),int(this._data.freeXP * param1));
        }

        override protected function onDispose() : void
        {
            this.content.dispose();
            this.content = null;
            this.bg = null;
            this._data = null;
            super.onDispose();
        }
    }
}
