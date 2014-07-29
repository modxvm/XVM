package net.wg.gui.lobby.profile.headerBar
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.MovieClip;
    import scaleform.clik.constants.InvalidationType;
    import flash.text.TextFieldAutoSize;
    
    public class ProfileTabButton extends SoundButtonEx
    {
        
        public function ProfileTabButton()
        {
            super();
            preventAutosizing = true;
            constraintsDisabled = true;
            this.widthOffset = this.highLight.width - this.backGround.width;
        }
        
        private static var LAST_LINE_INVALID:String = "lli";
        
        public var hit:MovieClip;
        
        public var highLight:MovieClip;
        
        public var backGround:MovieClip;
        
        private var textHOffset:uint = 14;
        
        private var _showLastLineItem:Boolean;
        
        private var widthOffset:uint;
        
        override protected function initialize() : void
        {
            super.initialize();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            hitArea = this.hit;
            this.hit.visible = false;
        }
        
        override protected function draw() : void
        {
            var _loc1_:uint = 0;
            var _loc2_:ProfileTabButtonBg = null;
            if(_baseDisposed)
            {
                return;
            }
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                textField.autoSize = TextFieldAutoSize.LEFT;
                textField.x = this.textHOffset;
                _loc1_ = this.receiveWidth();
                this.highLight.width = _loc1_ + this.widthOffset;
                this.backGround.width = _loc1_;
                this.hit.width = _loc1_;
            }
            if(isInvalid(LAST_LINE_INVALID))
            {
                _loc2_ = this.backGround as ProfileTabButtonBg;
                if(_loc2_)
                {
                    _loc2_.lastLine.visible = this._showLastLineItem;
                }
            }
        }
        
        override public function set data(param1:Object) : void
        {
            super.data = param1;
            if(data is String)
            {
                this.label = param1.toString();
            }
            else
            {
                this.label = data.label;
            }
        }
        
        override public function set label(param1:String) : void
        {
            super.label = App.utils.toUpperOrLowerCase(param1,true);
        }
        
        private function receiveWidth() : uint
        {
            if(textField)
            {
                return Math.round(textField.width + 2 * this.textHOffset);
            }
            return super.width;
        }
        
        override protected function updateAfterStateChange() : void
        {
            super.updateAfterStateChange();
            invalidate(LAST_LINE_INVALID);
        }
        
        override protected function updateText() : void
        {
            super.updateText();
            invalidate(InvalidationType.SIZE);
        }
        
        override public function get width() : Number
        {
            return this.receiveWidth();
        }
        
        public function set showLastLineItem(param1:Boolean) : void
        {
            this._showLastLineItem = param1;
            invalidate(LAST_LINE_INVALID);
        }
    }
}
