package net.wg.gui.battle.epicBattle.battleloading.components
{
    import net.wg.gui.battle.epicBattle.views.data.EpicStatsDataProviderBaseCtrl;
    import net.wg.gui.battle.battleloading.interfaces.IVehiclesDataProvider;
    import net.wg.gui.battle.epicBattle.battleloading.renderers.EpicBattleLoadingPlayerItemRenderer;
    import scaleform.clik.controls.ScrollingList;
    import net.wg.infrastructure.events.ListDataProviderEvent;
    import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
    import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehicleStatsVO;

    public class EpicBattleStatsTableCtrl extends EpicStatsDataProviderBaseCtrl
    {

        private var _table:EpicBattleStatsTable = null;

        public function EpicBattleStatsTableCtrl(param1:EpicBattleStatsTable)
        {
            super();
            this._table = param1;
        }

        override public function setVehiclesData(param1:Array, param2:Vector.<Number>, param3:Boolean) : void
        {
            var _loc4_:IVehiclesDataProvider = param3?enemyDP:teamDP;
            super.setVehiclesData(param1,param2,param3);
            if(param3)
            {
                this._table.team2PlayerList.visible = true;
                if(this._table.team2PlayerList.dataProvider != null)
                {
                    this._table.team2PlayerList.dataProvider.cleanUp();
                }
                this._table.team2PlayerList.dataProvider = _loc4_;
            }
            else
            {
                this._table.team1PlayerList.visible = true;
                if(this._table.team1PlayerList.dataProvider != null)
                {
                    this._table.team1PlayerList.dataProvider.cleanUp();
                }
                this._table.team1PlayerList.dataProvider = _loc4_;
            }
        }

        override protected function cleanUp() : void
        {
            this._table = null;
            super.cleanUp();
        }

        public function scrollToPosition(param1:int) : void
        {
            this._table.team1ScrollBar.position = param1;
            this._table.team2ScrollBar.position = param1;
        }

        private function getRendererIfInRange(param1:ScrollingList, param2:int) : EpicBattleLoadingPlayerItemRenderer
        {
            var _loc5_:EpicBattleLoadingPlayerItemRenderer = null;
            var _loc3_:int = param2 - param1.scrollPosition;
            var _loc4_:EpicBattleLoadingPlayerItemRenderer = null;
            if(_loc3_ >= 0 && _loc3_ < param1.rowCount)
            {
                _loc5_ = param1.getRendererAt(_loc3_) as EpicBattleLoadingPlayerItemRenderer;
                if(_loc5_)
                {
                    _loc4_ = _loc5_;
                }
            }
            return _loc4_;
        }

        override protected function updateTeamDPItems(param1:ListDataProviderEvent) : void
        {
            var _loc5_:* = 0;
            var _loc6_:DAAPIVehicleInfoVO = null;
            var _loc7_:EpicBattleLoadingPlayerItemRenderer = null;
            var _loc8_:EpicVehicleStatsVO = null;
            var _loc2_:uint = this._table.team1PlayerList.scrollPosition;
            var _loc3_:uint = _loc2_ + this._table.team1PlayerList.rowCount - 1;
            var _loc4_:Vector.<int> = Vector.<int>(param1.data);
            for each(_loc5_ in _loc4_)
            {
                if(!(_loc5_ < _loc2_ || _loc5_ > _loc3_))
                {
                    _loc6_ = teamDP.requestItemAt(_loc5_) as DAAPIVehicleInfoVO;
                    _loc7_ = this.getRendererIfInRange(this._table.team1PlayerList,_loc5_);
                    if(_loc6_ && _loc7_)
                    {
                        _loc7_.isEnemy = false;
                        _loc7_.setData(_loc6_);
                        _loc8_ = teamDP.requestEpicData(_loc6_.vehicleID);
                        if(_loc8_)
                        {
                            _loc7_.setEpicData(_loc8_);
                        }
                        _loc7_.validateNow();
                    }
                }
            }
        }

        override protected function updateEnemyDPItems(param1:ListDataProviderEvent) : void
        {
            var _loc5_:* = 0;
            var _loc6_:DAAPIVehicleInfoVO = null;
            var _loc7_:EpicBattleLoadingPlayerItemRenderer = null;
            var _loc8_:EpicVehicleStatsVO = null;
            var _loc2_:uint = this._table.team2PlayerList.scrollPosition;
            var _loc3_:uint = _loc2_ + this._table.team2PlayerList.rowCount - 1;
            var _loc4_:Vector.<int> = Vector.<int>(param1.data);
            for each(_loc5_ in _loc4_)
            {
                if(!(_loc5_ < _loc2_ || _loc5_ > _loc3_))
                {
                    _loc6_ = enemyDP.requestItemAt(_loc5_) as DAAPIVehicleInfoVO;
                    _loc7_ = this.getRendererIfInRange(this._table.team2PlayerList,_loc5_);
                    if(_loc6_ && _loc7_)
                    {
                        _loc7_.isEnemy = true;
                        _loc7_.setData(_loc6_);
                        _loc8_ = enemyDP.requestEpicData(_loc6_.vehicleID);
                        if(_loc8_)
                        {
                            _loc7_.setEpicData(_loc8_);
                        }
                        _loc7_.validateNow();
                    }
                }
            }
        }
    }
}
