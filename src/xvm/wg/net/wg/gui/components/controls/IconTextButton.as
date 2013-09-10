package net.wg.gui.components.controls 
{
    import net.wg.data.constants.*;
    import scaleform.clik.core.*;
    
    public class IconTextButton extends net.wg.gui.components.controls.IconButton
    {
        public function IconTextButton()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.ICON_TXT_BTN;
            return;
        }

        public function set icon(arg1:String):void
        {
            if (iconSource != "../maps/icons/buttons/" + arg1) 
                iconSource = "../maps/icons/buttons/" + arg1;
            return;
        }

        protected override function configUI():void
        {
            iconOffsetTop = 1;
            iconOffsetLeft = 2;
            if (iconSource && iconSource.indexOf("../maps/icons/buttons/") == -1) 
                iconSource = "../maps/icons/buttons/" + iconSource;
            super.configUI();
            return;
        }

        protected override function configIcon():void
        {
            if (loader) 
            {
                loader.x = _iconOffsetLeft;
                loader.y = _iconOffsetTop;
                var loc1:*;
                loader.mouseEnabled = loc1 = false;
                loader.tabEnabled = loc1;
                loader.visible = true;
            }
            return;
        }

        public function get caps():Boolean
        {
            return this._caps;
        }

        public function set caps(arg1:Boolean):void
        {
            if (this._caps == arg1) 
                return;
            this._caps = arg1;
            invalidate();
            return;
        }

        protected override function updateText():void
        {
            var loc1:*=null;
            if (this.caps) 
                if (_label != null) 
                {
                    loc1 = App.utils.locale.makeString(_label, {});
                    if (loc1) 
                        loc1 = loc1.toUpperCase();
                    else 
                        loc1 = "";
                    if (textField != null) 
                        textField.text = loc1;
                    if (textField1 != null) 
                        textField1.text = loc1;
                    if (blurTextField != null) 
                        blurTextField.text = loc1;
                    if (!(filtersMC == null) && !(filtersMC.textField == null)) 
                        filtersMC.textField.text = loc1;
                }
            else 
            {
                super.updateText();
                if (blurTextField != null) 
                    blurTextField.text = _label;
                if (!(filtersMC == null) && !(filtersMC.textField == null)) 
                    filtersMC.textField.text = _label;
            }
            return;
        }

        public var alertMC:scaleform.clik.core.UIComponent;

        protected var _caps:Boolean=true;
    }
}
