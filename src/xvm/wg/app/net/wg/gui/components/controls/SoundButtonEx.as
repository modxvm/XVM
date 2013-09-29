package net.wg.gui.components.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class SoundButtonEx extends net.wg.gui.components.controls.SoundButton implements net.wg.infrastructure.interfaces.IHelpLayoutComponent
    {
        public function SoundButtonEx()
        {
            super();
            return;
        }

        public function get tooltip():String
        {
            return this._tooltip;
        }

        public function set tooltip(arg1:String):void
        {
            if (this._tooltip == arg1) 
            {
                return;
            }
            this._tooltip = arg1;
            invalidate();
            return;
        }

        public function showHelpLayout():void
        {
            var loc1:*=null;
            if (this.helpText.length > 0) 
            {
                loc1 = {"borderWidth":width, "borderHeight":height, "direction":this.helpDirection, "text":this.helpText, "x":0, "y":0, "connectorLength":this.helpConnectorLength};
                this.setHelpLayout(App.utils.helpLayout.create(this.root, loc1, this));
            }
            return;
        }

        public function closeHelpLayout():void
        {
            if (this.getHelpLayout() != null) 
            {
                App.utils.helpLayout.destroy(this.getHelpLayout());
            }
            return;
        }

        protected function getHelpLayout():flash.display.DisplayObject
        {
            return this._helpLayout;
        }

        protected function setHelpLayout(arg1:flash.display.DisplayObject):void
        {
            this._helpLayout = arg1;
            return;
        }

        protected override function updateAfterStateChange():void
        {
            if (!initialized) 
            {
                return;
            }
            if (!(constraints == null) && !constraintsDisabled) 
            {
                if (textField != null) 
                {
                    constraints.updateElement("textField", textField);
                }
                if (this.textField1 != null) 
                {
                    constraints.updateElement("textField1", this.textField1);
                }
            }
            dispatchEvent(new net.wg.gui.events.StateManagerEvent(scaleform.clik.events.ComponentEvent.STATE_CHANGE, state));
            return;
        }

        internal function updateDisable():void
        {
            if (this.disableMc != null) 
            {
                this.disableMc.visible = !enabled;
                var loc1:*;
                this.disableMc.y = loc1 = this._fillPadding;
                this.disableMc.x = loc1;
                this.disableMc.scaleX = 1 / this.scaleX;
                this.disableMc.scaleY = 1 / this.scaleY;
                this.disableMc.widthFill = Math.round(this.bgMc.width * this.scaleX) - this._fillPadding * 2;
                this.disableMc.heightFill = Math.round(this.bgMc.height * this.scaleY) - this._fillPadding * 2;
            }
            return;
        }

        public function get paddingHorizontal():Number
        {
            return this._paddingHorizontal;
        }

        public function set paddingHorizontal(arg1:Number):void
        {
            this._paddingHorizontal = arg1;
            if (!(autoSize == "none") && !(textField == null) && initialized) 
            {
                var loc1:*;
                width = loc1 = this.calculateWidth();
                _width = loc1;
            }
            this.updateAfterStateChange();
            return;
        }

        protected override function calculateWidth():Number
        {
            var loc2:*=NaN;
            var loc3:*=null;
            var loc1:*=actualWidth;
            if (!constraintsDisabled) 
            {
                loc2 = 0;
                if (autoSize != "none") 
                {
                    loc2 = this._paddingHorizontal;
                }
                loc3 = constraints.getElement("textField");
                loc1 = Math.ceil(textField.textWidth + loc3.left + loc3.right + 5 + loc2 * 2);
            }
            return loc1;
        }

        public override function toString():String
        {
            return "[WG SoundButtonEx " + name + "]";
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE)) 
            {
                if (_newFrame) 
                {
                    gotoAndPlay(_newFrame);
                    _newFrame = null;
                }
                if (focusIndicator && _newFocusIndicatorFrame) 
                {
                    focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
                    _newFocusIndicatorFrame = null;
                }
                this.updateAfterStateChange();
                dispatchEvent(new scaleform.clik.events.ComponentEvent(scaleform.clik.events.ComponentEvent.STATE_CHANGE));
                invalidate(scaleform.clik.constants.InvalidationType.DATA, scaleform.clik.constants.InvalidationType.SIZE);
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.updateText();
                if (autoSize != flash.text.TextFieldAutoSize.NONE) 
                {
                    invalidateSize();
                }
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                if (!preventAutosizing) 
                {
                    alignForAutoSize();
                    setActualSize(_width, _height);
                }
                if (!constraintsDisabled) 
                {
                    constraints.update(_width, _height);
                }
            }
            this.updateDisable();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            if (!constraintsDisabled) 
            {
                if (this.textField1 != null) 
                {
                    constraints.addElement("textField1", this.textField1, scaleform.clik.utils.Constraints.ALL);
                }
            }
            addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleMouseDown);
            if (!(focusIndicator == null) && !_focused && focusIndicator.totalFrames == 1) 
            {
                focusIndicator.visible = false;
            }
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleMouseDown);
            this._helpLayout = null;
            this.blurTextField = null;
            this.textField1 = null;
            if (this.disableMc) 
            {
                this.disableMc.dispose();
                this.disableMc = null;
            }
            this.bgMc = null;
            this.filtersMC = null;
            super.dispose();
            return;
        }

        public function showTooltip(arg1:flash.events.MouseEvent):void
        {
            if (this._tooltip && App.toolTipMgr) 
            {
                App.toolTipMgr.showComplex(this._tooltip);
            }
            return;
        }

        public function hideTooltip(arg1:flash.events.MouseEvent):void
        {
            if (App.toolTipMgr) 
            {
                App.toolTipMgr.hide();
            }
            return;
        }

        public function handleMouseDown(arg1:flash.events.MouseEvent):void
        {
            this.hideTooltip(arg1);
            return;
        }

        public function get fillPadding():Number
        {
            return this._fillPadding;
        }

        public function set fillPadding(arg1:Number):void
        {
            if (arg1 == this._fillPadding) 
            {
                return;
            }
            this._fillPadding = arg1;
            return;
        }

        protected override function updateText():void
        {
            super.updateText();
            if (_label != null) 
            {
                if (this.textField1 != null) 
                {
                    this.textField1.text = _label;
                }
            }
            return;
        }

        public function get textColor():Number
        {
            return this._textColor;
        }

        public function set textColor(arg1:Number):void
        {
            if (this._textColor == arg1) 
            {
                return;
            }
            this._textColor = arg1;
            invalidate();
            return;
        }

        protected var _tooltip:String=null;

        public var helpText:String="";

        public var helpDirection:String="T";

        public var helpConnectorLength:Number=12;

        public var _fillPadding:Number=0;

        protected var _paddingHorizontal:Number=5;

        internal var _helpLayout:flash.display.DisplayObject=null;

        public var blurTextField:flash.text.TextField;

        public var disableMc:net.wg.gui.components.controls.BitmapFill;

        public var bgMc:flash.display.MovieClip;

        public var textField1:flash.text.TextField;

        public var filtersMC:flash.display.MovieClip;

        public var _textColor:Number;
    }
}
