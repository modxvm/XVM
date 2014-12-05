package net.wg.gui.components.controls
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.ITextContainer;
    import flash.text.TextField;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Tooltips;
    import scaleform.clik.controls.ListItemRenderer;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.data.constants.Errors;
    import flash.display.DisplayObject;
    import flash.display.InteractiveObject;
    import scaleform.clik.constants.InvalidationType;
    import flash.geom.Point;
    import net.wg.data.constants.IconsTypes;
    import net.wg.utils.ILocale;
    import flash.text.TextFormat;
    import scaleform.clik.controls.Button;
    
    public class ActionPrice extends UIComponent implements ITextContainer
    {
        
        public function ActionPrice()
        {
            this.alertVisibleInNextStates = [];
            this._textColorType = TEXT_COLOR_TYPE_ICON;
            this.textColors = {"error":this.COLOR_ERROR,
            "disable":this.COLOR_DISABLE
        };
        super();
        this.alertVisibleInNextStates = [STATE_ALIGN_MIDDLE,STATE_ALIGN_TOP,STATE_ALIGN_MIDDLE_SMALL];
    }
    
    public static var TEXT_COLOR_TYPE_ICON:String = "iconColor";
    
    public static var TEXT_COLOR_TYPE_DISABLE:String = "disable";
    
    public static var TEXT_COLOR_TYPE_ERROR:String = "error";
    
    public static var STATE_ALIGN_MIDDLE:String = "alignMiddle";
    
    public static var STATE_ALIGN_MIDDLE_SMALL:String = "alignMiddleSmall";
    
    public static var STATE_ALIGN_TOP:String = "alignTop";
    
    public static var STATE_CAMOUFLAGE:String = "camouflage";
    
    public static var STATE_TECH_TREE_VEHICLE:String = "techTreeVeh";
    
    public static var STATE_TECH_TREE_MODULE:String = "techTreeMod";
    
    public static var INVALID_POSITION:String = "invalidPosition";
    
    public static var ALERT_ICO_MARGIN:Number = 5;
    
    public var iconText:IconText = null;
    
    public var textField:TextField = null;
    
    public var alertIco:AlertIco = null;
    
    public var hitMc:Sprite = null;
    
    public var bg:MovieClip = null;
    
    protected var _textFont:String = "$FieldFont";
    
    private var _owner:UIComponent;
    
    private var alertVisibleInNextStates:Array;
    
    private var COLOR_GOLD:uint = 16761699;
    
    private var COLOR_CREDITS:uint = 13556185;
    
    private var COLOR_ELITE_XP:uint = 16498786;
    
    private var COLOR_FREE_XP:uint = 16498786;
    
    private var COLOR_DISABLE:uint = 7435380;
    
    private var COLOR_ERROR:uint = 16711680;
    
    private var defIconPos:Number = 0;
    
    private var defTextFieldXPos:Number = 0;
    
    private var defMarginBetweenTextAndBg:Number = 0;
    
    private var defBgPos:Number = 0;
    
    private var _state:String = "camouflage";
    
    private var _iconPosition:String = "right";
    
    private var _vo:ActionPriceVO = null;
    
    private var _tooltipEnabled:Boolean = true;
    
    private var _textColorType:String;
    
    private var _textSize:Number = 12;
    
    private var _textYOffset:Number = 0;
    
    private var textFieldYStartPos:Number = -1;
    
    private var textColors:Object;
    
    override protected function onDispose() : void
    {
        removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
        removeEventListener(MouseEvent.MOUSE_DOWN,this.onPressHandler);
        this._owner = null;
        if(this._vo)
        {
            this._vo.dispose();
            this._vo = null;
        }
    }
    
    override public function toString() : String
    {
        return "[WG ActionPrice " + name + "]";
    }
    
    public function showTooltip() : void
    {
        App.toolTipMgr.showSpecial(Tooltips.ACTION_PRICE,null,this._vo.type,this._vo.key,this._vo.newPrices,this._vo.oldPrices,this._vo.isBuying,this._vo.forCredits,this._vo.rentPackage);
    }
    
    public function hideTooltip() : void
    {
        App.toolTipMgr.hide();
    }
    
    public function setup(param1:UIComponent) : void
    {
        this._owner = param1;
        this._owner.mouseChildren = true;
        if(param1 is ListItemRenderer)
        {
            focusable = false;
            focusTarget = param1;
        }
        this.updateEnabledMode();
    }
    
    public function setData(param1:ActionPriceVO) : void
    {
        if(param1 == null)
        {
            this.visible = false;
            return;
        }
        if(!param1.useAction)
        {
            this.visible = false;
            return;
        }
        this.visible = true;
        this._vo = param1;
        if(this.visible)
        {
            invalidateData();
        }
    }
    
    public function getData() : ActionPriceVO
    {
        return this._vo;
    }
    
    override public function set enabled(param1:Boolean) : void
    {
        if(param1 == super.enabled)
        {
            return;
        }
        super.enabled = param1;
        this.alpha = param1?1:0.8;
        this.updateEnabledMode();
        tabEnabled = !enabled?false:_focusable;
        invalidateData();
    }
    
    public function get textAlign() : String
    {
        return this.textField.getTextFormat().align;
    }
    
    public function set textAlign(param1:String) : void
    {
        throw new AbstractException("setter CheckBox::textAlign" + Errors.ABSTRACT_INVOKE);
    }
    
    public function get state() : String
    {
        return this._state;
    }
    
    public function set state(param1:String) : void
    {
        this._state = param1;
        this.textFieldYStartPos = -1;
        invalidateState();
    }
    
    public function get tooltipEnabled() : Boolean
    {
        return this._tooltipEnabled;
    }
    
    public function set tooltipEnabled(param1:Boolean) : void
    {
        if(param1 == this._tooltipEnabled)
        {
            return;
        }
        this._tooltipEnabled = param1;
        invalidateData();
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
        invalidateData();
    }
    
    public function get ico() : String
    {
        if(!this._vo)
        {
            return "";
        }
        return this._vo.ico;
    }
    
    public function set ico(param1:String) : void
    {
        if(!this._vo || this._vo.ico == param1)
        {
            return;
        }
        this._vo.ico = param1;
        invalidateData();
    }
    
    public function get iconPosition() : String
    {
        return this._iconPosition;
    }
    
    public function set iconPosition(param1:String) : void
    {
        if(param1 == this._iconPosition)
        {
            return;
        }
        this._iconPosition = param1;
        invalidate(INVALID_POSITION);
    }
    
    public function get textColorType() : String
    {
        return this._textColorType;
    }
    
    public function set textColorType(param1:String) : void
    {
        this._textColorType = param1;
        invalidateData();
    }
    
    public function get textSize() : Number
    {
        return this._textSize;
    }
    
    public function set textSize(param1:Number) : void
    {
        this._textSize = param1;
        invalidateData();
    }
    
    public function get textYOffset() : Number
    {
        return this._textYOffset;
    }
    
    public function set textYOffset(param1:Number) : void
    {
        this._textYOffset = param1;
        invalidateData();
    }
    
    override protected function configUI() : void
    {
        var _loc2_:DisplayObject = null;
        super.configUI();
        addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
        addEventListener(MouseEvent.MOUSE_DOWN,this.onPressHandler);
        var _loc1_:* = 0;
        while(_loc1_ < this.numChildren)
        {
            _loc2_ = this.getChildAt(_loc1_);
            if(!(_loc2_ == this.hitMc) && _loc2_ is InteractiveObject)
            {
                InteractiveObject(_loc2_).mouseEnabled = false;
            }
            _loc1_++;
        }
        this.hitMc.mouseEnabled = true;
        this.hitArea = this.hitMc;
        this.updateEnabledMode();
    }
    
    override protected function draw() : void
    {
        if(!initialized)
        {
            return;
        }
        super.draw();
        if(isInvalid(InvalidationType.STATE))
        {
            this.updateState();
            this.updateData();
            this.updatePositions();
        }
        if(isInvalid(InvalidationType.DATA))
        {
            this.updateData();
            this.updatePositions();
        }
        if(isInvalid(INVALID_POSITION))
        {
            this.updatePositions();
        }
    }
    
    private function checkHitTest(param1:InteractiveObject) : Boolean
    {
        var _loc3_:Point = null;
        var _loc2_:* = false;
        if(param1)
        {
            _loc3_ = new Point(param1.mouseX,param1.mouseY);
            _loc3_ = param1.localToGlobal(_loc3_);
            _loc2_ = param1.hitTestPoint(_loc3_.x,_loc3_.y);
        }
        return _loc2_;
    }
    
    private function getTextColor(param1:String) : uint
    {
        var _loc2_:uint = 16777215;
        switch(param1)
        {
            case IconsTypes.GOLD:
                _loc2_ = this.COLOR_GOLD;
                break;
            case IconsTypes.CREDITS:
                _loc2_ = this.COLOR_CREDITS;
                break;
            case IconsTypes.ELITE_XP:
                _loc2_ = this.COLOR_ELITE_XP;
                break;
            case IconsTypes.FREE_XP:
                _loc2_ = this.COLOR_FREE_XP;
                break;
        }
        return _loc2_;
    }
    
    private function updateState() : void
    {
        gotoAndStop(this._state);
        if(this.bg)
        {
            this.bg.gotoAndStop(this._state);
        }
        if(_baseDisposed)
        {
            return;
        }
        if(this.textFieldYStartPos < 0)
        {
            this.textFieldYStartPos = this.textField.y;
        }
        this.defMarginBetweenTextAndBg = this.bg.x - (this.textField.x + this.textField.width);
        this.defIconPos = 0;
        this.defTextFieldXPos = 0;
        this.defBgPos = 0;
        this.iconText.mouseEnabled = this.iconText.mouseChildren = false;
    }
    
    private function updatePositions() : void
    {
        if(!this._vo)
        {
            return;
        }
        if(this.defIconPos == 0)
        {
            this.defIconPos = this.iconText.x;
        }
        if(this.defTextFieldXPos == 0)
        {
            this.defTextFieldXPos = this.textField.x;
        }
        if(this.defBgPos == 0)
        {
            this.defBgPos = this.bg.x;
        }
        var _loc1_:Boolean = this._vo.state == ActionPriceVO.STATE_PENALTY && !(this.alertVisibleInNextStates.indexOf(this._state) == -1);
        if(this._iconPosition == "left")
        {
            this.iconText.x = 0;
            this.textField.x = this.iconText.width;
            this.bg.x = Math.abs(this.textField.x + this.textField.textWidth + this.defMarginBetweenTextAndBg);
            if(_loc1_)
            {
                this.alertIco.x = this.bg.x + ALERT_ICO_MARGIN;
            }
        }
        else if(_loc1_)
        {
            this.iconText.x = -this.iconText.width;
            this.textField.x = Math.floor(this.iconText.x - this.textField.textWidth) + 1;
            this.alertIco.x = this.textField.x - this.alertIco.width + -ALERT_ICO_MARGIN;
        }
        else
        {
            this.iconText.x = this.defIconPos;
            if((this.textField.text) && this.textField.text.length > 0)
            {
                this.textField.x = Math.floor(this.iconText.x - this.textField.textWidth) - 2;
            }
            this.bg.x = this.defBgPos;
        }
        
        this.bg.visible = !_loc1_;
        this.alertIco.visible = _loc1_;
        if(_loc1_)
        {
            this.alertIco.y = this.textField.y + (this.textField.height - this.alertIco.height >> 1) + (this._textSize - 13);
        }
        this.updateHitArea(this._state);
    }
    
    private function updateData() : void
    {
        var _loc2_:ILocale = null;
        var _loc3_:String = null;
        var _loc4_:TextFormat = null;
        if(!this._vo)
        {
            return;
        }
        if(!(this._vo.ico == "") && (this.iconText))
        {
            this.iconText.icon = this._vo.ico;
            this.iconText.validateNow();
        }
        var _loc1_:uint = 0;
        if(this._textColorType == TEXT_COLOR_TYPE_ICON)
        {
            _loc1_ = this.getTextColor(this._vo.ico);
        }
        else
        {
            _loc1_ = this.textColors[this._textColorType];
        }
        if(this._state == STATE_TECH_TREE_VEHICLE || this._state == STATE_TECH_TREE_MODULE)
        {
            this.textField.text = "";
        }
        else
        {
            _loc2_ = App.utils.locale;
            _loc3_ = "";
            if(this._vo.useSign)
            {
                if(this._vo.externalSign == "")
                {
                    _loc3_ = this._vo.newPrice > 0?"+":"";
                }
                else
                {
                    _loc3_ = this._vo.externalSign;
                }
            }
            this.textField.text = _loc3_ + (this._vo.ico == IconsTypes.GOLD?_loc2_.gold(this._vo.newPrice):_loc2_.integer(this._vo.newPrice));
            _loc4_ = this.textField.getTextFormat();
            _loc4_.font = this._textFont;
            _loc4_.size = this._textSize;
            this.textField.setTextFormat(_loc4_);
            this.textField.textColor = _loc1_;
            this.textField.width = this.textField.textWidth + 3;
            if(this.textFieldYStartPos != -1)
            {
                this.textField.y = this.textFieldYStartPos + this.textYOffset;
            }
        }
    }
    
    private function updateHitArea(param1:String) : void
    {
        if(!this.tooltipEnabled)
        {
            param1 = STATE_TECH_TREE_VEHICLE;
        }
        var _loc2_:Number = 0;
        switch(param1)
        {
            case STATE_CAMOUFLAGE:
                _loc2_ = this.alertIco.visible?this.alertIco.x:this.textField.x + this.textField.width - this.textField.textWidth - 3;
                this.hitMc.x = Math.min(_loc2_,-55);
                this.hitMc.y = this.textField.y;
                this.hitMc.width = this.hitMc.x;
                this.hitMc.height = this.textField.textHeight;
                this.hitMc.visible = true;
                break;
            case STATE_ALIGN_MIDDLE:
            case STATE_ALIGN_MIDDLE_SMALL:
            case STATE_ALIGN_TOP:
                if(this._iconPosition == "right")
                {
                    if(this.alertIco.visible)
                    {
                        _loc2_ = this.alertIco.x;
                    }
                    else
                    {
                        _loc2_ = this.textField.x + this.textField.width - this.textField.textWidth - 3;
                    }
                }
                else
                {
                    _loc2_ = 0;
                }
                this.hitMc.x = _loc2_;
                this.hitMc.y = this.textField.y;
                if(this.alertIco.visible)
                {
                    this.hitMc.width = this._iconPosition == "right"?Math.abs(this.hitMc.x):Math.abs(this.hitMc.x - this.bg.x);
                }
                else
                {
                    this.hitMc.width = this._iconPosition == "right"?Math.abs(this.hitMc.x):Math.abs(this.bg.x);
                }
                this.hitMc.height = this.textField.textHeight + 3;
                this.hitMc.visible = true;
                break;
            case STATE_TECH_TREE_VEHICLE:
            case STATE_TECH_TREE_MODULE:
                this.hitMc.x = -1;
                this.hitMc.y = 0;
                this.hitMc.width = 1;
                this.hitMc.height = 1;
                this.hitMc.visible = false;
                break;
        }
        this.updateEnabledMode();
    }
    
    private function updateEnabledMode() : void
    {
        var _loc1_:* = false;
        if((this._owner && this._owner.enabled) && (this.enabled) && this._owner is Button)
        {
            _loc1_ = true;
        }
        useHandCursor = _loc1_;
        buttonMode = _loc1_;
        this.hitMc.buttonMode = _loc1_;
    }
    
    private function onRollOverHandler(param1:MouseEvent) : void
    {
        if((this._owner) && (this.checkHitTest(this._owner)))
        {
            this._owner.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
        }
        this.showTooltip();
    }
    
    private function onRollOutHandler(param1:MouseEvent) : void
    {
        this.hideTooltip();
        if((this._owner) && (this.checkHitTest(this._owner)))
        {
            this._owner.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
        }
    }
    
    private function onPressHandler(param1:MouseEvent) : void
    {
        this.hideTooltip();
    }
}
}
