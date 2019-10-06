package net.wg.gui.lobby.vehicleCustomization
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.Sprite;
    import flash.text.TextField;
    import net.wg.gui.components.common.CounterView;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSwitcherVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
    import scaleform.gfx.MouseEventEx;
    import net.wg.data.constants.SoundManagerStates;
    import net.wg.data.constants.SoundTypes;

    public class CustomizationTrigger extends UIComponentEx
    {

        private static const TEXT_BORDER_OFFSET:int = 45;

        private static const TEXT_TO_TEXT_OFFSET:int = 65;

        private static const ENABLE_ALPHA:Number = 0.6;

        private static const HOVER_ALPHA:Number = 0.8;

        private static const DISABLE_ALPHA:Number = 1;

        private static const COUNTER_X_OFFSET:int = -16;

        public var background:Sprite;

        public var backgroundDisable:CustomizationTriggerBgDisable;

        public var selectBackground:Sprite;

        public var glowBackground:Sprite;

        public var leftValue:TextField;

        public var rightValue:TextField;

        public var counter:CounterView;

        private var _glowBackOffset:int;

        private var _selectedLeft:Boolean = true;

        private var _data:CustomizationSwitcherVO;

        private var _tooltipMgr:ITooltipMgr;

        public function CustomizationTrigger()
        {
            this._tooltipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.background.buttonMode = true;
            this.background.useHandCursor = true;
            this.backgroundDisable.visible = false;
            this.backgroundDisable.addEventListener(MouseEvent.ROLL_OVER,this.onBackgroundDisableMouseOverHandler);
            this.backgroundDisable.addEventListener(MouseEvent.ROLL_OUT,this.onBackgroundDisableMouseOutHandler);
            this.leftValue.mouseEnabled = false;
            this.rightValue.mouseEnabled = false;
            this.glowBackground.mouseEnabled = this.glowBackground.mouseChildren = false;
            this.counter.mouseEnabled = this.counter.mouseChildren = false;
            this.leftValue.autoSize = TextFieldAutoSize.CENTER;
            this.rightValue.autoSize = TextFieldAutoSize.CENTER;
            this._glowBackOffset = this.glowBackground.width - this.selectBackground.width;
            var _loc1_:Sprite = new Sprite();
            addChild(_loc1_);
            this.glowBackground.hitArea = _loc1_;
            invalidateData();
            invalidateState();
            this.background.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
            this.background.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            this.background.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.backgroundDisable.visible = !this._data.rightEnabled;
                this.leftValue.text = this._data.leftLabel;
                this.rightValue.text = this._data.rightLabel;
                this._selectedLeft = this._data.isLeft;
                _loc1_ = this.leftValue.width + TEXT_TO_TEXT_OFFSET + this.rightValue.width;
                this.leftValue.x = TEXT_BORDER_OFFSET;
                this.rightValue.x = this.leftValue.x + this.leftValue.width + TEXT_TO_TEXT_OFFSET;
                this.background.width = TEXT_BORDER_OFFSET * 2 + _loc1_;
                this.backgroundDisable.width = this.background.width;
                invalidateState();
                this.layoutCounter();
            }
            if(isInvalid(InvalidationType.STATE))
            {
                _loc2_ = this._selectedLeft?this.leftValue.width:this.rightValue.width;
                _loc3_ = this._selectedLeft?this.leftValue.x:this.rightValue.x;
                this.selectBackground.width = TEXT_BORDER_OFFSET * 2 + _loc2_;
                this.selectBackground.x = _loc3_ - TEXT_BORDER_OFFSET;
                this.glowBackground.width = TEXT_BORDER_OFFSET * 2 + _loc2_ + this._glowBackOffset;
                this.glowBackground.x = _loc3_ - TEXT_BORDER_OFFSET - (this._glowBackOffset >> 1);
                this.applyValidTextAlpha();
            }
        }

        override protected function onDispose() : void
        {
            App.utils.scheduler.cancelTask(invalidate);
            this.backgroundDisable.removeEventListener(MouseEvent.ROLL_OVER,this.onBackgroundDisableMouseOverHandler);
            this.backgroundDisable.removeEventListener(MouseEvent.ROLL_OUT,this.onBackgroundDisableMouseOutHandler);
            this.background.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
            this.background.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            this.background.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            this._tooltipMgr = null;
            this.selectBackground = null;
            this.glowBackground = null;
            this.background = null;
            this.backgroundDisable.dispose();
            this.backgroundDisable = null;
            this.counter.dispose();
            this.counter = null;
            this.leftValue = null;
            this.rightValue = null;
            this._data = null;
            super.onDispose();
        }

        public function init(param1:CustomizationSwitcherVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        public function setNotificationCounters(param1:int) : void
        {
            this.counter.visible = param1 > 0;
            if(this.counter.visible)
            {
                this.counter.setCount(param1.toString());
            }
        }

        private function layoutCounter() : void
        {
            if(this._selectedLeft)
            {
                this.counter.x = this.rightValue.x + this.rightValue.width + COUNTER_X_OFFSET | 0;
            }
            else
            {
                this.counter.x = this.leftValue.x + this.leftValue.width + COUNTER_X_OFFSET | 0;
            }
        }

        private function dispatchSwitch(param1:String) : void
        {
            dispatchEvent(new CustomizationItemEvent(param1));
        }

        private function applyValidTextAlpha() : void
        {
            var _loc2_:* = NaN;
            var _loc1_:Number = this._selectedLeft?ENABLE_ALPHA:DISABLE_ALPHA;
            _loc2_ = !this._selectedLeft?ENABLE_ALPHA:DISABLE_ALPHA;
            this.rightValue.alpha = _loc1_;
            this.leftValue.alpha = _loc2_;
        }

        public function get selectedCustomStyle() : Boolean
        {
            return !this._selectedLeft;
        }

        private function onMouseClickHandler(param1:MouseEventEx) : void
        {
            if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
                if(this._data.rightEnabled)
                {
                    this._selectedLeft = !this._selectedLeft;
                    invalidate(InvalidationType.STATE);
                    this.dispatchSwitch(this._selectedLeft?this._data.leftEvent:this._data.rightEvent);
                    App.utils.scheduler.scheduleOnNextFrame(this.dispatchSwitch,this._selectedLeft?this._data.leftEvent:this._data.rightEvent);
                }
            }
        }

        private function onMouseOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:TextField = null;
            if(this._data.rightEnabled)
            {
                _loc2_ = this._selectedLeft?this.rightValue:this.leftValue;
                _loc2_.alpha = HOVER_ALPHA;
                App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.CUSTOMIZATION_DEFAULT,null);
            }
        }

        private function onMouseOutHandler(param1:MouseEvent) : void
        {
            if(this._data.rightEnabled)
            {
                this.applyValidTextAlpha();
            }
        }

        private function onBackgroundDisableMouseOverHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.show(VEHICLE_CUSTOMIZATION.CUSTOMIZATION_CUSTOMIZATIONTRIGGER_TOOLTIP_NOSTYLE);
        }

        private function onBackgroundDisableMouseOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }
    }
}
