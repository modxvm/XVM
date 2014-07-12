package net.wg.gui.components.controls
{
    import scaleform.clik.controls.Button;
    
    public class HyperLink extends Button
    {
        
        public function HyperLink() {
            this._linkType = LINK_TYPE_NORMAL;
            super();
            buttonMode = true;
        }
        
        public static var LINK_TYPE_NORMAL:String = "normal_";
        
        public static var LINK_TYPE_ORANGE:String = "orange_";
        
        public var isUnderline:Boolean = true;
        
        private var _linkType:String;
        
        public function get linkType() : String {
            return this._linkType;
        }
        
        public function set linkType(param1:String) : void {
            this._linkType = param1;
            setState(_state);
        }
        
        override protected function changeFocus() : void {
            if(!enabled)
            {
                return;
            }
            setState((_focused) || (_displayFocus)?"over":"out");
            if((_pressedByKeyboard) && !_focused)
            {
                _pressedByKeyboard = false;
            }
        }
        
        override protected function updateText() : void {
            if(!(_label == null) && !(textField == null))
            {
                textField.text = _label;
                if(this.isUnderline)
                {
                    textField.htmlText = "<u>" + textField.text + "</u>";
                }
            }
        }
        
        override protected function getStatePrefixes() : Vector.<String> {
            return this.linkType == LINK_TYPE_NORMAL?statesDefault:Vector.<String>([this.linkType,""]);
        }
    }
}
