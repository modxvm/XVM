package net.wg.gui.lobby.messengerBar.carousel
{
    import net.wg.gui.components.advanced.BlinkingButton;
    import net.wg.infrastructure.interfaces.IDynamicContent;
    import flash.events.MouseEvent;
    
    public class ChannelButton extends BlinkingButton implements IDynamicContent
    {
        
        public function ChannelButton() {
            super();
            constraintsDisabled = true;
            _iconOffsetLeft = 1;
            _iconOffsetTop = 1;
        }
        
        override public function set label(param1:String) : void {
            super.label = param1;
            tooltip = "";
        }
        
        override public function set iconSource(param1:String) : void {
            if(iconSource != param1)
            {
                super.iconSource = param1;
                setState(state);
            }
        }
        
        override protected function configUI() : void {
            super.configUI();
        }
        
        override protected function draw() : void {
            super.draw();
        }
        
        override protected function getStatePrefixes() : Vector.<String> {
            var _loc1_:String = iconSource?"icon_":"";
            if(blinking)
            {
                return Vector.<String>(_selected?["selected_",_loc1_ + "blinking_"]:[_loc1_ + "blinking_"]);
            }
            return Vector.<String>(_selected?["selected_",_loc1_]:[_loc1_]);
        }
        
        override protected function updateAfterStateChange() : void {
            super.updateAfterStateChange();
        }
        
        override protected function handleMouseRollOver(param1:MouseEvent) : void {
            super.handleMouseRollOver(param1);
            if(tooltip)
            {
                App.toolTipMgr.show(tooltip);
            }
        }
        
        override protected function handleMouseRollOut(param1:MouseEvent) : void {
            super.handleMouseRollOut(param1);
            App.toolTipMgr.hide();
        }
        
        override protected function updateText() : void {
            if(!(_label == null) && !(textField == null))
            {
                textField.text = _label;
                this.truncateText();
            }
        }
        
        private function truncateText() : void {
            var _loc1_:String = null;
            var _loc2_:String = null;
            var _loc3_:uint = 0;
            if(textField.textWidth > textField.width)
            {
                tooltip = _label;
                _loc1_ = textField.text.length > 0?textField.text:_label;
                _loc2_ = _loc1_;
                _loc3_ = 1;
                while(_loc2_.length > 0 && _loc3_ > 0)
                {
                    _loc2_ = _loc1_.substring(0,_loc1_.length - _loc3_) + "..";
                    textField.text = _loc2_;
                    if(textField.textWidth > textField.width)
                    {
                        _loc3_++;
                    }
                    else
                    {
                        _loc3_ = 0;
                    }
                }
            }
        }
    }
}
