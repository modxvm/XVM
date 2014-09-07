package net.wg.gui.lobby.fortifications.popovers.impl
{
    import net.wg.infrastructure.base.meta.impl.FortOrderPopoverMeta;
    import net.wg.infrastructure.base.meta.IFortOrderPopoverMeta;
    import flash.events.MouseEvent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import scaleform.clik.controls.StatusIndicator;
    import net.wg.gui.lobby.fortifications.popovers.orderPopover.OrderInfoBlock;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.fortifications.data.OrderPopoverVO;
    import net.wg.gui.components.controls.SoundButton;
    import flash.display.InteractiveObject;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.utilData.TwoDimensionalPadding;
    import flash.geom.Point;
    import net.wg.gui.components.popOvers.PopOverConst;
    import net.wg.infrastructure.interfaces.IWrapper;
    import net.wg.gui.components.popOvers.PopOver;
    import scaleform.clik.constants.InvalidationType;
    
    public class FortOrderPopover extends FortOrderPopoverMeta implements IFortOrderPopoverMeta
    {
        
        public function FortOrderPopover()
        {
            super();
            this.useOrderBtn.UIID = 96;
        }
        
        private static var AFTER_DESCR_PADDING:int = 15;
        
        private static var TEXT_PADDING:int = 5;
        
        private static var BUTTON_PADDING:int = 10;
        
        private static var PIXEL_PADDING:int = 1;
        
        private static var DISABLED_ALPHA:Number = 0.5;
        
        private static var INV_DISABLE_BTN:String = "invDisableBtn";
        
        private static var INV_FOCUS:String = "invFocus";
        
        private static function hideTooltip(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private static function showAlertTooltip(param1:MouseEvent) : void
        {
            if(App.globalVarsMgr.isFortificationBattleAvailableS())
            {
                App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_ORDERPOPOVER_USEORDERBTN_DEFENCEHOURDISABLED);
            }
            else
            {
                App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_ORDERPOPOVER_USEORDERBTN_NOTAVAILABLE);
            }
        }
        
        public var bigIcon:UILoaderAlt;
        
        public var titleTF:TextField;
        
        public var levelTF:TextField;
        
        public var timeLeftTF:TextField;
        
        public var descriptionTF:TextField;
        
        public var timerHover:MovieClip;
        
        public var alertIcon:MovieClip;
        
        public var durationProgress:StatusIndicator;
        
        public var infoBlock:OrderInfoBlock;
        
        public var useOrderBtn:SoundButtonEx;
        
        private var _data:OrderPopoverVO = null;
        
        public var bottomSeparator:MovieClip = null;
        
        private var _isOrderDisabled:Boolean = false;
        
        private var _cooldownPeriod:Number = 0;
        
        public var questLink:SoundButton;
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            if((this.useOrderBtn.visible) && (this.useOrderBtn.enabled))
            {
                setFocus(this.useOrderBtn);
            }
            else if(this.infoBlock.showCreateOrderBtn)
            {
                setFocus(this.infoBlock.createOrderBtn);
            }
            else
            {
                setFocus(this);
            }
            
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.useOrderBtn.visible = false;
            this.useOrderBtn.label = FORTIFICATIONS.ORDERS_ORDERPOPOVER_USEORDER;
            this.infoBlock.createOrderBtn.addEventListener(ButtonEvent.CLICK,this.createOrderClickHandler);
            this.useOrderBtn.addEventListener(ButtonEvent.CLICK,this.useOrderClickHandler);
            this.useOrderBtn.addEventListener(MouseEvent.MOUSE_OVER,this.showUseBtnTooltip);
            this.useOrderBtn.addEventListener(MouseEvent.MOUSE_OUT,hideTooltip);
            this.timerHover.addEventListener(MouseEvent.MOUSE_OVER,this.showDurationTooltip);
            this.timerHover.addEventListener(MouseEvent.MOUSE_OUT,hideTooltip);
            this.alertIcon.addEventListener(MouseEvent.MOUSE_OVER,showAlertTooltip);
            this.alertIcon.addEventListener(MouseEvent.MOUSE_OUT,hideTooltip);
            this.questLink.addEventListener(ButtonEvent.CLICK,this.openQuestWindow);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
        }
        
        override protected function getKeyPointPadding() : TwoDimensionalPadding
        {
            var _loc1_:TwoDimensionalPadding = super.getKeyPointPadding();
            _loc1_.top = new Point(-5,_loc1_.top.y);
            return _loc1_;
        }
        
        override protected function setInitData(param1:OrderPopoverVO) : void
        {
            this._data = param1;
            invalidateData();
        }
        
        public function as_disableOrder(param1:Boolean) : void
        {
            this._isOrderDisabled = param1;
            invalidate(INV_DISABLE_BTN);
        }
        
        override protected function initLayout() : void
        {
            popoverLayout.preferredLayout = PopOverConst.ARROW_BOTTOM;
            super.initLayout();
        }
        
        private function startCooldownAnimation() : void
        {
            App.utils.scheduler.cancelTask(this.updateCooldonwAnimation);
            var _loc1_:Number = this._data.leftTime / this._data.effectTime;
            var _loc2_:int = Math.round(_loc1_ * this.durationProgress.totalFrames);
            this._cooldownPeriod = this._data.leftTime / _loc2_ * 1000;
            App.utils.scheduler.scheduleTask(this.updateCooldonwAnimation,this._cooldownPeriod);
        }
        
        private function updateCooldonwAnimation() : void
        {
            var _loc1_:Number = getLeftTimeS();
            this.timeLeftTF.htmlText = getLeftTimeStrS();
            if(_loc1_ > 0)
            {
                this.durationProgress.value = getLeftTimeS();
                App.utils.scheduler.scheduleTask(this.updateCooldonwAnimation,this._cooldownPeriod);
            }
            else
            {
                this.clearCooldown();
            }
        }
        
        override public function set wrapper(param1:IWrapper) : void
        {
            super.wrapper = param1;
            PopOver(param1).isCloseBtnVisible = true;
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            if((isInvalid(InvalidationType.DATA)) && (this._data))
            {
                this.titleTF.htmlText = this._data.title;
                this.levelTF.htmlText = this._data.levelStr;
                this.alertIcon.visible = this._data.showAlertIcon;
                this.descriptionTF.htmlText = this._data.description;
                this.timeLeftTF.htmlText = this._data.leftTimeStr;
                if((this._data.inCooldown) && !this._data.isPermanent)
                {
                    this.durationProgress.visible = true;
                    this.durationProgress.maximum = this._data.effectTime;
                    this.durationProgress.value = this._data.leftTime;
                    this.startCooldownAnimation();
                }
                else
                {
                    this.clearCooldown();
                }
                this.useOrderBtn.visible = this._data.canUseOrder;
                this.questLink.visible = this._data.showLinkBtn;
                this.infoBlock.duration = this._data.effectTimeStr;
                this.infoBlock.productionTime = this._data.productionTime;
                this.infoBlock.building = this._data.buildingStr;
                this.infoBlock.price = this._data.productionCost;
                this.infoBlock.producedAmount = this._data.producedAmount;
                this.infoBlock.showCreateOrderBtn = this._data.canCreateOrder;
                this.bigIcon.source = this._data.icon;
                this.bigIcon.alpha = this._data.hasBuilding?1:DISABLED_ALPHA;
                this.infoBlock.validateNow();
                invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.titleTF.height = Math.round(this.titleTF.textHeight + TEXT_PADDING);
                App.utils.commons.moveDsiplObjToEndOfText(this.alertIcon,this.titleTF,0,PIXEL_PADDING);
                this.levelTF.y = Math.round(this.titleTF.y + this.titleTF.height);
                this.descriptionTF.height = Math.round(this.descriptionTF.textHeight + TEXT_PADDING);
                this.infoBlock.y = Math.round(this.descriptionTF.y + this.descriptionTF.textHeight + AFTER_DESCR_PADDING);
                _loc1_ = Math.round(this.infoBlock.y + this.infoBlock.height + AFTER_DESCR_PADDING + TEXT_PADDING);
                this.bottomSeparator.y = this.infoBlock.y + this.infoBlock.height + TEXT_PADDING + this.bottomSeparator.height;
                this.useOrderBtn.y = this.bottomSeparator.y - this.bottomSeparator.height + BUTTON_PADDING;
                _loc2_ = Math.round(this.useOrderBtn.y + this.useOrderBtn.height + BUTTON_PADDING);
                App.utils.commons.moveDsiplObjToEndOfText(this.questLink,this.descriptionTF,TEXT_PADDING,PIXEL_PADDING);
                if(this._data.canUseOrder)
                {
                    setSize(this.width,_loc2_);
                    this.bottomSeparator.visible = true;
                }
                else
                {
                    setSize(this.width,_loc1_);
                    this.bottomSeparator.visible = false;
                }
            }
            if(isInvalid(INV_DISABLE_BTN))
            {
                this.useOrderBtn.enabled = !this._isOrderDisabled;
                this.useOrderBtn.mouseChildren = true;
                this.useOrderBtn.mouseEnabled = true;
                invalidate(INV_FOCUS);
            }
            super.draw();
        }
        
        private function clearCooldown() : void
        {
            App.utils.scheduler.cancelTask(this.updateCooldonwAnimation);
            this.durationProgress.visible = false;
            this._cooldownPeriod = 0;
        }
        
        override protected function onDispose() : void
        {
            App.utils.scheduler.cancelTask(this.updateCooldonwAnimation);
            if(this.questLink)
            {
                this.questLink.removeEventListener(ButtonEvent.CLICK,this.openQuestWindow);
                this.questLink.dispose();
                this.questLink = null;
            }
            this.bigIcon.dispose();
            this.bigIcon = null;
            this.titleTF = null;
            this.levelTF = null;
            this.timeLeftTF = null;
            this.descriptionTF = null;
            if(this.alertIcon)
            {
                this.alertIcon.removeEventListener(MouseEvent.MOUSE_OVER,showAlertTooltip);
                this.alertIcon.removeEventListener(MouseEvent.MOUSE_OUT,hideTooltip);
                this.alertIcon = null;
            }
            if(this.timerHover)
            {
                this.timerHover.removeEventListener(MouseEvent.MOUSE_OVER,this.showDurationTooltip);
                this.timerHover.removeEventListener(MouseEvent.MOUSE_OUT,hideTooltip);
                this.timerHover = null;
            }
            if(this.durationProgress)
            {
                this.durationProgress.dispose();
                this.durationProgress = null;
            }
            if(this.infoBlock)
            {
                this.infoBlock.createOrderBtn.removeEventListener(ButtonEvent.CLICK,this.createOrderClickHandler);
                this.infoBlock.dispose();
                this.infoBlock = null;
            }
            if(this.useOrderBtn)
            {
                this.useOrderBtn.removeEventListener(ButtonEvent.CLICK,this.useOrderClickHandler);
                this.useOrderBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.showUseBtnTooltip);
                this.useOrderBtn.removeEventListener(MouseEvent.MOUSE_OUT,hideTooltip);
                this.useOrderBtn.dispose();
                this.useOrderBtn = null;
            }
            if(this._data)
            {
                this._data.dispose();
                this._data = null;
            }
            super.onDispose();
        }
        
        private function createOrderClickHandler(param1:ButtonEvent) : void
        {
            requestForCreateOrderS();
        }
        
        private function useOrderClickHandler(param1:ButtonEvent) : void
        {
            App.eventLogManager.logUIEvent(param1,0);
            requestForUseOrderS();
        }
        
        private function showDurationTooltip(param1:MouseEvent) : void
        {
            var _loc2_:String = getLeftTimeTooltipS();
            if(_loc2_)
            {
                App.toolTipMgr.show(_loc2_);
            }
        }
        
        private function showUseBtnTooltip(param1:MouseEvent) : void
        {
            var _loc2_:String = null;
            if(this._data)
            {
                _loc2_ = this._data.useBtnTooltip;
                if(_loc2_.length > 0)
                {
                    App.toolTipMgr.showComplex(_loc2_);
                }
            }
        }
        
        private function openQuestWindow(param1:ButtonEvent) : void
        {
            if(this._data)
            {
                openQuestS(this._data.questID);
            }
        }
    }
}
