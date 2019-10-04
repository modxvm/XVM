package net.wg.gui.lobby.store.actions.cards
{
    import net.wg.gui.lobby.store.actions.data.StoreActionCardVo;
    import net.wg.gui.lobby.store.actions.data.StoreActionCardDescrVo;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.store.actions.evnts.StoreActionsEvent;
    import net.wg.data.constants.IconsTypes;
    import net.wg.gui.lobby.store.actions.data.StoreActionTimeVo;

    public class StoreActionCardHero extends StoreActionCardBase
    {

        private static const LEFT_ITEM_SHIFT_FOR_SHORT_VIEW:Number = 0;

        private static const RIGHT_ITEM_SHIFT_FOR_SHORT_VIEW:Number = 0;

        private static const LEFT_ITEM_SHIFT_FOR_WIDE_VIEW:Number = -25;

        private static const RIGHT_ITEM_SHIFT_FOR_WIDE_VIEW:Number = 25;

        private static const ITEM_START_POS_NEW_INDICATOR:Number = 21;

        private static const ITEM_START_POS_INFO_ICON:Number = 40;

        private static const ITEM_SHIFT_POS_INFO_ICON:Number = -25;

        private static const ITEM_START_POS_HEADER:Number = 17;

        private static const ITEM_START_POS_QUEST_BTN:Number = 21;

        private static const ITEM_START_POS_QUEST_INFO:Number = 69;

        private static const ITEM_START_POS_PICTURE:Number = 453;

        private static const ITEM_START_POS_DISCOUNT:Number = 755;

        private static const RIGHT_ITEM_SHIFT_FOR_WIDE_DISCOUNT:Number = 63;

        private static const RIGHT_ITEM_SHIFT_FOR_SHORT_DISCOUNT:Number = 0;

        public var descrTTC:StoreActionDescrTTC = null;

        private var _leftItemsShift:int = 0;

        private var _hasTTCData:Boolean = false;

        private var _isTimeOver:Boolean = false;

        public function StoreActionCardHero()
        {
            super();
        }

        override protected function updateData(param1:StoreActionCardVo) : void
        {
            super.updateData(param1);
            var _loc2_:StoreActionCardDescrVo = param1.storeItemDescrVo;
            App.utils.asserter.assertNotNull(_loc2_,"storeItemDescrVo" + Errors.CANT_NULL);
            this._hasTTCData = _loc2_.ttcDataVO != null;
            header.visible = descr.visible = !this._hasTTCData;
            if(this._hasTTCData)
            {
                this.descrTTC.setData(param1);
                this.descrTTC.updateTimeLimit(this._isTimeOver);
                if(this._isTimeOver)
                {
                    this.descrTTC.removeEventListener(StoreActionsEvent.ACTION_CLICK,this.onDescrActionClickHandler);
                }
                else
                {
                    this.descrTTC.addEventListener(StoreActionsEvent.ACTION_CLICK,this.onDescrActionClickHandler);
                }
                this.descrTTC.visible = true;
            }
        }

        override protected function onDispose() : void
        {
            this.descrTTC.removeEventListener(StoreActionsEvent.ACTION_CLICK,this.onDescrActionClickHandler);
            this.descrTTC.dispose();
            this.descrTTC = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.descrTTC.mouseEnabled = false;
            descr.visible = this.descrTTC.visible = false;
        }

        override protected function updateCardSize(param1:String) : void
        {
            var _loc2_:* = 0;
            this._leftItemsShift = param1 == VIEW_SIZE_SHORT_ID?LEFT_ITEM_SHIFT_FOR_SHORT_VIEW:LEFT_ITEM_SHIFT_FOR_WIDE_VIEW;
            _loc2_ = RIGHT_ITEM_SHIFT_FOR_SHORT_VIEW;
            var _loc3_:int = RIGHT_ITEM_SHIFT_FOR_SHORT_DISCOUNT;
            if(param1 == VIEW_SIZE_WIDE_ID)
            {
                _loc2_ = RIGHT_ITEM_SHIFT_FOR_WIDE_VIEW;
                _loc3_ = RIGHT_ITEM_SHIFT_FOR_WIDE_DISCOUNT;
            }
            newIndicator.x = ITEM_START_POS_NEW_INDICATOR + this._leftItemsShift ^ 0;
            this.updateTitlePos(isNewShow,isInfoIcoShow);
            header.x = ITEM_START_POS_HEADER + this._leftItemsShift ^ 0;
            descr.updateCardSize(this._leftItemsShift,_loc2_);
            this.descrTTC.updateCardSize(this.getBounds(this));
            battleQuestsBtn.x = ITEM_START_POS_QUEST_BTN + this._leftItemsShift ^ 0;
            battleQuestsInfo.x = ITEM_START_POS_QUEST_INFO + this._leftItemsShift ^ 0;
            picture.x = ITEM_START_POS_PICTURE + _loc2_ ^ 0;
            discount.x = ITEM_START_POS_DISCOUNT + _loc3_ ^ 0;
            setTimeLeftXPos(timeLeft.icon != IconsTypes.EMPTY);
            super.updateCardSize(param1);
        }

        override protected function setTime(param1:StoreActionTimeVo) : void
        {
            super.setTime(param1);
            this._isTimeOver = param1.isTimeOver;
        }

        override protected function timeLeftViewSizeDependent() : Number
        {
            return viewSizeBreakPointId == VIEW_SIZE_SHORT_ID?RIGHT_ITEM_SHIFT_FOR_SHORT_VIEW:RIGHT_ITEM_SHIFT_FOR_WIDE_VIEW;
        }

        override protected function updateTitlePos(param1:Boolean, param2:Boolean) : void
        {
            infoIcon.x = this.getTitleIcoPos(param1);
            title.x = this.getTitlePos(param1,param2);
        }

        override protected function getTitleIcoPos(param1:Boolean) : Number
        {
            var _loc2_:Number = param1?0:ITEM_SHIFT_POS_INFO_ICON;
            return ITEM_START_POS_INFO_ICON + this._leftItemsShift + _loc2_ ^ 0;
        }

        override protected function getTitlePos(param1:Boolean, param2:Boolean) : Number
        {
            if(param2)
            {
                return this.getTitleIcoPos(param1) + infoIcon.width + INFO_TITLE_PADDING ^ 0;
            }
            return this.getTitleIcoPos(param1);
        }

        override protected function get isAllowTitleAnim() : Boolean
        {
            return true;
        }

        private function onDescrActionClickHandler(param1:StoreActionsEvent) : void
        {
            param1.actionId = cardId;
            param1.triggerChainID = triggerChainID;
            dispatchEvent(param1);
        }
    }
}
