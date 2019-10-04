package net.wg.gui.lobby.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import net.wg.gui.lobby.questsWindow.data.ComplexTooltipVO;
    import flash.display.BitmapData;
    import flash.events.MouseEvent;
    import scaleform.gfx.TextFieldEx;
    import flash.text.TextFieldAutoSize;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
    import net.wg.data.constants.ProgressIndicatorStates;

    public class ProgressIndicator extends UIComponentEx
    {

        public static const MASK_WIDTH:Number = 64;

        private static const DEFAULT_VALUE:int = 100;

        private static const DOTS_RIGHT_PADDING:int = 2;

        private static const DOTS_RIGHT_HEIGHT:int = 1;

        public var textField:TextField = null;

        public var maskMC:MovieClip = null;

        public var lineMC:MovieClip = null;

        public var dotsContainer:MovieClip = null;

        public var bgMC:MovieClip = null;

        private var _container:Sprite = null;

        private var _type:String = "current";

        private var _currentValue:Number = 0;

        private var _totalValue:Number = 100;

        private var _tooltip:ComplexTooltipVO = null;

        private var _dotsBitmapData:BitmapData = null;

        public function ProgressIndicator()
        {
            super();
            validateNow();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.CLICK,this.onClickHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            TextFieldEx.setVerticalAutoSize(this.textField,TextFieldEx.VALIGN_TOP);
            this.textField.autoSize = TextFieldAutoSize.RIGHT;
            var _loc1_:Class = App.utils.classFactory.getClass(Linkages.PROGRESS_INDICATOR_DOTS_BITMAP);
            this._dotsBitmapData = new _loc1_();
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.CLICK,this.onClickHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            if(this._container != null && this.bgMC.contains(this._container))
            {
                this.bgMC.removeChild(this._container);
            }
            if(this._tooltip != null)
            {
                this._tooltip.dispose();
                this._tooltip = null;
            }
            this._container = null;
            this.textField = null;
            this.maskMC = null;
            this.lineMC = null;
            this.dotsContainer = null;
            this.bgMC = null;
            if(this._dotsBitmapData != null)
            {
                this._dotsBitmapData.dispose();
            }
            this._dotsBitmapData = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            var _loc3_:* = 0;
            var _loc4_:MovieClip = null;
            var _loc5_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.textField.visible = true;
                this.maskMC.width = this._currentValue / this._totalValue * MASK_WIDTH;
                this.textField.htmlText = App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.COUNTER_TEXT,App.utils.locale.integer(this._currentValue) + " / " + App.utils.locale.integer(this._totalValue));
                if(this._container != null && this.bgMC.contains(this._container))
                {
                    this.bgMC.removeChild(this._container);
                }
                if(this._type == ProgressIndicatorStates.CURRENT)
                {
                    this.lineMC.gotoAndStop(ProgressIndicatorStates.CURRENT);
                }
                if(this._type == ProgressIndicatorStates.COMMON)
                {
                    this.lineMC.gotoAndStop(ProgressIndicatorStates.STRATEGIC);
                    this.textField.visible = false;
                }
                if(this._type == ProgressIndicatorStates.STRATEGIC)
                {
                    this.lineMC.gotoAndStop(ProgressIndicatorStates.STRATEGIC);
                    this._container = new Sprite();
                    this._container.scaleX = 1 / scaleX;
                    this._container.scaleY = 1 / scaleY;
                    this.bgMC.addChild(this._container);
                    _loc1_ = this._totalValue - 1;
                    _loc2_ = MASK_WIDTH / this._totalValue;
                    _loc3_ = 0;
                    while(_loc3_ < _loc1_)
                    {
                        _loc4_ = App.utils.classFactory.getComponent(Linkages.DELIMETER_UI,MovieClip);
                        _loc4_.x = _loc2_ + _loc2_ * _loc3_ ^ 0;
                        this._container.addChild(_loc4_);
                        _loc3_++;
                    }
                }
            }
            if(isInvalid(InvalidationType.SETTINGS))
            {
                this.dotsContainer.graphics.beginBitmapFill(this._dotsBitmapData);
                _loc5_ = _width - DOTS_RIGHT_PADDING * scaleX;
                this.dotsContainer.graphics.drawRect(0,0,_loc5_,DOTS_RIGHT_HEIGHT);
                this.dotsContainer.graphics.endFill();
                this.dotsContainer.scaleX = 1 / scaleX;
            }
        }

        public function setTooltip(param1:Object) : void
        {
            this._tooltip = param1?new ComplexTooltipVO(param1):null;
        }

        public function setValues(param1:String, param2:Number, param3:Number) : void
        {
            this._currentValue = param2;
            this._totalValue = param3 > 0?param3:DEFAULT_VALUE;
            this._type = param1;
            invalidateData();
        }

        private function hideTooltip() : void
        {
            App.toolTipMgr.hide();
        }

        private function showTooltip() : void
        {
            var _loc1_:String = null;
            if(this._tooltip)
            {
                _loc1_ = App.toolTipMgr.getNewFormatter().addHeader(this._tooltip.header).addBody(this._tooltip.body,false).addNote(this._tooltip.note?this._tooltip.note:null,false).make();
                if(_loc1_.length > 0)
                {
                    App.toolTipMgr.showComplex(_loc1_);
                }
            }
        }

        private function onClickHandler(param1:MouseEvent) : void
        {
            this.hideTooltip();
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this.hideTooltip();
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            this.showTooltip();
        }
    }
}
