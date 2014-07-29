package net.wg.gui.lobby.questsWindow.components
{
    import scaleform.clik.core.UIComponent;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.text.TextFormat;
    import net.wg.data.constants.QuestsStates;
    import flash.text.TextFieldAutoSize;
    
    public class QuestStatusComponent extends UIComponent
    {
        
        public function QuestStatusComponent()
        {
            super();
        }
        
        private static var TEXT_PADDING:int = 5;
        
        private static function hideTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var textField:TextField;
        
        private var _status:String = "";
        
        private var INV_STATUS:String = "invStatus";
        
        private var INV_ALIGN:String = "invAlign";
        
        private var _statusTooltip:String = "";
        
        private var _showTooltip:Boolean = true;
        
        private var _textAlign:String = "left";
        
        public var iconMC:MovieClip;
        
        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.CLICK,hideTooltip);
            addEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            addEventListener(MouseEvent.ROLL_OVER,this.showStatusTooltip);
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.CLICK,hideTooltip);
            removeEventListener(MouseEvent.ROLL_OUT,hideTooltip);
            removeEventListener(MouseEvent.ROLL_OVER,this.showStatusTooltip);
            super.onDispose();
        }
        
        public function setStatus(param1:String) : void
        {
            this._status = param1;
            invalidate(this.INV_STATUS);
        }
        
        override protected function draw() : void
        {
            var _loc1_:TextFormat = null;
            super.draw();
            if(isInvalid(this.INV_STATUS))
            {
                if(this._status == QuestsStates.NOT_AVAILABLE)
                {
                    visible = true;
                    gotoAndStop(QuestsStates.NOT_AVAILABLE);
                    this.textField.text = QUESTS.QUESTS_STATUS_NOTAVAILABLE;
                    this.textField.textColor = QuestsStates.CLR_STATUS_NOT_AVAILABLE;
                    this._statusTooltip = TOOLTIPS.QUESTS_STATUS_NOTREADY;
                }
                else if(this._status == QuestsStates.DONE)
                {
                    visible = true;
                    gotoAndStop(QuestsStates.DONE);
                    this.textField.text = QUESTS.QUESTS_STATUS_DONE;
                    this.textField.textColor = QuestsStates.CLR_STATUS_DONE;
                    this._statusTooltip = TOOLTIPS.QUESTS_STATUS_DONE;
                }
                else
                {
                    visible = false;
                    this._statusTooltip = "";
                }
                
            }
            if(isInvalid(this.INV_ALIGN))
            {
                _loc1_ = this.textField.getTextFormat();
                _loc1_.align = this._textAlign;
                this.textField.setTextFormat(_loc1_);
                if(this._textAlign == TextFieldAutoSize.RIGHT)
                {
                    this.iconMC.x = this.textField.x + this.textField.width - this.textField.textWidth - this.iconMC.width - TEXT_PADDING;
                }
            }
        }
        
        private function showStatusTooltip(param1:MouseEvent) : void
        {
            if(this._showTooltip)
            {
                App.toolTipMgr.show(this._statusTooltip);
            }
        }
        
        public function get showTooltip() : Boolean
        {
            return this._showTooltip;
        }
        
        public function set showTooltip(param1:Boolean) : void
        {
            this._showTooltip = param1;
        }
        
        public function get textAlign() : String
        {
            return this._textAlign;
        }
        
        public function set textAlign(param1:String) : void
        {
            this._textAlign = param1;
            invalidate(this.INV_ALIGN);
        }
    }
}
