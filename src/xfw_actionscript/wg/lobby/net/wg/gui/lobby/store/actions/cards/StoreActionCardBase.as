package net.wg.gui.lobby.store.actions.cards
{
    import fl.motion.easing.Cubic;
    import net.wg.gui.components.assets.interfaces.INewIndicator;
    import net.wg.infrastructure.interfaces.IInfoIcon;
    import net.wg.gui.interfaces.IButtonIconLoader;
    import flash.text.TextField;
    import flash.display.Sprite;
    import scaleform.clik.motion.Tween;
    import net.wg.data.constants.generated.STORE_CONSTANTS;
    import net.wg.gui.lobby.store.actions.evnts.StoreActionsEvent;
    import net.wg.gui.lobby.store.actions.data.StoreActionCardVo;
    import net.wg.data.constants.Values;
    import net.wg.gui.components.controls.InfoIcon;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.store.actions.data.StoreActionTimeVo;
    import net.wg.data.constants.generated.TEXT_ALIGN;
    import flash.events.MouseEvent;
    import scaleform.gfx.MouseEventEx;

    public class StoreActionCardBase extends StoreActionCardAbstract
    {

        private static const ANIM_STATE_PLAY_OUT:String = "animStatePlayOut";

        private static const ANIM_STATE_PLAY_OVER:String = "animStatePlayIn";

        protected static const INFO_TITLE_PADDING:Number = 2;

        private static const ANIM_SPEED_TIME:Number = 300;

        private static const ANIM_SPEED_RUN_DELAY:Number = 200;

        private static const ANIM_SPEED_RUN_LAG_DELAY:Number = 300;

        private static const TIME_LEFT_POS_X_CORRECT:Number = 16;

        private static const TIME_OVER_CARD_ALPHA:Number = 0.4;

        private static const PROPERTIES_ANIM:Object = {
            "paused":false,
            "delay":ANIM_SPEED_RUN_DELAY,
            "ease":Cubic.easeInOut,
            "onComplete":null
        };

        private static const PROPERTIES_LAG_ANIM:Object = {
            "paused":false,
            "delay":ANIM_SPEED_RUN_LAG_DELAY,
            "ease":Cubic.easeInOut,
            "onComplete":null
        };

        public var newIndicator:INewIndicator = null;

        public var infoIcon:IInfoIcon = null;

        public var descr:StoreActionDescr = null;

        public var discount:StoreActionDiscount = null;

        public var battleQuestsBtn:IButtonIconLoader = null;

        public var battleQuestsInfo:TextField = null;

        public var overBg:Sprite = null;

        protected var isShowDescrTableOfers:Boolean = false;

        protected var isNewShow:Boolean = false;

        protected var isInfoIcoShow:Boolean = false;

        private var _selectFrame:ActionCardSelectFrame = null;

        private var _isTimeOver:Boolean = false;

        private var _isSelectFrameShow:Boolean = false;

        private var _headerStartPosY:Number = 0;

        private var _headerFinishPosY:Number = 0;

        private var _tweenDescr:Tween = null;

        private var _tweenHeader:Tween = null;

        private var _tweenDiscount:Tween = null;

        private var _tweenIsNew:Tween = null;

        private var _tweenSelectFrame:Tween = null;

        private var _tweenTitle:Tween = null;

        private var _tweenTitleIco:Tween = null;

        private var _tweenPicture:Tween = null;

        private var _tweenBgOver:Tween = null;

        private var _isListenersEnabled:Boolean = false;

        private var _animState:String = "animStatePlayOut";

        public function StoreActionCardBase()
        {
            super();
        }

        override protected function showSelect() : void
        {
            if(this._isTimeOver)
            {
                return;
            }
            if(cardSettingsVo && cardSettingsVo.selectFrameLabel)
            {
                if(!this._selectFrame)
                {
                    this._selectFrame = App.utils.classFactory.getComponent(STORE_CONSTANTS.ACTION_CARD_SELECT_LINKAGE,ActionCardSelectFrame);
                    this._selectFrame.addEventListener(StoreActionsEvent.ANIM_FINISHED,this.onSelectFrameAnimFinishedHandler);
                    this.addChild(this._selectFrame);
                }
                else
                {
                    this._selectFrame.alpha = 1;
                }
                this._selectFrame.show(cardSettingsVo.selectFrameLabel);
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.newIndicator.visible = false;
            this.battleQuestsInfo.visible = false;
            this.battleQuestsBtn.visible = false;
            this.newIndicator.mouseEnabled = false;
            this.newIndicator.mouseChildren = false;
            this.descr.mouseEnabled = false;
            this.discount.mouseEnabled = false;
            this.discount.mouseChildren = false;
            this.battleQuestsInfo.mouseEnabled = false;
            this.overBg.mouseChildren = false;
            this.overBg.mouseEnabled = false;
            this.initAnimStartState();
        }

        override protected function updateData(param1:StoreActionCardVo) : void
        {
            super.updateData(param1);
            this.isNewShow = param1.isNew && !param1.time.isTimeOver;
            this.isInfoIcoShow = param1.tooltipInfo != Values.EMPTY_STR;
            this.newIndicator.visible = this.isNewShow;
            this.isShowDescrTableOfers = param1.storeItemDescrVo.tableOffers != null;
            var _loc2_:String = param1.tooltipInfo != Values.EMPTY_STR?App.toolTipMgr.getNewFormatter().addHeader(param1.title).addBody(param1.tooltipInfo).make():App.toolTipMgr.getNewFormatter().addBody(param1.title).make();
            if(this.isInfoIcoShow)
            {
                this.infoIcon.visible = true;
                this.infoIcon.icoType = InfoIcon.TYPE_INFO;
                this.infoIcon.tooltip = _loc2_;
            }
            else
            {
                this.infoIcon.visible = false;
            }
            this.updateTitlePos(this.isNewShow,this.isInfoIcoShow);
            title.setText(param1.title,_loc2_);
            header.setText(param1.header);
            this.updateHeaderAnimStartPosition(param1.hasBattleQuest);
            var _loc3_:String = this.getDescriptionVerticalAlign();
            this.descr.setData(param1,this.getIsSetDescr(),header.y,header.height,cardSettingsVo.contentAvailableHeight,cardSettingsVo.getMarginFromHeaderToDescription(this.isShowDescrTableOfers),_loc3_,this.getBtnAlign(param1.hasBattleQuest),getPermanentWidth(),getPermanentHeight(),cardSettingsVo.contentRightPadding);
            this.updateHeaderAnimFinishPosition(this.descr.descriptionInfoTopPos,_loc3_);
            this.discount.setData(cardSettingsVo.discountFrameLabel,param1.discount);
            if(param1.hasBattleQuest)
            {
                this.battleQuestsInfo.htmlText = param1.battleQuestsInfo;
                this.battleQuestsBtn.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_QUEST_ICON;
                this.battleQuestsBtn.visible = true;
                this.battleQuestsBtn.addEventListener(ButtonEvent.CLICK,this.onBattleQuestsBtnClickHandler);
                this.battleQuestsInfo.visible = true;
            }
            else
            {
                this.battleQuestsInfo.visible = false;
                this.battleQuestsBtn.visible = false;
            }
        }

        override protected function onDispose() : void
        {
            this.removeListeners();
            if(this._selectFrame)
            {
                this._selectFrame.removeEventListener(StoreActionsEvent.ANIM_FINISHED,this.onSelectFrameAnimFinishedHandler);
                this._selectFrame.dispose();
                this.removeChild(this._selectFrame);
                this._selectFrame = null;
            }
            if(this._tweenIsNew)
            {
                this._tweenIsNew.paused = true;
                this._tweenIsNew.dispose();
                this._tweenIsNew = null;
            }
            if(this._tweenSelectFrame)
            {
                this._tweenSelectFrame.paused = true;
                this._tweenSelectFrame.dispose();
                this._tweenSelectFrame = null;
            }
            if(this._tweenTitle)
            {
                this._tweenTitle.paused = true;
                this._tweenTitle.dispose();
                this._tweenTitle = null;
            }
            if(this._tweenTitleIco)
            {
                this._tweenTitleIco.paused = true;
                this._tweenTitleIco.dispose();
                this._tweenTitleIco = null;
            }
            this.clearTween();
            this.newIndicator.dispose();
            this.newIndicator = null;
            this.infoIcon.dispose();
            this.infoIcon = null;
            this.descr.dispose();
            this.descr = null;
            this.discount.dispose();
            this.discount = null;
            this.battleQuestsBtn.removeEventListener(ButtonEvent.CLICK,this.onBattleQuestsBtnClickHandler);
            this.battleQuestsBtn.dispose();
            this.battleQuestsBtn = null;
            this.battleQuestsInfo = null;
            this.overBg = null;
            super.onDispose();
        }

        override protected function setTime(param1:StoreActionTimeVo) : void
        {
            super.setTime(param1);
            this.setTimeLeftXPos(param1.isShowTimeIco);
            this.descr.updateTimeLimit(param1.isTimeOver);
            this.battleQuestsBtn.enabled = !param1.isTimeOver;
            this._isTimeOver = param1.isTimeOver;
            if(this._isTimeOver)
            {
                App.utils.commons.setSaturation(this,0);
                this.alpha = TIME_OVER_CARD_ALPHA;
                this.removeListeners();
                this.animHideSelectFrame(ANIM_SPEED_RUN_DELAY);
                if(this._animState == ANIM_STATE_PLAY_OVER)
                {
                    this.playAnimRollOut();
                }
            }
            else
            {
                this.filters = null;
                this.alpha = 1;
                this.addListeners();
            }
            var _loc2_:Number = param1.isShowTimeIco == true?0:TIME_LEFT_POS_X_CORRECT;
            title.setAvailableWidth(timeLeft.x - title.x + _loc2_ - cardSettingsVo.gapFromTitleToTimeLeft ^ 0);
        }

        protected function setTimeLeftXPos(param1:Boolean) : void
        {
            var _loc2_:Number = param1 == true?TIME_LEFT_POS_X_CORRECT:0;
            _loc2_ = _loc2_ + (cardSettingsVo.timeLeftRightShift + this.timeLeftViewSizeDependent());
            timeLeft.x = getPermanentWidth() - timeLeft.getVisibleWidth() + _loc2_ ^ 0;
        }

        protected function timeLeftViewSizeDependent() : Number
        {
            return 0;
        }

        protected function getIsSetDescr() : Boolean
        {
            return true;
        }

        protected function getDescriptionVerticalAlign() : String
        {
            return StoreActionDescr.DESCRIPTION_POS_UNDER_STATIC_HEADER;
        }

        protected function getBtnAlign(param1:Boolean) : String
        {
            return TEXT_ALIGN.CENTER;
        }

        protected function updateHeaderAnimStartPosition(param1:Boolean) : void
        {
            this._headerStartPosY = header.y;
        }

        protected function initAnimStartState() : void
        {
            this.overBg.alpha = 0;
        }

        protected function updateTitlePos(param1:Boolean, param2:Boolean) : void
        {
            title.x = this.getTitlePos(param1,param2);
        }

        protected function getTitleIcoPos(param1:Boolean) : Number
        {
            return 0;
        }

        protected function getTitlePos(param1:Boolean, param2:Boolean) : Number
        {
            if(param2)
            {
                return this.infoIcon.x + this.infoIcon.width + INFO_TITLE_PADDING;
            }
            return this.infoIcon.x;
        }

        private function clearTween() : void
        {
            if(this._tweenDescr)
            {
                this._tweenDescr.paused = true;
                this._tweenDescr.dispose();
                this._tweenDescr = null;
            }
            if(this._tweenHeader)
            {
                this._tweenHeader.paused = true;
                this._tweenHeader.dispose();
                this._tweenHeader = null;
            }
            if(this._tweenDiscount)
            {
                this._tweenDiscount.paused = true;
                this._tweenDiscount.dispose();
                this._tweenDiscount = null;
            }
            if(this._tweenPicture)
            {
                this._tweenPicture.paused = true;
                this._tweenPicture.dispose();
                this._tweenPicture = null;
            }
            if(this._tweenBgOver)
            {
                this._tweenBgOver.paused = true;
                this._tweenBgOver.dispose();
                this._tweenBgOver = null;
            }
        }

        private function updateHeaderAnimFinishPosition(param1:Number, param2:String) : void
        {
            if(param2 == StoreActionDescr.DESCRIPTION_POS_CENTER_WITH_HEADER)
            {
                this._headerFinishPosY = param1 - cardSettingsVo.getMarginFromHeaderToDescription(this.isShowDescrTableOfers) - header.height ^ 0;
            }
            else if(param2 == StoreActionDescr.DESCRIPTION_POS_UNDER_STATIC_HEADER)
            {
                this._headerFinishPosY = header.y;
            }
        }

        private function addListeners() : void
        {
            if(this._isListenersEnabled)
            {
                return;
            }
            this.descr.addEventListener(StoreActionsEvent.ACTION_CLICK,this.onDescrActionClickHandler);
            this.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            this.addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
            this.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
            this.buttonMode = true;
            this._isListenersEnabled = true;
        }

        private function removeListeners() : void
        {
            if(!this._isListenersEnabled)
            {
                return;
            }
            this.descr.removeEventListener(StoreActionsEvent.ACTION_CLICK,this.onDescrActionClickHandler);
            this.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            this.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
            this.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
            this.buttonMode = false;
            this._isListenersEnabled = false;
        }

        private function playAnimRollOver() : void
        {
            this._animState = ANIM_STATE_PLAY_OVER;
            if(this.isNewShow)
            {
                this._tweenIsNew = new Tween(ANIM_SPEED_TIME,this.newIndicator,{"alpha":0},PROPERTIES_ANIM);
                this.isNewShow = false;
                if(this.isAllowTitleAnim)
                {
                    this._tweenTitle = new Tween(ANIM_SPEED_TIME,this.title,{"x":this.getTitlePos(this.isNewShow,this.isInfoIcoShow)},PROPERTIES_ANIM);
                    this._tweenTitleIco = new Tween(ANIM_SPEED_TIME,this.infoIcon,{"x":this.getTitleIcoPos(this.isNewShow)},PROPERTIES_ANIM);
                }
                dispatchEvent(new StoreActionsEvent(StoreActionsEvent.ACTION_SEEN,cardId,triggerChainID));
            }
            this.animHideSelectFrame(ANIM_SPEED_RUN_DELAY);
            if(cardSettingsVo.isUseDescrAnim)
            {
                this._tweenDescr = new Tween(ANIM_SPEED_TIME,this.descr,{"alpha":1},PROPERTIES_LAG_ANIM);
            }
            this._tweenHeader = new Tween(ANIM_SPEED_TIME,this.header,{"y":this._headerFinishPosY},PROPERTIES_ANIM);
            if(cardSettingsVo.isUseDiscountAnim)
            {
                this._tweenDiscount = new Tween(ANIM_SPEED_TIME,this.discount,{"alpha":0},PROPERTIES_ANIM);
            }
            if(cardSettingsVo.isUsePictureAnim)
            {
                this._tweenPicture = new Tween(ANIM_SPEED_TIME,this.actualPicture,{"alpha":0.1},PROPERTIES_ANIM);
            }
            this._tweenBgOver = new Tween(ANIM_SPEED_TIME,this.overBg,{"alpha":1},PROPERTIES_ANIM);
        }

        private function playAnimRollOut() : void
        {
            this._animState = ANIM_STATE_PLAY_OUT;
            if(cardSettingsVo.isUseDescrAnim)
            {
                this._tweenDescr = new Tween(ANIM_SPEED_TIME,this.descr,{"alpha":0},PROPERTIES_ANIM);
            }
            this._tweenHeader = new Tween(ANIM_SPEED_TIME,this.header,{"y":this._headerStartPosY},PROPERTIES_LAG_ANIM);
            if(cardSettingsVo.isUseDiscountAnim)
            {
                this._tweenDiscount = new Tween(ANIM_SPEED_TIME,this.discount,{"alpha":1},PROPERTIES_LAG_ANIM);
            }
            if(cardSettingsVo.isUsePictureAnim)
            {
                this._tweenPicture = new Tween(ANIM_SPEED_TIME,this.actualPicture,{"alpha":1},PROPERTIES_LAG_ANIM);
            }
            this._tweenBgOver = new Tween(ANIM_SPEED_TIME,this.overBg,{"alpha":0},PROPERTIES_LAG_ANIM);
        }

        private function animHideSelectFrame(param1:Number) : void
        {
            if(!this._isSelectFrameShow || !this._selectFrame)
            {
                return;
            }
            this._isSelectFrameShow = false;
            this._tweenSelectFrame = new Tween(ANIM_SPEED_TIME,this._selectFrame,{"alpha":0},{
                "paused":false,
                "delay":param1,
                "ease":Cubic.easeInOut,
                "onComplete":null
            });
        }

        protected function get isAllowTitleAnim() : Boolean
        {
            return false;
        }

        private function onSelectFrameAnimFinishedHandler(param1:StoreActionsEvent) : void
        {
            this._isSelectFrameShow = true;
            if(this._animState == ANIM_STATE_PLAY_OVER)
            {
                this.animHideSelectFrame(0);
            }
        }

        private function onMouseClickHandler(param1:MouseEvent) : void
        {
            var _loc2_:MouseEventEx = null;
            var _loc3_:uint = 0;
            if(param1.target == param1.currentTarget)
            {
                _loc2_ = param1 as MouseEventEx;
                _loc3_ = _loc2_ == null?0:_loc2_.buttonIdx;
                if(_loc3_ != MouseEventEx.LEFT_BUTTON)
                {
                    return;
                }
                dispatchEvent(new StoreActionsEvent(StoreActionsEvent.ACTION_CLICK,cardId,triggerChainID));
            }
        }

        private function onBattleQuestsBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new StoreActionsEvent(StoreActionsEvent.BATTLE_TASK_CLICK,cardId,triggerChainID));
        }

        private function onDescrActionClickHandler(param1:StoreActionsEvent) : void
        {
            param1.actionId = cardId;
            param1.triggerChainID = triggerChainID;
            dispatchEvent(param1);
        }

        private function onMouseRollOverHandler(param1:MouseEvent) : void
        {
            this.clearTween();
            this.playAnimRollOver();
        }

        private function onMouseRollOutHandler(param1:MouseEvent) : void
        {
            this.clearTween();
            this.playAnimRollOut();
        }
    }
}
