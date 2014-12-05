package net.wg.gui.lobby.quests.components
{
    import net.wg.gui.components.advanced.DashLineTextItem;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.events.MouseEvent;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Tooltips;
    
    public class ChainProgressDashLineTextItem extends DashLineTextItem
    {
        
        public function ChainProgressDashLineTextItem()
        {
            super();
        }
        
        private static var ICON_PADDING:int = 16;
        
        private static var ICON_DEFAULT_WIDTH:int = 16;
        
        public var icon:UILoaderAlt = null;
        
        private var _data:Object = null;
        
        private var _chainID:int = -1;
        
        private var _tileID:int = -1;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.icon.autoSize = false;
            this.icon.addEventListener(MouseEvent.ROLL_OVER,this.onIconRollOverHandler);
            this.icon.addEventListener(MouseEvent.ROLL_OUT,this.onIconRollOutHandler);
        }
        
        override protected function onDispose() : void
        {
            this.icon.removeEventListener(MouseEvent.ROLL_OVER,this.onIconRollOverHandler);
            this.icon.removeEventListener(MouseEvent.ROLL_OUT,this.onIconRollOutHandler);
            this.icon.dispose();
            this.icon = null;
            if(this._data)
            {
                this._data = null;
            }
            super.onDispose();
        }
        
        public function get data() : Object
        {
            return this._data;
        }
        
        public function set data(param1:Object) : void
        {
            if(this._data == param1)
            {
                return;
            }
            this._data = param1;
            if(this._data)
            {
                this.label = this._data.label;
                this.value = this._data.value;
                this.icon.source = this._data.iconSource;
                this._tileID = this._data.tileID;
                this._chainID = this._data.chainID;
            }
        }
        
        override protected function applySizeChanges() : void
        {
            dashLine.width = Math.round(_width - labelTextField.width - valueTextField.width - dashLinePadding * 2 - ICON_DEFAULT_WIDTH - ICON_PADDING);
            dashLine.x = Math.round(labelTextField.width + dashLinePadding);
            valueTextField.x = Math.round(_width - valueTextField.width - ICON_PADDING - ICON_DEFAULT_WIDTH);
            this.icon.x = Math.round(_width - ICON_DEFAULT_WIDTH);
        }
        
        override protected function draw() : void
        {
            if(isInvalid(VALUE_INV))
            {
                if(_myEnabled)
                {
                    gotoAndPlay("up");
                    valueTextField.autoSize = TextFieldAutoSize.LEFT;
                    valueTextField.htmlText = this._data.value;
                }
                else
                {
                    gotoAndPlay("disabled");
                    valueTextField.autoSize = TextFieldAutoSize.LEFT;
                    valueTextField.htmlText = "--";
                }
                invalidate(InvalidationType.SIZE);
            }
            if(isInvalid(LABEL_INV))
            {
                labelTextField.autoSize = TextFieldAutoSize.LEFT;
                labelTextField.htmlText = this._data.label;
                invalidate(InvalidationType.SIZE);
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.applySizeChanges();
            }
        }
        
        private function onIconRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showSpecial(Tooltips.PRIVATE_QUESTS_CHAIN,null,this._tileID,this._chainID);
        }
        
        private function onIconRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
    }
}
