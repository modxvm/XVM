package net.wg.gui.battle.random.views.stats.components.playersPanel.list
{
    import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersListItemHolder;
    import net.wg.gui.battle.components.stats.playersPanel.interfaces.IRandomPlayersPanelListItem;
    import net.wg.data.constants.PlayerStatus;
    import net.wg.gui.battle.views.stats.constants.DynamicSquadState;
    import net.wg.data.constants.InvitationStatus;

    public class PlayersPanelListItemHolder extends BasePlayersListItemHolder
    {

        private var _isInviteReceived:Boolean = false;

        private var _randomListItem:IRandomPlayersPanelListItem = null;

        public function PlayersPanelListItemHolder(param1:PlayersPanelListItem)
        {
            this._randomListItem = IRandomPlayersPanelListItem(param1);
            super(param1);
        }

        override protected function onDispose() : void
        {
            this._randomListItem = null;
            super.onDispose();
        }

        override protected function updateInvitationValues() : void
        {
            this.updateInviteStatus();
            this.updateDynamicSquadState();
        }

        override protected function updatePlayerStatusValues() : void
        {
            this.updateDynamicSquadState();
        }

        override protected function updateUserTagsValues() : void
        {
            this.updateDynamicSquadState();
        }

        override protected function updateListItemVehicleDataValues() : void
        {
            this._randomListItem.getDynamicSquad().setUID(vehicleData.accountDBID);
        }

        override protected function updateVehicleDataValues() : void
        {
            this.updateInviteStatus();
            this.updateDynamicSquadState();
        }

        override protected function applyPlayerStatusValues() : void
        {
            this._randomListItem.setSquad(vehicleData.isSquadPersonal(),vehicleData.squadIndex);
            this._randomListItem.setSquadNoSound(PlayerStatus.isVoipDisabled(playerStatus));
        }

        private function updateDynamicSquadState() : void
        {
            var _loc1_:int = DynamicSquadState.getState(vehicleData);
            this._randomListItem.setSquadState(_loc1_);
        }

        private function updateInviteStatus() : void
        {
            this._isInviteReceived = InvitationStatus.isOnlyReceived(vehicleData.invitationStatus);
        }

        override public function get isInviteReceived() : Boolean
        {
            return this._isInviteReceived;
        }
    }
}
