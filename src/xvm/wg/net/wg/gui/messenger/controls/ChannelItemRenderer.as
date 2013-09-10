package net.wg.gui.messenger.controls 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    
    public class ChannelItemRenderer extends net.wg.gui.components.controls.TextFieldShort
    {
        public function ChannelItemRenderer()
        {
            super();
            return;
        }

        public override function setData(arg1:Object):void
        {
            visible = !(arg1 == null);
            super.setData(arg1);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            visible = !(data == null);
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
                updateAfterStateChange();
                dispatchEvent(new scaleform.clik.events.ComponentEvent(scaleform.clik.events.ComponentEvent.STATE_CHANGE));
                invalidate(scaleform.clik.constants.InvalidationType.DATA, scaleform.clik.constants.InvalidationType.SIZE);
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                updateText();
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
            textField.text = _label;
            if (textField.getLineLength(0) < textField.text.length) 
            {
                loc1 = textField.getLineLength(0);
                if (loc1 < 3) 
                {
                    loc1 = textField.getLineLength(1);
                }
                textField.text = textField.text.substring(0, loc1 - 2) + "..";
            }
            _toolTip = _label;
            return;
        }
    }
}
