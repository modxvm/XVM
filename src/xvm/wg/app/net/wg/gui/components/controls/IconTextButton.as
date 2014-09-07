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
            RES_ICONS.maps_icons_buttons(param1);
            var _loc2_:String = RES_ICONS.MAPS_ICONS_BUTTONS + "/" + param1;
            if(iconSource != _loc2_)
            {
                iconSource = _loc2_;
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
        
        override protected function configUI() : void
        {
            if((iconSource) && iconSource.indexOf(RES_ICONS.MAPS_ICONS_BUTTONS + "/") == -1)
            {
                RES_ICONS.maps_icons_buttons(iconSource);
                iconSource = RES_ICONS.MAPS_ICONS_BUTTONS + "/" + iconSource;
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
        
        override protected function getParamsForHelpLayout(param1:String, param2:String, param3:Number) : Object
        {
            return {"borderWidth":width - 3,
            "borderHeight":height - 2,
            "direction":param1,
            "text":param2,
            "x":0,
            "y":0,
            "connectorLength":param3
        };
    }
}
}
