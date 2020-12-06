package net.wg.gui.notification
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.notification.vo.ButtonVO;
    import net.wg.gui.notification.vo.MessageInfoVO;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.controls.BitmapFill;
    import flash.text.TextField;
    import net.wg.gui.components.common.CounterView;
    import net.wg.gui.notification.vo.NotificationInfoVO;
    import net.wg.gui.components.containers.Group;
    import net.wg.utils.IClassFactory;
    import flash.text.TextFieldAutoSize;
    import flash.events.TextEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.events.UILoaderEvent;
    import net.wg.gui.components.containers.HorizontalGroupLayout;
    import net.wg.gui.notification.constants.MessageMetrics;
    import net.wg.gui.notification.constants.ButtonType;
    import scaleform.clik.events.ButtonEvent;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.Linkages;
    import net.wg.data.constants.Values;
    import flash.text.TextFormatAlign;
    import flash.events.Event;
    import net.wg.data.constants.Errors;
    import net.wg.gui.notification.events.ServiceMessageEvent;
    import flash.display.DisplayObject;

    public class ServiceMessage extends UIComponentEx
    {

        private static const DATA_INVALID:String = "dataInv";

        private static const LAYOUT_INVALID:String = "layoutInv";

        private static const TIMESTAMP_INVALID:String = "tsInv";

        private static const BMP_FILL_WIDTH:uint = 100;

        private static const BMP_FILL_HEIGHT:uint = 50;

        private static const BMP_FILL_SOURCE_LABEL:String = "BackgroundFill";

        private static const BMP_FILL_START_POS:String = "TL";

        private static const BMP_FILL_REPEAT:String = "all";

        private static const MSG_TYPE_ACTION:String = "action";

        private static const MSG_TYPE_NY_BOXES:String = "nyBoxes";

        private static const CANT_CREATE_BUTTON:String = "Can\'t create button";

        private static const NY_ICON_X:int = 20;

        private static const NY_ICON_Y:int = 0;

        private static const NY_TEXT_Y:int = 141;

        private static const NY_TEXT_X:int = 19;

        private static const NY_BG_ICON_OFFET:int = 20;

        private static const NY_COUNTER_X:int = 213;

        private static const NY_COUNTER_Y:int = 77;

        private static const NY_COUNTER_SMALL_X:int = 195;

        private static const NY_COUNTER_SMALL_Y:int = 77;

        private static const NY_BTN_PADDING:int = 12;

        private static const NY_BOTTOM_OFFSET:int = 30;

        private static const NY_COUNTER_NAME:String = "nyCounter";

        private static const FIELD_CATEGORY:String = "category";

        private static const FIELD_COUNT:String = "count";

        private static const NY_TEXT_W:int = 250;

        public var background:MovieClip;

        public var icon:UILoaderAlt;

        public var bgIcon:UILoaderAlt;

        public var bmpFill:BitmapFill;

        public var textField:TextField;

        private var _nyCounter:CounterView = null;

        private var _nyBg:MovieClip = null;

        private var _isTFClickedByMBR:Boolean = false;

        private var _timeComponent:NotificationTimeComponent;

        private var _messageTopOffset:int = 17;

        private var _messageBottomOffset:int = 18;

        private var _buttonPadding:int = 10;

        private var _data:NotificationInfoVO;

        private var _buttonsGroup:Group;

        private var _timeStamp:String = "";

        private var _classFactory:IClassFactory;

        private var _textDefaultX:int = -1;

        private var _textDefaultY:int = -1;

        private var _textDefaultW:int = -1;

        private var _iconDefaultY:int = -1;

        private var _isNYMessage:Boolean = false;

        public function ServiceMessage()
        {
            this._classFactory = App.utils.classFactory;
            super();
            _deferredDispose = true;
        }

        private static function updateButton(param1:SoundButtonEx, param2:ButtonVO, param3:MessageInfoVO) : void
        {
            var _loc4_:String = param2.type;
            param1.name = _loc4_;
            param1.width = param2.width;
            param1.label = param2.label;
            param1.data = param2.action;
            param1.enabled = param3.isButtonEnabled(_loc4_);
            param1.visible = param3.isButtonVisible(_loc4_);
            param1.validateNow();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._textDefaultX = this.textField.x;
            this._textDefaultY = this.textField.y;
            this._textDefaultW = this.textField.width;
            this._iconDefaultY = this.icon.y;
            _focusable = tabEnabled = false;
            App.utils.styleSheetManager.setLinkStyle(this.textField);
            this.textField.autoSize = TextFieldAutoSize.LEFT;
            this.textField.multiline = true;
            this.textField.wordWrap = true;
            this.textField.selectable = true;
            this.background.tabEnabled = false;
            this.textField.addEventListener(TextEvent.LINK,this.onTextFieldLinkHandler);
            this.textField.addEventListener(MouseEvent.CLICK,this.onTextFieldClickHandler);
            this.icon.mouseChildren = this.icon.mouseEnabled = false;
            this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
            this.icon.addEventListener(UILoaderEvent.IOERROR,this.onIconIoerrorHandler);
            this.bgIcon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
            this.bgIcon.addEventListener(UILoaderEvent.IOERROR,this.onIconIoerrorHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(DATA_INVALID))
            {
                this.invalidateMessageData();
            }
            if(isInvalid(TIMESTAMP_INVALID))
            {
                this.invalidateTimestamp();
            }
            if(isInvalid(LAYOUT_INVALID))
            {
                this.updateLayout();
            }
        }

        override protected function onBeforeDispose() : void
        {
            this.textField.removeEventListener(TextEvent.LINK,this.onTextFieldLinkHandler);
            this.textField.removeEventListener(MouseEvent.CLICK,this.onTextFieldClickHandler);
            this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
            this.icon.removeEventListener(UILoaderEvent.IOERROR,this.onIconIoerrorHandler);
            this.bgIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
            this.bgIcon.removeEventListener(UILoaderEvent.IOERROR,this.onIconIoerrorHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.icon.dispose();
            this.icon = null;
            this.bgIcon.dispose();
            this.bgIcon = null;
            this.bmpFill.dispose();
            this.bmpFill = null;
            this.removeButtonsGroup();
            if(this._timeComponent != null)
            {
                removeChild(this._timeComponent);
                this._timeComponent.dispose();
                this._timeComponent = null;
            }
            if(this._data != null)
            {
                this._data.dispose();
                this._data = null;
            }
            this.textField = null;
            this.background = null;
            this._classFactory = null;
            if(this._nyCounter)
            {
                this._nyCounter.dispose();
                this._nyCounter = null;
            }
            if(this._nyBg)
            {
                this._nyBg = null;
            }
            super.onDispose();
        }

        private function createButtonsGroup(param1:MessageInfoVO) : void
        {
            if(!param1.areButtonsVisible())
            {
                return;
            }
            var _loc2_:Vector.<ButtonVO> = param1.buttonsLayout;
            var _loc3_:uint = _loc2_.length;
            if(_loc3_ == 0)
            {
                return;
            }
            this._buttonsGroup = new Group();
            var _loc4_:HorizontalGroupLayout = new HorizontalGroupLayout();
            _loc4_.gap = MessageMetrics.BUTTONS_PADDING;
            this._buttonsGroup.layout = _loc4_;
            this._buttonsGroup.x = this.textField.x;
            addChild(this._buttonsGroup);
            var _loc5_:* = 0;
            while(_loc5_ < _loc3_)
            {
                this.createButton(_loc2_[_loc5_],param1);
                _loc5_++;
            }
            this._buttonsGroup.validateNow();
        }

        private function createButton(param1:ButtonVO, param2:MessageInfoVO) : void
        {
            var _loc3_:String = ButtonType.getLinkageByType(param1.type);
            if(_loc3_ == null)
            {
                return;
            }
            var _loc4_:SoundButtonEx = this._classFactory.getComponent(_loc3_,SoundButtonEx);
            if(_loc4_ == null)
            {
                DebugUtils.LOG_ERROR(CANT_CREATE_BUTTON,_loc3_);
                return;
            }
            this._buttonsGroup.addChild(_loc4_);
            _loc4_.addEventListener(ButtonEvent.CLICK,this.onBtnClickHandler,false,0,true);
            _loc4_.focusable = false;
            updateButton(_loc4_,param1,param2);
        }

        private function invalidateTimestamp() : void
        {
            if(this._timeComponent == null && StringUtils.isNotEmpty(this._timeStamp))
            {
                this._timeComponent = NotificationTimeComponent(this._classFactory.getComponent(Linkages.NOTIFICATION_TIME_COMPONENT,NotificationTimeComponent));
                addChildAt(this._timeComponent,getChildIndex(this.textField) + 1);
            }
            if(this._timeComponent != null)
            {
                this._timeComponent.textField.text = this._timeStamp != null?this._timeStamp:Values.EMPTY_STR;
                invalidate(LAYOUT_INVALID);
            }
        }

        private function invalidateMessageData() : void
        {
            var _loc1_:MessageInfoVO = null;
            var _loc2_:String = null;
            var _loc3_:Object = null;
            if(this._data != null)
            {
                _loc1_ = this._data.messageVO;
                this.textField.htmlText = _loc1_.message;
                _loc2_ = _loc1_.type;
                _loc3_ = _loc1_.nyData;
                this.icon.visible = this.icon.source == _loc1_.icon;
                if(StringUtils.isNotEmpty(_loc1_.icon))
                {
                    if(this._isNYMessage && _loc3_ != null)
                    {
                        this.icon.source = StringUtils.isNotEmpty(_loc3_[FIELD_CATEGORY])?RES_ICONS.getNYLBcategoryIcon(_loc3_[FIELD_CATEGORY]):_loc1_.icon;
                    }
                    else
                    {
                        this.icon.source = _loc1_.icon;
                    }
                }
                this.bgIcon.visible = false;
                if(StringUtils.isNotEmpty(_loc1_.bgIcon))
                {
                    this.bgIcon.source = _loc1_.bgIcon;
                }
                if(StringUtils.isNotEmpty(_loc1_.defaultIcon))
                {
                    this.icon.sourceAlt = _loc1_.defaultIcon;
                }
                if(_loc2_ != null && _loc2_ == MSG_TYPE_ACTION)
                {
                    this.bmpFill.visible = true;
                    this.bmpFill.repeat = BMP_FILL_REPEAT;
                    this.bmpFill.startPos = BMP_FILL_START_POS;
                    this.bmpFill.source = _loc2_ + BMP_FILL_SOURCE_LABEL;
                    this.bmpFill.setSize(BMP_FILL_WIDTH,BMP_FILL_HEIGHT);
                }
                else
                {
                    this.bmpFill.visible = false;
                }
                this.timeStamp = _loc1_.timestampStr;
                if(!this._buttonsGroup)
                {
                    this.createButtonsGroup(_loc1_);
                }
                else
                {
                    this.updateButtonsGroup(_loc1_);
                }
                if(this._isNYMessage)
                {
                    if(!this._nyCounter)
                    {
                        this._nyCounter = this._classFactory.getComponent(Linkages.NY_COUNTER_VIEW_UI,CounterView);
                        this._nyCounter.name = NY_COUNTER_NAME;
                        this._nyCounter.mouseChildren = this._nyCounter.mouseEnabled = false;
                        addChild(this._nyCounter);
                    }
                    if(_loc1_.nyData != null)
                    {
                        this._nyCounter.setCount(_loc1_.nyData[FIELD_COUNT]);
                    }
                }
                else if(this._nyCounter)
                {
                    removeChild(this._nyCounter);
                    this._nyCounter = null;
                }
                invalidate(LAYOUT_INVALID);
            }
        }

        private function updateLayout() : void
        {
            var _loc7_:* = 0;
            var _loc8_:* = 0;
            var _loc9_:Object = null;
            var _loc10_:* = false;
            var _loc1_:MessageInfoVO = this._data.messageVO;
            this.background.visible = !this._isNYMessage;
            if(this._isNYMessage)
            {
                if(!this._nyBg)
                {
                    this._nyBg = this._classFactory.getComponent(Linkages.NY_LB_NOTIFICATION_BG_UI,MovieClip);
                    this._nyBg.y = this.bgIcon.y - NY_BG_ICON_OFFET;
                    addChildAt(this._nyBg,getChildIndex(this.bgIcon));
                }
            }
            else if(this._nyBg)
            {
                removeChild(this._nyBg);
                this._nyBg = null;
            }
            this.textField.x = this._isNYMessage?NY_TEXT_X:this._textDefaultX;
            this.textField.y = this._isNYMessage?NY_TEXT_Y - NY_BG_ICON_OFFET:this._textDefaultY;
            this.textField.width = this._isNYMessage?NY_TEXT_W:this._textDefaultW;
            if(this._timeComponent)
            {
                this._timeComponent.y = MessageMetrics.TIME_PADDING_Y;
                this._timeComponent.x = this.width - (this._timeComponent.width + MessageMetrics.TIME_PADDING_X) ^ 0;
            }
            var _loc2_:* = 0;
            if(this._buttonsGroup != null)
            {
                _loc2_ = this._buttonsGroup.height + this.buttonPadding;
            }
            var _loc3_:int = this.textField.height;
            var _loc4_:* = 0;
            if(StringUtils.isNotEmpty(this.bgIcon.source) && _loc1_)
            {
                _loc4_ = _loc1_.bgIconSizeAuto?this.bgIcon.height:_loc1_.bgIconHeight | 0;
            }
            if(this._buttonsGroup != null)
            {
                this._buttonsGroup.y = _loc3_ + this.textField.y + this.buttonPadding ^ 0;
                if(this._isNYMessage && _loc1_.buttonsAlign == TextFormatAlign.CENTER)
                {
                    this._buttonsGroup.x = this.textField.x + (this.textField.width - this._buttonsGroup.width >> 1) | 0;
                }
                else
                {
                    this._buttonsGroup.x = this.textField.x;
                }
            }
            var _loc5_:int = this.textField.y + _loc3_ + this.messageBottomOffset + _loc2_;
            var _loc6_:int = Math.max(_loc5_,_loc4_);
            if(_loc6_ != this.background.height)
            {
                this.background.height = _loc6_;
                dispatchEvent(new Event(Event.RESIZE));
            }
            if(this._isNYMessage)
            {
                this._nyBg.height = this.background.height + NY_BG_ICON_OFFET;
            }
            if(this.bmpFill.visible)
            {
                _loc7_ = this.bmpFill.y << 1;
                this.bmpFill.setSize(this.background.width - _loc7_ ^ 0,_loc6_ - _loc7_);
            }
            if(this._isNYMessage)
            {
                this.icon.x = NY_ICON_X;
                this.icon.y = NY_ICON_Y;
            }
            else
            {
                _loc8_ = MessageMetrics.ICON_DEFAULT_PADDING_X;
                this.icon.x = _loc8_ + (this.textField.x - _loc8_ - this.icon.width >> 1);
                if(this.textField.textHeight < this.icon.height)
                {
                    this.icon.y = this.textField.y + (this.textField.textHeight - this.icon.height >> 1) + MessageMetrics.ICON_DEFAULT_PADDING_Y ^ 0;
                }
                else
                {
                    this.icon.y = this._iconDefaultY;
                }
            }
            if(this._isNYMessage && this._nyCounter)
            {
                _loc9_ = _loc1_.nyData;
                _loc10_ = StringUtils.isNotEmpty(_loc9_[FIELD_CATEGORY]);
                this._nyCounter.x = _loc10_?NY_COUNTER_X:NY_COUNTER_SMALL_X;
                this._nyCounter.y = _loc10_?NY_COUNTER_Y:NY_COUNTER_SMALL_Y;
            }
        }

        private function updateButtonsGroup(param1:MessageInfoVO) : void
        {
            var _loc2_:* = 0;
            var _loc6_:ButtonVO = null;
            var _loc7_:SoundButtonEx = null;
            if(!param1.areButtonsVisible())
            {
                this.removeButtonsGroup();
                return;
            }
            var _loc3_:int = this._buttonsGroup.numChildren;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
                this._buttonsGroup.getChildAt(_loc2_).visible = false;
                _loc2_++;
            }
            var _loc4_:Vector.<ButtonVO> = param1.buttonsLayout;
            var _loc5_:uint = _loc4_.length;
            if(_loc5_ == 0)
            {
                return;
            }
            _loc2_ = 0;
            while(_loc2_ < _loc5_)
            {
                _loc6_ = _loc4_[_loc2_];
                _loc7_ = SoundButtonEx(this._buttonsGroup.getChildByName(_loc6_.type));
                if(_loc7_ != null)
                {
                    updateButton(_loc7_,_loc6_,param1);
                }
                else
                {
                    this.createButton(_loc6_,param1);
                }
                _loc2_++;
            }
        }

        private function removeButtonsGroup() : void
        {
            var _loc1_:Object = null;
            var _loc2_:uint = 0;
            var _loc3_:* = 0;
            if(this._buttonsGroup != null)
            {
                _loc2_ = this._buttonsGroup.numChildren;
                _loc3_ = 0;
                while(_loc3_ < _loc2_)
                {
                    _loc1_ = this._buttonsGroup.getChildAt(_loc3_);
                    _loc1_.removeEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
                    _loc3_++;
                }
                this._buttonsGroup.dispose();
                this._buttonsGroup = null;
            }
        }

        override public function get height() : Number
        {
            return this.background.height;
        }

        override public function get width() : Number
        {
            return Math.ceil(actualWidth);
        }

        public function get messageTopOffset() : Number
        {
            return this._messageTopOffset;
        }

        public function set messageTopOffset(param1:Number) : void
        {
            this._messageTopOffset = param1;
            invalidate(LAYOUT_INVALID);
        }

        public function get messageBottomOffset() : Number
        {
            return this._isNYMessage?NY_BOTTOM_OFFSET:this._messageBottomOffset;
        }

        public function set messageBottomOffset(param1:Number) : void
        {
            this._messageBottomOffset = param1;
            invalidate(LAYOUT_INVALID);
        }

        public function get buttonPadding() : int
        {
            return this._isNYMessage?NY_BTN_PADDING:this._buttonPadding;
        }

        public function set buttonPadding(param1:int) : void
        {
            this._buttonPadding = param1;
            invalidate(LAYOUT_INVALID);
        }

        public function get data() : Object
        {
            return this._data;
        }

        public function set data(param1:Object) : void
        {
            this._data = param1 as NotificationInfoVO;
            App.utils.asserter.assertNotNull(this._data,Errors.INVALID_TYPE + "NotificationInfoVO.");
            var _loc2_:MessageInfoVO = this._data.messageVO;
            this._isNYMessage = _loc2_ && _loc2_.type == MSG_TYPE_NY_BOXES;
            invalidate(DATA_INVALID);
        }

        public function get buttonsGroup() : Group
        {
            return this._buttonsGroup;
        }

        public function get timeStamp() : String
        {
            return this._timeStamp;
        }

        public function set timeStamp(param1:String) : void
        {
            if(this._timeStamp != param1)
            {
                this._timeStamp = param1;
                invalidate(TIMESTAMP_INVALID);
            }
        }

        private function onTextFieldLinkHandler(param1:TextEvent) : void
        {
            if(!this._isTFClickedByMBR)
            {
                dispatchEvent(new ServiceMessageEvent(ServiceMessageEvent.MESSAGE_LINK_CLICKED,this._data.typeID,this._data.entityID,true,false,param1.text));
            }
        }

        private function onTextFieldClickHandler(param1:MouseEvent) : void
        {
            this._isTFClickedByMBR = App.utils.commons.isRightButton(param1);
        }

        private function onIconIoerrorHandler(param1:UILoaderEvent) : void
        {
            DisplayObject(param1.currentTarget).visible = false;
        }

        private function onIconCompleteHandler(param1:UILoaderEvent) : void
        {
            DisplayObject(param1.currentTarget).visible = true;
            invalidate(LAYOUT_INVALID);
        }

        private function onBtnClickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:ServiceMessageEvent = new ServiceMessageEvent(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED,this._data.typeID,this._data.entityID,true);
            _loc2_.action = param1.target.data;
            dispatchEvent(_loc2_);
        }
    }
}
