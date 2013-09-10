package net.wg.gui.components.controls 
{
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.utils.*;
    import scaleform.clik.utils.*;
    
    public class MainMenuButton extends net.wg.gui.components.controls.SoundButtonEx
    {
        public function MainMenuButton()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.MAIN_MENU;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.paddingHorizontal = 0;
            if (blurTextField) 
            {
                constraints.addElement("blurTextField", blurTextField, scaleform.clik.utils.Constraints.ALL);
            }
            if (filtersMC != null) 
            {
                constraints.addElement("filtersMC", filtersMC, scaleform.clik.utils.Constraints.ALL);
                constraints.addElement("filtersMC.textField", filtersMC.textField, scaleform.clik.utils.Constraints.ALL);
            }
            addEventListener(flash.events.MouseEvent.ROLL_OVER, this.onBtnOver);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, this.onBtnOut);
            this.checkBrowserEffect();
            return;
        }

        public override function get paddingHorizontal():Number
        {
            return _paddingHorizontal;
        }

        public override function set paddingHorizontal(arg1:Number):void
        {
            _paddingHorizontal = arg1;
            invalidate();
            return;
        }

        public function get caps():Boolean
        {
            return this._caps;
        }

        public function set caps(arg1:Boolean):void
        {
            if (this._caps == arg1) 
            {
                return;
            }
            this._caps = arg1;
            invalidate();
            return;
        }

        public override function set enabled(arg1:Boolean):void
        {
            super.enabled = arg1;
            if (arg1) 
            {
                this.checkBrowserEffect();
            }
            return;
        }

        protected override function updateText():void
        {
            var loc1:*=null;
            if (this.caps) 
            {
                if (_label != null) 
                {
                    loc1 = App.utils.locale.makeString(_label, {});
                    if (loc1) 
                    {
                        loc1 = loc1.toUpperCase();
                    }
                    else 
                    {
                        loc1 = "";
                    }
                    if (textField != null) 
                    {
                        textField.text = loc1;
                    }
                    if (textField1 != null) 
                    {
                        textField1.text = loc1;
                    }
                    if (blurTextField != null) 
                    {
                        blurTextField.text = loc1;
                    }
                    if (!(filtersMC == null) && !(filtersMC.textField == null)) 
                    {
                        filtersMC.textField.text = loc1;
                    }
                }
            }
            else 
            {
                super.updateText();
                if (blurTextField != null) 
                {
                    blurTextField.text = _label;
                }
                if (!(filtersMC == null) && !(filtersMC.textField == null)) 
                {
                    filtersMC.textField.text = _label;
                }
            }
            return;
        }

        protected override function alignForAutoSize():void
        {
            var loc1:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            if (!initialized || _autoSize == flash.text.TextFieldAutoSize.NONE || !textField && !filtersMC) 
            {
                return;
            }
            loc1 = _width;
            var loc5:*;
            _width = loc5 = this.calculateWidth();
            var loc2:*=loc5;
            loc5 = _autoSize;
            switch (loc5) 
            {
                case flash.text.TextFieldAutoSize.RIGHT:
                {
                    loc3 = x + loc1;
                    x = loc3 - loc2;
                    break;
                }
                case flash.text.TextFieldAutoSize.CENTER:
                {
                    loc4 = x + loc1 * 0.5;
                    x = loc4 - loc2 * 0.5;
                    break;
                }
            }
            return;
        }

        protected override function updateAfterStateChange():void
        {
            super.updateAfterStateChange();
            if (!(constraints == null) && !constraintsDisabled) 
            {
                if (filtersMC != null) 
                {
                    constraints.updateElement("filtersMC.textField", filtersMC.textField);
                    constraints.updateElement("filtersMC", filtersMC);
                }
                if (blurTextField != null) 
                {
                    constraints.updateElement("blurTextField", blurTextField);
                }
            }
            return;
        }

        protected override function calculateWidth():Number
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=actualWidth;
            if (!constraintsDisabled && initialized) 
            {
                loc2 = constraints.getElement(textField ? "textField" : "blurTextField");
                loc3 = textField ? textField : blurTextField;
                loc1 = loc3.textWidth + loc2.left + loc2.right + 5 + (_paddingHorizontal << 1);
            }
            return loc1;
        }

        protected override function draw():void
        {
            super.draw();
            if (_textColor && enabled) 
            {
                if (!(filtersMC == null) && !(filtersMC.textField == null)) 
                {
                    filtersMC.textField.textColor = _textColor;
                }
            }
            return;
        }

        public override function showHelpLayout():void
        {
            var loc1:*=App.utils.helpLayout;
            var loc2:*={"borderWidth":width, "borderHeight":filtersMC.textField.textHeight - 4, "direction":data["helpDirection"], "text":data["helpText"], "x":0, "y":(filtersMC.height - filtersMC.textField.textHeight) / 2, "connectorLength":data["helpConnectorLength"]};
            if (data["helpText"]) 
            {
                setHelpLayout(loc1.create(root, loc2, this));
            }
            return;
        }

        internal function checkBrowserEffect():void
        {
            if (data && data.value == "browser") 
            {
                App.utils.scheduler.scheduleTask(this.changeEffectState, 1000);
                selected = false;
            }
            return;
        }

        internal function changeEffectState():void
        {
            var loc1:*=null;
            if (selected || !enabled) 
            {
                filters = [];
                this._isBlinking = false;
                return;
            }
            this._isBlinking = !this._isBlinking;
            if (this._isBlinking) 
            {
                loc1 = [];
                loc1 = loc1.concat([1.3, 0, 0, 0, 0]);
                loc1 = loc1.concat([0, 1.3, 0, 0, 0]);
                loc1 = loc1.concat([0, 0, 1.3, 0, 0]);
                loc1 = loc1.concat([0, 0, 0, 1, 0]);
                filters = [new flash.filters.ColorMatrixFilter(loc1)];
            }
            else 
            {
                filters = [];
            }
            App.utils.scheduler.scheduleTask(this.changeEffectState, 1000);
            return;
        }

        internal function onBtnOver(arg1:flash.events.MouseEvent):void
        {
            if (data && data.value == "browser") 
            {
                App.utils.scheduler.cancelTask(this.changeEffectState);
                filters = [];
            }
            return;
        }

        internal function onBtnOut(arg1:flash.events.MouseEvent):void
        {
            this.checkBrowserEffect();
            return;
        }

        internal var _caps:Boolean=true;

        internal var _isBlinking:Boolean=false;
    }
}
