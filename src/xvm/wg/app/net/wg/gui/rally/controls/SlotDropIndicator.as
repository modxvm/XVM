package net.wg.gui.rally.controls
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.rally.controls.interfaces.ISlotDropIndicator;
    import net.wg.gui.interfaces.IExtendedUserVO;
    import flash.display.InteractiveObject;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Cursors;
    import flash.geom.Point;
    import net.wg.gui.rally.helpers.PlayerCIGenerator;
    import net.wg.gui.events.ContextMenuEvent;
    import net.wg.gui.rally.events.RallyViewsEvent;
    
    public class SlotDropIndicator extends UIComponent implements ISlotDropIndicator
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
        
        private var legionariesIcon:InteractiveObject;
        
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
        
        public function setAdditionalToolTipTarget(param1:InteractiveObject) : void
        {
            this.legionariesIcon = param1;
            this.showToolTip();
        }
        
        public function removeAdditionalTooltipTarget() : void
        {
            this.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
            this.legionariesIcon = null;
        }
        
        public function get getCursorType() : String
        {
            return Cursors.DRAG_OPEN;
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
            this.removeAdditionalTooltipTarget();
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
        
        private function showToolTip() : void
        {
            if(this.legionariesIcon)
            {
                if(this.checkHitTestPoint())
                {
                    App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_BATTLEROOMLEGIONARIES_TEAMSECTION);
                }
                else
                {
                    App.toolTipMgr.show(this._data.getToolTip());
                    this.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
                }
            }
            else
            {
                App.toolTipMgr.show(this._data.getToolTip());
            }
        }
        
        private function checkHitTestPoint() : Boolean
        {
            var _loc1_:Point = new Point(mouseX,mouseY);
            _loc1_ = localToGlobal(_loc1_);
            return this.legionariesIcon.hitTestPoint(_loc1_.x,_loc1_.y);
        }
        
        private function onClickHandler(param1:MouseEvent) : void
        {
            var _loc2_:IExtendedUserVO = null;
            var _loc3_:* = false;
            var _loc4_:PlayerCIGenerator = null;
            if(App.utils.commons.isRightButton(param1))
            {
                _loc2_ = this._data?this._data.himself?null:this._data:null;
                _loc3_ = App.contextMenuMgr.canGiveLeadershipTo(_loc2_.dbID)?_loc2_:false;
                _loc4_ = new PlayerCIGenerator(this._isCurrentUserCommander,_loc3_);
                if(_loc2_)
                {
                    App.contextMenuMgr.showUserContextMenu(this,this._data,_loc4_,this.onContextMenuAction);
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
                this.showToolTip();
            }
        }
        
        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
            App.toolTipMgr.hide();
        }
        
        private function onMouseMoveHandler(param1:MouseEvent) : void
        {
            if(this.checkHitTestPoint())
            {
                App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_BATTLEROOMLEGIONARIES_TEAMSECTION);
            }
            else
            {
                App.toolTipMgr.show(this._data.getToolTip());
            }
        }
    }
}
