package net.wg.gui.rally.controls
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.entity.IDropItem;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import net.wg.gui.interfaces.IExtendedUserVO;
    import flash.events.MouseEvent;
    import net.wg.gui.rally.helpers.PlayerCIGenerator;
    import net.wg.gui.events.ContextMenuEvent;
    import net.wg.gui.rally.events.RallyViewsEvent;
    
    public class SlotDropIndicator extends UIComponent implements IDropItem, IUpdatable
    {
        
        public function SlotDropIndicator()
        {
            super();
            addEventListener(MouseEvent.CLICK,this.onClickHandler);
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.setHighlightState(false);
        }
        
        private var _data:IExtendedUserVO = null;
        
        private var _index:Number = -1;
        
        private var _isCurrentUserCommander:Boolean = false;
        
        private var _playerStatus:int = -1;
        
        private var _isHighlighted:Boolean = false;
        
        public function setHighlightState(param1:Boolean) : void
        {
            this._isHighlighted = param1;
            alpha = this._isHighlighted?1:0;
            this.updateMouseEnabled();
        }
        
        public function update(param1:Object) : void
        {
            this._data = param1?IExtendedUserVO(param1):null;
            this.updateMouseEnabled();
        }
        
        public function get index() : Number
        {
            return this._index;
        }
        
        public function set index(param1:Number) : void
        {
            this._index = param1;
        }
        
        public function get data() : Object
        {
            return this._data;
        }
        
        public function set isCurrentUserCommander(param1:Boolean) : void
        {
            this._isCurrentUserCommander = param1;
        }
        
        public function set playerStatus(param1:int) : void
        {
            this._playerStatus = param1;
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.CLICK,this.onClickHandler);
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            if(this._data)
            {
                this._data.dispose();
                this._data = null;
            }
            super.onDispose();
        }
        
        private function updateMouseEnabled() : void
        {
            if(this._isCurrentUserCommander)
            {
                mouseEnabled = this._index > 0 && ((this._isHighlighted) || (this._data));
            }
            else
            {
                mouseEnabled = (this._data) && !this._data.himself;
            }
            buttonMode = useHandCursor = mouseEnabled;
        }
        
        private function onClickHandler(param1:MouseEvent) : void
        {
            var _loc2_:IExtendedUserVO = null;
            var _loc3_:PlayerCIGenerator = null;
            if(App.utils.commons.isRightButton(param1))
            {
                _loc2_ = this._data?this._data.himself?null:this._data:null;
                _loc3_ = new PlayerCIGenerator(this._isCurrentUserCommander);
                if(_loc2_)
                {
                    App.contextMenuMgr.showUserContextMenu(this,this._data,_loc3_,this.onContextMenuAction);
                }
            }
        }
        
        private function onContextMenuAction(param1:ContextMenuEvent) : void
        {
            switch(param1.id)
            {
                case "addToIgnored":
                    dispatchEvent(new RallyViewsEvent(RallyViewsEvent.IGNORE_USER_REQUEST,this._data.dbID));
                    break;
            }
        }
        
        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(this._data)
            {
                App.toolTipMgr.show(this._data.getToolTip());
            }
        }
        
        private function onRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
    }
}
