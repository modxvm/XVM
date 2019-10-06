package net.wg.gui.lobby.storage.categories.cards
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.utils.IStageSizeDependComponent;
    import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
    import net.wg.infrastructure.interfaces.entity.ISoundable;
    import flash.geom.Rectangle;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.IconText;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.Image;
    import flash.display.Sprite;
    import scaleform.clik.motion.Tween;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.text.TextFieldAutoSize;
    import flash.display.Graphics;
    import scaleform.clik.constants.InvalidationType;
    import flash.geom.Point;
    import net.wg.gui.components.controls.VO.PriceVO;
    import net.wg.data.constants.generated.SLOT_HIGHLIGHT_TYPES;
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.utils.ICommons;
    import net.wg.gui.components.controls.VO.CompoundPriceVO;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;

    public class BaseCard extends UIComponentEx implements IStageSizeDependComponent, IScrollerItemRenderer, ISoundable
    {

        protected static const FIRST_ANIMATION_DURATION:Number = 200;

        protected static const FLAG_SIZE:Rectangle = new Rectangle(0,0,205,171);

        protected static const DISCOUNT_OFFSET:int = 2;

        protected static const ROLL_OVER_ANIMATION_DELAY:int = 300;

        protected static const SELL_BUTTON_MIN_WIDTH:int = 90;

        protected static const BORDER_OFFSET:Number = 0.5;

        protected static const BORDER_CORNER_RADIUS:int = 2;

        protected static const OVERLAY_OFFSET:int = 1;

        protected static const ININVENTORY_ICON_OFFSET:int = 2;

        protected static const BORDER_SIZE_CORRECTION:Number = 2.5;

        protected static const OVERLAY_SIZE_CORRECTION:int = 3;

        private static const CANNOT_SELL_ICON_V_OFFSET:int = 1;

        private static const TOOLTIP_ACTION_PRICE_FIELD_NAME_ITEM:String = "item";

        private static const DISPLAY_OBJECT_NAME_OVERLAY:String = "overlay";

        private static const DISPLAY_OBJECT_NAME_CONTAINER:String = "container";

        private static const FRAME_LABEL_CONNECTOR:String = "_";

        private static const FLAG_HOVER_ALPHA:Number = 0.7;

        public var inInventoryIcon:MovieClip;

        public var discountIcon:MovieClip;

        public var equipmentType:MovieClip;

        public var price:IconText;

        public var titleTF:TextField;

        public var descriptionTF:TextField;

        public var inInventoryCountTF:TextField;

        public var cannotSellTF:TextField;

        public var cannotSellIcon:MovieClip;

        public var sellButton:SoundButtonEx;

        public var image:Image;

        public var flags:Image;

        protected var _container:Sprite;

        protected var _overlay:Sprite;

        protected var _tweens:Vector.<Tween>;

        protected var _data:BaseCardVO;

        protected var _sizeVO:CardSizeVO;

        protected var _isOver:Boolean;

        protected var _resetViewOnDataChange:Boolean = true;

        private var _index:uint;

        private var _stageWidthBoundary:int;

        public function BaseCard()
        {
            super();
        }

        override protected function initialize() : void
        {
            super.initialize();
            alpha = 0;
            App.stageSizeMgr.register(this);
        }

        override protected function onDispose() : void
        {
            App.utils.scheduler.cancelTask(dispatchEvent);
            if(App.soundMgr != null)
            {
                App.soundMgr.removeSoundHdlrs(this);
            }
            this.disposeTweens();
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            removeEventListener(MouseEvent.CLICK,this.onClickHandler);
            if(this.flags)
            {
                this.flags.removeEventListener(Event.CHANGE,this.onFlagsChangeHandler);
                this.flags.dispose();
                this.flags = null;
            }
            this.inInventoryIcon = null;
            if(this.discountIcon)
            {
                this.discountIcon.removeEventListener(MouseEvent.MOUSE_OVER,this.onDiscountIconMouseOverHandler);
                this.discountIcon.removeEventListener(MouseEvent.MOUSE_OUT,this.onDiscountIconMouseOutHandler);
                this.discountIcon = null;
            }
            this.equipmentType = null;
            this.sellButton.dispose();
            this.sellButton = null;
            this.image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
            this.image.dispose();
            this.image = null;
            if(this.price)
            {
                this.price.dispose();
                this.price = null;
            }
            this.titleTF = null;
            this.descriptionTF = null;
            this.inInventoryCountTF = null;
            this.cannotSellTF = null;
            this.cannotSellIcon = null;
            this._data = null;
            this._tweens = null;
            this._container = null;
            this._overlay = null;
            this._sizeVO = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._tweens = new Vector.<Tween>(0);
            this._overlay = new Sprite();
            this._overlay.name = DISPLAY_OBJECT_NAME_OVERLAY;
            this._overlay.alpha = 0;
            this._container = new Sprite();
            this._container.name = DISPLAY_OBJECT_NAME_CONTAINER;
            this._container.addChild(this.titleTF);
            this._container.mouseEnabled = this._container.mouseChildren = false;
            if(this.price)
            {
                this.price.mouseEnabled = this.price.mouseChildren = false;
            }
            this.titleTF.multiline = true;
            this.titleTF.wordWrap = true;
            this.titleTF.autoSize = TextFieldAutoSize.LEFT;
            if(this.cannotSellTF)
            {
                this.cannotSellTF.mouseEnabled = this.cannotSellTF.mouseWheelEnabled = false;
                this.cannotSellTF.autoSize = TextFieldAutoSize.LEFT;
                this.cannotSellTF.text = STORAGE.CARD_CANNOTSELLTITLE;
                this.cannotSellIcon.mouseChildren = this.cannotSellIcon.mouseEnabled = false;
            }
            if(this.inInventoryCountTF)
            {
                this.inInventoryCountTF.mouseEnabled = this.inInventoryCountTF.mouseWheelEnabled = false;
                this.inInventoryCountTF.autoSize = TextFieldAutoSize.LEFT;
                this.inInventoryIcon.mouseEnabled = this.inInventoryIcon.mouseChildren = false;
            }
            hitArea = this._overlay;
            if(this.equipmentType)
            {
                this.equipmentType.visible = false;
                this.equipmentType.mouseEnabled = this.equipmentType.mouseChildren = false;
            }
            if(this.discountIcon)
            {
                this.discountIcon.addEventListener(MouseEvent.MOUSE_OVER,this.onDiscountIconMouseOverHandler);
                this.discountIcon.addEventListener(MouseEvent.MOUSE_OUT,this.onDiscountIconMouseOutHandler);
            }
            if(this.flags)
            {
                this.flags.mouseEnabled = this.flags.mouseChildren = false;
                this.flags.addEventListener(Event.CHANGE,this.onFlagsChangeHandler);
            }
            this.image.mouseEnabled = this.image.mouseChildren = false;
            this.image.addEventListener(Event.CHANGE,this.onImageChangeHandler);
            if(this.descriptionTF)
            {
                this._container.addChild(this.descriptionTF);
                this.descriptionTF.alpha = 0;
                this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
            }
            this.sellButton.label = STORAGE.BUTTONLABEL_SELL;
            this.sellButton.alpha = 0;
            this.sellButton.minWidth = SELL_BUTTON_MIN_WIDTH;
            this.sellButton.autoSize = TextFieldAutoSize.RIGHT;
            addChild(this._container);
            addChildAt(this._overlay,0);
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            addEventListener(MouseEvent.CLICK,this.onClickHandler);
            if(App.soundMgr)
            {
                App.soundMgr.addSoundsHdlrs(this);
            }
            alpha = 1;
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            var _loc2_:Graphics = null;
            var _loc3_:Rectangle = null;
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                buttonMode = this._data.enabled;
                _loc1_ = this._data.price && this._data.price.action != null;
                this.titleTF.htmlText = this._data.title;
                if(this.descriptionTF)
                {
                    this.descriptionTF.htmlText = this._data.description;
                    if(this._resetViewOnDataChange)
                    {
                        this.descriptionTF.alpha = 0;
                    }
                }
                this.drawPrice();
                if(this.flags)
                {
                    if(this._data.nationFlagIcon)
                    {
                        this.flags.source = this._data.nationFlagIcon;
                        this.flags.visible = true;
                        if(this._resetViewOnDataChange)
                        {
                            this.flags.alpha = FLAG_HOVER_ALPHA;
                        }
                    }
                    else
                    {
                        this.flags.visible = false;
                    }
                }
                if(this.inInventoryCountTF)
                {
                    this.inInventoryCountTF.visible = this.inInventoryIcon.visible = this._data.count > 0;
                    this.inInventoryCountTF.text = this._data.count.toString();
                    if(this._resetViewOnDataChange)
                    {
                        this.inInventoryCountTF.alpha = 1;
                        this.inInventoryIcon.alpha = 1;
                    }
                }
                if(this.discountIcon)
                {
                    this.discountIcon.visible = _loc1_ && this._data.enabled;
                }
                this.sellButton.visible = this._data.enabled;
                if(this._resetViewOnDataChange)
                {
                    this.sellButton.alpha = 0;
                    this._overlay.alpha = 0;
                }
                invalidateSize();
            }
            if(this._data && isInvalid(InvalidationType.SIZE))
            {
                if(this._resetViewOnDataChange)
                {
                    this.disposeTweens();
                }
                if(this.image.source != this._data.image)
                {
                    this.image.alpha = 0;
                    this.image.sourceAlt = this._data.imageAlt;
                    this.image.source = this._data.image;
                }
                _loc2_ = graphics;
                _loc2_.clear();
                _loc2_.lineStyle(1,16777215,0.15);
                _loc2_.beginFill(0,0.25);
                _loc2_.drawRoundRect(BORDER_OFFSET,BORDER_OFFSET,width - BORDER_SIZE_CORRECTION,height - BORDER_SIZE_CORRECTION,BORDER_CORNER_RADIUS,BORDER_CORNER_RADIUS);
                _loc2_.endFill();
                _loc2_ = this._overlay.graphics;
                _loc2_.clear();
                _loc2_.beginFill(1973272);
                _loc2_.drawRoundRect(1,1,width - OVERLAY_SIZE_CORRECTION,height - OVERLAY_SIZE_CORRECTION,BORDER_CORNER_RADIUS,BORDER_CORNER_RADIUS);
                _loc2_.endFill();
                if(this.flags)
                {
                    this.flags.y = this._sizeVO.flagsOffset;
                }
                _loc3_ = this._sizeVO.innerPadding;
                if(this.price)
                {
                    if(this.discountIcon && this.discountIcon.visible)
                    {
                        this.discountIcon.x = _loc3_.left;
                        this.price.x = this.discountIcon.x + this.discountIcon.width + DISCOUNT_OFFSET >> 0;
                        this.price.y = _loc3_.bottom - this.price.height >> 0;
                        this.discountIcon.y = this.price.y + (this.price.height - this.discountIcon.height >> 1);
                    }
                    else
                    {
                        this.price.x = _loc3_.left;
                        this.price.y = _loc3_.bottom - this.price.height >> 0;
                    }
                }
                if(this.cannotSellTF)
                {
                    this.cannotSellTF.x = _loc3_.left + this.cannotSellIcon.width + ININVENTORY_ICON_OFFSET;
                    this.cannotSellTF.y = _loc3_.bottom - this.cannotSellTF.height >> 0;
                    this.cannotSellIcon.x = _loc3_.left;
                    this.cannotSellIcon.y = this.cannotSellTF.y + (this.cannotSellTF.height - this.cannotSellIcon.height >> 1) + CANNOT_SELL_ICON_V_OFFSET;
                }
                if(this.inInventoryCountTF)
                {
                    this.inInventoryCountTF.x = _loc3_.right - this.inInventoryCountTF.width >> 0;
                    this.inInventoryCountTF.y = _loc3_.bottom - this.inInventoryCountTF.height >> 0;
                    this.inInventoryIcon.x = this.inInventoryCountTF.x - this.inInventoryIcon.width - ININVENTORY_ICON_OFFSET;
                    this.inInventoryIcon.y = this.inInventoryCountTF.y - ININVENTORY_ICON_OFFSET;
                }
                this.titleTF.x = _loc3_.left;
                this.titleTF.width = this.price && this.price.visible || !this.inInventoryIcon || !this.inInventoryIcon.visible?_loc3_.width:this.inInventoryIcon.x - this.titleTF.x;
                if(!this._isOver)
                {
                    this._container.y = this.getContainerYRolloutPosition();
                }
                if(this.descriptionTF)
                {
                    this.descriptionTF.x = _loc3_.left;
                    this.descriptionTF.y = this.titleTF.y + this.titleTF.height + this._sizeVO.descriptionOffset;
                    this.descriptionTF.width = _loc3_.width >> 0;
                }
                this.sellButton.x = _loc3_.right - this.sellButton.width >> 0;
                this.sellButton.y = _loc3_.bottom - this.sellButton.height >> 0;
                this.renderEquipmentType();
                this.onImageComplete();
            }
        }

        public function canPlaySound(param1:String) : Boolean
        {
            return true;
        }

        public function getSoundId() : String
        {
            return null;
        }

        public function getSoundType() : String
        {
            return null;
        }

        public function measureSize(param1:Point = null) : Point
        {
            return null;
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            this._stageWidthBoundary = App.stageSizeMgr.calcAllowSize(param1,CardSizeConfig.ALLOW_CARDS_RESOLUTION);
            this._sizeVO = CardSizeConfig.getConfig(this._stageWidthBoundary);
        }

        protected function drawPrice() : void
        {
            var _loc1_:PriceVO = this._data.price?this._data.price.price.getPriceVO():null;
            if(this._data.enabled && _loc1_)
            {
                if(this.price)
                {
                    this.price.text = App.utils.locale.integer(_loc1_.value);
                    this.price.icon = _loc1_.name;
                    this.price.visible = true;
                    this.price.invalidatePosition();
                    this.price.validateNow();
                }
                if(this.cannotSellTF)
                {
                    this.cannotSellTF.visible = this.cannotSellIcon.visible = false;
                }
            }
            else
            {
                if(this.price)
                {
                    this.price.visible = false;
                }
                if(this.cannotSellTF)
                {
                    this.cannotSellTF.visible = this.cannotSellIcon.visible = true;
                }
            }
        }

        protected function getRollOverTweens() : Vector.<Tween>
        {
            var _loc1_:* = height - this._container.height >> 1;
            if(this.sellButton.visible && _loc1_ + this._container.height > this.sellButton.y)
            {
                _loc1_ = this.sellButton.y - this._container.height >> 1;
            }
            var _loc2_:Vector.<Tween> = new <Tween>[new Tween(FIRST_ANIMATION_DURATION,this._container,{"y":_loc1_},{
                "fastTransform":false,
                "delay":ROLL_OVER_ANIMATION_DELAY
            }),new Tween(FIRST_ANIMATION_DURATION,this._overlay,{"alpha":1},{
                "fastTransform":false,
                "delay":ROLL_OVER_ANIMATION_DELAY
            }),new Tween(FIRST_ANIMATION_DURATION,this.image,{"alpha":0.1},{
                "fastTransform":false,
                "delay":ROLL_OVER_ANIMATION_DELAY
            })];
            if(this.descriptionTF)
            {
                _loc2_.push(new Tween(FIRST_ANIMATION_DURATION / 2,this.descriptionTF,{"alpha":1},{
                    "fastTransform":false,
                    "delay":ROLL_OVER_ANIMATION_DELAY + FIRST_ANIMATION_DURATION / 2
                }));
            }
            if(this.equipmentType)
            {
                _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.equipmentType,{"alpha":0.1},{
                    "fastTransform":false,
                    "delay":ROLL_OVER_ANIMATION_DELAY
                }));
            }
            if(this.flags)
            {
                _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.flags,{"alpha":0.1},{
                    "fastTransform":false,
                    "delay":ROLL_OVER_ANIMATION_DELAY
                }));
            }
            if(this.inInventoryCountTF)
            {
                _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.inInventoryCountTF,{"alpha":0},{
                    "fastTransform":false,
                    "delay":ROLL_OVER_ANIMATION_DELAY
                }));
                _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.inInventoryIcon,{"alpha":0},{
                    "fastTransform":false,
                    "delay":ROLL_OVER_ANIMATION_DELAY
                }));
            }
            if(this.sellButton.visible)
            {
                _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.sellButton,{"alpha":1},{
                    "fastTransform":false,
                    "delay":ROLL_OVER_ANIMATION_DELAY + FIRST_ANIMATION_DURATION
                }));
            }
            return _loc2_;
        }

        protected function getRollOutTweens() : Vector.<Tween>
        {
            var _loc1_:int = this.getContainerYRolloutPosition();
            var _loc2_:Vector.<Tween> = new <Tween>[new Tween(FIRST_ANIMATION_DURATION,this._container,{"y":_loc1_},{"fastTransform":false}),new Tween(FIRST_ANIMATION_DURATION,this._overlay,{"alpha":0},{"fastTransform":false}),new Tween(FIRST_ANIMATION_DURATION,this.image,{"alpha":1},{"fastTransform":false})];
            if(this.descriptionTF)
            {
                _loc2_.unshift(new Tween(FIRST_ANIMATION_DURATION / 2,this.descriptionTF,{"alpha":0},{"fastTransform":false}));
            }
            if(this.sellButton.visible)
            {
                _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.sellButton,{"alpha":0},{"fastTransform":false}));
            }
            if(this.equipmentType)
            {
                _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.equipmentType,{"alpha":1},{"fastTransform":false}));
            }
            if(this.inInventoryCountTF)
            {
                _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.inInventoryCountTF,{"alpha":1},{"fastTransform":false}),new Tween(FIRST_ANIMATION_DURATION,this.inInventoryIcon,{"alpha":1},{"fastTransform":false}));
            }
            if(this.flags)
            {
                _loc2_.push(new Tween(FIRST_ANIMATION_DURATION,this.flags,{"alpha":FLAG_HOVER_ALPHA},{"fastTransform":false}));
            }
            return _loc2_;
        }

        protected function getContainerYRolloutPosition() : int
        {
            var _loc1_:* = 0;
            if(this.price && this.price.visible)
            {
                _loc1_ = this.price.y - this.titleTF.height >> 0;
            }
            else if(this.cannotSellTF && this.cannotSellTF.visible)
            {
                _loc1_ = this.cannotSellTF.y - this.titleTF.height >> 0;
            }
            else
            {
                _loc1_ = this._sizeVO.innerPadding.bottom - this.titleTF.height >> 0;
            }
            return _loc1_;
        }

        protected function onRollOver() : void
        {
            this._isOver = true;
            this.disposeTweens();
            this._tweens = this.getRollOverTweens();
            App.utils.scheduler.scheduleTask(dispatchEvent,ROLL_OVER_ANIMATION_DELAY,new CardEvent(CardEvent.PLAY_INFO_SOUND));
        }

        protected function onRollOut() : void
        {
            this._isOver = false;
            this.disposeTweens();
            this._tweens = this.getRollOutTweens();
            App.utils.scheduler.cancelTask(dispatchEvent);
        }

        protected function animateImage() : void
        {
            if(!this._isOver && this.image.alpha != 1)
            {
                this._tweens.push(new Tween(FIRST_ANIMATION_DURATION,this.image,{"alpha":1},{"fastTransform":false}));
            }
        }

        protected function onImageComplete() : void
        {
            if(this.image.width)
            {
                this.image.width = this._sizeVO.imageSize.width;
                this.image.height = this._sizeVO.imageSize.height;
                this.image.x = width - this.image.width >> 1;
                this.animateImage();
                if(this.equipmentType)
                {
                    this.equipmentType.x = this.image.x + (this.image.width >> 1) >> 0;
                    this.equipmentType.y = this.image.y + (this.image.height >> 1) >> 0;
                }
            }
        }

        protected function disposeTweens() : void
        {
            var _loc1_:Tween = null;
            for each(_loc1_ in this._tweens)
            {
                _loc1_.paused = true;
                _loc1_.dispose();
            }
            this._tweens.length = 0;
        }

        private function renderEquipmentType() : void
        {
            if(this.equipmentType && this._data)
            {
                if(this._data.type == SLOT_HIGHLIGHT_TYPES.NO_HIGHLIGHT)
                {
                    this.equipmentType.visible = false;
                }
                else
                {
                    this.equipmentType.visible = true;
                    this.equipmentType.gotoAndStop(this._data.type + FRAME_LABEL_CONNECTOR + this._stageWidthBoundary);
                    if(this._resetViewOnDataChange)
                    {
                        this.equipmentType.alpha = 1;
                    }
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
            return null;
        }

        public function set owner(param1:UIComponent) : void
        {
        }

        public function get selected() : Boolean
        {
            return false;
        }

        public function set selected(param1:Boolean) : void
        {
        }

        public function get data() : Object
        {
            return this._data;
        }

        public function set data(param1:Object) : void
        {
            var _loc2_:BaseCardVO = param1 as BaseCardVO;
            if(this._data && this._data.isEqual(_loc2_))
            {
                return;
            }
            this.setData(_loc2_);
            invalidateData();
        }

        protected function setData(param1:BaseCardVO) : void
        {
            this._data = param1;
        }

        public function set tooltipDecorator(param1:ITooltipMgr) : void
        {
        }

        public function set isViewPortEnabled(param1:Boolean) : void
        {
        }

        protected function onClick(param1:MouseEvent) : void
        {
            if(this._data == null)
            {
                return;
            }
            var _loc2_:ICommons = App.utils.commons;
            if(_loc2_.isRightButton(param1))
            {
                if(this._data.contextMenuId)
                {
                    dispatchEvent(new CardEvent(CardEvent.SHOW_CONTEXT_MENU,this._data));
                }
            }
            else if(this._data.enabled)
            {
                dispatchEvent(new CardEvent(CardEvent.SELL,this._data));
            }
        }

        private function onFlagsChangeHandler(param1:Event) : void
        {
            this.flags.width = FLAG_SIZE.width;
            this.flags.height = FLAG_SIZE.height;
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            this.onRollOver();
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this.onRollOut();
        }

        private function onImageChangeHandler(param1:Event) : void
        {
            this.onImageComplete();
        }

        private function onClickHandler(param1:MouseEvent) : void
        {
            this.onClick(param1);
        }

        private function onDiscountIconMouseOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:CompoundPriceVO = this._data.price.price;
            var _loc3_:CompoundPriceVO = this._data.price.defPrice;
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_PRICE,null,TOOLTIP_ACTION_PRICE_FIELD_NAME_ITEM,this._data.id,[_loc2_.getPriceValueByName(CURRENCIES_CONSTANTS.CREDITS),_loc2_.getPriceValueByName(CURRENCIES_CONSTANTS.GOLD),_loc2_.getPriceValueByName(CURRENCIES_CONSTANTS.CRYSTAL)],[_loc3_.getPriceValueByName(CURRENCIES_CONSTANTS.CREDITS),_loc3_.getPriceValueByName(CURRENCIES_CONSTANTS.GOLD),_loc3_.getPriceValueByName(CURRENCIES_CONSTANTS.CRYSTAL)],false,true,-1);
        }

        private function onDiscountIconMouseOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
    }
}
