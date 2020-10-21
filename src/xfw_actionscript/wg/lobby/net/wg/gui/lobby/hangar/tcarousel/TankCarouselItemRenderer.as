package net.wg.gui.lobby.hangar.tcarousel
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
    import flash.display.Sprite;
    import net.wg.gui.components.carousels.data.VehicleCarouselVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.data.constants.SoundTypes;
    import net.wg.data.constants.SoundManagerStatesLobby;
    import flash.geom.Point;
    import net.wg.data.constants.Values;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import scaleform.gfx.MouseEventEx;
    import net.wg.gui.components.carousels.events.TankItemEvent;
    import net.wg.gui.components.controls.scroller.ListRendererEvent;
    import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import org.idmedia.as3commons.util.StringUtils;

    public class TankCarouselItemRenderer extends SoundButtonEx implements IScrollerItemRenderer
    {

        private static const RANKED_BONUS_NAME:String = "rankedBonus";

        private static const PROGRESSION_POINTS:String = "progressionPoints";

        private static const CAROUSEL_RANKED_BONUS_LINKAGE:String = "CarouselRankedBonusUI";

        private static const LINKAGE_CAROUSEL_PROGRESSION_POINTS:String = "CarouselProgressionPointsUI";

        private static const PROGRESSION_POINTS_OFFSET:int = -8;

        public var content:BaseTankIcon = null;

        public var border:Sprite = null;

        public var crystalsBorder:Sprite = null;

        public var selectedMc:Sprite = null;

        private var _index:uint = 0;

        private var _dataVO:VehicleCarouselVO = null;

        private var _toolTipMgr:ITooltipMgr = null;

        private var _isClickEnabled:Boolean = false;

        private var _isSpecialSlot:Boolean = false;

        private var _isViewPortEnabled:Boolean = true;

        private var _isInteractive:Boolean = false;

        private var _rankedBonus:Sprite = null;

        private var _progressionPoints:CarouselProgressionPoints = null;

        public function TankCarouselItemRenderer()
        {
            super();
            preventAutosizing = true;
            constraintsDisabled = true;
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseChildren = true;
            mouseEnabled = false;
            this.border.mouseEnabled = false;
            this.border.mouseChildren = false;
            this.crystalsBorder.mouseEnabled = false;
            this.crystalsBorder.mouseChildren = false;
            this.selectedMc.mouseEnabled = false;
            this.selectedMc.mouseChildren = false;
            this.content.cacheAsBitmap = true;
            this.content.buttonMode = true;
            this.content.mouseChildren = false;
            soundType = SoundTypes.CAROUSEL_BTN;
            soundId = SoundManagerStatesLobby.CAROUSEL_CELL_BTN;
            this.addListeners();
        }

        override protected function onDispose() : void
        {
            this.removeListeners();
            this.content.dispose();
            this.content = null;
            this._dataVO = null;
            _owner = null;
            this._toolTipMgr = null;
            this.border = null;
            this.crystalsBorder = null;
            this.selectedMc = null;
            this.clearRankedBonus();
            this.clearProgressionPoints();
            super.onDispose();
        }

        public function measureSize(param1:Point = null) : Point
        {
            return null;
        }

        protected function updateData() : void
        {
            var _loc1_:* = false;
            _loc1_ = this._dataVO != null;
            if(_loc1_)
            {
                alpha = this._dataVO.alpha;
                isUseRightBtn = this._dataVO.isUseRightBtn;
                this._isClickEnabled = this._dataVO.clickEnabled;
                this._isSpecialSlot = this._dataVO.buySlot || this._dataVO.buyTank || this._dataVO.isRentPromotion;
                this.crystalsBorder.visible = this._dataVO.isEarnCrystals && !this._dataVO.isCrystalsLimitReached;
                this.border.visible = !this.crystalsBorder.visible;
                mouseEnabledOnDisabled = true;
            }
            else
            {
                alpha = Values.DEFAULT_ALPHA;
                isUseRightBtn = false;
                this._isClickEnabled = false;
                this._isSpecialSlot = false;
                this.crystalsBorder.visible = false;
                mouseEnabledOnDisabled = false;
            }
            this.updateRankedBonus(_loc1_?this._dataVO.hasRankedBonus:false);
            this.updateProgressionPoints(_loc1_?this._dataVO.hasProgression:false);
            this.updateInteractiveState();
            this.content.setData(this._dataVO);
        }

        private function clearProgressionPoints() : void
        {
            if(this._progressionPoints)
            {
                this._progressionPoints.dispose();
                removeChild(this._progressionPoints);
                this._progressionPoints = null;
            }
        }

        private function updateProgressionPoints(param1:Boolean) : void
        {
            if(param1)
            {
                if(!this._progressionPoints)
                {
                    this._progressionPoints = App.utils.classFactory.getComponent(LINKAGE_CAROUSEL_PROGRESSION_POINTS,CarouselProgressionPoints);
                    this._progressionPoints.setData(this._dataVO.progressionPoints,this._dataVO.intCD);
                    this._progressionPoints.name = PROGRESSION_POINTS;
                    this._progressionPoints.x = width - this._progressionPoints.width >> 1;
                    this._progressionPoints.y = PROGRESSION_POINTS_OFFSET;
                    addChild(this._progressionPoints);
                }
                this._progressionPoints.visible = true;
                this.border.visible = !this._dataVO.progressionPoints.isSpecialVehicle && !this.crystalsBorder.visible;
            }
            else
            {
                this.clearProgressionPoints();
                this.border.visible = !this.crystalsBorder.visible;
            }
        }

        private function clearRankedBonus() : void
        {
            if(this._rankedBonus)
            {
                removeChild(this._rankedBonus);
                this._rankedBonus = null;
            }
        }

        private function updateRankedBonus(param1:Boolean) : void
        {
            if(param1)
            {
                if(!this._rankedBonus)
                {
                    this.addRankedBonus();
                }
                this._rankedBonus.visible = true;
            }
            else
            {
                this.clearRankedBonus();
            }
        }

        private function addRankedBonus() : void
        {
            this._rankedBonus = App.utils.classFactory.getComponent(CAROUSEL_RANKED_BONUS_LINKAGE,Sprite);
            this._rankedBonus.name = RANKED_BONUS_NAME;
            this._rankedBonus.x = width >> 1;
            addChild(this._rankedBonus);
        }

        private function addListeners() : void
        {
            this.content.addEventListener(MouseEvent.ROLL_OVER,this.onSlotMouseRollOverHandler);
            this.content.addEventListener(MouseEvent.ROLL_OUT,this.onSlotMouseRollOutHandler);
            addEventListener(MouseEvent.CLICK,this.onSlotMouseClickHandler);
        }

        private function removeListeners() : void
        {
            this.content.removeEventListener(MouseEvent.ROLL_OVER,this.onSlotMouseRollOverHandler);
            this.content.removeEventListener(MouseEvent.ROLL_OUT,this.onSlotMouseRollOutHandler);
            removeEventListener(MouseEvent.CLICK,this.onSlotMouseClickHandler);
        }

        private function updateInteractiveState() : void
        {
            this._isInteractive = this._isViewPortEnabled && this._isClickEnabled || this._isSpecialSlot;
            this.enabled = this._isInteractive;
            this.content.enabled = this._isInteractive;
        }

        override public function set enabled(param1:Boolean) : void
        {
            if(param1 != enabled)
            {
                super.enabled = param1;
                mouseChildren = param1;
                mouseEnabled = false;
            }
        }

        override public function get data() : Object
        {
            return this._dataVO;
        }

        override public function set data(param1:Object) : void
        {
            if(this._dataVO != null)
            {
                this._dataVO.removeEventListener(Event.CHANGE,this.onDataVOChangeHandler);
                this._dataVO = null;
            }
            if(param1 != null)
            {
                this._dataVO = VehicleCarouselVO(param1);
                this._dataVO.addEventListener(Event.CHANGE,this.onDataVOChangeHandler);
            }
            this.updateData();
        }

        public function get index() : uint
        {
            return this._index;
        }

        public function set index(param1:uint) : void
        {
            this._index = param1;
        }

        public function set tooltipDecorator(param1:ITooltipMgr) : void
        {
            this._toolTipMgr = param1;
        }

        public function set isViewPortEnabled(param1:Boolean) : void
        {
            if(this._isViewPortEnabled == param1)
            {
                return;
            }
            this._isViewPortEnabled = param1;
            this.updateInteractiveState();
        }

        protected function get dataVO() : VehicleCarouselVO
        {
            return this._dataVO;
        }

        private function onSlotMouseClickHandler(param1:Event) : void
        {
            var _loc2_:MouseEventEx = null;
            var _loc3_:uint = 0;
            var _loc4_:String = null;
            if(!this._isInteractive)
            {
                return;
            }
            if(this._dataVO != null)
            {
                _loc2_ = param1 as MouseEventEx;
                _loc3_ = _loc2_ == null?0:_loc2_.buttonIdx;
                if(!selected && _loc3_ == MouseEventEx.LEFT_BUTTON)
                {
                    if(this._dataVO.isRentPromotion)
                    {
                        dispatchEvent(new TankItemEvent(TankItemEvent.SELECT_RENT_PROMOTION_SLOT,this._dataVO.intCD));
                    }
                    else
                    {
                        if(this._dataVO.buySlot)
                        {
                            _loc4_ = TankItemEvent.SELECT_BUY_SLOT;
                        }
                        else if(this._dataVO.buyTank)
                        {
                            _loc4_ = TankItemEvent.SELECT_BUY_TANK;
                        }
                        else if(this._dataVO.restoreTank)
                        {
                            _loc4_ = TankItemEvent.SELECT_RESTORE_TANK;
                        }
                        else if(this._dataVO.clickEnabled)
                        {
                            _loc4_ = TankItemEvent.SELECT_ITEM;
                            dispatchEvent(new ListRendererEvent(ListRendererEvent.SELECT));
                        }
                        dispatchEvent(new TankItemEvent(_loc4_,this._index));
                    }
                }
                else if(_loc3_ == MouseEventEx.RIGHT_BUTTON && isUseRightBtn && !this._dataVO.buySlot && !this._dataVO.buyTank && !this._dataVO.restoreTank && !this._dataVO.isRentPromotion)
                {
                    App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.VEHICLE,this,{"inventoryId":this._dataVO.id});
                }
            }
            this._toolTipMgr.hide();
        }

        private function onSlotMouseRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
            this.content.handleRollOut(this._dataVO);
        }

        private function onSlotMouseRollOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:ActionPriceVO = null;
            var _loc3_:String = null;
            if(!this._isInteractive || !this._dataVO)
            {
                return;
            }
            if(this._dataVO.buyTank || this._dataVO.restoreTank)
            {
                this._toolTipMgr.showComplex(this._dataVO.tooltip);
            }
            else if(this._dataVO.buySlot)
            {
                _loc2_ = this._dataVO.getActionPriceVO();
                if(_loc2_)
                {
                    App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_SLOT_PRICE,null,_loc2_.newPrices,_loc2_.oldPrices);
                }
                else
                {
                    this._toolTipMgr.showComplex(this._dataVO.tooltip);
                }
            }
            else if(StringUtils.isNotEmpty(this._dataVO.lockedTooltip))
            {
                this._toolTipMgr.showComplex(this._dataVO.lockedTooltip);
            }
            else
            {
                _loc3_ = !this._dataVO.isEvent?this._dataVO.tooltip:TOOLTIPS_CONSTANTS.EVENT_CAROUSEL_VEHICLE;
                this._toolTipMgr.showSpecial(_loc3_,null,this._dataVO.intCD);
                this.content.handleRollOver(this._dataVO);
            }
        }

        private function onDataVOChangeHandler(param1:Event) : void
        {
            this.updateData();
        }
    }
}
