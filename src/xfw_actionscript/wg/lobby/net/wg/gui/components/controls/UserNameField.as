package net.wg.gui.components.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.infrastructure.interfaces.ITextContainer;
    import flash.text.TextField;
    import net.wg.data.VO.UserVO;
    import flash.text.TextFormat;
    import flash.utils.Dictionary;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    import flash.events.MouseEvent;
    import flash.filters.DropShadowFilter;
    import scaleform.clik.constants.InvalidationType;
    import flash.text.TextFieldAutoSize;
    import net.wg.data.constants.Values;
    import flash.events.Event;

    public class UserNameField extends UIComponentEx implements ITextContainer
    {

        public static const DEF_USER_NAME_COLOR:uint = 15327935;

        public static const TEAM_KILLER_USER_NAME_COLOR:uint = 647935;

        private static const SHADOW_COLOR_BLACK:String = "Black";

        private static const SHADOW_COLOR_WHITE:String = "White";

        private static const SHADOW_ALPHA:uint = 1;

        private static const SHADOW_DISTANCE:uint = 1;

        private static const SHADOW_BLUR:uint = 0;

        public var textField:TextField;

        protected var _toolTip:String = "";

        private var _userVO:UserVO;

        private var _textFormat:TextFormat;

        private var _textFont:String;

        private var _textSize:Number = 12;

        private var _textAlign:String;

        private var _shadowColor:String = "Black";

        private var _showToolTip:Boolean = true;

        private var _textColor:uint = 15327935;

        private var _altToolTip:String = "";

        private var _shadowColorList:Dictionary;

        private var _toolTipMgr:ITooltipMgr;

        public function UserNameField()
        {
            this._toolTipMgr = App.toolTipMgr;
            super();
        }

        override protected function preInitialize() : void
        {
            constraints = new Constraints(this,ConstrainMode.REFLOW);
        }

        override protected function configUI() : void
        {
            this._textFormat = this.textField.getTextFormat();
            constraints.addElement(this.textField.name,this.textField,Constraints.ALL);
            constraints.update(width,height);
            initSize();
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
            this.textField = null;
            this._toolTipMgr = null;
            this._textFormat = null;
            this._userVO = null;
            App.utils.data.cleanupDynamicObject(this._shadowColorList);
            this._shadowColorList = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:DropShadowFilter = null;
            var _loc2_:* = false;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                constraints.update(_width,_height);
            }
            if(isInvalid(InvalidationType.STATE))
            {
                this._textFormat.size = this._textSize;
                this._textFormat.font = this._textFont;
                this._textFormat.align = this._textAlign;
                this.textField.setTextFormat(this._textFormat);
                this.textField.textColor = this._textColor;
                _loc1_ = this.getDropShadowFilter(this._shadowColor);
                this.textField.filters = [_loc1_];
                constraints.update(_width,_height);
            }
            if(isInvalid(InvalidationType.DATA))
            {
                this.textField.setTextFormat(this._textFormat);
                if(this.userVO)
                {
                    this.textField.autoSize = TextFieldAutoSize.NONE;
                    _loc2_ = App.utils.commons.formatPlayerName(this.textField,this.userVO.userProps);
                    this._showToolTip = _loc2_;
                    if(_loc2_)
                    {
                        this._toolTip = this.userVO.fullName;
                    }
                    else
                    {
                        this._toolTip = null;
                    }
                    this.textField.textColor = this.userVO.isTeamKiller?TEAM_KILLER_USER_NAME_COLOR:this._textColor;
                }
                else
                {
                    this.textField.text = Values.SPACE_STR;
                }
                dispatchEvent(new Event(Event.CHANGE));
            }
        }

        private function getDropShadowFilter(param1:String) : DropShadowFilter
        {
            if(!this._shadowColorList)
            {
                this._shadowColorList = new Dictionary();
                this._shadowColorList[SHADOW_COLOR_BLACK] = new UserNameFieldShadowColor(0,1,2,270);
                this._shadowColorList[SHADOW_COLOR_WHITE] = new UserNameFieldShadowColor(16777215,0.4,3,90);
            }
            var _loc2_:DropShadowFilter = new DropShadowFilter();
            var _loc3_:UserNameFieldShadowColor = this._shadowColorList[param1];
            _loc2_.color = _loc3_.color;
            _loc2_.angle = _loc3_.angle;
            _loc2_.alpha = SHADOW_ALPHA;
            _loc2_.blurX = SHADOW_BLUR;
            _loc2_.blurY = SHADOW_BLUR;
            _loc2_.distance = SHADOW_DISTANCE;
            _loc2_.strength = _loc3_.strange;
            _loc2_.inner = false;
            _loc2_.knockout = false;
            _loc2_.quality = _loc3_.quality;
            return _loc2_;
        }

        public function get showToolTip() : Boolean
        {
            return this._showToolTip;
        }

        public function set showToolTip(param1:Boolean) : void
        {
            this._showToolTip = param1;
        }

        public function get textFont() : String
        {
            return this._textFont;
        }

        public function set textFont(param1:String) : void
        {
            if(this._textFont == param1)
            {
                return;
            }
            this._textFont = param1;
            invalidateState();
        }

        public function get textSize() : Number
        {
            return this._textSize;
        }

        public function set textSize(param1:Number) : void
        {
            if(this._textSize == param1)
            {
                return;
            }
            this._textSize = param1;
            invalidateState();
        }

        public function get textAlign() : String
        {
            return this._textAlign;
        }

        public function set textAlign(param1:String) : void
        {
            if(this._textAlign == param1)
            {
                return;
            }
            this._textAlign = param1;
            invalidateState();
        }

        public function get textColor() : Number
        {
            return this._textColor;
        }

        public function set textColor(param1:Number) : void
        {
            if(this._textColor == param1)
            {
                return;
            }
            this._textColor = param1;
            invalidateState();
        }

        public function get shadowColor() : String
        {
            return this._shadowColor;
        }

        public function set shadowColor(param1:String) : void
        {
            if(this._shadowColor == param1)
            {
                return;
            }
            this._shadowColor = param1;
            invalidateState();
        }

        public function get toolTip() : String
        {
            return this._toolTip;
        }

        public function set toolTip(param1:String) : void
        {
            if(this._toolTip == param1)
            {
                return;
            }
            this._toolTip = App.utils.locale.makeString(param1);
        }

        public function get altToolTip() : String
        {
            return this._altToolTip;
        }

        public function set altToolTip(param1:String) : void
        {
            if(this._altToolTip == param1)
            {
                return;
            }
            this._altToolTip = App.utils.locale.makeString(param1);
        }

        public function get userVO() : UserVO
        {
            return this._userVO;
        }

        public function set userVO(param1:UserVO) : void
        {
            this._userVO = param1;
            invalidateData();
        }

        public function get textWidth() : Number
        {
            return this.textField.textWidth;
        }

        protected function onMouseRollOverHandler(param1:MouseEvent) : void
        {
            if(this._showToolTip)
            {
                if(this._altToolTip)
                {
                    this._toolTipMgr.show(this._altToolTip);
                }
                else if(this._toolTip)
                {
                    this._toolTipMgr.show(this._toolTip);
                }
            }
        }

        protected function onMouseRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }
    }
}
