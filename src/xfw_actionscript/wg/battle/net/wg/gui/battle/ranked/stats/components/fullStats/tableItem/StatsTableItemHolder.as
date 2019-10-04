package net.wg.gui.battle.ranked.stats.components.fullStats.tableItem
{
    import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderBase;
    import net.wg.gui.battle.ranked.VO.daapi.RankedDAAPIVehicleInfoVO;
    import net.wg.gui.battle.random.views.stats.constants.VehicleActions;
    import net.wg.data.constants.UserTags;

    public class StatsTableItemHolder extends StatsTableItemHolderBase
    {

        private var _isEnemy:Boolean = false;

        public function StatsTableItemHolder(param1:StatsTableItem, param2:Boolean)
        {
            super(param1);
            this._isEnemy = param2;
        }

        override protected function vehicleDataSync() : void
        {
            var _loc2_:StatsTableItem = null;
            var _loc3_:uint = 0;
            super.vehicleDataSync();
            var _loc1_:RankedDAAPIVehicleInfoVO = data as RankedDAAPIVehicleInfoVO;
            if(_loc1_)
            {
                _loc2_ = this.getStatsItem;
                _loc2_.setVehicleLevel(_loc1_.vehicleLevel);
                _loc2_.setVehicleIcon(_loc1_.vehicleIconName);
                _loc2_.setIsSpeaking(_loc1_.isSpeaking);
                _loc2_.setRank(_loc1_.division,_loc1_.level,_loc1_.isGroup);
                _loc3_ = _loc1_.vehicleAction;
                if(_loc3_)
                {
                    _loc2_.setVehicleAction(VehicleActions.getActionName(_loc1_.vehicleAction));
                }
                else
                {
                    _loc2_.clearVehicleAction();
                }
            }
        }

        override protected function applyUserTags() : void
        {
            super.applyUserTags();
            var _loc1_:Array = data.userTags;
            if(!_loc1_)
            {
                return;
            }
            var _loc2_:StatsTableItem = this.getStatsItem;
            _loc2_.setIsMute(UserTags.isMuted(_loc1_));
            _loc2_.setDisableCommunication(UserTags.isIgnored(_loc1_));
        }

        public function get isEnemy() : Boolean
        {
            return this._isEnemy;
        }

        private function get getStatsItem() : StatsTableItem
        {
            return StatsTableItem(statsItem);
        }
    }
}
