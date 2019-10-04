package net.wg.gui.battle.random.views.stats.components.playersPanel.list
{
    import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersPanelListItem;
    import net.wg.gui.battle.components.stats.playersPanel.interfaces.IRandomPlayersPanelListItem;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
    import flash.events.MouseEvent;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelItemEvent;

    public class PlayersPanelListItem extends BasePlayersPanelListItem implements IRandomPlayersPanelListItem
    {

        private static const SQUAD_ITEMS_AREA_WIDTH:int = 25;

        public var dynamicSquad:PlayersPanelDynamicSquad;

        private var _isSquadPersonal:Boolean = false;

        public function PlayersPanelListItem()
        {
            super();
            maxPlayerNameWidth = WIDTH - ICONS_AREA_WIDTH - vehicleTF.width - fragsTF.width - SQUAD_ITEMS_AREA_WIDTH - SQUAD_ITEMS_AREA_WIDTH - BADGE_OFFSET;
        }

        override public function isSquadPersonal() : Boolean
        {
            return this._isSquadPersonal;
        }

        override public function setIsInteractive(param1:Boolean) : void
        {
            this.dynamicSquad.setIsInteractive(param1);
        }

        override public function setIsInviteShown(param1:Boolean) : void
        {
            this.dynamicSquad.setIsInviteShown(param1);
        }

        override protected function onDispose() : void
        {
            this.dynamicSquad.dispose();
            this.dynamicSquad = null;
            super.onDispose();
        }

        override protected function updatePositionsRight() : void
        {
            super.updatePositionsRight();
            x = -(fragsTF.x + fragsTF.width + SQUAD_ITEMS_AREA_WIDTH ^ 0);
            this.dynamicSquad.x = fragsTF.x + fragsTF.width + SQUAD_ITEMS_AREA_WIDTH ^ 0;
        }

        override protected function updatePositionsLeft() : void
        {
            super.updatePositionsLeft();
            x = -(fragsTF.x - SQUAD_ITEMS_AREA_WIDTH ^ 0);
            this.dynamicSquad.x = fragsTF.x - SQUAD_ITEMS_AREA_WIDTH ^ 0;
        }

        override protected function initializeRightAligned(param1:Boolean) : void
        {
            this.dynamicSquad.setIsEnemy(param1);
        }

        public function getDynamicSquad() : PlayersPanelDynamicSquad
        {
            return this.dynamicSquad;
        }

        public function setSquad(param1:Boolean, param2:int) : void
        {
            this.dynamicSquad.setCurrentSquad(param1,param2);
            if(this._isSquadPersonal != param1)
            {
                this._isSquadPersonal = param1;
                invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
            }
        }

        public function setSquadNoSound(param1:Boolean) : void
        {
            this.dynamicSquad.setNoSound(param1);
        }

        public function setSquadState(param1:int) : void
        {
            this.dynamicSquad.setState(param1);
        }

        override protected function onMouseOver(param1:MouseEvent) : void
        {
            var _loc2_:PlayersPanelItemEvent = new PlayersPanelItemEvent(PlayersPanelItemEvent.ON_ITEM_OVER,this,holderItemID,param1);
            dispatchEvent(_loc2_);
            this.dynamicSquad.onItemOver();
        }

        override protected function onMouseOut(param1:MouseEvent) : void
        {
            var _loc2_:PlayersPanelItemEvent = new PlayersPanelItemEvent(PlayersPanelItemEvent.ON_ITEM_OUT,this,holderItemID,param1);
            dispatchEvent(_loc2_);
            this.dynamicSquad.onItemOut();
        }

        override protected function onMouseClick(param1:MouseEvent) : void
        {
            var _loc2_:PlayersPanelItemEvent = new PlayersPanelItemEvent(PlayersPanelItemEvent.ON_ITEM_CLICK,this,holderItemID,param1);
            dispatchEvent(_loc2_);
        }
    }
}
