package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.assets.ArrowSeparator;
    import flash.text.TextField;
    import net.wg.gui.components.controls.IconText;
    import net.wg.gui.components.controls.ActionPrice;
    import net.wg.gui.components.controls.NumericStepper;
    import net.wg.gui.components.advanced.StaticItemSlot;
    import net.wg.gui.components.advanced.DashLine;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.data.BoosterBuyWindowVO;
    import net.wg.gui.data.BoosterBuyWindowUpdateVO;
    import net.wg.utils.ITextManager;
    import flash.display.Sprite;
    import scaleform.clik.events.IndexEvent;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
    import flash.events.Event;

    public class BoosterBuyContent extends UIComponentEx
    {

        public static const LAYOUT_CHANGED:String = "layoutChanged";

        private static const CHAR_MULTY:String = " x ";

        private static const INVALID_COUNT_RELATED_ITEMS:String = "invalidCountRelatedItems";

        private static const GAP_DESC_SEP:int = -70;

        private static const BOTTOM_GAP:int = -28;

        public var submitBtn:SoundButtonEx = null;

        public var cancelBtn:SoundButtonEx = null;

        public var separator:ArrowSeparator = null;

        public var nameTf:TextField = null;

        public var descTf:TextField = null;

        public var countTf:TextField = null;

        public var inHangarTf:TextField = null;

        public var buyTf:TextField = null;

        public var totalPriceTf:TextField = null;

        public var inHangarValue:TextField = null;

        public var totalPriceValue:IconText = null;

        public var buyPriceValue:IconText = null;

        public var buyActionPrice:ActionPrice = null;

        public var countNumStepper:NumericStepper = null;

        public var boosterSlot:StaticItemSlot = null;

        public var countDashLine:DashLine = null;

        public var inHangarDashLine:DashLine = null;

        public var buyDashLine:DashLine = null;

        public var totalPriceDashLine:DashLine = null;

        public var rearmCheckbox:CheckBox = null;

        private var _data:BoosterBuyWindowVO = null;

        private var _dataUpdate:BoosterBuyWindowUpdateVO = null;

        private var _isMoneyEnough:Boolean = false;

        private var _textMgr:ITextManager = null;

        private var _bottomContentMc:Sprite = null;

        public function BoosterBuyContent()
        {
            super();
            this._textMgr = App.textMgr;
            this._bottomContentMc = new Sprite();
            addChildAt(this._bottomContentMc,0);
            this._bottomContentMc.addChild(this.submitBtn);
            this._bottomContentMc.addChild(this.cancelBtn);
            this._bottomContentMc.addChild(this.separator);
            this._bottomContentMc.addChild(this.inHangarDashLine);
            this._bottomContentMc.addChild(this.buyDashLine);
            this._bottomContentMc.addChild(this.countDashLine);
            this._bottomContentMc.addChild(this.totalPriceDashLine);
            this._bottomContentMc.addChild(this.countNumStepper);
            this._bottomContentMc.addChild(this.countTf);
            this._bottomContentMc.addChild(this.inHangarTf);
            this._bottomContentMc.addChild(this.buyTf);
            this._bottomContentMc.addChild(this.totalPriceTf);
            this._bottomContentMc.addChild(this.inHangarValue);
            this._bottomContentMc.addChild(this.totalPriceValue);
            this._bottomContentMc.addChild(this.buyPriceValue);
            this._bottomContentMc.addChild(this.buyActionPrice);
            this._bottomContentMc.addChild(this.rearmCheckbox);
        }

        override protected function onDispose() : void
        {
            this.countNumStepper.removeEventListener(IndexEvent.INDEX_CHANGE,this.onCountNumStepperIndexChangeHandler);
            this.submitBtn.dispose();
            this.submitBtn = null;
            this.cancelBtn.dispose();
            this.cancelBtn = null;
            this.separator.dispose();
            this.separator = null;
            this.nameTf = null;
            this.descTf = null;
            this.countTf = null;
            this.buyTf = null;
            this.inHangarTf = null;
            this.inHangarValue = null;
            this.totalPriceTf = null;
            this.totalPriceValue.dispose();
            this.totalPriceValue = null;
            this.buyPriceValue.dispose();
            this.buyPriceValue = null;
            this.inHangarDashLine.dispose();
            this.inHangarDashLine = null;
            this.buyActionPrice.dispose();
            this.buyActionPrice = null;
            this.countNumStepper.dispose();
            this.countNumStepper = null;
            this.boosterSlot.dispose();
            this.boosterSlot = null;
            this.countDashLine.dispose();
            this.countDashLine = null;
            this.buyDashLine.dispose();
            this.buyDashLine = null;
            this.totalPriceDashLine.dispose();
            this.totalPriceDashLine = null;
            this._bottomContentMc = null;
            this.rearmCheckbox.dispose();
            this.rearmCheckbox = null;
            this._data = null;
            this._dataUpdate = null;
            this._textMgr = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.totalPriceValue.useHtmlText = this.buyPriceValue.useHtmlText = true;
            this.countNumStepper.addEventListener(IndexEvent.INDEX_CHANGE,this.onCountNumStepperIndexChangeHandler);
            this.totalPriceTf.autoSize = this.inHangarTf.autoSize = this.buyTf.autoSize = this.countTf.autoSize = this.nameTf.autoSize = TextFieldAutoSize.LEFT;
            this.inHangarValue.autoSize = TextFieldAutoSize.RIGHT;
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.nameTf.htmlText = this._data.nameText;
                this.descTf.htmlText = this._data.descText;
                this.buyTf.htmlText = this._data.buyLabelText;
                this.totalPriceTf.htmlText = this._data.totalPriceLabelText;
                this.countTf.htmlText = this._data.countLabelText;
                this.inHangarTf.htmlText = this._data.inHangarLabelText;
                this.rearmCheckbox.toolTip = this._data.rearmCheckboxTooltip;
                this.rearmCheckbox.label = this._data.rearmCheckboxLabel;
                this.submitBtn.label = this._data.submitBtnLabel;
                this.cancelBtn.label = this._data.cancelBtnLabel;
                this.updateItemPriceFields();
                this.boosterSlot.setup(this._data.boosterSlot);
                this.updateLayout();
            }
            if(this._data && isInvalid(INVALID_COUNT_RELATED_ITEMS))
            {
                this.updateCountRelatedDashlines();
            }
        }

        public function setInitData(param1:BoosterBuyWindowVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        public function updateItemPrice(param1:BoosterBuyWindowUpdateVO) : void
        {
            this._dataUpdate = param1;
            if(this._data)
            {
                this.updateItemPriceFields();
                invalidate(INVALID_COUNT_RELATED_ITEMS);
            }
        }

        private function updateItemPriceFields() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            if(this._dataUpdate)
            {
                this.rearmCheckbox.selected = this._dataUpdate.rearmCheckboxValue;
                _loc1_ = this._dataUpdate.itemCount;
                _loc2_ = _loc1_ + 1;
                if(this._dataUpdate.itemPrice)
                {
                    _loc3_ = Math.floor(this._dataUpdate.currencyCount / this._dataUpdate.itemPrice) + _loc1_;
                }
                else
                {
                    _loc3_ = this._dataUpdate.currencyCount;
                }
                this._isMoneyEnough = _loc3_ >= _loc2_;
                this.countNumStepper.minimum = _loc2_;
                this.countNumStepper.maximum = Math.max(_loc3_,_loc2_);
                this.submitBtn.enabled = this._isMoneyEnough;
                this.inHangarValue.htmlText = this.getStatsFormattedText(String(_loc1_));
                this.totalPriceValue.icon = this.buyPriceValue.icon = this._dataUpdate.currency;
                if(this._dataUpdate.actionPriceData)
                {
                    this.buyActionPrice.setData(this._dataUpdate.actionPriceData);
                    this.buyActionPrice.visible = true;
                    this.buyPriceValue.visible = false;
                }
                else
                {
                    this.buyActionPrice.visible = false;
                    this.buyPriceValue.visible = true;
                }
                this.updateBuyCountRelatedItems();
            }
        }

        private function updateCountRelatedDashlines() : void
        {
            this.buyDashLine.width = this.buyPriceValue.x - this.buyDashLine.x;
            this.totalPriceDashLine.width = this.totalPriceValue.x - this.totalPriceDashLine.x;
        }

        private function updateBuyCountRelatedItems() : void
        {
            var _loc1_:int = this._dataUpdate.itemPrice;
            var _loc2_:int = this.countNumStepper.value - this._dataUpdate.itemCount;
            this.buyPriceValue.text = this.getStatsFormattedText(String(_loc2_ + CHAR_MULTY + _loc1_));
            this.totalPriceValue.text = this.getStatsFormattedText(String(_loc2_ * _loc1_),!this._isMoneyEnough);
        }

        private function getStatsFormattedText(param1:String, param2:Boolean = false) : String
        {
            var _loc3_:String = null;
            if(param2)
            {
                _loc3_ = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.ERROR_TEXT,param1);
            }
            else
            {
                _loc3_ = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.STATS_TEXT,param1);
            }
            return _loc3_;
        }

        private function updateLayout() : void
        {
            App.utils.commons.updateTextFieldSize(this.descTf,false,true);
            this._bottomContentMc.y = this.descTf.y + this.descTf.height + GAP_DESC_SEP | 0;
            this.countDashLine.x = this.countTf.x + this.countTf.width;
            this.countDashLine.width = this.countNumStepper.x - this.countDashLine.x;
            this.inHangarDashLine.x = this.inHangarTf.x + this.inHangarTf.width;
            this.inHangarDashLine.width = this.inHangarValue.x - this.inHangarDashLine.x;
            this.buyDashLine.x = this.buyTf.x + this.buyTf.width;
            this.totalPriceDashLine.x = this.totalPriceTf.x + this.totalPriceTf.width;
            this.updateCountRelatedDashlines();
            dispatchEvent(new Event(LAYOUT_CHANGED));
        }

        override public function get height() : Number
        {
            return this._bottomContentMc.y + this._bottomContentMc.height + BOTTOM_GAP;
        }

        private function onCountNumStepperIndexChangeHandler(param1:IndexEvent) : void
        {
            if(this._dataUpdate)
            {
                this.updateBuyCountRelatedItems();
                invalidate(INVALID_COUNT_RELATED_ITEMS);
            }
        }
    }
}
