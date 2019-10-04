package net.wg.gui.battle.random.views.stats.components.playersPanel
{
    import net.wg.gui.battle.components.PlayersPanelBase;
    import net.wg.infrastructure.interfaces.IDAAPIDataClass;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelSwitchEvent;
    import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
    import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
    import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
    import net.wg.data.constants.Errors;
    import flash.events.MouseEvent;

    public class PlayersPanel extends PlayersPanelBase
    {

        private var _leftListHasBadges:Boolean;

        private var _rightListHasBadges:Boolean;

        public function PlayersPanel()
        {
            super();
        }

        override public function updateVehiclesData(param1:IDAAPIDataClass) : void
        {
            this.applyVehicleData(param1);
        }

        override protected function configUI() : void
        {
            super.configUI();
        }

        override protected function onDispose() : void
        {
            super.onDispose();
        }

        override protected function setListsState(param1:int) : void
        {
            listLeft.state = this.validateState(param1,this._leftListHasBadges);
            listRight.state = this.validateState(param1,this._rightListHasBadges);
            if(state == param1)
            {
                return;
            }
            state = param1;
            dispatchEvent(new PlayersPanelSwitchEvent(PlayersPanelSwitchEvent.STATE_REQUESTED,param1));
        }

        override protected function applyVehicleData(param1:IDAAPIDataClass) : void
        {
            var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
            this.checkBadges(_loc2_);
            listLeft.setVehicleData(_loc2_.leftVehicleInfos);
            listLeft.updateOrder(_loc2_.leftVehiclesIDs);
            listRight.setVehicleData(_loc2_.rightVehicleInfos);
            listRight.updateOrder(_loc2_.rightVehiclesIDs);
        }

        private function checkBadges(param1:DAAPIVehiclesDataVO) : void
        {
            var _loc2_:DAAPIVehicleInfoVO = null;
            if(!this._leftListHasBadges)
            {
                for each(_loc2_ in param1.leftVehicleInfos)
                {
                    if(_loc2_.badgeType)
                    {
                        this._leftListHasBadges = true;
                        break;
                    }
                }
            }
            if(!this._rightListHasBadges)
            {
                for each(_loc2_ in param1.rightVehicleInfos)
                {
                    if(_loc2_.badgeType)
                    {
                        this._rightListHasBadges = true;
                        break;
                    }
                }
            }
            if(this._leftListHasBadges || this._rightListHasBadges)
            {
                this.setListsState(state);
            }
        }

        private function validateState(param1:int, param2:Boolean) : int
        {
            var _loc5_:* = 0;
            var _loc3_:Array = PLAYERS_PANEL_STATE.BASE_STATES;
            var _loc4_:Array = PLAYERS_PANEL_STATE.BASE_STATES_NO_BADGES;
            if(!param2)
            {
                _loc5_ = _loc3_.indexOf(param1);
                if(_loc5_ == -1)
                {
                    App.utils.asserter.assert(true,Errors.WRONG_VALUE);
                }
                return _loc4_[_loc5_];
            }
            return param1;
        }

        override protected function onListRollOver(param1:MouseEvent) : void
        {
            if(state != PLAYERS_PANEL_STATE.FULL)
            {
                this.setListsState(PLAYERS_PANEL_STATE.FULL);
            }
        }

        override protected function onListRollOut(param1:MouseEvent) : void
        {
            if(state == PLAYERS_PANEL_STATE.FULL)
            {
                this.setListsState(expandState);
                expandState = PLAYERS_PANEL_STATE.NONE;
            }
        }
    }
}
