package net.wg.gui.lobby.vehicleCustomization.controls
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
    import net.wg.infrastructure.interfaces.entity.IDropItem;
    import flash.geom.Point;
    import net.wg.gui.components.controls.Image;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.price.CompoundPrice;
    import net.wg.gui.components.common.CounterView;
    import net.wg.gui.components.controls.BitmapFill;
    import flash.text.TextField;
    import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselRendererVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import scaleform.clik.core.UIComponent;
    import scaleform.clik.motion.Tween;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import scaleform.gfx.TextFieldEx;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.components.controls.VO.PriceVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationShared;
    import flash.geom.Rectangle;
    import net.wg.data.constants.ImageCacheTypes;
    import net.wg.data.constants.Values;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import net.wg.data.constants.SoundManagerStates;
    import net.wg.data.constants.SoundTypes;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
    import net.wg.data.constants.Cursors;
    import scaleform.gfx.MouseEventEx;
    import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;

    public class CarouselItemRenderer extends UIComponentEx implements IScrollerItemRenderer, IDropItem
    {

        private static const LIMITED_TEXT_ICON_SIZE:int = 32;

        private static const IMAGE_MARGIN:int = 1;

        private static const LOCKED_LOCK_AND_BONUS_ALPHA:Number = 1;

        private static const LOCKED_IMG_ALPHA:Number = 0.33;

        private static const ICON_PADDING_RIGHT:int = 5;

        private static const ALERT_ICON_X:int = 5;

        private static const ACTION_ICON_PADDING_RIGHT:int = 6;

        private static const ACTION_MIN_RES_OFFSET:int = -4;

        private static const SELECTED_WIDTH_OFFSET:int = 20;

        private static const SELECTED_HEIGHT_OFFSET:int = 18;

        private static const SELECTED_SMALL_X:int = 1;

        private static const SELECTED_WIDE_X:int = 11;

        private static const SELECTED_MIN_RES_SMALL_X:int = -1;

        private static const SELECTED_MIN_RES_WIDE_X:int = 8;

        private static const SELECTED_Y:int = 1;

        private static const SELECTED_MIN_RES_Y:int = -1;

        private static const NON_HISTORIC_OFFSET:int = 1;

        private static const PRICE_ICON_OFFSET:Point = new Point(-2,1);

        private static const PRICE_BG_OFFSET:Point = new Point(-2,0);

        private static const STYLE_NAME_TF_WIDE_WIDTH:int = 205;

        private static const STYLE_NAME_TF_WIDE_SMALL_WIDTH:int = 157;

        private static const PLACEHOLDER_ALPHA:Number = 0.2;

        private static const ALREADY_USED_STYLE_NAME_ALPHA:Number = 0.3;

        private static const TEXTFIELD_PADDING:int = 8;

        private static const MIN_WIDTH_RESOLUTION:int = 1280;

        private static const MIN_HEIGHT_RESOLUTION:int = 900;

        private static const SHADOW_SCALE:Number = 0.6;

        private static const STORAGE_OFFSET:int = 3;

        private static const STYLE_NAME_TF_V_POS:int = 23;

        private static const STYLE_NAME_TF_V_OFFSET:int = -10;

        private static const RENTAL_ICON_OFFSET:int = 8;

        private static const RENTAL_ICON_MAX_HEIGHT:int = 38;

        private static const RESET_COUNTER_DELAY:int = 300;

        private static const COUNTER_OFFSET:int = -20;

        private static const FORM_ICON_OFFSET_Y:int = 88;

        private static const FORM_ICON_OFFSET_SMALL_Y:int = 66;

        public var imgIcon:Image = null;

        public var hitMc:MovieClip = null;

        public var rareIcon:Image = null;

        public var rareBg:Sprite = null;

        public var frontground:Sprite = null;

        public var equippedImg:Image = null;

        public var alertIcon:Image = null;

        public var lockedIcon:MovieClip = null;

        public var compoundPrice:CompoundPrice = null;

        public var counter:CounterView = null;

        public var shadow:MovieClip = null;

        public var nonHistoricImg:Image = null;

        public var disabledFill:BitmapFill = null;

        public var bg:MovieClip = null;

        public var selectedMC:MovieClip = null;

        public var hover:MovieClip = null;

        public var imgBg:MovieClip = null;

        public var rentalIcon:Image = null;

        public var rentalTF:TextField = null;

        public var storageIcon:Image = null;

        public var limitedIcon:Image = null;

        public var storageTF:TextField = null;

        public var styleNameTF:TextField = null;

        public var limitedText:TextField = null;

        public var limitedTextIcon:Image = null;

        public var isResponsive:Boolean = true;

        public var considerWidth:Boolean = false;

        public var formIcon:Image = null;

        private var _isMinResolution:Boolean = false;

        private var _data:CustomizationCarouselRendererVO = null;

        private var _toolTipMgr:ITooltipMgr = null;

        private var _selected:Boolean = false;

        private var _index:uint = 0;

        private var _owner:UIComponent = null;

        private var _buyOperationAllowed:Boolean = true;

        private var _styleTfFiltersPreset:Array;

        private var _customWidth:Number = 0;

        private var _customHeight:Number = 0;

        private var _tweens:Vector.<Tween>;

        private var _inventoryFadeTween:Tween = null;

        private var _handlersRegistered:Boolean = false;

        private var _originalImgWidth:Number = 0;

        private var _originalImgHeight:Number = 0;

        public function CarouselItemRenderer()
        {
            this._styleTfFiltersPreset = [];
            this._tweens = new Vector.<Tween>();
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            hitArea = this.hitMc;
            mouseChildren = true;
            buttonMode = true;
            this.registerHandlers();
            this.bg.mouseChildren = this.bg.mouseEnabled = false;
            this.disabledFill.mouseChildren = this.disabledFill.mouseEnabled = false;
            this.selectedMC.mouseChildren = this.selectedMC.mouseEnabled = false;
            this.hover.mouseChildren = this.hover.mouseEnabled = false;
            this.hover.visible = false;
            this.imgBg.visible = false;
            this.nonHistoricImg.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_NON_HISTORICAL;
            this.nonHistoricImg.addEventListener(Event.CHANGE,this.onNonHistoricImgChangeHandler);
            this.nonHistoricImg.mouseChildren = this.nonHistoricImg.mouseEnabled = true;
            this.nonHistoricImg.buttonMode = true;
            this.nonHistoricImg.addEventListener(MouseEvent.ROLL_OVER,this.onNonHistoricImgRollOverHandler);
            this.nonHistoricImg.addEventListener(MouseEvent.ROLL_OUT,this.onNonHistoricImgRollOutHandler);
            this.nonHistoricImg.visible = false;
            this.storageIcon.visible = this.storageTF.visible = false;
            this.storageIcon.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_STORAGE_ICON;
            this.storageIcon.addEventListener(Event.CHANGE,this.onStorageIconChangeHandler);
            this.limitedIcon.mouseEnabled = false;
            this.limitedIcon.visible = false;
            this.limitedIcon.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_STAR;
            this.imgIcon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
            this.lockedIcon.alpha = LOCKED_LOCK_AND_BONUS_ALPHA;
            this.lockedIcon.mouseEnabled = false;
            this.rentalIcon.mouseEnabled = false;
            this.rentalTF.mouseEnabled = false;
            this.rentalTF.visible = this.rentalIcon.visible = false;
            this.alertIcon.visible = false;
            this.alertIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ALERTICON;
            this.limitedTextIcon.mouseChildren = this.limitedTextIcon.mouseEnabled = false;
            this.limitedTextIcon.visible = false;
            this.limitedTextIcon.source = RES_ICONS.MAPS_ICONS_VEHICLESTATES_UNSUITABLETOUNIT;
            this.equippedImg.visible = false;
            this.equippedImg.mouseEnabled = this.equippedImg.mouseChildren = false;
            this.equippedImg.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_EQUIPPED_SLOT;
            this.equippedImg.addEventListener(Event.CHANGE,this.onEquippedImgChangeHandler);
            this.rentalIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_CLOCKICON_1;
            TextFieldEx.setVerticalAlign(this.styleNameTF,TextFieldEx.VALIGN_CENTER);
            this.storageTF.autoSize = TextFieldAutoSize.LEFT;
            TextFieldEx.setVerticalAlign(this.limitedText,TextFieldEx.VALIGN_CENTER);
            this.limitedText.autoSize = TextFieldAutoSize.LEFT;
            this.limitedText.mouseEnabled = false;
            this.limitedText.visible = false;
            this.rareIcon.visible = false;
            this.rareIcon.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_BRUSH_RARE;
            this.rareIcon.mouseEnabled = this.rareIcon.mouseChildren = false;
            this.rareBg.mouseEnabled = this.rareBg.mouseChildren = false;
            this.formIcon.mouseEnabled = this.formIcon.mouseChildren = false;
            this._styleTfFiltersPreset = this.styleNameTF.filters;
        }

        override protected function onDispose() : void
        {
            var _loc1_:Tween = null;
            App.utils.scheduler.cancelTask(this.resetCounter);
            this.unregisterHandlers();
            this.nonHistoricImg.removeEventListener(MouseEvent.ROLL_OVER,this.onNonHistoricImgRollOverHandler);
            this.nonHistoricImg.removeEventListener(MouseEvent.ROLL_OUT,this.onNonHistoricImgRollOutHandler);
            this._toolTipMgr = null;
            this.imgIcon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
            this.imgIcon.dispose();
            this.imgIcon = null;
            this.alertIcon.dispose();
            this.alertIcon = null;
            this.equippedImg.removeEventListener(Event.CHANGE,this.onEquippedImgChangeHandler);
            this.equippedImg.dispose();
            this.equippedImg = null;
            this.frontground = null;
            this.imgBg = null;
            this.lockedIcon = null;
            this.compoundPrice.dispose();
            this.compoundPrice = null;
            this.counter.dispose();
            this.counter = null;
            this.shadow = null;
            this.hover = null;
            this.disabledFill.dispose();
            this.disabledFill = null;
            this.bg = null;
            this.selectedMC = null;
            this.nonHistoricImg.removeEventListener(Event.CHANGE,this.onNonHistoricImgChangeHandler);
            this.nonHistoricImg.dispose();
            this.nonHistoricImg = null;
            this.limitedIcon.dispose();
            this.limitedIcon = null;
            this.rentalIcon.dispose();
            this.limitedTextIcon.dispose();
            this.limitedTextIcon = null;
            this.formIcon.dispose();
            this.formIcon = null;
            this.rareIcon.dispose();
            this.rareIcon = null;
            this.rareBg = null;
            this._data = null;
            this._owner = null;
            for each(_loc1_ in this._tweens)
            {
                _loc1_.paused = true;
                _loc1_.dispose();
            }
            this._tweens.splice(0,this._tweens.length);
            this._tweens = null;
            if(this._inventoryFadeTween)
            {
                this._inventoryFadeTween.dispose();
                this._inventoryFadeTween = null;
            }
            this.styleNameTF = null;
            this.limitedText = null;
            this.rentalIcon = null;
            this.rentalTF = null;
            this.storageIcon.removeEventListener(Event.CHANGE,this.onStorageIconChangeHandler);
            this.storageIcon.dispose();
            this.storageIcon = null;
            this.storageTF = null;
            this.hitMc = null;
            this._styleTfFiltersPreset.length = 0;
            this._styleTfFiltersPreset = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:PriceVO = null;
            var _loc2_:PriceVO = null;
            var _loc3_:PriceVO = null;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.applyData();
            }
            if(isInvalid(InvalidationType.STATE))
            {
                _loc1_ = new PriceVO([CURRENCIES_CONSTANTS.GOLD,int(this._buyOperationAllowed)]);
                _loc2_ = new PriceVO([CURRENCIES_CONSTANTS.CREDITS,int(this._buyOperationAllowed)]);
                _loc3_ = new PriceVO([CURRENCIES_CONSTANTS.CRYSTAL,int(this._buyOperationAllowed)]);
                this.compoundPrice.updateEnoughStatuses(new <PriceVO>[_loc1_,_loc2_,_loc3_]);
            }
        }

        public function applyData() : void
        {
            var _loc3_:* = 0;
            var _loc4_:* = false;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            var _loc1_:Boolean = this._data != null && this._data.intCD;
            this._isMinResolution = this.isResponsive && App.appHeight < MIN_HEIGHT_RESOLUTION;
            if(this.considerWidth && !this._isMinResolution)
            {
                this._isMinResolution = this.isResponsive && App.appWidth <= MIN_WIDTH_RESOLUTION;
            }
            var _loc2_:Rectangle = CustomizationShared.computeItemSize(this._data?this._data.isWide:false,this._isMinResolution);
            this._customWidth = _loc2_.width;
            this._customHeight = _loc2_.height;
            this.bg.width = this._customWidth;
            this.bg.height = this._customHeight;
            this.shadow.width = this.bg.width - (IMAGE_MARGIN << 1);
            this.shadow.height = this.bg.height * SHADOW_SCALE;
            this.hover.width = this.bg.width - (IMAGE_MARGIN << 1);
            this.hover.height = this.bg.height - (IMAGE_MARGIN << 1);
            this.imgIcon.cacheType = ImageCacheTypes.USE_WEB_CACHE;
            this.setEnable(_loc1_);
            if(!_loc1_)
            {
                this.imgIcon.source = null;
                this.disabledFill.visible = false;
                this.lockedIcon.visible = false;
                this.imgIcon.alpha = this._data?this._data.defaultIconAlpha:Values.DEFAULT_ALPHA;
                this.counter.visible = false;
                this.imgBg.visible = false;
                return;
            }
            this.nonHistoricImg.source = this._isMinResolution?RES_ICONS.MAPS_ICONS_CUSTOMIZATION_NON_HISTORICAL_MINI:RES_ICONS.MAPS_ICONS_CUSTOMIZATION_NON_HISTORICAL;
            if(this._data.isDarked)
            {
                this.frontground.width = this._customWidth;
                this.frontground.height = this._customHeight;
                this.frontground.visible = true;
                buttonMode = true;
            }
            else
            {
                this.frontground.visible = false;
            }
            this.disabledFill.visible = this._data.locked;
            this.lockedIcon.visible = this._data.locked;
            this.lockedIcon.x = this._customWidth - this.lockedIcon.width - ICON_PADDING_RIGHT;
            this.counter.visible = this._data.noveltyCounter > 0;
            if(this.counter.visible)
            {
                this.counter.setCount(this._data.noveltyCounter.toString());
                this.counter.x = this._customWidth + COUNTER_OFFSET | 0;
            }
            this.limitedIcon.visible = this._data.isSpecial;
            this.rareIcon.visible = this.rareBg.visible = this._data.showRareIcon;
            this.imgBg.visible = this._data.isDim;
            if(this.imgBg.visible)
            {
                this.imgBg.width = this._customWidth;
                this.imgBg.height = this._customHeight;
            }
            this.selectedMC.width = this.shadow.width + SELECTED_WIDTH_OFFSET;
            this.selectedMC.height = this.bg.height + SELECTED_HEIGHT_OFFSET;
            if(this._isMinResolution)
            {
                this.selectedMC.x = this._data.isWide?SELECTED_MIN_RES_WIDE_X:SELECTED_MIN_RES_SMALL_X;
                this.selectedMC.y = SELECTED_MIN_RES_Y;
            }
            else
            {
                this.selectedMC.x = this._data.isWide?SELECTED_WIDE_X:SELECTED_SMALL_X;
                this.selectedMC.y = SELECTED_Y;
            }
            this.disabledFill.width = this.shadow.width;
            this.disabledFill.height = this.bg.height - (IMAGE_MARGIN << 1);
            this.disabledFill.widthFill = this.shadow.width;
            this.disabledFill.heightFill = this.bg.height - (IMAGE_MARGIN << 1);
            this.nonHistoricImgPosition();
            hitArea.width = this._customWidth;
            hitArea.height = this._customHeight;
            this.imgIcon.scaleX = this.imgIcon.scaleY = 1;
            this.imgIcon.source = this._data.icon;
            this.setImageIconTransform();
            this.nonHistoricImg.visible = this._data.isNonHistoric;
            this.imgIcon.alpha = this._data.locked?LOCKED_IMG_ALPHA:this._data.defaultIconAlpha;
            this.alertIcon.visible = this._data.showAlert;
            this.formIcon.y = this._isMinResolution?FORM_ICON_OFFSET_SMALL_Y:FORM_ICON_OFFSET_Y;
            this.formIcon.visible = StringUtils.isNotEmpty(this._data.formIconSource);
            this.formIcon.source = this._data.formIconSource;
            if(this.limitedIcon.visible)
            {
                this.alertIcon.x = this.limitedIcon.x + this.limitedIcon.width;
            }
            else
            {
                this.alertIcon.x = ALERT_ICON_X;
            }
            this.equippedImgPosition();
            this.equippedImg.visible = this._data.isEquipped;
            this.compoundPrice.visible = false;
            this.compoundPrice.itemsDirection = CompoundPrice.DIRECTION_UP;
            this.compoundPrice.itemsAnchor = CompoundPrice.ANCHOR_BOTTOM_RIGHT;
            this.compoundPrice.priceIconOffset = PRICE_ICON_OFFSET;
            this.compoundPrice.priceActionOffset = PRICE_BG_OFFSET;
            this.styleNameTF.visible = StringUtils.isNotEmpty(this._data.styleName);
            if(this.styleNameTF.visible)
            {
                this.styleNameTF.alpha = Values.DEFAULT_ALPHA;
                this.styleNameTF.htmlText = this._isMinResolution?this._data.styleNameSmall:this._data.styleName;
                this.styleNameTF.filters = this._isMinResolution?[]:this._styleTfFiltersPreset;
            }
            this.styleNameTF.y = STYLE_NAME_TF_V_POS + int(this._isMinResolution) * STYLE_NAME_TF_V_OFFSET;
            this.styleNameTF.width = this._isMinResolution?STYLE_NAME_TF_WIDE_SMALL_WIDTH:STYLE_NAME_TF_WIDE_WIDTH;
            if(this._data.isAlreadyUsed || this._data.isUnsupportedForm)
            {
                this.imgIcon.alpha = this._data.defaultIconAlpha;
                this.frontground.visible = false;
                this.styleNameTF.alpha = ALREADY_USED_STYLE_NAME_ALPHA;
                this.lockedIcon.visible = false;
                this.limitedText.visible = false;
                if(this._data.isWide)
                {
                    this.limitedText.visible = true;
                    this.limitedText.htmlText = this._data.lockText;
                    this.limitedText.autoSize = TextFieldAutoSize.LEFT;
                    this.limitedText.width = this.limitedText.textWidth + TEXTFIELD_PADDING;
                    _loc3_ = this._customWidth - LIMITED_TEXT_ICON_SIZE - this.limitedText.width >> 1;
                    this.limitedTextIcon.y = this._customHeight - LIMITED_TEXT_ICON_SIZE >> 1;
                    this.limitedTextIcon.x = _loc3_;
                    this.limitedText.y = this._customHeight - this.limitedText.height >> 1;
                    this.limitedText.x = this.limitedTextIcon.x + LIMITED_TEXT_ICON_SIZE;
                }
                else
                {
                    this.limitedTextIcon.x = this._customWidth - LIMITED_TEXT_ICON_SIZE >> 1;
                    this.limitedTextIcon.y = this._customHeight - LIMITED_TEXT_ICON_SIZE >> 1;
                }
                this.limitedTextIcon.visible = true;
            }
            else
            {
                this.limitedText.visible = false;
                this.limitedTextIcon.visible = false;
            }
            if(this._data.buyPrice)
            {
                this.compoundPrice.setData(this._data.buyPrice);
                this.compoundPrice.validateNow();
                this.buyOperationAllowed = this._data.buyOperationAllowed;
                this.compoundPrice.visible = StringUtils.isEmpty(this._data.quantity);
                if(this.compoundPrice.visible)
                {
                    _loc4_ = this._data.buyPrice.action != null;
                    _loc5_ = this._isMinResolution?0:-ICON_PADDING_RIGHT;
                    _loc6_ = _loc4_?ACTION_ICON_PADDING_RIGHT:0;
                    _loc7_ = _loc4_ && this._isMinResolution?ACTION_MIN_RES_OFFSET:0;
                    this.compoundPrice.x = this._customWidth + _loc5_ + _loc6_ + _loc7_;
                    this.compoundPrice.y = this._customHeight;
                }
            }
            if(this._data.isRental)
            {
                if(StringUtils.isNotEmpty(this._data.quantity))
                {
                    this.rentalTF.visible = this.rentalIcon.visible = true;
                    this.storageIcon.visible = this.storageTF.visible = false;
                    this.rentalTF.text = this._data.quantity.toString();
                    this.rentalTF.y = this._customHeight - this.rentalTF.height ^ 0;
                    this.rentalIcon.y = this._customHeight - RENTAL_ICON_MAX_HEIGHT + RENTAL_ICON_OFFSET;
                    this.rentalIcon.source = this._data.autoRentEnabled?RES_ICONS.MAPS_ICONS_CUSTOMIZATION_ICON_RENT:RES_ICONS.MAPS_ICONS_LIBRARY_CLOCKICON_1;
                }
                else
                {
                    this.rentalTF.visible = false;
                    this.rentalIcon.visible = false;
                    this.storageIcon.visible = false;
                    this.storageTF.visible = true;
                    this.compoundPrice.validateNow();
                    this.storageTF.htmlText = this._data.rentalInfoText;
                    this.storageTF.x = this.compoundPrice.x - this.compoundPrice.contentWidth - this.storageTF.width ^ 0;
                    this.storageTF.y = this._customHeight - this.storageTF.height ^ 0;
                    this.storageIcon.y = this._customHeight - this.storageIcon.height ^ 0;
                }
            }
            else if(StringUtils.isNotEmpty(this._data.quantity))
            {
                this.rentalTF.visible = this.rentalIcon.visible = false;
                this.storageIcon.visible = this.storageTF.visible = true;
                this.storageTF.text = this._data.quantity.toString();
                this.layoutStorageInfo();
            }
            else
            {
                this.rentalTF.visible = this.rentalIcon.visible = false;
                this.storageIcon.visible = this.storageTF.visible = false;
            }
            if(!this._data.showDetailItems)
            {
                this.rentalTF.visible = this.rentalIcon.visible = false;
                this.storageIcon.visible = this.storageTF.visible = false;
            }
            if(this._data.isPlaceHolder)
            {
                alpha = PLACEHOLDER_ALPHA;
            }
        }

        public function measureSize(param1:Point = null) : Point
        {
            return null;
        }

        public function setImageSize() : void
        {
            this.setImageIconTransform();
            dispatchEvent(new Event(Event.CHANGE));
        }

        private function nonHistoricImgPosition() : void
        {
            this.nonHistoricImg.x = this.shadow.width - this.nonHistoricImg.width + NON_HISTORIC_OFFSET;
        }

        private function equippedImgPosition() : void
        {
            this.equippedImg.x = this.shadow.width - this.equippedImg.width >> 1;
        }

        private function registerHandlers() : void
        {
            if(!this._handlersRegistered)
            {
                addEventListener(MouseEvent.CLICK,this.onClickHandler);
                addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
                addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
                this._handlersRegistered = true;
            }
        }

        private function unregisterHandlers() : void
        {
            if(this._handlersRegistered)
            {
                removeEventListener(MouseEvent.CLICK,this.onClickHandler);
                removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
                removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
                this._handlersRegistered = false;
            }
        }

        private function setEnable(param1:Boolean) : void
        {
            if(enabled != param1)
            {
                enabled = param1;
                this.imgIcon.visible = param1;
            }
        }

        private function setImageIconTransform() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            var _loc3_:* = NaN;
            if(this._originalImgWidth != 0 && this._originalImgHeight != 0 && this._customWidth != 0 && this._customHeight != 0)
            {
                _loc1_ = this._customWidth - (IMAGE_MARGIN << 1);
                _loc2_ = this._customHeight - (IMAGE_MARGIN << 1);
                _loc3_ = Math.min(Math.min(_loc1_ / this._originalImgWidth,_loc2_ / this._originalImgHeight),1);
                this.imgIcon.width = this._originalImgWidth * _loc3_ | 0;
                this.imgIcon.height = this._originalImgHeight * _loc3_ | 0;
                this.imgIcon.x = this._customWidth - this.imgIcon.width >> 1;
                this.imgIcon.y = this._customHeight - this.imgIcon.height >> 1;
            }
        }

        private function showItemTooltip() : void
        {
            this.tooltipDecorator.showSpecial(TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM,null,this._data.intCD,true,this._data.isUnsupportedForm);
            App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.CUSTOMIZATION_DEFAULT,null);
        }

        private function layoutStorageInfo() : void
        {
            if(!this._data.isRental)
            {
                this.storageTF.x = this._customWidth - this.storageTF.width - STORAGE_OFFSET ^ 0;
                this.storageIcon.x = this.storageTF.x - this.storageIcon.width + ICON_PADDING_RIGHT ^ 0;
            }
            this.storageTF.y = this._customHeight - this.storageTF.height ^ 0;
            this.storageIcon.y = this._customHeight - this.storageIcon.height ^ 0;
        }

        private function resetCounter() : void
        {
            if(this.counter.visible)
            {
                this.counter.visible = false;
                dispatchEvent(new CustomizationItemEvent(CustomizationItemEvent.SEEN_ITEM,this._data.intCD));
            }
        }

        public function set buyOperationAllowed(param1:Boolean) : void
        {
            this._buyOperationAllowed = param1;
            invalidateState();
        }

        public function get selected() : Boolean
        {
            return this._selected;
        }

        public function set selected(param1:Boolean) : void
        {
            this.selectedMC.visible = param1;
            if(this._selected != param1)
            {
                this._selected = param1;
                if(this._selected)
                {
                    App.utils.scheduler.cancelTask(this.resetCounter);
                    this.resetCounter();
                }
            }
        }

        public function get index() : uint
        {
            return this._index;
        }

        public function set index(param1:uint) : void
        {
            this._index = param1;
        }

        public function get owner() : UIComponent
        {
            return this._owner;
        }

        public function set owner(param1:UIComponent) : void
        {
            this._owner = param1;
        }

        public function get data() : Object
        {
            return this._data;
        }

        public function set data(param1:Object) : void
        {
            if(param1)
            {
                this._data = CustomizationCarouselRendererVO(param1);
                invalidateData();
            }
            else
            {
                this.compoundPrice.visible = false;
            }
        }

        public function get tooltipDecorator() : ITooltipMgr
        {
            if(this._toolTipMgr != null)
            {
                return this._toolTipMgr;
            }
            return App.toolTipMgr;
        }

        public function set tooltipDecorator(param1:ITooltipMgr) : void
        {
            this._toolTipMgr = param1;
        }

        public function set isViewPortEnabled(param1:Boolean) : void
        {
        }

        public function get getCursorType() : String
        {
            return Cursors.HAND;
        }

        public function get isLocked() : Boolean
        {
            return this._data.locked;
        }

        private function onNonHistoricImgRollOutHandler(param1:MouseEvent) : void
        {
            this.tooltipDecorator.hide();
            this.showItemTooltip();
        }

        private function onNonHistoricImgRollOverHandler(param1:MouseEvent) : void
        {
            this.tooltipDecorator.showSpecial(TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_HISTORIC_ITEM,null,true,true,false);
        }

        private function onEquippedImgChangeHandler(param1:Event) : void
        {
            this.equippedImgPosition();
        }

        private function onNonHistoricImgChangeHandler(param1:Event) : void
        {
            this.nonHistoricImgPosition();
        }

        private function onImageChangeHandler(param1:Event) : void
        {
            this._originalImgWidth = this.imgIcon.width;
            this._originalImgHeight = this.imgIcon.height;
            this.setImageSize();
        }

        private function onStorageIconChangeHandler(param1:Event) : void
        {
            this.layoutStorageInfo();
        }

        private function onClickHandler(param1:MouseEvent) : void
        {
            var _loc2_:MouseEventEx = param1 as MouseEventEx;
            var _loc3_:uint = _loc2_ == null?0:_loc2_.buttonIdx;
            if(_loc3_ == MouseEventEx.LEFT_BUTTON && (this._data.locked || this._data.isDarked))
            {
                param1.stopImmediatePropagation();
            }
            else if(_loc3_ == MouseEventEx.LEFT_BUTTON)
            {
                dispatchEvent(new CustomizationItemEvent(CustomizationItemEvent.SELECT_ITEM,this._index,this._data.intCD));
            }
            else if(_loc3_ == MouseEventEx.RIGHT_BUTTON)
            {
                App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.CUSTOMIZATION_ITEM,this,{
                    "itemID":this._data.intCD,
                    "itemType":this._data.typeId,
                    "itemIndex":this._index
                });
                dispatchEvent(new CustomizationItemEvent(CustomizationItemEvent.DISPLAYED_CONTEXT_MENU,this._data.intCD));
            }
            this.tooltipDecorator.hide();
            App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.CUSTOMIZATION_DEFAULT,null);
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this.hover.visible = false;
            this.tooltipDecorator.hide();
            App.utils.scheduler.cancelTask(this.resetCounter);
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            this.hover.visible = true;
            this.showItemTooltip();
            App.utils.scheduler.scheduleTask(this.resetCounter,RESET_COUNTER_DELAY);
        }
    }
}
