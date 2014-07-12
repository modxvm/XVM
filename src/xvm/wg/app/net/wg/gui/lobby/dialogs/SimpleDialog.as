package net.wg.gui.lobby.dialogs
{
    import net.wg.infrastructure.base.meta.impl.SimpleDialogMeta;
    import net.wg.infrastructure.base.meta.ISimpleDialogMeta;
    import scaleform.clik.controls.Button;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.infrastructure.interfaces.IWindow;
    import scaleform.clik.utils.Padding;
    import flash.display.InteractiveObject;
    import flash.text.TextFieldAutoSize;
    import net.wg.data.constants.SoundTypes;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.windows.Window;
    import flash.events.EventPhase;
    
    public class SimpleDialog extends SimpleDialogMeta implements ISimpleDialogMeta
    {
        
        public function SimpleDialog() {
            this._minWidth = this.MIN_WIDTH;
            this._minHeight = this.MIN_HEIGHT;
            super();
            isModal = true;
        }
        
        public static var SUBMIT_BUTTON:String = "submit";
        
        public static var CLOSE_BUTTON:String = "close";
        
        protected static var ADDITIONAL_MULTI_LINE_PADDING:uint = 10;
        
        private static var TEXT_HEIGHT_PADDING:uint = 3;
        
        private static var WINDOW_PADDING:Object;
        
        private static var LAYOUT_INVALID:String = "layoutInv";
        
        private static var BUTTON_ENABLE_INVALID:String = "btnEnInv";
        
        private static var BUTTON_FOCUS_INVALID:String = "btnFocusInv";
        
        private static function hideBtnProcessor(param1:Button) : void {
            param1.visible = false;
        }
        
        public var textField:TextField = null;
        
        public var firstBtn:SoundButtonEx = null;
        
        public var secondBtn:SoundButtonEx = null;
        
        public var thirdBtn:SoundButtonEx = null;
        
        public var dynamicWhiteButton:SoundButtonEx = null;
        
        private var _minWidth:Number;
        
        private var _minHeight:Number;
        
        private var _btnEnableCandidate:ItemStatusData;
        
        private var _btnFocusCandidateId:String;
        
        private var _lastFocusedBtn:SoundButtonEx = null;
        
        protected var BTN_MARGIN:Number = 9;
        
        private var MIN_WIDTH:Number = 360;
        
        private var MIN_HEIGHT:Number = 115;
        
        override public function setWindow(param1:IWindow) : void {
            var _loc2_:Padding = null;
            super.setWindow(param1);
            if(window)
            {
                _loc2_ = window.contentPadding as Padding;
                _loc2_.right = WINDOW_PADDING.right;
                _loc2_.bottom = WINDOW_PADDING.bottom;
            }
        }
        
        override protected function onSetModalFocus(param1:InteractiveObject) : void {
            super.onSetModalFocus(param1);
            setFocus(this._lastFocusedBtn);
        }
        
        public function as_setText(param1:String) : void {
            this.textField.htmlText = param1;
            this.textField.autoSize = TextFieldAutoSize.LEFT;
            this.invalidateLayout();
        }
        
        public function as_setTitle(param1:String) : void {
            window.title = param1;
        }
        
        public function as_setButtons(param1:Array) : void {
            var _loc4_:* = NaN;
            var _loc5_:SoundButtonEx = null;
            var _loc6_:String = null;
            var _loc2_:Vector.<Button> = this.getButtonsOrder();
            var _loc3_:Number = _loc2_.length - param1.length;
            assert(_loc3_ >= 0,"buttonNames too much");
            _loc4_ = param1.length - 1;
            while(_loc4_ >= 0)
            {
                _loc5_ = _loc2_[_loc4_ + _loc3_] as SoundButtonEx;
                _loc6_ = param1[_loc4_].id;
                if(_loc6_ == CLOSE_BUTTON)
                {
                    this.dynamicWhiteButton.x = _loc5_.x;
                    this.dynamicWhiteButton.y = _loc5_.y;
                    this.dynamicWhiteButton.data = param1[_loc4_];
                    this.dynamicWhiteButton.label = param1[_loc4_].label;
                    if(param1[_loc4_].focused)
                    {
                        this._lastFocusedBtn = this.dynamicWhiteButton;
                    }
                    this.dynamicWhiteButton.visible = true;
                    this.dynamicWhiteButton.soundType = SoundTypes.CANCEL_BTN;
                    this.addListenerButtonProcessor(this.dynamicWhiteButton);
                    _loc5_.visible = false;
                }
                else
                {
                    _loc5_.data = param1[_loc4_];
                    _loc5_.label = param1[_loc4_].label;
                    if(param1[_loc4_].focused)
                    {
                        this._lastFocusedBtn = _loc5_;
                    }
                    _loc5_.visible = true;
                    if(_loc6_ == SUBMIT_BUTTON)
                    {
                        _loc5_.soundType = SoundTypes.OK_BTN;
                    }
                    else
                    {
                        _loc5_.soundType = SoundTypes.NORMAL_BTN;
                    }
                }
                _loc4_--;
            }
        }
        
        public function as_setButtonEnabling(param1:String, param2:Boolean) : void {
            if(!this._btnEnableCandidate)
            {
                this._btnEnableCandidate = new ItemStatusData();
            }
            this._btnEnableCandidate.id = param1;
            this._btnEnableCandidate.status = param2;
            invalidate(BUTTON_ENABLE_INVALID);
        }
        
        public function as_setButtonFocus(param1:String) : void {
            this._btnFocusCandidateId = param1;
            invalidate(BUTTON_FOCUS_INVALID);
        }
        
        override public function get height() : Number {
            var _loc1_:Number = this.thirdBtn.height;
            return this.getBackgroundActualHeight() + TEXT_HEIGHT_PADDING + _loc1_;
        }
        
        public function get minWidth() : Number {
            return this._minWidth;
        }
        
        public function set minWidth(param1:Number) : void {
            if(param1 == this._minWidth)
            {
                return;
            }
            this._minWidth = param1;
        }
        
        public function get minHeight() : Number {
            return this._minHeight;
        }
        
        public function set minHeight(param1:Number) : void {
            if(param1 == this._minHeight)
            {
                return;
            }
            this._minHeight = param1;
            this.updateActualSize();
        }
        
        override protected function onPopulate() : void {
            window.useBottomBtns = true;
            canDrag = false;
            this.reflowDialogToCtrl();
            updateStage(App.appWidth,App.appHeight);
            this.processButtons(this.addListenerButtonProcessor);
            super.onPopulate();
        }
        
        override protected function onDispose() : void {
            this.processButtons(this.removeListenerButtonProcessor);
            this.dynamicWhiteButton.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHdlr);
            this._lastFocusedBtn = null;
            if(this.textField)
            {
                this.textField.text = "";
                if(this.textField.parent)
                {
                    this.textField.parent.removeChild(this.textField);
                }
                this.textField = null;
            }
            super.onDispose();
        }
        
        override protected function draw() : void {
            var _loc2_:String = null;
            var _loc3_:* = false;
            var _loc4_:Button = null;
            var _loc5_:uint = 0;
            var _loc6_:* = 0;
            var _loc7_:SoundButtonEx = null;
            super.draw();
            if(isInvalid(LAYOUT_INVALID))
            {
                this.applyLayout();
            }
            var _loc1_:Vector.<SoundButtonEx> = null;
            if((isInvalid(BUTTON_ENABLE_INVALID)) && (this._btnEnableCandidate))
            {
                _loc2_ = this._btnEnableCandidate.id;
                _loc3_ = this._btnEnableCandidate.status;
                _loc1_ = this.getAllButtons();
                _loc5_ = _loc1_.length;
                _loc6_ = 0;
                while(_loc6_ < _loc5_)
                {
                    _loc4_ = _loc1_[_loc6_];
                    if((_loc4_.data) && (_loc4_.data.hasOwnProperty("id")))
                    {
                        if(_loc2_ == _loc4_.data.id)
                        {
                            _loc4_.enabled = _loc3_;
                            break;
                        }
                    }
                    _loc6_++;
                }
            }
            if((isInvalid(BUTTON_FOCUS_INVALID)) && (this._btnFocusCandidateId))
            {
                _loc1_ = this.getAllButtons();
                for each(_loc7_ in _loc1_)
                {
                    if((_loc7_.data) && (_loc7_.data.hasOwnProperty("id")) && this._btnFocusCandidateId == _loc7_.data.id)
                    {
                        if(_loc7_.enabled)
                        {
                            this._lastFocusedBtn = _loc7_;
                        }
                        break;
                    }
                }
            }
        }
        
        protected function invalidateLayout() : void {
            invalidate(LAYOUT_INVALID);
        }
        
        protected function applyLayout() : void {
            this.layoutButtons(this.getBackgroundActualHeight());
            UIComponent(window).invalidate(Window.INVALID_SRC_VIEW);
        }
        
        protected function getBackgroundActualHeight() : Number {
            return Math.max(this.getTextAreaCurrentHeight(),this.getTextAreaMinHeight());
        }
        
        protected function getTextAreaMinHeight() : Number {
            var _loc1_:Number = this.thirdBtn.height;
            return Math.ceil(this._minHeight - _loc1_ - TEXT_HEIGHT_PADDING);
        }
        
        protected function getTextAreaCurrentHeight() : Number {
            return Math.ceil(this.textField.y + this.textField.textHeight + ADDITIONAL_MULTI_LINE_PADDING);
        }
        
        protected function layoutButtons(param1:Number) : void {
            var _loc2_:Vector.<SoundButtonEx> = this.getAllButtons();
            var _loc3_:uint = _loc2_.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                _loc2_[_loc4_].y = param1;
                _loc4_++;
            }
        }
        
        protected function getButtonsOrder() : Vector.<Button> {
            return Vector.<Button>([this.firstBtn,this.secondBtn,this.thirdBtn]);
        }
        
        protected function getAllButtons() : Vector.<SoundButtonEx> {
            return Vector.<SoundButtonEx>([this.firstBtn,this.secondBtn,this.thirdBtn,this.dynamicWhiteButton]);
        }
        
        protected function updateActualSize() : void {
            this.textField.height = Math.max(this.textField.textHeight,this._minHeight - this.thirdBtn.height - this.BTN_MARGIN);
            var _loc1_:Number = this.getBackgroundActualHeight();
            window.setMinHeight(_loc1_);
            window.setSize(actualWidth,_loc1_);
        }
        
        private function reflowDialogToCtrl() : void {
            this.processButtons(hideBtnProcessor);
        }
        
        private function processButtons(param1:Function) : void {
            var _loc2_:Button = null;
            for each(_loc2_ in this.getButtonsOrder())
            {
                param1(_loc2_);
            }
        }
        
        private function addListenerButtonProcessor(param1:Button) : void {
            param1.addEventListener(ButtonEvent.CLICK,this.onButtonClickHdlr);
        }
        
        private function removeListenerButtonProcessor(param1:Button) : void {
            param1.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHdlr);
        }
        
        private function onButtonClickHdlr(param1:ButtonEvent) : void {
            var _loc2_:String = null;
            if(param1.eventPhase == EventPhase.AT_TARGET)
            {
                _loc2_ = Button(param1.target).data.id;
                assertNotNull(_loc2_,"Button has not unique name");
                onButtonClickS(_loc2_);
            }
        }
    }
}
