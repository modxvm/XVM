package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.gui.lobby.eventBattleResult.data.ResultDataVO;
    import net.wg.data.constants.Values;

    public class ResultStats extends RewardValuesAnimation
    {

        public var soulsInTank:ResultStatItem = null;

        public var soulsTotal:ResultStatItem = null;

        public var kills:ResultStatItem = null;

        public var damage:ResultStatItem = null;

        private var _data:ResultDataVO = null;

        public function ResultStats()
        {
            super();
        }

        public function setData(param1:ResultDataVO) : void
        {
            this._data = param1;
            this.soulsInTank.setData(EVENT.RESULTSCREEN_STATS_MATTERONTANK,param1.matterOnTankTooltip);
            this.soulsTotal.setData(EVENT.RESULTSCREEN_STATS_MATTER,param1.matterTooltip);
            this.kills.setData(EVENT.RESULTSCREEN_STATS_KILL,param1.killsTooltip);
            this.damage.setData(EVENT.RESULTSCREEN_STATS_DAMAGE,param1.damageTooltip);
            this.soulsInTank.setValue(Values.ZERO);
            this.soulsTotal.setValue(Values.ZERO);
            this.kills.setValue(Values.ZERO);
            this.damage.setValue(Values.ZERO);
        }

        override protected function setAnimationProgress(param1:Number) : void
        {
            if(this._data == null)
            {
                return;
            }
            this.soulsInTank.setValue(int(this._data.matterOnTank * param1));
            this.soulsTotal.setValue(int(this._data.matter * param1));
            this.kills.setValue(int(this._data.kills * param1));
            this.damage.setValue(int(this._data.damage * param1));
        }

        override protected function onDispose() : void
        {
            this.soulsInTank.dispose();
            this.soulsInTank = null;
            this.soulsTotal.dispose();
            this.soulsTotal = null;
            this.kills.dispose();
            this.kills = null;
            this.damage.dispose();
            this.damage = null;
            this._data = null;
            super.onDispose();
        }
    }
}
