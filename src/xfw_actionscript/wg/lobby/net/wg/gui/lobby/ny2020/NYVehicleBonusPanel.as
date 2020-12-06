package net.wg.gui.lobby.ny2020
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.Image;
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    import net.wg.utils.StageSizeBoundaries;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import org.idmedia.as3commons.util.StringUtils;

    public class NYVehicleBonusPanel extends UIComponentEx
    {

        private static const LBL_OUT:String = "out";

        private static const LBL_OVER:String = "over";

        private static const LBL_BIG:String = "big";

        private static const LBL_SMALL:String = "small";

        private static const ICON_OFFSET_Y:int = 3;

        private static const ICON_OFFSET_Y_SMALL:int = 4;

        private static const HIT_AREA_HEIGHT_OFFSET:int = 17;

        private static const HIT_AREA_HEIGHT_OFFSET_SMALL:int = 8;

        private static const BONUS_CREDIT_OFFSET:uint = 15;

        private static const CREDIT_ICON_TEXT_OFFSET:uint = 1;

        private static const CHECKED_BONUS_ICON:String = "icon_free_exp_main_screen";

        private static const CHECKED_ICON_OFFSET:int = -4;

        public var bg:MovieClip = null;

        public var icon:Image = null;

        public var creditsIcon:Sprite = null;

        public var hitAreaMc:MovieClip = null;

        public var nyVehicleHitAreaMc:MovieClip = null;

        public var nyCreditsHitAreaMc:MovieClip = null;

        public var tfBonusLabel:TextField = null;

        public var tfLabel:TextField = null;

        public var tfCreditsLabel:TextField = null;

        private var _bonusIcon:String;

        private var _bonusValue:String;

        private var _label:String;

        private var _tooltip:String;

        private var _isCreditsBonusVisible:Boolean = false;

        private var _isNYVehicle:Boolean = false;

        private var _creditsAmount:String = "";

        public function NYVehicleBonusPanel()
        {
            super();
            hitArea = this.hitAreaMc;
            this.bg.mouseEnabled = false;
            stop();
        }

        override protected function initialize() : void
        {
            super.initialize();
            this.nyVehicleHitAreaMc.addEventListener(MouseEvent.ROLL_OVER,this.showVehicleTooltip);
            this.nyVehicleHitAreaMc.addEventListener(MouseEvent.ROLL_OUT,this.hideBonusTooltip);
            this.nyCreditsHitAreaMc.addEventListener(MouseEvent.ROLL_OVER,this.showCreditsTooltip);
            this.nyCreditsHitAreaMc.addEventListener(MouseEvent.ROLL_OUT,this.hideBonusTooltip);
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = NaN;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                buttonMode = this.nyCreditsHitAreaMc.buttonMode = this.nyVehicleHitAreaMc.buttonMode = this._isNYVehicle;
                if(!this.icon.hasEventListener(Event.CHANGE))
                {
                    this.icon.addEventListener(Event.CHANGE,this.onChangeHandler);
                }
                this.icon.source = this._bonusIcon;
                this.tfBonusLabel.text = this._bonusValue;
                App.utils.commons.updateTextFieldSize(this.tfBonusLabel,true,true);
                this.tfLabel.htmlText = this._label;
                this.tfCreditsLabel.htmlText = this._creditsAmount;
                App.utils.commons.updateTextFieldSize(this.tfCreditsLabel,true,true);
                this.icon.visible = this._isNYVehicle;
                this.tfBonusLabel.visible = this._isNYVehicle;
                this.creditsIcon.visible = this._isCreditsBonusVisible;
                this.tfCreditsLabel.visible = this._isCreditsBonusVisible;
                invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                if(this.isNYVehicle)
                {
                    _loc1_ = this._bonusIcon.indexOf(CHECKED_BONUS_ICON) > -1?CHECKED_ICON_OFFSET:0;
                    _loc2_ = this._isCreditsBonusVisible?this.creditsIcon.width + this.tfCreditsLabel.width + BONUS_CREDIT_OFFSET + CREDIT_ICON_TEXT_OFFSET:0;
                    this.icon.x = -(this.tfBonusLabel.width + this.icon.width + _loc1_ + _loc2_) >> 1;
                    this.icon.y = (this.tfBonusLabel.y + this.tfBonusLabel.textHeight - this.icon.height >> 1) + (App.appHeight <= StageSizeBoundaries.HEIGHT_768?ICON_OFFSET_Y_SMALL:ICON_OFFSET_Y);
                    this.tfBonusLabel.x = this.icon.x + this.icon.width + _loc1_ | 0;
                    this.nyVehicleHitAreaMc.x = this.icon.x;
                    this.nyVehicleHitAreaMc.y = Math.min(this.icon.y,this.tfBonusLabel.y) | 0;
                    this.nyVehicleHitAreaMc.width = this.icon.width + this.tfBonusLabel.width;
                    this.nyVehicleHitAreaMc.height = Math.max(this.icon.height,this.tfBonusLabel.height);
                }
                else
                {
                    this.nyVehicleHitAreaMc.width = 0;
                    this.nyVehicleHitAreaMc.height = 0;
                }
                this.hitAreaMc.height = this.tfLabel.y + this.tfLabel.height | 0;
                if(this._isCreditsBonusVisible)
                {
                    this.creditsIcon.x = this.tfBonusLabel.x + this.tfBonusLabel.width + BONUS_CREDIT_OFFSET | 0;
                    if(!this._isNYVehicle)
                    {
                        this.creditsIcon.x = -(this.creditsIcon.width + this.tfCreditsLabel.width + CREDIT_ICON_TEXT_OFFSET) >> 1;
                    }
                    this.tfCreditsLabel.x = this.creditsIcon.x + this.creditsIcon.width + CREDIT_ICON_TEXT_OFFSET | 0;
                    this.creditsIcon.y = this.tfCreditsLabel.y + (this.tfCreditsLabel.height - this.creditsIcon.height >> 1);
                    this.nyCreditsHitAreaMc.x = this.creditsIcon.x;
                    this.nyCreditsHitAreaMc.y = Math.min(this.creditsIcon.y,this.tfCreditsLabel.y);
                    this.nyCreditsHitAreaMc.width = this.creditsIcon.width + this.tfCreditsLabel.width;
                    this.nyCreditsHitAreaMc.height = Math.max(this.creditsIcon.height,this.tfCreditsLabel.height);
                }
                else
                {
                    this.nyCreditsHitAreaMc.width = 0;
                    this.nyCreditsHitAreaMc.height = 0;
                }
            }
        }

        override protected function onDispose() : void
        {
            this.nyVehicleHitAreaMc.removeEventListener(MouseEvent.ROLL_OVER,this.showVehicleTooltip);
            this.nyVehicleHitAreaMc.removeEventListener(MouseEvent.ROLL_OUT,this.hideBonusTooltip);
            this.nyCreditsHitAreaMc.removeEventListener(MouseEvent.ROLL_OVER,this.showCreditsTooltip);
            this.nyCreditsHitAreaMc.removeEventListener(MouseEvent.ROLL_OUT,this.hideBonusTooltip);
            this.icon.removeEventListener(Event.CHANGE,this.onChangeHandler);
            this.icon.dispose();
            this.icon = null;
            this.creditsIcon = null;
            this.tfBonusLabel = null;
            this.tfLabel = null;
            this.tfCreditsLabel = null;
            this.hitAreaMc = null;
            this.nyVehicleHitAreaMc = null;
            this.nyCreditsHitAreaMc = null;
            this.bg = null;
            super.onDispose();
        }

        public function setIsSmall(param1:Boolean) : void
        {
            gotoAndStop(param1?LBL_SMALL:LBL_BIG);
            invalidateData();
        }

        public function showCreditsTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.NY_CREDIT_BONUS);
        }

        public function showOut() : void
        {
            this.bg.gotoAndStop(LBL_OUT);
            App.toolTipMgr.hide();
        }

        public function showOver() : void
        {
            this.bg.gotoAndStop(LBL_OVER);
            if(!this._isCreditsBonusVisible)
            {
                this.showVehicleTooltip();
            }
        }

        public function showVehicleTooltip(param1:MouseEvent = null) : void
        {
            if(this._isNYVehicle && StringUtils.isNotEmpty(this._tooltip))
            {
                App.toolTipMgr.showComplex(this._tooltip);
            }
        }

        public function hideBonusTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }

        public function update(param1:Boolean, param2:String, param3:String, param4:String, param5:String, param6:Boolean, param7:String) : void
        {
            this._bonusIcon = param2;
            this._bonusValue = param3;
            this._label = param4;
            this._tooltip = param7;
            this._creditsAmount = param5;
            this._isCreditsBonusVisible = param6;
            this._isNYVehicle = param1;
            invalidateData();
        }

        override public function get height() : Number
        {
            return this.hitAreaMc.height + (App.appHeight <= StageSizeBoundaries.HEIGHT_768?HIT_AREA_HEIGHT_OFFSET_SMALL:HIT_AREA_HEIGHT_OFFSET);
        }

        public function get isNYVehicle() : Boolean
        {
            return this._isNYVehicle;
        }

        private function onChangeHandler(param1:Event) : void
        {
            invalidateSize();
        }
    }
}
