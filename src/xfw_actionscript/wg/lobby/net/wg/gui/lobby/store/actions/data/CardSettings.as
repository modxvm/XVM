package net.wg.gui.lobby.store.actions.data
{
    public class CardSettings extends Object
    {

        public var cardId:String = "";

        public var permanentWidth:Number = 0;

        public var permanentHeight:Number = 0;

        public var cardBottomMargin:Number = 0;

        public var cardLeftMargin:Number = 0;

        public var contentRightPadding:Number = 0;

        public var contentAvailableHeight:Number = 0;

        public var timeLeftRightShift:Number = 0;

        public var gapFromTitleToTimeLeft:Number = 0;

        public var marginFromHeaderToDescriptionText:Number = 0;

        public var marginFromHeaderToDescriptionTable:Number = 0;

        public var discountFrameLabel:String = "";

        public var selectFrameLabel:String = "";

        public var pictureScale:Number = 1;

        public var isUseDescrAnim:Boolean = true;

        public var isUsePictureAnim:Boolean = true;

        public var isUseDiscountAnim:Boolean = true;

        public function CardSettings()
        {
            super();
        }

        public function getMarginFromHeaderToDescription(param1:Boolean) : Number
        {
            return param1?this.marginFromHeaderToDescriptionTable:this.marginFromHeaderToDescriptionText;
        }
    }
}
