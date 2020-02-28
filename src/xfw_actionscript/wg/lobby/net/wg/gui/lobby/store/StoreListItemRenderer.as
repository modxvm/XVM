package net.wg.gui.lobby.store
{
    import flash.filters.DropShadowFilter;
    import net.wg.gui.components.controls.Money;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import net.wg.gui.lobby.store.shop.ShopIconText;
    import net.wg.gui.interfaces.IButtonIconLoader;
    import net.wg.gui.components.controls.Image;
    import net.wg.utils.IScheduler;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.display.Stage;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ComponentEvent;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.VO.StoreTableData;
    import flash.text.TextFormat;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.generated.TEXT_ALIGN;
    import net.wg.gui.lobby.store.data.StoreTooltipMapVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.data.constants.Errors;
    import net.wg.data.constants.generated.FITTING_TYPES;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import net.wg.data.constants.Currencies;
    import net.wg.data.constants.ComponentState;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import net.wg.gui.data.VehCompareEntrypointVO;
    import net.wg.data.constants.Values;

    public class StoreListItemRenderer extends ComplexListItemRenderer
    {

        private static const OVER_STATE:String = "over";

        private static const OUT_STATE:String = "out";

        private static const DOTS:String = "...";

        private static const ADD_TO_COMPARE_BTN_ORIGINAL_X:int = 530;

        private static const ADD_TO_COMPARE_BTN_ORIGINAL_WIDTH:int = 160;

        private static const EXPECT_NEW_LINE_LETTERS_SHIFT:int = 1;

        private static const DEFAULT_LETTERS_SHIFT:int = 3;

        private static const NEW_LINE_SYMBOL:String = "\n";

        private static const TXT_INFO_CRIT_FILTER:DropShadowFilter = new DropShadowFilter(0,90,9831174,1,12,12,1.8,2);

        private static const TXT_INFO_WARN_FILTER:DropShadowFilter = new DropShadowFilter(0,90,0,1,12,12,1.8,2);

        private static const INFO_IMAGE_OFFSET:int = 32;

        private static const ERROR_TEXT_OFFSET:int = 3;

        public var credits:Money = null;

        public var actionPrice:TextField = null;

        public var discountBg:MovieClip = null;

        public var errorField:TextField = null;

        public var hitMc:Sprite;

        public var rent:ShopIconText = null;

        public var addToCompareBtn:IButtonIconLoader = null;

        public var infoImg:Image = null;

        protected var _scheduler:IScheduler;

        private var _compareModeOn:Boolean = false;

        private var _tooltipMgr:ITooltipMgr = null;

        private var _stage:Stage = null;

        private var _tooltipIsVisible:Boolean = false;

        public function StoreListItemRenderer()
        {
            super();
            this._scheduler = App.utils.scheduler;
            this._tooltipMgr = App.toolTipMgr;
            this._stage = App.stage;
        }

        override protected function onDispose() : void
        {
            this.hideTooltip();
            this._scheduler = null;
            removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
            removeEventListener(ComponentEvent.STATE_CHANGE,this.onStateChangeHandler);
            this.discountBg.removeEventListener(MouseEvent.MOUSE_OVER,this.onActionPriceMouseOverHandler);
            this.discountBg = null;
            this.credits.dispose();
            this.credits = null;
            this.errorField = null;
            this.hitMc = null;
            if(this.rent != null)
            {
                this.rent.dispose();
                this.rent = null;
            }
            if(this.addToCompareBtn != null)
            {
                this.addToCompareBtn.dispose();
                this.addToCompareBtn = null;
            }
            if(this.infoImg != null)
            {
                this.infoImg.dispose();
                this.infoImg = null;
            }
            this.actionPrice = null;
            hitArea = null;
            this._tooltipMgr = null;
            this._stage = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            constraints.addElement(textField.name,textField,Constraints.ALL);
            constraints.addElement(descField.name,descField,Constraints.ALL);
            constraints.addElement(this.credits.name,this.credits,Constraints.LEFT);
            constraints.addElement(this.actionPrice.name,this.actionPrice,Constraints.LEFT);
            constraints.addElement(this.discountBg.name,this.discountBg,Constraints.LEFT);
            if(this.rent)
            {
                constraints.addElement(this.rent.name,this.rent,Constraints.LEFT);
            }
            this.actionPrice.mouseEnabled = false;
            this.discountBg.addEventListener(MouseEvent.MOUSE_OVER,this.onActionPriceMouseOverHandler);
            addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
            addEventListener(ComponentEvent.STATE_CHANGE,this.onStateChangeHandler);
            hitArea = this.hitMc;
            if(this.addToCompareBtn)
            {
                this.addToCompareBtn.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_VEHICLECOMPAREBTN;
                this.addToCompareBtn.focusable = false;
                this.addToCompareBtn.mouseEnabledOnDisabled = true;
                this.addToCompareBtn.visible = false;
                this.addToCompareBtn.validateNow();
            }
        }

        override protected function draw() : void
        {
            if(isInvalid(InvalidationType.SIZE))
            {
                if(this.addToCompareBtn)
                {
                    this.addToCompareBtn.x = ADD_TO_COMPARE_BTN_ORIGINAL_X / scaleX;
                    this.addToCompareBtn.scaleX = 1 / scaleX;
                    this.addToCompareBtn.width = ADD_TO_COMPARE_BTN_ORIGINAL_WIDTH;
                }
            }
            if(isInvalid(InvalidationType.DATA))
            {
                this.update();
            }
            super.draw();
            if(this.actionPrice)
            {
                mouseChildren = true;
            }
        }

        protected function update() : void
        {
            var _loc1_:StoreTableData = null;
            var _loc2_:String = null;
            var _loc3_:* = 0;
            if(data)
            {
                if(App.instance)
                {
                    App.utils.asserter.assert(data is StoreTableData,"data in shopTableItemRenderer must extends StoreTableData class!");
                }
                _loc1_ = StoreTableData(data);
                visible = true;
                this.onPricesCalculated(_loc1_);
                textField.htmlText = _loc1_.name;
                descField.text = _loc1_.desc;
                if(descField.getLineLength(2) != -1)
                {
                    _loc2_ = _loc1_.desc.substr(descField.getLineLength(0) + descField.getLineLength(1) - 1,1);
                    _loc3_ = _loc2_ == NEW_LINE_SYMBOL?EXPECT_NEW_LINE_LETTERS_SHIFT:DEFAULT_LETTERS_SHIFT;
                    descField.text = descField.text.substr(0,descField.getLineLength(0) + descField.getLineLength(1) - _loc3_) + DOTS;
                }
                this.updateTexts(_loc1_);
                if(enabled && this._tooltipIsVisible)
                {
                    setState(OVER_STATE);
                    this.onShowTooltipTask();
                }
                else
                {
                    this.hideTooltip();
                }
                this.updateRent(_loc1_);
                this.updateAddToCompare(_loc1_);
            }
            else
            {
                visible = false;
            }
        }

        protected function onPricesCalculated(param1:StoreTableData) : void
        {
        }

        protected function getVehicleIconWidth() : int
        {
            return 0;
        }

        protected function updateTexts(param1:StoreTableData) : void
        {
        }

        protected function updateErrorText(param1:StoreTableData) : void
        {
            var _loc2_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:TextFormat = null;
            if(this.errorField != null && this.infoImg != null)
            {
                this.infoImg.visible = StringUtils.isNotEmpty(param1.statusImgSrc);
                _loc2_ = this.infoImg.visible?INFO_IMAGE_OFFSET:0;
                _loc3_ = this.getVehicleIconWidth();
                this.errorField.width = _loc3_ - _loc2_ ^ 0;
                this.errorField.htmlText = param1.statusMessage;
                App.utils.commons.updateTextFieldSize(this.errorField,true,true);
                this.errorField.x = (_loc3_ - this.errorField.width + _loc2_ >> 1) - ERROR_TEXT_OFFSET;
                this.errorField.y = height - this.errorField.height >> 1;
                this.errorField.filters = param1.isCritLvl?[TXT_INFO_CRIT_FILTER]:[TXT_INFO_WARN_FILTER];
                if(this.infoImg.visible)
                {
                    this.infoImg.source = param1.statusImgSrc;
                    this.infoImg.x = this.errorField.x - _loc2_;
                    this.infoImg.y = this.errorField.y - ERROR_TEXT_OFFSET;
                }
                _loc4_ = this.errorField.getTextFormat();
                _loc4_.align = this.infoImg.visible?TEXT_ALIGN.LEFT:TEXT_ALIGN.CENTER;
                this.errorField.setTextFormat(_loc4_);
            }
        }

        protected function getTooltipMapping() : StoreTooltipMapVO
        {
            throw new AbstractException(Errors.ABSTRACT_INVOKE);
        }

        protected final function infoItem() : void
        {
            dispatchEvent(new StoreEvent(StoreEvent.INFO,StoreTableData(data).id));
        }

        protected final function getHelper() : StoreHelper
        {
            return StoreHelper.getInstance();
        }

        protected function onLeftButtonClick(param1:Object) : void
        {
        }

        protected function onRightButtonClick() : void
        {
            var _loc1_:StoreTableData = StoreTableData(data);
            if(_loc1_ && _loc1_.itemTypeName != FITTING_TYPES.BOOSTER)
            {
                this.infoItem();
            }
        }

        protected function showTooltip() : void
        {
            var _loc1_:StoreTableData = null;
            var _loc2_:String = null;
            var _loc3_:* = 0;
            _loc1_ = StoreTableData(data);
            if(this.addToCompareBtn != null && this.addToCompareBtn.visible && this.addToCompareBtn.hitTestPoint(this._stage.mouseX,this._stage.mouseY,true))
            {
                this._tooltipMgr.showComplex(this.addToCompareBtn.tooltip);
            }
            else if(this.discountBg.visible && this.discountBg.hitTestPoint(this._stage.mouseX,this._stage.mouseY,true))
            {
                this.showActionPriceTooltip();
            }
            else if(App.instance)
            {
                switch(_loc1_.itemTypeName)
                {
                    case FITTING_TYPES.VEHICLE:
                        this._tooltipMgr.showSpecial(this.getTooltipMapping().vehId,null,_loc1_.id);
                        break;
                    case FITTING_TYPES.SHELL:
                        this._tooltipMgr.showSpecial(this.getTooltipMapping().shellId,null,_loc1_.id,_loc1_.inventoryCount);
                        break;
                    default:
                        _loc2_ = _loc1_.itemTypeName == FITTING_TYPES.BOOSTER?this.getTooltipMapping().battleBoosterId:this.getTooltipMapping().defaultId;
                        if(_loc2_ == TOOLTIPS_CONSTANTS.INVENTORY_MODULE)
                        {
                            _loc3_ = Currencies.INDEX_FROM_NAME[_loc1_.currency];
                            this._tooltipMgr.showSpecial(_loc2_,null,_loc1_.id,_loc1_.price[_loc3_],_loc1_.currency,_loc1_.inventoryCount,_loc1_.vehicleCount);
                        }
                        else
                        {
                            this._tooltipMgr.showSpecial(_loc2_,null,_loc1_.id);
                        }
                }
            }
        }

        protected function changedState() : void
        {
            this.discountBg.buttonMode = state != ComponentState.DISABLED;
        }

        protected function showActionPriceTooltip() : void
        {
            var _loc1_:ActionPriceVO = StoreTableData(data).actionPriceDataVo;
            if(_loc1_)
            {
                this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_PRICE,null,_loc1_.type,_loc1_.key,_loc1_.newPrices,_loc1_.oldPrices,_loc1_.isBuying,_loc1_.forCredits,_loc1_.rentPackage);
            }
        }

        protected function hideTooltip() : void
        {
            this._scheduler.cancelTask(this.onShowTooltipTask);
            this._scheduler.cancelTask(this.showTooltip);
            this._tooltipMgr.hide();
            this._tooltipIsVisible = false;
        }

        private function updateAddToCompare(param1:StoreTableData) : void
        {
            var _loc2_:VehCompareEntrypointVO = null;
            var _loc3_:* = false;
            if(this.addToCompareBtn)
            {
                _loc2_ = param1.vehCompareVO;
                _loc3_ = _loc2_.modeAvailable;
                this._compareModeOn = _loc3_;
                this.addToCompareBtn.visible = this._compareModeOn;
                if(this._compareModeOn)
                {
                    this.addToCompareBtn.enabled = _loc2_.btnEnabled;
                    this.addToCompareBtn.tooltip = _loc2_.btnTooltip;
                }
            }
        }

        private function updateRent(param1:StoreTableData) : void
        {
            if(this.rent)
            {
                if(!param1.rentLeft || param1.rentLeft == Values.EMPTY_STR)
                {
                    this.rent.visible = false;
                }
                else
                {
                    this.rent.updateText(param1.rentLeft);
                    this.rent.y = descField.y + descField.textHeight ^ 0;
                    this.rent.visible = true;
                }
            }
        }

        private function onShowTooltipTask() : void
        {
            this._scheduler.cancelTask(this.showTooltip);
            this._scheduler.scheduleTask(this.showTooltip,100);
            this._tooltipIsVisible = true;
        }

        override public function set selected(param1:Boolean) : void
        {
            if(this.addToCompareBtn == null || !this.addToCompareBtn.hitTestPoint(this._stage.mouseX,this._stage.mouseY,true))
            {
                super.selected = param1;
            }
        }

        protected function get compareModeOn() : Boolean
        {
            return this._compareModeOn;
        }

        override protected function handleMouseRollOut(param1:MouseEvent) : void
        {
            this.hideTooltip();
            if(enabled)
            {
                if(!_focused && !_displayFocus || focusIndicator != null)
                {
                    setState(OUT_STATE);
                }
                callLogEvent(param1);
            }
        }

        override protected function handleMouseRelease(param1:MouseEvent) : void
        {
            if(param1.target != this.addToCompareBtn)
            {
                super.handleMouseRelease(param1);
            }
        }

        override protected function handleMousePress(param1:MouseEvent) : void
        {
            if(param1.target != this.addToCompareBtn)
            {
                this.hideTooltip();
                super.handleMousePress(param1);
            }
        }

        override protected function handleMouseRollOver(param1:MouseEvent) : void
        {
            super.handleMouseRollOver(param1);
            this._scheduler.cancelTask(this.onShowTooltipTask);
            this._scheduler.scheduleTask(this.onShowTooltipTask,100);
        }

        private function onActionPriceMouseOverHandler(param1:MouseEvent) : void
        {
            this.showActionPriceTooltip();
        }

        private function onMouseDownHandler(param1:MouseEvent) : void
        {
            var _loc2_:Boolean = App.utils.commons.isRightButton(param1);
            if(param1.target == this.addToCompareBtn && this.addToCompareBtn.enabled)
            {
                if(!_loc2_)
                {
                    dispatchEvent(new StoreEvent(StoreEvent.ADD_TO_COMPARE,StoreTableData(data).id));
                }
            }
            else if(_loc2_)
            {
                this.onRightButtonClick();
            }
            else
            {
                this.onLeftButtonClick(param1.target);
            }
        }

        private function onStateChangeHandler(param1:ComponentEvent) : void
        {
            this.changedState();
        }
    }
}
