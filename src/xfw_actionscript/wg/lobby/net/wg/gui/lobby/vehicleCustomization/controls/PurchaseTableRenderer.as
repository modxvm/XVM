package net.wg.gui.lobby.vehicleCustomization.controls
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import net.wg.gui.lobby.vehicleCustomization.controls.slotsGroup.ICustomizationSlot;
    import flash.events.MouseEvent;
    import scaleform.gfx.MouseEventEx;
    import net.wg.gui.components.controls.Image;
    import flash.display.Sprite;
    import net.wg.gui.lobby.components.TextWrapper;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.price.CompoundPrice;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.PurchaseVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.vehicleCustomization.controls.slotsGroup.CustomizationSlotsLayout;
    import net.wg.gui.lobby.vehicleCustomization.CustomizationShared;
    import flash.geom.Rectangle;
    import net.wg.data.constants.Values;
    import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
    import net.wg.data.constants.SoundTypes;

    public class PurchaseTableRenderer extends SoundButtonEx implements IUpdatable, ICustomizationSlot
    {

        private static const CHECK_FRAME:int = 1;

        private static const UNCHECKED_FRAME:int = 2;

        private static const CHECK_FRAME_HOVER_DIFF:int = 2;

        private static const PRICE_OFFSET:int = 12;

        private static const COUNT_OFFSET_X:int = 3;

        private static const COUNT_OFFSET_Y:int = 0;

        private static const STORAGE_COUNT_OFFSET:int = 9;

        private static const PLACEHOLDER_ALPHA:Number = 0.15;

        private static const NORMAL_ALPHA:Number = 1;

        private static const HIDE_ALPHA:Number = 0.0;

        private static const SEPARATOR:String = "×";

        public var placeHolderIcon:Image = null;

        public var hoverMc:Sprite = null;

        public var count:TextWrapper = null;

        public var check:MovieClip = null;

        public var storageIcon:Sprite = null;

        public var price:CompoundPrice = null;

        public var itemRenderer:CarouselItemRenderer = null;

        private var _dataVO:PurchaseVO = null;

        private var _selectedCheck:Boolean = true;

        private var _isLock:Boolean = false;

        private var _isPlaceHolder:Boolean = false;

        private var _tooltipMgr:ITooltipMgr;

        private var _hitArea:Sprite = null;

        public function PurchaseTableRenderer()
        {
            this._tooltipMgr = App.toolTipMgr;
            super();
            constraintsDisabled = true;
            preventAutosizing = true;
            this.itemRenderer.mouseEnabled = this.itemRenderer.mouseChildren = false;
            this.itemRenderer.considerWidth = true;
            this.price.mouseEnabled = this.price.mouseChildren = false;
            this.check.mouseEnabled = this.check.mouseChildren = false;
            this.count.mouseEnabled = false;
            this.check.gotoAndStop(CHECK_FRAME);
            this._hitArea = new Sprite();
            addChild(this._hitArea);
            hitArea = this._hitArea;
            mouseEnabledOnDisabled = true;
            soundType = SoundTypes.CUSTOMIZATION_DEFAULT;
        }

        private static function isClickLeftMouse(param1:MouseEvent) : Boolean
        {
            var _loc2_:MouseEventEx = param1 as MouseEventEx;
            var _loc3_:uint = _loc2_ == null?0:_loc2_.buttonIdx;
            return _loc3_ == MouseEventEx.LEFT_BUTTON;
        }

        override protected function initialize() : void
        {
            super.initialize();
            this.itemRenderer.isResponsive = true;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.count.tf.setTextFormat(new TextFormat(null,null,null,null,null,null,null,null,TextFormatAlign.RIGHT));
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
            this.placeHolderIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_TANKITEM_BUY_TANK_POPOVER_SMALL;
            this.placeHolderIcon.addEventListener(Event.CHANGE,this.onImageChangeHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._dataVO && isInvalid(InvalidationType.SIZE))
            {
                this.updateLayout();
            }
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
            this.placeHolderIcon.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
            this.itemRenderer.dispose();
            this.itemRenderer = null;
            this.price.dispose();
            this.price = null;
            this.count.dispose();
            this.count = null;
            this.placeHolderIcon.dispose();
            this.placeHolderIcon = null;
            this.storageIcon = null;
            this.hoverMc = null;
            this.check = null;
            this._tooltipMgr = null;
            this._dataVO = null;
            this._hitArea = null;
            super.onDispose();
        }

        public function isWide() : Boolean
        {
            return this._dataVO.itemImg.isWide;
        }

        public function update(param1:Object) : void
        {
            this._dataVO = PurchaseVO(param1);
            this.storageIcon.visible = false;
            this.itemRenderer.data = this._dataVO.itemImg;
            this.itemRenderer.selected = false;
            this.price.visible = !this._dataVO.isLock;
            this.check.visible = !this._dataVO.isLock;
            this.count.visible = !this._dataVO.isLock;
            this._isLock = this._dataVO.isLock;
            this._isPlaceHolder = this._dataVO.itemImg.isPlaceHolder;
            this.placeHolderIcon.visible = this._isPlaceHolder;
            buttonMode = useHandCursor = !this._isLock;
            mouseEnabled = mouseChildren = !this._isLock;
            enabled = !this._isLock;
            alpha = this._isPlaceHolder?PLACEHOLDER_ALPHA:NORMAL_ALPHA;
            if(this._dataVO.compoundPrice)
            {
                this.price.setData(this._dataVO.compoundPrice);
                this.price.validateNow();
                if(this._dataVO.isFromStorage)
                {
                    this.storageIcon.visible = true;
                    this.price.visible = false;
                }
            }
            this.updateLayout();
            this.redrawHitArea();
        }

        private function updateLayout() : void
        {
            var _loc1_:* = false;
            if(App.appWidth <= CustomizationSlotsLayout.SMALL_SCREEN_WIDTH || App.appHeight < CustomizationSlotsLayout.SMALL_SCREEN_HEIGHT)
            {
                _loc1_ = true;
            }
            var _loc2_:Rectangle = CustomizationShared.computeItemSize(this._dataVO.itemImg.isWide,_loc1_);
            this.hoverMc.width = _loc2_.width;
            this.hoverMc.height = _loc2_.height;
            this.itemRenderer.width = _loc2_.width;
            this.itemRenderer.height = _loc2_.height;
            this.updateImageSize();
            if(this._dataVO.isFromStorage)
            {
                this.storageIcon.x = this.hoverMc.width - this.storageIcon.width;
                this.storageIcon.y = this.hoverMc.height - this.storageIcon.height;
                this.count.tf.text = this._dataVO.quantity.toString();
                this.count.x = this.storageIcon.x - this.count.width + STORAGE_COUNT_OFFSET;
            }
            else
            {
                if(this._dataVO.quantity > 1)
                {
                    this.count.tf.text = this._dataVO.quantity + SEPARATOR;
                }
                else
                {
                    this.count.tf.text = Values.EMPTY_STR;
                }
                this.count.x = this.price.x + this.price.hit.x - this.count.width + COUNT_OFFSET_X;
            }
            this.count.y = this.hoverMc.height - this.count.height + COUNT_OFFSET_Y | 0;
            this.check.x = this.hoverMc.width - this.check.width >> 1;
            this.price.x = this.hoverMc.width - this.price.width + PRICE_OFFSET;
            this.price.y = this.count.y;
        }

        private function redrawHitArea() : void
        {
            hitArea.graphics.clear();
            hitArea.graphics.beginFill(65280,0);
            hitArea.graphics.drawRect(this.hoverMc.x,this.hoverMc.y,this.hoverMc.width,this.hoverMc.height);
            hitArea.graphics.endFill();
            hitArea.graphics.beginFill(255,0);
            hitArea.graphics.drawRect(this.check.x,this.check.y,this.check.width,this.check.height);
            hitArea.graphics.endFill();
        }

        private function setCheckFrameAndAlpha(param1:Boolean) : void
        {
            var _loc2_:* = 0;
            _loc2_ = (this._selectedCheck?CHECK_FRAME:UNCHECKED_FRAME) + (param1?CHECK_FRAME_HOVER_DIFF:0);
            this.hoverMc.alpha = param1?NORMAL_ALPHA:HIDE_ALPHA;
            this.check.gotoAndStop(_loc2_);
        }

        private function onMouseOverHandler(param1:MouseEvent) : void
        {
            if(this._dataVO.itemImg.intCD)
            {
                this._tooltipMgr.showSpecial(this._dataVO.tooltip,null,this._dataVO.itemImg.intCD,!this._isLock);
                if(!(this._isLock || this._isPlaceHolder))
                {
                    this.setCheckFrameAndAlpha(true);
                }
            }
        }

        private function onMouseOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
            this.setCheckFrameAndAlpha(false);
        }

        private function onImageChangeHandler(param1:Event) : void
        {
            this.updateImageSize();
        }

        private function updateImageSize() : void
        {
            this.placeHolderIcon.width = this.itemRenderer.width;
            this.placeHolderIcon.height = this.itemRenderer.height;
        }

        private function onMouseClickHandler(param1:MouseEvent) : void
        {
            var _loc2_:String = null;
            if(this._isLock || !isClickLeftMouse(param1))
            {
                return;
            }
            this._selectedCheck = !this._selectedCheck;
            _loc2_ = this._selectedCheck?CustomizationItemEvent.SELECT_ITEM:CustomizationItemEvent.DESELECT_ITEM;
            dispatchEvent(new CustomizationItemEvent(_loc2_,this._dataVO.id,0,this._dataVO.isFromStorage));
            this.setCheckFrameAndAlpha(this.hoverMc.alpha == NORMAL_ALPHA);
            selected = !selected;
        }
    }
}
