package net.wg.gui.lobby.store.actions.cards
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.controls.HyperLink;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.store.actions.data.StoreActionCardVo;
    import net.wg.data.constants.Values;
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.data.constants.generated.TEXT_ALIGN;
    import net.wg.gui.lobby.store.actions.evnts.StoreActionsEvent;

    public class StoreActionDescr extends Sprite implements IDisposable
    {

        private static const TEXT_FIELD_HEIGHT_PADDING:Number = 4;

        private static const ITEMS_TOP_MARGIN:Number = 6;

        private static const DESCRIPTION_TEXT_UNDER_TABLE_TOP_MARGIN:Number = 3;

        private static const ITEM_START_POS_DESCRIPTION_TABLE:Number = 18;

        private static const ITEM_START_POS_DESCRIPTION_TEXT:Number = 18;

        public static const DESCRIPTION_POS_UNDER_STATIC_HEADER:String = "descriptionPosUnderStaticHeader";

        public static const DESCRIPTION_POS_CENTER_WITH_HEADER:String = "descriptionPosCenterWithHeader";

        public var description:TextField = null;

        public var item1:StoreActionCardDescrTableOfferItem = null;

        public var item2:StoreActionCardDescrTableOfferItem = null;

        public var item3:StoreActionCardDescrTableOfferItem = null;

        public var actionBtn:ISoundButtonEx = null;

        public var linkBtn:HyperLink = null;

        private var _itemsList:Vector.<StoreActionCardDescrTableOfferItem> = null;

        private var _descriptionInfoTopPosition:Number = 0;

        private var _isShowDescrTableOfers:Boolean = false;

        private var _rightItemsShift:Number = 0;

        private var _cardWidth:Number = 0;

        private var _btnAlign:String = "center";

        private var _contentRightPadding:Number = 0;

        public function StoreActionDescr()
        {
            super();
            this.item1.visible = false;
            this.item2.visible = false;
            this.item3.visible = false;
            this.actionBtn.visible = false;
            this.actionBtn.dynamicSizeByText = true;
            this.actionBtn.changeSizeOnlyUpwards = true;
            this.linkBtn.visible = false;
            this.linkBtn.isShowLinkIco = true;
            this._itemsList = new <StoreActionCardDescrTableOfferItem>[this.item1,this.item2,this.item3];
            this.description.mouseEnabled = false;
            this.item1.mouseEnabled = false;
            this.item1.mouseChildren = false;
            this.item2.mouseEnabled = false;
            this.item2.mouseChildren = false;
            this.item3.mouseEnabled = false;
            this.item3.mouseChildren = false;
        }

        public final function dispose() : void
        {
            if(this.actionBtn.visible)
            {
                this.actionBtn.removeEventListener(ButtonEvent.CLICK,this.onActionBtnClickHandler);
            }
            if(this.linkBtn.visible)
            {
                this.linkBtn.removeEventListener(ButtonEvent.CLICK,this.onActionBtnClickHandler);
            }
            this.actionBtn.dispose();
            this.actionBtn = null;
            this.linkBtn.dispose();
            this.linkBtn = null;
            this._itemsList.slice(0,this._itemsList.length);
            this._itemsList = null;
            this.description = null;
            this.item1.dispose();
            this.item1 = null;
            this.item2.dispose();
            this.item2 = null;
            this.item3.dispose();
            this.item3 = null;
        }

        public function setData(param1:StoreActionCardVo, param2:Boolean, param3:Number, param4:Number, param5:Number, param6:Number, param7:String, param8:String, param9:Number, param10:Number, param11:Number) : void
        {
            var _loc12_:* = NaN;
            var _loc13_:* = 0;
            var _loc14_:* = 0;
            var _loc15_:* = NaN;
            var _loc16_:* = NaN;
            var _loc17_:* = NaN;
            var _loc18_:* = NaN;
            this._cardWidth = param9;
            this._btnAlign = param8;
            this._contentRightPadding = param11;
            if(param2)
            {
                _loc12_ = 0;
                _loc13_ = 0;
                _loc14_ = 0;
                _loc15_ = this.description.text != Values.EMPTY_STR?DESCRIPTION_TEXT_UNDER_TABLE_TOP_MARGIN:0;
                this._isShowDescrTableOfers = param1.storeItemDescrVo.tableOffers != null;
                _loc16_ = 0;
                _loc17_ = Number.MAX_VALUE;
                if(this._isShowDescrTableOfers)
                {
                    _loc13_ = param1.storeItemDescrVo.tableOffers.length;
                    _loc14_ = 0;
                    while(_loc14_ < _loc13_)
                    {
                        if(param1.storeItemDescrVo.tableOffers[_loc14_])
                        {
                            this._itemsList[_loc14_].setData(param1.storeItemDescrVo.tableOffers[_loc14_]);
                            this._itemsList[_loc14_].visible = true;
                            _loc12_ = _loc12_ + (this._itemsList[_loc14_].height + ITEMS_TOP_MARGIN);
                            if(_loc17_ > this._itemsList[_loc14_].getSpaceForDiscount())
                            {
                                _loc17_ = this._itemsList[_loc14_].getSpaceForDiscount();
                                _loc16_ = this._itemsList[_loc14_].getDiscountLeftPos();
                            }
                        }
                        else
                        {
                            this._itemsList[_loc14_].visible = false;
                        }
                        _loc14_++;
                    }
                    _loc16_ = _loc16_ + _loc17_ / 2 ^ 0;
                    _loc12_ = _loc12_ + _loc15_;
                }
                this.description.height = param5 - param4 - param6 - _loc12_;
                App.utils.commons.truncateTextFieldText(this.description,param1.storeItemDescrVo.descr,false,true);
                this.description.height = this.description.textHeight + TEXT_FIELD_HEIGHT_PADDING;
                _loc12_ = _loc12_ + this.description.height ^ 0;
                _loc18_ = 0;
                if(param7 == DESCRIPTION_POS_CENTER_WITH_HEADER)
                {
                    _loc18_ = param10 + param4 + param6 - _loc12_ >> 1;
                }
                else if(param7 == DESCRIPTION_POS_UNDER_STATIC_HEADER)
                {
                    _loc18_ = param3 + param4 + param6;
                }
                this._descriptionInfoTopPosition = _loc18_;
                if(this._isShowDescrTableOfers)
                {
                    _loc13_ = this._itemsList.length;
                    _loc14_ = 0;
                    while(_loc14_ < _loc13_)
                    {
                        if(this._itemsList[_loc14_].visible)
                        {
                            this._itemsList[_loc14_].setDiscountPos(_loc16_);
                            this._itemsList[_loc14_].y = _loc18_ ^ 0;
                            _loc18_ = _loc18_ + (this._itemsList[_loc14_].height + ITEMS_TOP_MARGIN);
                        }
                        _loc14_++;
                    }
                    _loc18_ = _loc18_ + _loc15_;
                }
                this.description.y = _loc18_ ^ 0;
            }
            else
            {
                this.description.visible = false;
            }
            if(param1.hasLinkBtn)
            {
                this.actionBtn.visible = false;
                this.linkBtn.label = param1.linkBtnLabel;
                this.linkBtn.validateNow();
                this.setBtnPosition(this.linkBtn);
                this.linkBtn.visible = true;
                this.linkBtn.addEventListener(ButtonEvent.CLICK,this.onActionBtnClickHandler);
            }
            else if(param1.hasActionBtn)
            {
                this.linkBtn.visible = false;
                this.actionBtn.label = param1.actionBtnLabel;
                this.actionBtn.validateNow();
                this.setBtnPosition(this.actionBtn);
                this.actionBtn.visible = true;
                this.actionBtn.addEventListener(ButtonEvent.CLICK,this.onActionBtnClickHandler);
            }
            else
            {
                this.linkBtn.visible = false;
                this.actionBtn.visible = false;
            }
            this.updateTimeLimit(param1.time.isTimeOver);
        }

        public function updateCardSize(param1:Number, param2:Number) : void
        {
            var _loc3_:* = NaN;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            if(this._isShowDescrTableOfers)
            {
                _loc3_ = ITEM_START_POS_DESCRIPTION_TABLE + param1;
                _loc4_ = this._itemsList.length;
                _loc5_ = 0;
                while(_loc5_ < _loc4_)
                {
                    this._itemsList[_loc5_].x = _loc3_;
                    _loc5_++;
                }
            }
            this.description.x = ITEM_START_POS_DESCRIPTION_TEXT + param1;
            this._rightItemsShift = param2;
            if(this.actionBtn.visible)
            {
                this.setBtnPosition(this.linkBtn);
            }
            else
            {
                this.setBtnPosition(this.actionBtn);
            }
        }

        public function updateTimeLimit(param1:Boolean) : void
        {
            this.linkBtn.enabled = !param1;
            this.actionBtn.enabled = !param1;
        }

        private function setBtnPosition(param1:IUIComponentEx) : void
        {
            if(this._btnAlign == TEXT_ALIGN.CENTER)
            {
                param1.x = this._cardWidth - param1.actualWidth >> 1;
            }
            else if(this._btnAlign == TEXT_ALIGN.RIGHT)
            {
                param1.x = this._cardWidth - param1.actualWidth + this._contentRightPadding + this._rightItemsShift;
            }
        }

        public function get descriptionInfoTopPos() : Number
        {
            return this._descriptionInfoTopPosition;
        }

        private function onActionBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new StoreActionsEvent(StoreActionsEvent.ACTION_CLICK,Values.EMPTY_STR,Values.EMPTY_STR));
        }
    }
}
