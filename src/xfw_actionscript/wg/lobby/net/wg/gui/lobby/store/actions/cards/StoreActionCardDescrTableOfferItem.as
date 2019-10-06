package net.wg.gui.lobby.store.actions.cards
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.events.UILoaderEvent;
    import net.wg.gui.lobby.store.actions.data.StoreActionCardOffersItemVo;
    import org.idmedia.as3commons.util.StringUtils;

    public class StoreActionCardDescrTableOfferItem extends Sprite implements IDisposable
    {

        private static const TEXTFIELD_START_X_POS_WITHOUT_ICO:Number = -6;

        private static const TEXTFIELD_SHIFT_X:Number = 5;

        private static const DEF_ICO_Y_POS:Number = 3;

        private static const DEF_ICO_HEIGHT:Number = 16;

        private static const DEF_ICO_WIDTH:Number = 27;

        private static const DEF_ADDITIONAL_ICO_Y_POS:Number = 3;

        private static const DEF_ADDITIONAL_ICO_HEIGHT:Number = 16;

        private static const DEF_ADDITIONAL_ICO_WIDTH:Number = 16;

        private static const DEF_ADDITIONAL_ICO_RIGHT_SHIFT:Number = 2;

        private static const PATTERN_HAS_HTML_IMG:RegExp = new RegExp("<img");

        private static const START_ITEMS_POS:Number = 0;

        private static const ICON_WIDTH_PLUS_MARGIN:Number = 29;

        private static const ADDITIONAL_ICON_WIDTH_PLUS_MARGIN:Number = 16;

        public var icon:UILoaderAlt = null;

        public var additionalIcon:UILoaderAlt = null;

        public var textField:TextField = null;

        public var discount:TextField = null;

        public var price:TextField = null;

        private var _discountMinPos:Number = 0;

        private var _discountWidth:Number = 0;

        private var _discountSpace:Number = 0;

        public function StoreActionCardDescrTableOfferItem()
        {
            super();
        }

        public final function dispose() : void
        {
            this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
            this.icon.dispose();
            this.icon = null;
            this.additionalIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onAdditionalIconCompleteHandler);
            this.additionalIcon.dispose();
            this.additionalIcon = null;
            this.textField = null;
            this.discount = null;
            this.price = null;
        }

        public function getDiscountLeftPos() : Number
        {
            return this._discountMinPos;
        }

        public function getSpaceForDiscount() : Number
        {
            return this._discountSpace - this._discountWidth;
        }

        public function setData(param1:StoreActionCardOffersItemVo) : void
        {
            var _loc2_:Number = START_ITEMS_POS;
            if(StringUtils.isNotEmpty(param1.icon))
            {
                this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
                this.icon.source = param1.icon;
                _loc2_ = _loc2_ + ICON_WIDTH_PLUS_MARGIN;
            }
            else
            {
                this.icon.visible = false;
            }
            if(StringUtils.isNotEmpty(param1.additionalIcon))
            {
                this.additionalIcon.addEventListener(UILoaderEvent.COMPLETE,this.onAdditionalIconCompleteHandler);
                this.additionalIcon.source = param1.additionalIcon;
                _loc2_ = _loc2_ + ADDITIONAL_ICON_WIDTH_PLUS_MARGIN;
            }
            else
            {
                this.additionalIcon.visible = false;
            }
            if(StringUtils.isEmpty(param1.icon) && StringUtils.isEmpty(param1.additionalIcon))
            {
                _loc2_ = TEXTFIELD_START_X_POS_WITHOUT_ICO;
            }
            this.textField.htmlText = param1.title;
            var _loc3_:* = param1.title.match(PATTERN_HAS_HTML_IMG) != null;
            this.textField.x = _loc3_?_loc2_:_loc2_ + TEXTFIELD_SHIFT_X;
            this.discount.htmlText = param1.discount;
            this.price.htmlText = param1.price;
            this._discountMinPos = this.textField.x + this.textField.textWidth;
            var _loc4_:Number = this.price.x + this.price.width - this.price.textWidth;
            this._discountSpace = _loc4_ - this._discountMinPos;
            this._discountWidth = this.discount.textWidth;
        }

        public function setDiscountPos(param1:Number) : void
        {
            this.discount.x = param1;
        }

        private function onAdditionalIconCompleteHandler(param1:UILoaderEvent) : void
        {
            var _loc2_:Number = this.additionalIcon.height - DEF_ADDITIONAL_ICO_HEIGHT;
            if(_loc2_ > 0)
            {
                this.additionalIcon.y = DEF_ADDITIONAL_ICO_Y_POS - (_loc2_ >> 1);
            }
            this.additionalIcon.x = ICON_WIDTH_PLUS_MARGIN + DEF_ADDITIONAL_ICO_RIGHT_SHIFT + (DEF_ADDITIONAL_ICO_WIDTH - this.additionalIcon.width) / 2 | 0;
        }

        private function onIconCompleteHandler(param1:UILoaderEvent) : void
        {
            var _loc2_:Number = this.icon.height - DEF_ICO_HEIGHT;
            if(_loc2_ > 0)
            {
                this.icon.y = DEF_ICO_Y_POS - (_loc2_ >> 1);
            }
            this.icon.x = (DEF_ICO_WIDTH - this.icon.width) / 2 | 0;
        }
    }
}
