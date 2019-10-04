package net.wg.gui.lobby.vehicleCustomization
{
    import net.wg.infrastructure.base.meta.impl.CustomizationBuyWindowMeta;
    import net.wg.infrastructure.base.meta.ICustomizationBuyWindowMeta;
    import flash.geom.Point;
    import net.wg.gui.components.controls.universalBtn.UniversalBtn;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.lobby.vehicleCustomization.controls.CheckboxWithLabel;
    import flash.text.TextField;
    import net.wg.gui.components.controls.price.CompoundPrice;
    import net.wg.gui.components.controls.ResizableScrollPane;
    import flash.display.Sprite;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.InitBuyWindowVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.utils.IGameInputManager;
    import net.wg.utils.IUtils;
    import net.wg.data.constants.Linkages;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
    import flash.events.Event;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.BuyWindowTittlesVO;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.CustomizationBuyWindowDataVO;
    import net.wg.gui.lobby.vehicleCustomization.controls.slotsGroup.CustomizationSlotsLayout;
    import net.wg.data.constants.UniversalBtnStylesConst;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.PurchasesTotalVO;
    import net.wg.gui.components.controls.VO.PriceVO;
    import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
    import flash.display.InteractiveObject;
    import net.wg.data.constants.Values;
    import scaleform.clik.events.InputEvent;

    public class CustomizationBuyWindow extends CustomizationBuyWindowMeta implements ICustomizationBuyWindowMeta
    {

        private static const BUY_ALLOW_INVALID:String = "buyAllowInvalid";

        private static const LAYOUT_INVALID:String = "layoutInvalid";

        private static const PRICE_ICON_OFFSET:Point = new Point(1,0);

        private static const SCROLL_BAR_VALUE:String = "ScrollBar";

        private static const AUTO_PROLONGATION_CHECKBOX_NAME:String = "autoProlongationCheckbox";

        private static const SCROLL_SHIFT:int = 6;

        private static const BACKGROUND_BIG_OFFSET_Y:int = 30;

        private static const BIG_TITLE_OFFSET:int = 10;

        private static const SCROLL_BAR_STEP_FACTOR:int = 40;

        private static const SCROLL_BAR_MARGIN:int = 10;

        private static const BACK_BTN_X_OFFSET:int = 20;

        private static const CLOSE_BTN_RIGHT_OFFSET:int = 30;

        private static const CLOSE_BTN_Y_OFFSET:int = 50;

        private static const BTN_BUY_X_OFFSET:int = -40;

        private static const BTN_BUY_X_OFFSET_BIG:int = -36;

        private static const BTN_BUY_X_OFFSET_SMALL_RENDERERS_BIG:int = -42;

        private static const BTN_BUY_Y_OFFSET_BIG:int = 39;

        private static const BTN_BUY_Y_OFFSET:int = 19;

        private static const AUTOPROLONGATION_CHECKBOX_OFFSET:int = 13;

        private static const AUTOPROLONGATION_CHECKBOX_OFFSET_Y:int = 2;

        private static const PRICE_X_OFFSET:int = 12;

        private static const PRICE_Y_OFFSET:int = 0;

        private static const TITLE_X_OFFSET:int = 15;

        private static const SMALL_SCREEN_HEIGHT:int = 900;

        private static const SCROLL_SHIFT_SMALL:int = -24;

        private static const BACKGROUND_SMALL_Y:int = 74;

        private static const CLOSE_BTN_Y_OFFSET_SMALL:int = 30;

        private static const TITLE_Y_SMALL:int = 34;

        private static const CONTAINER_GAP:int = 260;

        private static const CONTAINER_GAP_SMALL:int = 230;

        private static const CONTAINER_BIG_RESOLUTION_GAP:int = 60;

        private static const SHADOW_CONTAINER_GAP:int = 20;

        private static const BOTTOM_LIPS_OFFSET:int = 80;

        private static const TOP_LIPS_OFFSET:int = 111;

        private static const BACKGROUND_LIST_OFFSET:int = 0;

        private static const PROLONGATION_CONDITION_TF_OFFSET_X:int = 2;

        private static const PROLONGATION_CONDITION_TF_OFFSET_Y:int = 8;

        private static const AUTO_PROLONGATION_CHECKBOX_HINT_DELAY:uint = 100;

        private static const AVAILABLE_HEIGHT_MIN:uint = 537;

        private static const BACKGROUND_WIDTH_OFFSET:uint = 17;

        public var btnBuy:UniversalBtn = null;

        public var backBtn:ISoundButtonEx = null;

        public var closeBtn:ISoundButtonEx = null;

        public var autoProlongationCheckbox:CheckboxWithLabel = null;

        public var titleTf:TextField = null;

        public var prolongationConditionTf:TextField = null;

        public var totalPrice:CompoundPrice = null;

        public var scrollPane:ResizableScrollPane = null;

        public var styleIcon:Sprite = null;

        public var background:Sprite = null;

        public var listBackground:Sprite = null;

        public var bottomLips:Sprite = null;

        public var topLips:Sprite = null;

        private var _seasonsContainer:CustomizationBuyContainer = null;

        private var _isCanBuy:Boolean = true;

        private var _isShopOn:Boolean = true;

        private var _isStyle:Boolean = false;

        private var _isSmallWidth:Boolean = false;

        private var _isSmallHeight:Boolean = false;

        private var _initDataVO:InitBuyWindowVO = null;

        private var _buyBtnLabel:String = "";

        private var _buyDisabledTooltip:String = "";

        private var _toolTipMgr:ITooltipMgr = null;

        private var _gameInputMgr:IGameInputManager = null;

        private var _utils:IUtils = null;

        private var _isContainsAutoProlongationCheckbox:Boolean = false;

        public function CustomizationBuyWindow()
        {
            super();
            this._seasonsContainer = CustomizationBuyContainer(this.scrollPane.target);
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            this._seasonsContainer.layoutContent();
            invalidate(LAYOUT_INVALID);
        }

        override protected function initialize() : void
        {
            super.initialize();
            this.autoProlongationCheckbox = App.utils.classFactory.getComponent(Linkages.GREEN_CHECKBOX_WITH_LABEL,CheckboxWithLabel);
            this.autoProlongationCheckbox.name = AUTO_PROLONGATION_CHECKBOX_NAME;
            this.autoProlongationCheckbox.text = VEHICLE_CUSTOMIZATION.WINDOW_PURCHASE_AUTOPROLONGATIONLABEL;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.totalPrice.bigFonts = true;
            this._toolTipMgr = App.toolTipMgr;
            this._utils = App.utils;
            this._gameInputMgr = App.gameInputMgr;
            this._gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onHandleEscapeHandler,true);
            this.scrollPane.scrollBar = SCROLL_BAR_VALUE;
            this.scrollPane.scrollBarMargin = SCROLL_BAR_MARGIN;
            this.scrollPane.scrollStepFactor = SCROLL_BAR_STEP_FACTOR;
            this.scrollPane.isSmoothScroll = false;
            this.backBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATIONHEADER_BACK;
            this.backBtn.addEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
            this.closeBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATIONHEADER_CLOSE;
            this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this.btnBuy.mouseEnabledOnDisabled = true;
            this.btnBuy.addEventListener(ButtonEvent.CLICK,this.onBtnBuyClickHandler);
            this.btnBuy.addEventListener(MouseEvent.MOUSE_OUT,this.onBtnBuyMouseOutHandler);
            this.btnBuy.addEventListener(MouseEvent.MOUSE_OVER,this.onBtnBuyMouseOverHandler);
            addEventListener(CustomizationItemEvent.SELECT_ITEM,this.onSelectItemHandler);
            addEventListener(CustomizationItemEvent.DESELECT_ITEM,this.onDeselectItemHandler);
            addEventListener(Event.RESIZE,this.onViewResizeHandler);
            this.bottomLips.mouseEnabled = this.bottomLips.mouseChildren = false;
            this.topLips.mouseEnabled = this.topLips.mouseChildren = false;
            this.totalPrice.priceIconOffset = PRICE_ICON_OFFSET;
            this.totalPrice.itemsDirection = CompoundPrice.DIRECTION_LEFT;
            this.totalPrice.itemsAnchor = CompoundPrice.ANCHOR_BOTTOM_RIGHT;
            this.titleTf.autoSize = TextFieldAutoSize.LEFT;
            this.prolongationConditionTf.autoSize = TextFieldAutoSize.LEFT;
            this.autoProlongationCheckbox.addEventListener(MouseEvent.CLICK,this.onAutoProlongationCheckboxClickHandler);
        }

        override protected function setTitles(param1:BuyWindowTittlesVO) : void
        {
            this._seasonsContainer.setTitles(param1);
        }

        override protected function setData(param1:CustomizationBuyWindowDataVO) : void
        {
            this._seasonsContainer.setDataProviders(param1.summerData,param1.winterData,param1.desertData);
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            var _loc8_:* = 0;
            var _loc9_:* = 0;
            var _loc10_:* = 0;
            var _loc11_:* = 0;
            super.draw();
            if(isInvalid(LAYOUT_INVALID))
            {
                _loc1_ = App.appWidth;
                _loc2_ = App.appHeight;
                _loc3_ = CustomizationSlotsLayout.BACKGROUND_BIG_WIDTH;
                _loc4_ = BTN_BUY_X_OFFSET_BIG;
                _loc5_ = BTN_BUY_Y_OFFSET_BIG;
                _loc6_ = CLOSE_BTN_Y_OFFSET;
                this._isSmallHeight = _loc2_ < SMALL_SCREEN_HEIGHT;
                this._isSmallWidth = _loc1_ <= CustomizationSlotsLayout.SMALL_SCREEN_WIDTH;
                this.resetTitle();
                _loc7_ = this._seasonsContainer.contentHeight;
                _loc7_ = _loc7_ + (this._isSmallHeight?0:SHADOW_CONTAINER_GAP);
                _loc8_ = _loc2_;
                _loc8_ = _loc8_ - (this._isSmallHeight?CONTAINER_GAP_SMALL:CONTAINER_GAP + CONTAINER_BIG_RESOLUTION_GAP);
                _loc9_ = _loc8_ > _loc7_?_loc7_:_loc8_;
                _loc10_ = (_loc2_ - _loc9_ >> 1) - BACKGROUND_BIG_OFFSET_Y;
                _loc11_ = _loc10_ - this.titleTf.height - BIG_TITLE_OFFSET;
                this._utils.universalBtnStyles.setStyle(this.btnBuy,UniversalBtnStylesConst.STYLE_HEAVY_ORANGE);
                if(this._isSmallHeight)
                {
                    _loc5_ = BTN_BUY_Y_OFFSET;
                    if(_loc9_ > AVAILABLE_HEIGHT_MIN)
                    {
                        _loc11_ = TITLE_Y_SMALL;
                        _loc6_ = CLOSE_BTN_Y_OFFSET_SMALL;
                        _loc10_ = BACKGROUND_SMALL_Y;
                    }
                }
                if(this._isSmallWidth)
                {
                    _loc4_ = BTN_BUY_X_OFFSET;
                    _loc3_ = CustomizationSlotsLayout.BACKGROUND_SMALL_WIDTH;
                }
                else
                {
                    if(this._isSmallHeight)
                    {
                        _loc4_ = BTN_BUY_X_OFFSET_SMALL_RENDERERS_BIG;
                    }
                    _loc3_ = CustomizationSlotsLayout.BACKGROUND_BIG_WIDTH;
                }
                if(this._isSmallWidth || this._isSmallHeight)
                {
                    this.scrollPane.scrollBarMargin = 0;
                }
                else
                {
                    this.scrollPane.scrollBarMargin = SCROLL_BAR_MARGIN;
                }
                this.styleIcon.visible = this._isStyle;
                this.listBackground.width = _loc3_;
                this.listBackground.height = _loc9_;
                this.listBackground.x = (_loc1_ - this.listBackground.width >> 1) + BACKGROUND_LIST_OFFSET | 0;
                this.listBackground.y = _loc10_;
                this.background.width = _loc1_;
                this.background.height = _loc2_;
                this.scrollPane.setSize(_loc3_,_loc9_);
                this.scrollPane.x = (_loc1_ - this.scrollPane.width >> 1) + BACKGROUND_LIST_OFFSET;
                this.scrollPane.y = _loc10_;
                this.scrollPane.scrollBarShiftHorizontal = this._isSmallWidth?SCROLL_SHIFT_SMALL:SCROLL_SHIFT;
                this.scrollPane.scrollPosition = 0;
                this.backBtn.x = BACK_BTN_X_OFFSET;
                this.backBtn.y = _loc6_;
                this.closeBtn.x = _loc1_ - this.closeBtn.width - CLOSE_BTN_RIGHT_OFFSET;
                this.closeBtn.y = _loc6_;
                this.topLips.width = this.listBackground.width;
                this.topLips.x = this.listBackground.x;
                this.topLips.y = this.listBackground.y - TOP_LIPS_OFFSET;
                this.bottomLips.width = this.listBackground.width;
                this.bottomLips.x = this.listBackground.x;
                this.bottomLips.y = this.listBackground.y + this.listBackground.height - BOTTOM_LIPS_OFFSET | 0;
                this.titleTf.x = this.listBackground.x + TITLE_X_OFFSET | 0;
                this.titleTf.y = _loc11_;
                this.btnBuy.x = this.listBackground.x + this.listBackground.width - this.btnBuy.width + _loc4_ | 0;
                this.btnBuy.y = this.listBackground.y + this.listBackground.height + _loc5_ | 0;
                this.autoProlongationCheckbox.x = this.listBackground.x + AUTOPROLONGATION_CHECKBOX_OFFSET;
                this.autoProlongationCheckbox.y = this.btnBuy.y + (this.btnBuy.height - this.autoProlongationCheckbox.height >> 1) + AUTOPROLONGATION_CHECKBOX_OFFSET_Y | 0;
                this.totalPrice.x = this.btnBuy.x - PRICE_X_OFFSET | 0;
                this.totalPrice.y = this.btnBuy.y - PRICE_Y_OFFSET | 0;
                this.totalPrice.validateNow();
                this.prolongationConditionTf.x = this.totalPrice.x - this.prolongationConditionTf.width - this.totalPrice.contentWidth - PROLONGATION_CONDITION_TF_OFFSET_X | 0;
                this.prolongationConditionTf.y = this.totalPrice.y + PROLONGATION_CONDITION_TF_OFFSET_Y;
                this.styleIcon.width = this.listBackground.width - BACKGROUND_WIDTH_OFFSET;
                this.styleIcon.scaleY = this.styleIcon.scaleX;
                this.styleIcon.x = this.listBackground.x + BACKGROUND_WIDTH_OFFSET;
                this.styleIcon.y = this.listBackground.y - this.styleIcon.height | 0;
                this.btnBuy.visible = true;
                this.btnBuy.invalidateState();
                if(!this._isContainsAutoProlongationCheckbox && this._initDataVO && this._initDataVO.haveAutoprolongation)
                {
                    this._isContainsAutoProlongationCheckbox = true;
                    this.autoProlongationCheckbox.selected = this._initDataVO.autoprolongationSelected;
                    addChild(this.autoProlongationCheckbox);
                    App.utils.scheduler.scheduleTask(onAutoProlongationCheckboxAddedS,AUTO_PROLONGATION_CHECKBOX_HINT_DELAY);
                }
            }
            if(isInvalid(BUY_ALLOW_INVALID))
            {
                this.btnBuy.enabled = this._isCanBuy;
                this.setBuyBtnLabelAndFocus();
            }
        }

        override protected function onDispose() : void
        {
            removeEventListener(Event.RESIZE,this.onViewResizeHandler);
            removeEventListener(CustomizationItemEvent.SELECT_ITEM,this.onSelectItemHandler);
            removeEventListener(CustomizationItemEvent.DESELECT_ITEM,this.onDeselectItemHandler);
            this._gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onHandleEscapeHandler);
            this.backBtn.removeEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
            this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this.btnBuy.removeEventListener(ButtonEvent.CLICK,this.onBtnBuyClickHandler);
            this.btnBuy.removeEventListener(MouseEvent.MOUSE_OUT,this.onBtnBuyMouseOutHandler);
            this.btnBuy.removeEventListener(MouseEvent.MOUSE_OVER,this.onBtnBuyMouseOverHandler);
            this._initDataVO.dispose();
            this._initDataVO = null;
            this.prolongationConditionTf = null;
            this.totalPrice.dispose();
            this.totalPrice = null;
            this.btnBuy.dispose();
            this.btnBuy = null;
            this.scrollPane.dispose();
            this.scrollPane = null;
            this.backBtn.dispose();
            this.backBtn = null;
            this.closeBtn.dispose();
            this.closeBtn = null;
            this.autoProlongationCheckbox.removeEventListener(MouseEvent.CLICK,this.onAutoProlongationCheckboxClickHandler);
            this.autoProlongationCheckbox.dispose();
            this.autoProlongationCheckbox = null;
            this._seasonsContainer = null;
            this.topLips = null;
            this.bottomLips = null;
            this.listBackground = null;
            this.background = null;
            this.styleIcon = null;
            this.titleTf = null;
            this.btnBuy = null;
            this._toolTipMgr = null;
            this._gameInputMgr = null;
            this._utils = null;
            super.onDispose();
        }

        override protected function setInitData(param1:InitBuyWindowVO) : void
        {
            this._initDataVO = param1;
            this._isStyle = param1.isStyle;
            this.styleIcon.visible = this._isStyle;
            var _loc2_:Boolean = this._initDataVO.prolongStyleRent;
            this.backBtn.visible = !_loc2_;
            this.closeBtn.visible = _loc2_;
            this.resetTitle();
        }

        override protected function setTotalData(param1:PurchasesTotalVO) : void
        {
            var _loc2_:* = 0;
            var _loc3_:PriceVO = null;
            var _loc4_:PriceVO = null;
            var _loc5_:PriceVO = null;
            if(param1)
            {
                _loc2_ = this._isShopOn?int(true):int(param1.enoughMoney);
                _loc3_ = new PriceVO([CURRENCIES_CONSTANTS.GOLD,_loc2_]);
                _loc4_ = new PriceVO([CURRENCIES_CONSTANTS.CREDITS,int(param1.enoughMoney)]);
                _loc5_ = new PriceVO([CURRENCIES_CONSTANTS.CRYSTAL,int(param1.enoughMoney)]);
                this.totalPrice.setData(param1.totalPrice);
                this.totalPrice.updateEnoughStatuses(new <PriceVO>[_loc3_,_loc4_,_loc5_]);
                this.totalPrice.actionTooltip = param1.totalPrice.action;
                this.prolongationConditionTf.htmlText = param1.prolongationCondition;
                invalidate(BUY_ALLOW_INVALID);
            }
        }

        public function as_setBuyBtnState(param1:Boolean, param2:String, param3:String, param4:Boolean) : void
        {
            this._buyBtnLabel = param2;
            this._buyDisabledTooltip = param3;
            this._isCanBuy = param1;
            this._isShopOn = param4;
            invalidate(BUY_ALLOW_INVALID);
        }

        private function setBuyBtnLabelAndFocus() : void
        {
            var _loc1_:InteractiveObject = this.btnBuy as InteractiveObject;
            if(_loc1_)
            {
                setFocus(_loc1_);
            }
            if(this._buyBtnLabel != Values.EMPTY_STR)
            {
                this.btnBuy.label = this._buyBtnLabel;
            }
        }

        private function resetTitle() : void
        {
            if(this._initDataVO)
            {
                this.titleTf.htmlText = this._isSmallHeight?this._initDataVO.titleTextSmall:this._initDataVO.titleText;
            }
        }

        private function onBtnBuyMouseOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onBtnBuyMouseOverHandler(param1:MouseEvent) : void
        {
            if(!this.btnBuy.enabled)
            {
                this._toolTipMgr.show(this._buyDisabledTooltip);
            }
        }

        private function onSelectItemHandler(param1:CustomizationItemEvent) : void
        {
            param1.stopImmediatePropagation();
            selectItemS(param1.itemId,param1.fromStorage);
        }

        private function onDeselectItemHandler(param1:CustomizationItemEvent) : void
        {
            deselectItemS(param1.itemId,param1.fromStorage);
        }

        private function onBtnBuyClickHandler(param1:ButtonEvent) : void
        {
            buyS();
        }

        private function onBackBtnClickHandler(param1:ButtonEvent) : void
        {
            closeS();
        }

        private function onCloseBtnClickHandler(param1:ButtonEvent) : void
        {
            closeS();
        }

        private function onHandleEscapeHandler(param1:InputEvent) : void
        {
            closeS();
        }

        private function onViewResizeHandler(param1:Event) : void
        {
            invalidate(LAYOUT_INVALID);
        }

        private function onAutoProlongationCheckboxClickHandler(param1:MouseEvent) : void
        {
            updateAutoProlongationS();
        }
    }
}
