package net.wg.gui.battle.components.stats.playersPanel.list
{
    import flash.display.Sprite;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelList;
    import net.wg.gui.battle.components.stats.playersPanel.interfaces.IPlayersPanelListItem;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelListItemHolder;
    import flash.utils.Dictionary;
    import net.wg.utils.ICommons;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.utils.ILocale;
    import net.wg.utils.IClassFactory;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.data.constants.Errors;
    import flash.geom.Rectangle;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Values;
    import net.wg.gui.battle.views.minimap.MinimapEntryController;
    import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
    import net.wg.gui.battle.components.events.PlayersPanelListEvent;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelItemEvent;
    import flash.display.DisplayObject;

    public class BasePlayersPanelList extends Sprite implements IPlayersPanelList
    {

        private static const ITEM_HEIGHT:int = 25;

        protected var panelListItems:Vector.<IPlayersPanelListItem> = null;

        private var _state:int;

        private var _items:Vector.<IPlayersPanelListItemHolder> = null;

        private var _currOrder:Vector.<Number> = null;

        private var _holderItemUnderMouseID:int = -1;

        private var _isVehicleLevelVisible:Boolean = true;

        private var _isCursorVisible:Boolean = false;

        private var _renderersContainer:Sprite = null;

        private var _mapHolderByVehicleID:Dictionary = null;

        private var _currentPlayerIsAnonymized:Boolean = false;

        private var _toolTipString:String = null;

        private var _commons:ICommons;

        private var _tooltipMgr:ITooltipMgr;

        private var _locale:ILocale;

        private var _classFactory:IClassFactory;

        public function BasePlayersPanelList()
        {
            this._commons = App.utils.commons;
            this._tooltipMgr = App.toolTipMgr;
            this._locale = App.utils.locale;
            this._classFactory = App.utils.classFactory;
            super();
            this._items = new Vector.<IPlayersPanelListItemHolder>();
            this._mapHolderByVehicleID = new Dictionary();
            this.panelListItems = new Vector.<IPlayersPanelListItem>();
            this._currOrder = new Vector.<Number>();
            this._renderersContainer = new Sprite();
            addChild(this._renderersContainer);
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function getItemHolderClass() : Class
        {
            throw new AbstractException(Errors.ABSTRACT_INVOKE);
        }

        public function getRenderersVisibleWidth() : uint
        {
            var _loc1_:Rectangle = this._renderersContainer.getBounds(this);
            return _loc1_.x + _loc1_.width;
        }

        public function removeAllItems() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:IPlayersPanelListItem = null;
            if(this._mapHolderByVehicleID)
            {
                App.utils.data.cleanupDynamicObject(this._mapHolderByVehicleID);
            }
            if(this._items)
            {
                _loc1_ = this._items.length;
                _loc2_ = 0;
                while(_loc2_ < _loc1_)
                {
                    this._items[_loc2_].dispose();
                    _loc2_++;
                }
                this._items.splice(0,_loc1_);
            }
            if(this._currOrder)
            {
                this._currOrder.splice(0,this._currOrder.length);
            }
            if(this.panelListItems)
            {
                for each(_loc3_ in this.panelListItems)
                {
                    _loc3_.removeEventListener(MouseEvent.MOUSE_OVER,this.onHitMouseOverHandler);
                    _loc3_.removeEventListener(MouseEvent.MOUSE_OUT,this.onHitMouseOutHandler);
                    _loc3_.dispose();
                }
                this.panelListItems.splice(0,this.panelListItems.length);
            }
            if(this._renderersContainer != null)
            {
                _loc1_ = this._renderersContainer.numChildren;
                while(--_loc1_ >= 0)
                {
                    this._renderersContainer.removeChildAt(0);
                }
            }
        }

        public function setFrags(param1:Number, param2:int) : void
        {
            var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
            if(_loc3_)
            {
                _loc3_.setFrags(param2);
            }
        }

        public function setChatCommand(param1:Number, param2:String, param3:uint) : void
        {
            var _loc4_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
            if(_loc4_)
            {
                _loc4_.setChatCommand(param2,param3);
            }
        }

        public function triggerChatCommand(param1:Number, param2:String) : void
        {
            var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
            if(_loc3_)
            {
                _loc3_.triggerChatCommand(param2);
            }
        }

        public function setInvitationStatus(param1:Number, param2:uint) : void
        {
        }

        public function setIsCursorVisible(param1:Boolean) : void
        {
            var _loc2_:IPlayersPanelListItemHolder = null;
            if(this._isCursorVisible == param1)
            {
                return;
            }
            this._isCursorVisible = param1;
            this.setMouseListenersEnabled(param1);
            if(this._holderItemUnderMouseID != Values.DEFAULT_INT)
            {
                if(this._isCursorVisible)
                {
                    _loc2_ = this._items[this._holderItemUnderMouseID];
                    MinimapEntryController.instance.highlight(_loc2_.vehicleID);
                }
                else
                {
                    this._holderItemUnderMouseID = Values.DEFAULT_INT;
                    MinimapEntryController.instance.unhighlight();
                }
            }
        }

        public function setIsInteractive(param1:Boolean) : void
        {
        }

        public function setIsInviteShown(param1:Boolean) : void
        {
        }

        public function setPlayerStatus(param1:Number, param2:uint) : void
        {
            var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
            if(_loc3_)
            {
                _loc3_.setPlayerStatus(param2);
            }
        }

        public function setSpeaking(param1:Number, param2:Boolean) : void
        {
            var _loc3_:IPlayersPanelListItem = this.getItemByAccountID(param1);
            if(_loc3_)
            {
                _loc3_.setIsSpeaking(param2);
            }
        }

        public function setUserTags(param1:Number, param2:Array) : void
        {
            var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
            if(_loc3_)
            {
                _loc3_.setUserTags(param2);
            }
        }

        public function setVehicleData(param1:Vector.<DAAPIVehicleInfoVO>) : void
        {
            var _loc2_:DAAPIVehicleInfoVO = null;
            var _loc3_:IPlayersPanelListItemHolder = null;
            for each(_loc2_ in param1)
            {
                _loc3_ = this.getHolderByVehicleID(_loc2_.vehicleID);
                if(_loc3_)
                {
                    _loc3_.setVehicleData(_loc2_);
                }
                else
                {
                    this.addItem(_loc2_);
                }
            }
            if(this._currentPlayerIsAnonymized && _loc2_)
            {
                this.setSquadTooltipInfo(_loc2_.clanAbbrev != Values.EMPTY_STR);
            }
            this.updatePlayerNameWidth();
            this.updateVehicleData();
            dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEMS_COUNT_CHANGE,0));
        }

        public function setVehicleLevelVisible(param1:Boolean) : void
        {
            var _loc2_:IPlayersPanelListItem = null;
            if(this._isVehicleLevelVisible == param1)
            {
                return;
            }
            this._isVehicleLevelVisible = param1;
            for each(_loc2_ in this.panelListItems)
            {
                _loc2_.setVehicleLevelVisible(param1);
            }
        }

        public function setVehicleStatus(param1:Number, param2:uint) : void
        {
            var _loc3_:IPlayersPanelListItemHolder = this.getHolderByVehicleID(param1);
            if(_loc3_)
            {
                _loc3_.setVehicleStatus(param2);
            }
        }

        public function updateColorBlind() : void
        {
            var _loc1_:IPlayersPanelListItem = null;
            for each(_loc1_ in this.panelListItems)
            {
                _loc1_.updateColorBlind();
            }
        }

        public function updateOrder(param1:Vector.<Number>) : void
        {
            var _loc4_:IPlayersPanelListItem = null;
            if(!param1 || !this.checkIfOrderIsValid(param1))
            {
                return;
            }
            var _loc2_:int = this._items.length;
            var _loc3_:Number = 0;
            var _loc5_:* = 0;
            while(_loc5_ < _loc2_)
            {
                _loc3_ = param1[_loc5_];
                if(this._currOrder[_loc5_] != _loc3_)
                {
                    _loc4_ = this.getItemByVehicleID(_loc3_);
                    if(_loc4_)
                    {
                        _loc4_.y = ITEM_HEIGHT * _loc5_;
                        this._currOrder[_loc5_] = _loc3_;
                    }
                }
                _loc5_++;
            }
        }

        public function resetFrags() : void
        {
            if(this.panelListItems == null)
            {
                return;
            }
            var _loc1_:int = this.panelListItems.length;
            var _loc2_:uint = 0;
            while(_loc2_ < _loc1_)
            {
                this.panelListItems[_loc2_].setFrags(0);
                _loc2_++;
            }
        }

        public function get state() : int
        {
            return this._state;
        }

        public function set state(param1:int) : void
        {
            var _loc2_:IPlayersPanelListItem = null;
            if(this._state == param1)
            {
                return;
            }
            for each(_loc2_ in this.panelListItems)
            {
                _loc2_.setState(param1);
            }
            this._state = param1;
            this.initializeState();
        }

        public function get isInviteReceived() : Boolean
        {
            return false;
        }

        protected function updateVehicleData() : void
        {
        }

        protected function onDispose() : void
        {
            this.setMouseListenersEnabled(false);
            this._holderItemUnderMouseID = Values.DEFAULT_INT;
            this.removeAllItems();
            this._mapHolderByVehicleID = null;
            this._items = null;
            this._currOrder = null;
            this.panelListItems = null;
            this._renderersContainer = null;
            this._toolTipString = null;
            this._currentPlayerIsAnonymized = false;
        }

        protected function initializeListItem(param1:IPlayersPanelListItem) : void
        {
        }

        protected function initializeState() : void
        {
        }

        protected function get itemLinkage() : String
        {
            throw new AbstractException(Errors.ABSTRACT_INVOKE);
        }

        protected function get isRightAligned() : Boolean
        {
            throw new AbstractException(Errors.ABSTRACT_INVOKE);
        }

        protected function onPlayersListItemRightClick(param1:PlayersPanelItemEvent) : void
        {
        }

        protected function getHolderByVehicleID(param1:Number) : IPlayersPanelListItemHolder
        {
            return this._mapHolderByVehicleID[param1];
        }

        protected function getItemHolderByIndex(param1:uint) : IPlayersPanelListItemHolder
        {
            return this._items.length > param1?this._items[param1]:null;
        }

        protected function checkInviteReceived() : Boolean
        {
            var _loc2_:IPlayersPanelListItemHolder = null;
            var _loc1_:* = false;
            for each(_loc2_ in this._items)
            {
                if(_loc2_.isInviteReceived)
                {
                    _loc1_ = true;
                    break;
                }
            }
            return _loc1_;
        }

        private function addItem(param1:DAAPIVehicleInfoVO) : void
        {
            var _loc2_:IPlayersPanelListItem = this._classFactory.getComponent(this.itemLinkage,IPlayersPanelListItem);
            var _loc3_:int = this._items.length;
            this.initializeListItem(_loc2_);
            _loc2_.setVehicleLevelVisible(this._isVehicleLevelVisible);
            _loc2_.setState(this._state);
            _loc2_.y = _loc3_ * ITEM_HEIGHT;
            _loc2_.setIsRightAligned(this.isRightAligned);
            _loc2_.holderItemID = _loc3_;
            this._renderersContainer.addChild(DisplayObject(_loc2_));
            this.panelListItems.push(_loc2_);
            var _loc4_:Class = this.getItemHolderClass();
            var _loc5_:IPlayersPanelListItemHolder = new _loc4_(_loc2_);
            _loc5_.setVehicleData(param1);
            var _loc6_:Number = param1.vehicleID;
            this._mapHolderByVehicleID[_loc6_] = _loc5_;
            this._items.push(_loc5_);
            this._currOrder.push(_loc6_);
            if(!this._toolTipString && _loc5_.isCurrentPlayer && param1.isAnonymized)
            {
                _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.onHitMouseOverHandler);
                _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.onHitMouseOutHandler);
                this.makeTooltipString(param1.playerFakeName,param1.clanAbbrev != Values.EMPTY_STR);
                this._currentPlayerIsAnonymized = true;
            }
        }

        private function makeTooltipString(param1:String, param2:Boolean) : void
        {
            this._toolTipString = param2?this._locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_CLAN,{"fakeName":param1}):this._locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_NOCLAN,{"fakeName":param1});
        }

        private function onHitMouseOverHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.show(this._toolTipString);
        }

        private function onHitMouseOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }

        private function setMouseListenersEnabled(param1:Boolean) : void
        {
            var _loc2_:IPlayersPanelListItem = null;
            if(param1)
            {
                for each(_loc2_ in this.panelListItems)
                {
                    _loc2_.addEventListener(PlayersPanelItemEvent.ON_ITEM_OVER,this.onPlayersListItemOnItemOverHandler);
                    _loc2_.addEventListener(PlayersPanelItemEvent.ON_ITEM_OUT,this.onPlayersListItemOnItemOutHandler);
                    _loc2_.addEventListener(PlayersPanelItemEvent.ON_ITEM_CLICK,this.onPlayersListItemOnItemClickHandler);
                }
            }
            else
            {
                for each(_loc2_ in this.panelListItems)
                {
                    _loc2_.removeEventListener(PlayersPanelItemEvent.ON_ITEM_OVER,this.onPlayersListItemOnItemOverHandler);
                    _loc2_.removeEventListener(PlayersPanelItemEvent.ON_ITEM_OUT,this.onPlayersListItemOnItemOutHandler);
                    _loc2_.removeEventListener(PlayersPanelItemEvent.ON_ITEM_CLICK,this.onPlayersListItemOnItemClickHandler);
                }
            }
        }

        private function updatePlayerNameWidth() : void
        {
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc1_:int = this.panelListItems.length;
            if(!_loc1_)
            {
                return;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
                _loc2_ = Math.max(_loc2_,this.panelListItems[_loc3_].getPlayerNameFullWidth());
                _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
                this.panelListItems[_loc3_].setPlayerNameFullWidth(_loc2_);
                _loc3_++;
            }
        }

        private function getItemByVehicleID(param1:Number) : IPlayersPanelListItem
        {
            var _loc2_:int = this._items.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                if(this._items[_loc3_].vehicleID == param1)
                {
                    return this.panelListItems[_loc3_];
                }
                _loc3_++;
            }
            return null;
        }

        private function getItemByAccountID(param1:Number) : IPlayersPanelListItem
        {
            var _loc2_:int = this._items.length;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                if(this._items[_loc3_].accountDBID == param1)
                {
                    return this.panelListItems[_loc3_];
                }
                _loc3_++;
            }
            return null;
        }

        private function checkIfOrderIsValid(param1:Vector.<Number>) : Boolean
        {
            var _loc2_:int = param1.length;
            if(_loc2_ != this._currOrder.length)
            {
                return false;
            }
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                if(this._currOrder.indexOf(param1[_loc3_]) == Values.DEFAULT_INT)
                {
                    return false;
                }
                _loc3_++;
            }
            return true;
        }

        private function setSquadTooltipInfo(param1:Boolean) : void
        {
            var _loc2_:IPlayersPanelListItem = null;
            for each(_loc2_ in this.panelListItems)
            {
                if(_loc2_.getDynamicSquad())
                {
                    _loc2_.getDynamicSquad().setCurrentPlayerAnonymized();
                    _loc2_.getDynamicSquad().setIsCurrentPlayerInClan(param1);
                }
            }
        }

        private function onPlayersListItemOnItemOverHandler(param1:PlayersPanelItemEvent) : void
        {
            this._holderItemUnderMouseID = param1.holderItemID;
            var _loc2_:IPlayersPanelListItemHolder = this._items[this._holderItemUnderMouseID];
            MinimapEntryController.instance.highlight(_loc2_.vehicleID);
        }

        private function onPlayersListItemOnItemOutHandler(param1:PlayersPanelItemEvent) : void
        {
            this._holderItemUnderMouseID = Values.DEFAULT_INT;
            MinimapEntryController.instance.unhighlight();
        }

        private function onPlayersListItemOnItemClickHandler(param1:PlayersPanelItemEvent) : void
        {
            var _loc2_:IPlayersPanelListItemHolder = this._items[param1.holderItemID];
            if(this._commons.isRightButton(param1.mEvent) && !_loc2_.isCurrentPlayer)
            {
                this.onPlayersListItemRightClick(param1);
            }
            else
            {
                dispatchEvent(new PlayersPanelListEvent(PlayersPanelListEvent.ITEM_SELECTED,_loc2_.vehicleID));
            }
        }
    }
}
