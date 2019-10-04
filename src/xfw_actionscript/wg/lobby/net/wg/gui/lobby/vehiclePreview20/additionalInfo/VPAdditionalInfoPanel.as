package net.wg.gui.lobby.vehiclePreview20.additionalInfo
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.utils.IStageSizeDependComponent;
    import flash.text.TextField;
    import net.wg.gui.lobby.vehiclePreview20.data.VPAdditionalInfoVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.utils.StageSizeBoundaries;

    public class VPAdditionalInfoPanel extends UIComponentEx implements IStageSizeDependComponent
    {

        private static const OBJECT_DESC_OFFSET:int = 10;

        private static const DESC_TITLE_TEXT_OFFSET:int = 3;

        private static const TITLE_SCALE_SMALL:Number = 0.64;

        private static const TITLE_SCALE_NORMAL:Number = 1;

        public var objectSubtitle:TextField;

        public var objectTitle:TextField;

        public var descriptionTitle:TextField;

        public var descriptionText:TextField;

        private var _data:VPAdditionalInfoVO;

        public function VPAdditionalInfoPanel()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabled = false;
            this.objectSubtitle.mouseEnabled = this.objectSubtitle.mouseWheelEnabled = false;
            this.objectSubtitle.wordWrap = false;
            this.objectTitle.mouseEnabled = this.objectTitle.mouseWheelEnabled = false;
            this.objectTitle.wordWrap = false;
            this.descriptionTitle.mouseEnabled = this.descriptionTitle.mouseWheelEnabled = false;
            this.descriptionTitle.wordWrap = false;
            this.descriptionText.mouseEnabled = this.descriptionText.mouseWheelEnabled = false;
            this.descriptionText.wordWrap = true;
            App.stageSizeMgr.register(this);
        }

        override protected function onDispose() : void
        {
            this._data = null;
            this.objectSubtitle = null;
            this.objectTitle = null;
            this.descriptionTitle = null;
            this.descriptionText = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.objectSubtitle.htmlText = this._data.objectSubtitle;
                this.objectTitle.htmlText = this._data.objectTitle;
                this.descriptionTitle.htmlText = this._data.descriptionTitle;
                this.descriptionText.htmlText = this._data.descriptionText;
                App.utils.commons.updateTextFieldSize(this.descriptionText,false,true);
                App.utils.commons.updateTextFieldSize(this.objectTitle,true,true);
            }
            if(this._data && isInvalid(InvalidationType.SIZE))
            {
                this.descriptionTitle.y = this.objectTitle.y + this.objectTitle.height + OBJECT_DESC_OFFSET | 0;
                this.descriptionText.y = this.descriptionTitle.y + this.descriptionTitle.height + DESC_TITLE_TEXT_OFFSET | 0;
            }
        }

        public function setData(param1:VPAdditionalInfoVO) : void
        {
            this._data = param1;
            invalidateData();
            invalidateSize();
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            if(param2 == StageSizeBoundaries.HEIGHT_768)
            {
                this.objectTitle.scaleX = this.objectTitle.scaleY = TITLE_SCALE_SMALL;
            }
            else
            {
                this.objectTitle.scaleX = this.objectTitle.scaleY = TITLE_SCALE_NORMAL;
            }
            invalidateSize();
        }
    }
}
