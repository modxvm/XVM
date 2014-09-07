package net.wg.gui.lobby.messengerBar.carousel
{
    import net.wg.gui.components.advanced.BlinkingButton;
    import net.wg.infrastructure.interfaces.IDynamicContent;
    import scaleform.clik.utils.Padding;
    import flash.display.MovieClip;
    import flash.geom.ColorTransform;
    import scaleform.clik.utils.ConstrainedElement;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.MouseEvent;
    
    public class ChannelButton extends BlinkingButton implements IDynamicContent
    {
        
        public function ChannelButton()
        {
            super();
            _iconOffsetLeft = 1;
            _iconOffsetTop = 1;
        }
        
        private static var TF_PADDING_INVALID:String = "tfpInv";
        
        private static var COLOR_BG_VISIBLE_INVALID:String = "cBgVisibleInv";
        
        private static var TF_COLOR_TRANSFORM_INVALID:String = "tfCtInv";
        
        private static var LABEL_INVALID:String = "lblInv";
        
        private var _tfPadding:Padding;
        
        public var mcColorBg:MovieClip;
        
        private var _selectedFocused:Boolean;
        
        private var colorBgVisible:Boolean = false;
        
        private var _textFieldColorTransform:ColorTransform;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.mcColorBg.visible = false;
        }
        
        override protected function draw() : void
        {
            var _loc1_:ConstrainedElement = null;
            if((isInvalid(TF_PADDING_INVALID)) && (this._tfPadding))
            {
                _loc1_ = constraints.getElement(textField.name);
                _loc1_.left = this._tfPadding.left;
                _loc1_.right = this._tfPadding.right;
            }
            super.draw();
            if((isInvalid(InvalidationType.STATE)) || (isInvalid(TF_COLOR_TRANSFORM_INVALID)) && (this._textFieldColorTransform))
            {
                textField.transform.colorTransform = this._textFieldColorTransform;
            }
            if((isInvalid(InvalidationType.STATE)) || (isInvalid(COLOR_BG_VISIBLE_INVALID)))
            {
                this.mcColorBg.visible = this.colorBgVisible;
            }
            if((isInvalid(LABEL_INVALID)) || (isInvalid(InvalidationType.STATE)))
            {
                App.utils.commons.truncateTextFieldText(textField,_label);
            }
        }
        
        override public function set label(param1:String) : void
        {
            var _loc2_:String = ((_iconSource) && !(_iconSource == "")?"     ":"") + param1;
            if(_loc2_ != label)
            {
                super.label = _loc2_;
                this.tooltip = param1;
                invalidate(LABEL_INVALID);
            }
        }
        
        override public function set tooltip(param1:String) : void
        {
            if(_tooltip != param1)
            {
                _tooltip = param1;
                App.toolTipMgr.hide();
            }
        }
        
        override public function set width(param1:Number) : void
        {
            if(width != param1)
            {
                super.width = param1;
                invalidate(LABEL_INVALID);
            }
        }
        
        override protected function getStatePrefixes() : Vector.<String>
        {
            var _loc1_:* = "";
            if(blinking)
            {
                if(this._selectedFocused)
                {
                    return Vector.<String>(["focused_",_loc1_ + "blinking_"]);
                }
                return Vector.<String>(_selected?["selected_",_loc1_ + "blinking_"]:[_loc1_ + "blinking_"]);
            }
            if(this._selectedFocused)
            {
                return Vector.<String>(["focused_",_loc1_]);
            }
            return Vector.<String>(_selected?["selected_",_loc1_]:[_loc1_]);
        }
        
        override public function showTooltip(param1:MouseEvent) : void
        {
            if((_tooltip) && (App.toolTipMgr))
            {
                App.toolTipMgr.show(_tooltip);
            }
        }
        
        override protected function handleMouseRollOut(param1:MouseEvent) : void
        {
            super.handleMouseRollOut(param1);
            App.toolTipMgr.hide();
        }
        
        override protected function updateText() : void
        {
            if(!(_label == null) && !(textField == null))
            {
                textField.text = _label;
            }
        }
        
        public function get selectedFocused() : Boolean
        {
            return this._selectedFocused;
        }
        
        public function set selectedFocused(param1:Boolean) : void
        {
            if(this._selectedFocused != param1)
            {
                this._selectedFocused = param1;
                if(_state == "out")
                {
                    setState("up");
                }
                else
                {
                    setState(state);
                }
            }
        }
        
        public function set textFieldPadding(param1:Padding) : void
        {
            this._tfPadding = param1;
            invalidate(TF_PADDING_INVALID);
            invalidateState();
        }
        
        public function showColorBg(param1:Boolean) : void
        {
            this.colorBgVisible = param1;
            invalidate(COLOR_BG_VISIBLE_INVALID);
        }
        
        public function setTextFieldColorTransform(param1:ColorTransform) : void
        {
            this._textFieldColorTransform = param1;
            invalidate(TF_COLOR_TRANSFORM_INVALID);
        }
    }
}
