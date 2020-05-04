package net.wg.gui.battle.pveEvent.views.eventPlayersPanel
{
    import net.wg.infrastructure.base.meta.impl.EventPlayersPanelMeta;
    import net.wg.infrastructure.base.meta.IEventPlayersPanelMeta;
    import flash.display.Sprite;
    import net.wg.gui.battle.pveEvent.views.eventPlayersPanel.VO.DAAPIPlayerPanelInfoVO;

    public class EventPlayersPanel extends EventPlayersPanelMeta implements IEventPlayersPanelMeta
    {

        private static const LIST_PLAYERS_ITEM_LINKAGE:String = "EventPlayersPanelListItemUI";

        private static const LIST_ITEM_HEIGHT:int = 33;

        private var _playersPanelListItems:Vector.<EventPlayersPanelListItem> = null;

        private var _playerRendererContainer:Sprite = null;

        private var _playersCount:int = 0;

        public function EventPlayersPanel()
        {
            super();
            mouseChildren = false;
            mouseEnabled = false;
            this._playersPanelListItems = new Vector.<EventPlayersPanelListItem>();
            this._playerRendererContainer = new Sprite();
            addChild(this._playerRendererContainer);
        }

        override protected function onDispose() : void
        {
            this.clearPlayerRendererContainer();
            this.clearPlayersPanelListItems();
            super.onDispose();
        }

        override protected function setPlayerPanelInfo(param1:DAAPIPlayerPanelInfoVO) : void
        {
            var _loc3_:EventPlayersPanelListItem = null;
            var _loc2_:int = this.getPlayerIndex(param1.vehID);
            if(_loc2_ >= 0)
            {
                this._playersPanelListItems[_loc2_].setData(param1);
            }
            else
            {
                _loc3_ = App.utils.classFactory.getComponent(LIST_PLAYERS_ITEM_LINKAGE,EventPlayersPanelListItem);
                _loc3_.y = this._playersCount * LIST_ITEM_HEIGHT;
                _loc3_.setData(param1);
                this._playerRendererContainer.addChild(_loc3_);
                this._playersPanelListItems.push(_loc3_);
                this._playersCount++;
            }
        }

        public function as_setPlayerDead(param1:int) : void
        {
            var _loc2_:int = this.getPlayerIndex(param1);
            if(_loc2_ >= 0)
            {
                this._playersPanelListItems[_loc2_].setEnable(false);
            }
        }

        public function as_setPlayerPanelCountLives(param1:int, param2:int) : void
        {
            var _loc3_:int = this.getPlayerIndex(param1);
            if(_loc3_ >= 0)
            {
                this._playersPanelListItems[_loc3_].setCountLives(param2);
            }
        }

        public function as_setPlayerPanelHp(param1:int, param2:int, param3:int) : void
        {
            var _loc4_:int = this.getPlayerIndex(param1);
            if(_loc4_ >= 0)
            {
                this._playersPanelListItems[_loc4_].setHp(param2,param3);
            }
        }

        private function clearPlayerRendererContainer() : void
        {
            var _loc1_:* = 0;
            if(this._playerRendererContainer)
            {
                _loc1_ = this._playerRendererContainer.numChildren;
                while(--_loc1_ >= 0)
                {
                    this._playerRendererContainer.removeChildAt(0);
                }
                removeChild(this._playerRendererContainer);
                this._playerRendererContainer = null;
            }
        }

        private function clearPlayersPanelListItems() : void
        {
            var _loc1_:EventPlayersPanelListItem = null;
            if(this._playersPanelListItems)
            {
                for each(_loc1_ in this._playersPanelListItems)
                {
                    _loc1_.dispose();
                }
                this._playersPanelListItems.splice(0,this._playersPanelListItems.length);
                this._playersPanelListItems = null;
            }
        }

        private function getPlayerIndex(param1:int) : int
        {
            var _loc2_:int = this._playersPanelListItems.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                if(this._playersPanelListItems[_loc3_].vehID == param1)
                {
                    return _loc3_;
                }
                _loc3_++;
            }
            return -1;
        }
    }
}
