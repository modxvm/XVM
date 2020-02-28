package net.wg.gui.lobby.vehicleCustomization
{
    import net.wg.infrastructure.base.meta.impl.CustomizationBottomPanelMeta;
    import net.wg.infrastructure.base.meta.ICustomizationBottomPanelMeta;
    import net.wg.infrastructure.interfaces.IFocusChainContainer;
    import net.wg.infrastructure.interfaces.IPopOverCaller;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.universalBtn.UniversalBtn;
    import flash.display.Sprite;
    import flash.text.TextField;
    import net.wg.gui.lobby.vehicleCustomization.controls.bottomPanel.CustomizationCarouselOverlay;
    import net.wg.infrastructure.managers.IPopoverManager;
    import net.wg.utils.IUtils;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.display.DisplayObjectContainer;
    import net.wg.data.constants.SoundTypes;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationTabEvent;
    import flash.events.Event;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
    import net.wg.gui.events.FiltersEvent;
    import net.wg.data.constants.UniversalBtnStylesConst;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationBottomPanelInitVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSwitcherVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationTabNavigatorVO;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselDataVO;
    import net.wg.data.VO.TankCarouselFilterSelectedVO;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselFilterVO;
    import net.wg.gui.lobby.vehicleCustomization.data.BottomPanelVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.notification.events.NotificationLayoutEvent;
    import flash.geom.Point;
    import net.wg.data.constants.Values;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselRendererVO;
    import net.wg.gui.lobby.vehicleCustomization.data.CustomizationBottomPanelNotificationVO;
    import flash.display.InteractiveObject;
    import flash.display.DisplayObject;
    import scaleform.gfx.MouseEventEx;
    import net.wg.data.Aliases;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class BottomPanel extends CustomizationBottomPanelMeta implements ICustomizationBottomPanelMeta, IFocusChainContainer, IPopOverCaller
    {

        private static const SM_PADDING_X:int = 4;

        private static const SM_PADDING_Y:int = -21;

        private static const INV_SYSTEM_MESSAGE:String = "InvSystemMessage";

        private static const INVALID_SCROLL_POS:String = "InvalidScrollPos";

        private static const BUY_OFFSET_VERTICAL:int = 26;

        private static const BUY_OFFSET_HORIZONTAL:int = 15;

        private static const PRICE_OFFSET_VERTICAL:int = -130;

        private static const PRICE_OFFSET_HORIZONTAL:int = 5;

        private static const SWITCH_Y:int = -34;

        private static const ITEMS_BUTTON_OFFSET:int = 5;

        private static const NON_HISTORIC_ICON_OFFSET_X:int = 25;

        private static const NON_HISTORIC_FIX_ICON_WIDTH:int = 60;

        private static const MIN_RESOLUTION:int = 900;

        private static const TOP_SMALL_OFFSET:int = 6;

        private static const BUY_BACKGROUND_Y:int = 4;

        private static const NON_HISTORIC_ICON_Y:int = 12;

        private static const ITEMS_INFO_BTN_ALPHA:Number = 0.6;

        private static const POPOVER_BUTTON_STATE_INVALID:String = "popoverBtnStateInvalid";

        public var tabBg:MovieClip = null;

        public var carousel:CustomizationCarousel = null;

        public var buyBtn:UniversalBtn = null;

        public var background:MovieClip = null;

        public var buyBackground:Sprite = null;

        public var tabGlow:Sprite = null;

        public var nonHistoricIcon:CustomizationNonHistoricIcon = null;

        public var defaultStyleLabel:TextField = null;

        public var bill:CustomizationBill = null;

        public var tabNavigator:CustomizationTabNavigator;

        public var switcher:CustomizationTrigger;

        public var itemsPopoverBtn:UniversalBtn = null;

        public var overlay:CustomizationCarouselOverlay = null;

        private var _popoverMgr:IPopoverManager = null;

        private var _utils:IUtils = null;

        private var _tooltipMgr:ITooltipMgr;

        private var _buyDisabledTooltip:String = "";

        private var _popoverBtnDisabledTooltip:String = "";

        private var _smPadding:Number = 0;

        private var _systemMessages:DisplayObjectContainer;

        private var _isNonHistoric:Boolean = false;

        private var _toolTipMgr:ITooltipMgr = null;

        private var _isCustomStyleMode:Boolean = false;

        private var _isMinResolution:Boolean = false;

        private var _intCDToScroll:int = -1;

        private var _scrollImmediately:Boolean = false;

        private var _popoverBtnState:Boolean = true;

        private var _popoverIsOpen:Boolean = false;

        private var _notificationShow:Boolean = false;

        public function BottomPanel()
        {
            this._tooltipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._utils = App.utils;
            this._popoverMgr = App.popoverMgr;
            this._toolTipMgr = App.toolTipMgr;
            this._systemMessages = App.systemMessages;
            this.buyBtn.soundType = SoundTypes.CUSTOMIZATION_DEFAULT;
            this.buyBtn.mouseEnabledOnDisabled = true;
            this.bill.visible = false;
            this.buyBackground.visible = false;
            this.background.mouseEnabled = this.background.mouseChildren = false;
            this.buyBackground.mouseEnabled = this.buyBackground.mouseChildren = false;
            this.tabGlow.mouseEnabled = this.tabGlow.mouseChildren = false;
            this.defaultStyleLabel.mouseEnabled = false;
            this.defaultStyleLabel.autoSize = TextFieldAutoSize.CENTER;
            var _loc1_:Sprite = new Sprite();
            this.background.hitArea = _loc1_;
            addChild(_loc1_);
            this.switcher.addEventListener(CustomizationItemEvent.INSTALL_CUSTOM_STYLE,this.onStageInstallCustomStyleHandler);
            this.switcher.addEventListener(CustomizationItemEvent.INSTALL_STYLES,this.onStageInstallStylesHandler);
            App.stage.addEventListener(CustomizationItemEvent.SELECT_ITEM,this.onBottomPanelCarouselSelectItemHandler);
            this.buyBtn.addEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
            this.buyBtn.addEventListener(MouseEvent.MOUSE_OUT,this.onBtnBuyMouseOutHandler);
            this.buyBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onBtnBuyMouseOverHandler);
            this.tabNavigator.addEventListener(CustomizationTabEvent.TAB_CHANGED,this.onNavigatorTabChangedHandler);
            this.tabNavigator.addEventListener(Event.RESIZE,this.onTabNavigatorResizeHandler);
            this.itemsPopoverBtn.mouseEnabledOnDisabled = true;
            this.itemsPopoverBtn.addEventListener(ButtonEvent.CLICK,this.onItemsPopoverBtnClickHandler);
            this.itemsPopoverBtn.addEventListener(MouseEvent.ROLL_OVER,this.onItemsPopoverBtnRollOverHandler);
            this.carousel.addEventListener(CustomizationEvent.REFRESH_FILTER_DATA,this.onRefreshFilterDataHandler);
            this.carousel.addEventListener(CustomizationEvent.RESET_FILTER,this.onResetFilterHandler);
            this.carousel.addEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onBottomPanelCarouselFilterCounterResetAllFiltersHandler);
            this.carousel.addEventListener(CustomizationEvent.SELECT_HOT_FILTER,this.onBottomPanelCarouselSelectHotFilterHandler);
            App.stage.addEventListener(CustomizationEvent.ITEMS_POPOVER_CLOSED,this.onItemPopoverClosedHandler);
            this.overlay.addEventListener(MouseEvent.CLICK,this.onOverlayClickHandler);
            this.overlay.visible = false;
            this._utils.universalBtnStyles.setStyle(this.itemsPopoverBtn,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
            this._utils.universalBtnStyles.setStyle(this.buyBtn,UniversalBtnStylesConst.STYLE_HEAVY_ORANGE);
            this.itemsPopoverBtn.disabledImageAlpha = ITEMS_INFO_BTN_ALPHA;
        }

        override protected function setBottomPanelInitData(param1:CustomizationBottomPanelInitVO) : void
        {
            this.defaultStyleLabel.text = param1.defaultStyleLabel;
            this.carousel.setCarouselFiltersInitData(param1.filtersVO);
            invalidateSize();
        }

        override protected function setSwitchersData(param1:CustomizationSwitcherVO) : void
        {
            this.switcher.init(param1);
            this.switchState(param1.isLeft);
        }

        override protected function setBottomPanelTabsData(param1:CustomizationTabNavigatorVO) : void
        {
            this.tabNavigator.setData(param1);
        }

        override protected function setBottomPanelTabsPluses(param1:Array) : void
        {
            this.tabNavigator.setTabsPluses(param1);
        }

        override protected function setCarouselData(param1:CustomizationCarouselDataVO) : void
        {
            this.carousel.setData(param1);
        }

        override protected function setCarouselFiltersData(param1:TankCarouselFilterSelectedVO) : void
        {
            this.carousel.setCarouselFiltersData(param1);
        }

        override protected function setFilterData(param1:CustomizationCarouselFilterVO) : void
        {
            this.carousel.setFilterData(param1);
        }

        public function showNotification() : void
        {
            this.updateNotificationState();
        }

        public function hideNotification() : void
        {
            this.updateNotificationState(true);
        }

        public function as_onProjectionDecalOnlyOnceHintShown() : void
        {
            this._notificationShow = true;
            this.updateNotificationState();
        }

        public function as_onProjectionDecalOnlyOnceHintHidden() : void
        {
            this._notificationShow = false;
            this.updateNotificationState();
        }

        private function updateNotificationState(param1:Boolean = false) : void
        {
            this.carousel.hintArea.visible = param1?false:this._notificationShow;
        }

        override protected function setBottomPanelPriceState(param1:BottomPanelVO) : void
        {
            this.buyBtn.label = param1.buyBtnLabel;
            this._buyDisabledTooltip = param1.buyBtnTooltip;
            this.buyBtn.enabled = param1.buyBtnEnabled;
            this.bill.setData(param1.billVO);
            this._isNonHistoric = !param1.isHistoric;
            if(this._isNonHistoric)
            {
                this.nonHistoricIcon.fadeIn();
            }
            else
            {
                this.nonHistoricIcon.fadeOut();
            }
            invalidateSize();
        }

        override protected function onDispose() : void
        {
            this.switcher.removeEventListener(CustomizationItemEvent.INSTALL_CUSTOM_STYLE,this.onStageInstallCustomStyleHandler);
            this.switcher.removeEventListener(CustomizationItemEvent.INSTALL_STYLES,this.onStageInstallStylesHandler);
            this.tabNavigator.removeEventListener(CustomizationTabEvent.TAB_CHANGED,this.onNavigatorTabChangedHandler);
            this.tabNavigator.removeEventListener(Event.RESIZE,this.onTabNavigatorResizeHandler);
            this.carousel.removeEventListener(CustomizationEvent.RESET_FILTER,this.onResetFilterHandler);
            this.carousel.removeEventListener(CustomizationEvent.REFRESH_FILTER_DATA,this.onRefreshFilterDataHandler);
            App.stage.removeEventListener(CustomizationItemEvent.SELECT_ITEM,this.onBottomPanelCarouselSelectItemHandler);
            this.buyBtn.removeEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
            this.buyBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.onBtnBuyMouseOutHandler);
            this.buyBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onBtnBuyMouseOverHandler);
            this.carousel.removeEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onBottomPanelCarouselFilterCounterResetAllFiltersHandler);
            this.carousel.removeEventListener(CustomizationEvent.SELECT_HOT_FILTER,this.onBottomPanelCarouselSelectHotFilterHandler);
            this.itemsPopoverBtn.removeEventListener(ButtonEvent.CLICK,this.onItemsPopoverBtnClickHandler);
            this.itemsPopoverBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onItemsPopoverBtnRollOverHandler);
            this.overlay.removeEventListener(MouseEvent.CLICK,this.onOverlayClickHandler);
            App.stage.removeEventListener(CustomizationEvent.ITEMS_POPOVER_CLOSED,this.onItemPopoverClosedHandler);
            this.overlay.dispose();
            this.overlay = null;
            this.itemsPopoverBtn.dispose();
            this.itemsPopoverBtn = null;
            this.tabNavigator.dispose();
            this.tabNavigator = null;
            this.bill.dispose();
            this.bill = null;
            this.carousel.dispose();
            this.carousel = null;
            this.buyBtn.dispose();
            this.buyBtn = null;
            this.switcher.dispose();
            this.switcher = null;
            this._utils = null;
            this.defaultStyleLabel = null;
            this.buyBackground = null;
            this.background = null;
            this.tabBg = null;
            this.tabGlow = null;
            this.nonHistoricIcon.dispose();
            this.nonHistoricIcon = null;
            this._popoverMgr = null;
            this._tooltipMgr = null;
            this._systemMessages = null;
            this._toolTipMgr = null;
            super.onDispose();
        }

        public function as_carouselFilterMessage(param1:String) : void
        {
            this.carousel.setFilterMessage(param1);
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                _loc1_ = App.appHeight < MIN_RESOLUTION;
                this.tabBg.width = _width;
                this.background.width = _width;
                this.tabGlow.width = _width;
                this.carousel.width = _width;
                this.carousel.invalidateSize();
                this.overlay.updateSize(_width,_height,_loc1_);
                this.tabNavigator.updateStage(_width,App.appHeight);
                _loc2_ = _loc1_?TOP_SMALL_OFFSET:0;
                this.buyBtn.x = _width - this.buyBtn.width - BUY_OFFSET_VERTICAL ^ 0;
                this.buyBackground.x = this.buyBtn.x - BUY_OFFSET_HORIZONTAL ^ 0;
                this.buyBackground.y = BUY_BACKGROUND_Y + _loc2_;
                this.itemsPopoverBtn.x = this.buyBtn.x - ITEMS_BUTTON_OFFSET - this.itemsPopoverBtn.width ^ 0;
                this.nonHistoricIcon.x = this.itemsPopoverBtn.x + this.itemsPopoverBtn.width - (NON_HISTORIC_FIX_ICON_WIDTH >> 1) + NON_HISTORIC_ICON_OFFSET_X ^ 0;
                this.nonHistoricIcon.y = NON_HISTORIC_ICON_Y + _loc2_;
                this.bill.x = _width - this.bill.width - PRICE_OFFSET_HORIZONTAL ^ 0;
                this.bill.y = PRICE_OFFSET_VERTICAL + _loc2_;
                this.switcher.validateNow();
                this.switcher.x = _width - this.switcher.background.width >> 1 ^ 0;
                this.switcher.y = SWITCH_Y;
                this.defaultStyleLabel.x = _width - this.defaultStyleLabel.width >> 1 ^ 0;
                if(this._isMinResolution != _loc1_)
                {
                    this._isMinResolution = _loc1_;
                    this._utils.universalBtnStyles.setStyle(this.itemsPopoverBtn,_loc1_?UniversalBtnStylesConst.STYLE_SLIM_GREEN:UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
                    this._utils.universalBtnStyles.setStyle(this.buyBtn,_loc1_?UniversalBtnStylesConst.STYLE_SLIM_ORANGE:UniversalBtnStylesConst.STYLE_HEAVY_ORANGE);
                }
            }
            if(isInvalid(INV_SYSTEM_MESSAGE))
            {
                this._systemMessages.dispatchEvent(new NotificationLayoutEvent(NotificationLayoutEvent.UPDATE_LAYOUT,new Point(SM_PADDING_X,this._smPadding + SM_PADDING_Y)));
            }
            if(isInvalid(INVALID_SCROLL_POS))
            {
                _loc3_ = 0;
                if(this._intCDToScroll != Values.DEFAULT_INT)
                {
                    _loc3_ = this.getItemIndexByIndCD(this._intCDToScroll);
                }
                if(_loc3_ != Values.DEFAULT_INT)
                {
                    this.carousel.goToItem(_loc3_,true,this._scrollImmediately);
                }
                this._intCDToScroll = Values.DEFAULT_INT;
            }
            if(isInvalid(POPOVER_BUTTON_STATE_INVALID))
            {
                this.itemsPopoverBtn.enabled = this._popoverIsOpen || this._popoverBtnState;
            }
        }

        public function getItemIndexByIndCD(param1:int) : int
        {
            var _loc3_:CustomizationCarouselRendererVO = null;
            var _loc2_:int = this.carousel.dataProvider.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc2_)
            {
                _loc3_ = CustomizationCarouselRendererVO(this.carousel.dataProvider.requestItemAt(_loc4_));
                if(_loc3_.intCD == param1)
                {
                    return _loc4_;
                }
                _loc4_++;
            }
            return Values.DEFAULT_INT;
        }

        override protected function setNotificationCounters(param1:CustomizationBottomPanelNotificationVO) : void
        {
            this.tabNavigator.setNotificationCounters(param1.tabsCounters);
            this.switcher.setNotificationCounters(param1.switchersCounter);
        }

        public function as_getDataProvider() : Object
        {
            return this.carousel.getDataProvider();
        }

        public function as_hideBill() : void
        {
            invalidate(INV_SYSTEM_MESSAGE);
            this._smPadding = this.background.height;
            this.setBillVisibility(false);
        }

        public function as_setItemsPopoverBtnEnabled(param1:Boolean) : void
        {
            invalidate(POPOVER_BUTTON_STATE_INVALID);
            this._popoverBtnState = param1;
        }

        public function as_showBill() : void
        {
            invalidate(INV_SYSTEM_MESSAGE);
            this._smPadding = this.background.height + this.bill.height;
            this.setBillVisibility(true);
        }

        public function as_showPopoverBtnIcon(param1:String, param2:String) : void
        {
            this.itemsPopoverBtn.iconSource = param1;
            this._popoverBtnDisabledTooltip = param2;
        }

        public function clearSelected() : void
        {
            this.carousel.clearSelected();
        }

        public function getFocusChain() : Vector.<InteractiveObject>
        {
            var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
            if(this.tabNavigator.visible)
            {
                _loc1_ = _loc1_.concat(this.tabNavigator.getFocusChain(),this.carousel.getFocusChain());
            }
            return _loc1_;
        }

        public function getHitArea() : DisplayObject
        {
            return this.itemsPopoverBtn;
        }

        public function getTargetButton() : DisplayObject
        {
            return this.itemsPopoverBtn;
        }

        public function as_playFilterBlink() : void
        {
            this.carousel.playFilterBlink();
        }

        public function hideOverlay() : void
        {
            this.overlay.hide();
        }

        public function as_scrollToSlot(param1:int, param2:Boolean) : void
        {
            this._intCDToScroll = param1;
            this._scrollImmediately = param2;
            invalidate(INVALID_SCROLL_POS);
        }

        public function selectSlot(param1:int, param2:Boolean = false) : void
        {
            this.carousel.selectSlot(param1,param2);
        }

        public function setBillVisibility(param1:Boolean) : void
        {
            this.bill.visible = param1;
            this.buyBackground.visible = param1;
        }

        public function showOverlay(param1:String, param2:Boolean = false) : void
        {
            this.overlay.show(param1,param2);
        }

        private function switchState(param1:Boolean) : void
        {
            this.carousel.playFilterBlink();
            this._isCustomStyleMode = param1;
            this.carousel.scrollList.moveToHorizontalScrollPosition(0);
            this.tabNavigator.switchState(param1);
            this.defaultStyleLabel.visible = !param1;
            if(!param1)
            {
                dispatchEvent(new CustomizationTabEvent(CustomizationTabEvent.TAB_CHANGED,0,true));
            }
        }

        private function onOverlayClickHandler(param1:MouseEvent) : void
        {
            this.hideOverlay();
        }

        private function onBtnBuyMouseOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onBtnBuyMouseOverHandler(param1:MouseEvent) : void
        {
            if(!this.buyBtn.enabled)
            {
                this._toolTipMgr.show(this._buyDisabledTooltip);
            }
        }

        private function onNavigatorTabChangedHandler(param1:CustomizationTabEvent) : void
        {
            this.carousel.scrollList.moveToHorizontalScrollPosition(0);
            this.carousel.playFilterBlink();
            if(param1.groupId != Values.DEFAULT_INT)
            {
                showGroupFromTabS(param1.groupId);
            }
        }

        private function onStageInstallCustomStyleHandler(param1:CustomizationItemEvent) : void
        {
            this.switchState(true);
            switchToCustomS();
        }

        private function onStageInstallStylesHandler(param1:CustomizationItemEvent) : void
        {
            this.switchState(false);
            switchToStyleS();
        }

        private function onItemsPopoverBtnClickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:String = null;
            if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
                _loc2_ = this._isCustomStyleMode?Aliases.CUSTOMIZATION_ITEMS_POPOVER:Aliases.CUSTOMIZATION_KIT_POPOVER;
                this._popoverIsOpen = true;
                this._popoverMgr.show(this,_loc2_,null);
            }
        }

        private function onBuyBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new CustomizationEvent(CustomizationEvent.SHOW_BUY_WINDOW,false));
        }

        private function onBottomPanelCarouselSelectItemHandler(param1:CustomizationItemEvent) : void
        {
            onSelectItemS(param1.itemId,param1.groupId);
        }

        private function onRefreshFilterDataHandler(param1:CustomizationEvent) : void
        {
            refreshFilterDataS();
        }

        private function onResetFilterHandler(param1:CustomizationEvent) : void
        {
            resetFilterS();
        }

        private function onItemPopoverClosedHandler(param1:CustomizationEvent) : void
        {
            this._popoverIsOpen = false;
            invalidate(POPOVER_BUTTON_STATE_INVALID);
        }

        private function onBottomPanelCarouselSelectHotFilterHandler(param1:CustomizationEvent) : void
        {
            onSelectHotFilterS(param1.index,param1.select);
            this.carousel.playFilterBlink();
        }

        private function onBottomPanelCarouselFilterCounterResetAllFiltersHandler(param1:FiltersEvent) : void
        {
            resetFilterS();
        }

        private function onItemsPopoverBtnRollOverHandler(param1:MouseEvent) : void
        {
            if(this.itemsPopoverBtn.enabled)
            {
                this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_HISTORIC_ITEM,null,this._isNonHistoric,false,this._isCustomStyleMode);
            }
            else
            {
                this._tooltipMgr.show(this._popoverBtnDisabledTooltip);
            }
        }

        private function onTabNavigatorResizeHandler(param1:Event) : void
        {
            this.tabBg.height = this.tabNavigator.tabBar.height;
            this.tabBg.y = this.tabGlow.y = this.tabNavigator.y = this.background.y - this.tabNavigator.tabBar.height;
            this.defaultStyleLabel.y = this.tabNavigator.y + (this.tabNavigator.tabBar.height - this.defaultStyleLabel.height >> 1);
            this.itemsPopoverBtn.y = this.tabNavigator.y + (this.tabNavigator.tabBar.height - this.itemsPopoverBtn.height >> 1);
            this.buyBtn.y = this.tabNavigator.y + (this.tabNavigator.tabBar.height - this.buyBtn.height >> 1);
        }
    }
}
