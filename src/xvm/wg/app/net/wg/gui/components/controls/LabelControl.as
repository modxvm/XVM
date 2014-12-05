package net.wg.gui.components.controls
{
    import scaleform.clik.controls.Label;
    import scaleform.clik.core.UIComponent;
    import flash.text.TextFormat;
    
    public class LabelControl extends Label
    {
        
        public function LabelControl()
        {
            super();
        }
        
        protected var _textAlign:String = "none";
        
        private var _tooltip:String = "";
        
        private var INFO_INV:String = "infoInv";
        
        private var _infoIcoType:String = "";
        
        private var _infoIco:InfoIcon = null;
        
        protected var _owner:UIComponent = null;
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function onDispose() : void
        {
            if(this._infoIco)
            {
                this.removeInfoIco();
            }
            this._owner = null;
            super.onDispose();
        }
        
        public function set textAlign(param1:String) : void
        {
            if(this._textAlign == param1)
            {
                return;
            }
            this._textAlign = param1;
            invalidateData();
        }
        
        public function get textAlign() : String
        {
            return this._textAlign;
        }
        
        override protected function updateText() : void
        {
            var _loc1_:TextFormat = null;
            super.updateText();
            if(!(_text == null) && !(textField == null))
            {
                _loc1_ = textField.getTextFormat();
                _loc1_.align = this._textAlign;
                textField.setTextFormat(_loc1_);
            }
        }
        
        public function set toolTip(param1:String) : void
        {
            if((param1) && !(param1 == this._tooltip))
            {
                this._tooltip = param1;
                invalidate(this.INFO_INV);
            }
        }
        
        public function get toolTip() : String
        {
            return this._tooltip;
        }
        
        public function set infoIcoType(param1:String) : void
        {
            if(param1 == this._infoIcoType)
            {
                return;
            }
            this._infoIcoType = param1;
            invalidate(this.INFO_INV);
        }
        
        public function get infoIcoType() : String
        {
            return this._infoIcoType;
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(this.INFO_INV))
            {
                if(!(this._infoIcoType == "") && !(this._tooltip == ""))
                {
                    if(!this._infoIco)
                    {
                        this.createInfoIco();
                    }
                    this._infoIco.tooltip = this._tooltip;
                    this._infoIco.icoType = this._infoIcoType;
                    this.repositionInfoIcon();
                }
                else
                {
                    this.removeInfoIco();
                }
            }
        }
        
        private function createInfoIco() : void
        {
            if(!this.owner && (parent))
            {
                this.owner = parent as UIComponent;
            }
            this._infoIco = InfoIcon(App.utils.classFactory.getObject("InfoIconUI"));
            this.owner.addChild(this._infoIco);
        }
        
        private function removeInfoIco() : void
        {
            if(this._infoIco)
            {
                this._infoIco.dispose();
                this.owner.removeChild(this._infoIco);
                this._infoIco = null;
            }
        }
        
        private function repositionInfoIcon() : void
        {
            if(this._infoIco)
            {
                this._infoIco.x = this.x + textField.x + textField.textWidth + InfoIcon.CHECK_BOX_MARGIN;
                this._infoIco.y = this.y + (textField.y + textField.height >> 1) - 1;
            }
        }
        
        public function get owner() : UIComponent
        {
            return this._owner;
        }
        
        public function set owner(param1:UIComponent) : void
        {
            this._owner = param1;
        }
    }
}
