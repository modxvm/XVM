package net.wg.gui.components.controls
{
    import scaleform.clik.core.UIComponent;
    import net.wg.data.constants.SoundTypes;
    
    public class IconTextButton extends IconButton
    {
        
        public function IconTextButton()
        {
            super();
            soundType = SoundTypes.ICON_TXT_BTN;
        }
        
        public var alertMC:UIComponent;
        
        protected var _caps:Boolean = true;
        
        public function set icon(param1:String) : void
        {
            if(iconSource != "../maps/icons/buttons/" + param1)
            {
                iconSource = "../maps/icons/buttons/" + param1;
            }
        }
        
        override protected function configUI() : void
        {
            if((iconSource) && iconSource.indexOf("../maps/icons/buttons/") == -1)
            {
                iconSource = "../maps/icons/buttons/" + iconSource;
            }
            super.configUI();
        }
        
        override protected function configIcon() : void
        {
            if(loader)
            {
                loader.x = _iconOffsetLeft;
                loader.y = _iconOffsetTop;
                loader.tabEnabled = loader.mouseEnabled = false;
                loader.visible = true;
            }
        }
        
        public function get caps() : Boolean
        {
            return this._caps;
        }
        
        public function set caps(param1:Boolean) : void
        {
            if(this._caps == param1)
            {
                return;
            }
            this._caps = param1;
            invalidate();
        }
        
        override protected function onDispose() : void
        {
            this.alertMC.dispose();
            this.alertMC = null;
            super.onDispose();
        }
        
        override protected function updateText() : void
        {
            var _loc1_:String = null;
            if(this.caps)
            {
                if(_label != null)
                {
                    _loc1_ = App.utils.locale.makeString(_label,{});
                    if(_loc1_)
                    {
                        _loc1_ = App.utils.toUpperOrLowerCase(_loc1_,true);
                    }
                    else
                    {
                        _loc1_ = "";
                    }
                    if(textField != null)
                    {
                        textField.text = _loc1_;
                    }
                    if(textField1 != null)
                    {
                        textField1.text = _loc1_;
                    }
                    if(blurTextField != null)
                    {
                        blurTextField.text = _loc1_;
                    }
                    if(!(filtersMC == null) && !(filtersMC.textField == null))
                    {
                        filtersMC.textField.text = _loc1_;
                    }
                }
            }
            else
            {
                super.updateText();
                if(blurTextField != null)
                {
                    blurTextField.text = _label;
                }
                if(!(filtersMC == null) && !(filtersMC.textField == null))
                {
                    filtersMC.textField.text = _label;
                }
            }
        }
    }
}
