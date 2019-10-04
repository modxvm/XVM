package net.wg.gui.lobby.modulesPanel.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.modulesPanel.data.ListOverlayVO;
    import net.wg.gui.events.UILoaderEvent;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;

    public class ListOverlay extends UIComponentEx
    {

        private static const GAP_TOP_ICON:int = -40;

        private static const GAP_ICON_DESC:int = -20;

        private static const GAP_DESC_BTN:int = 13;

        private static const PADDING_DESC:int = 120;

        public var icon:UILoaderAlt = null;

        public var titleTf:TextField = null;

        public var descTf:TextField = null;

        public var okBtn:ISoundButtonEx = null;

        public var bg:MovieClip = null;

        private var _data:ListOverlayVO = null;

        public function ListOverlay()
        {
            super();
            mouseChildren = false;
        }

        override protected function onDispose() : void
        {
            if(this._data)
            {
                this._data.dispose();
                this._data = null;
            }
            this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
            this.icon.dispose();
            this.icon = null;
            this.okBtn.dispose();
            this.okBtn = null;
            this.titleTf = null;
            this.descTf = null;
            this.bg = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
            this.icon.autoSize = this.icon.maintainAspectRatio = false;
            this.titleTf.autoSize = TextFieldAutoSize.LEFT;
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.icon.source = this._data.icon;
                this.titleTf.htmlText = this._data.titleText;
                this.descTf.htmlText = this._data.descText;
                this.okBtn.label = this._data.okBtnLabel;
                this.okBtn.visible = this._data.displayOkBtn;
                this.updateLayout();
            }
            if(this._data && isInvalid(InvalidationType.SIZE))
            {
                this.updateLayout();
            }
        }

        public function update(param1:ListOverlayVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        public function isClickEnabled() : Boolean
        {
            return this._data?this._data.isClickEnabled:true;
        }

        private function updateLayout() : void
        {
            this.bg.width = _width;
            this.bg.height = _height;
            this.descTf.width = _width - PADDING_DESC | 0;
            App.utils.commons.updateTextFieldSize(this.descTf,false,true);
            var _loc1_:* = _height - GAP_TOP_ICON - this.icon.height - GAP_ICON_DESC - this.titleTf.height - this.descTf.height - GAP_DESC_BTN - this.okBtn.height >> 1;
            this.icon.x = _width - this.icon.width >> 1;
            this.titleTf.x = _width - this.titleTf.width >> 1;
            this.descTf.x = PADDING_DESC >> 1;
            this.okBtn.x = _width - this.okBtn.width >> 1;
            this.icon.y = _loc1_ + GAP_TOP_ICON;
            _loc1_ = _loc1_ + (this.icon.height + GAP_TOP_ICON + GAP_ICON_DESC);
            this.titleTf.y = _loc1_;
            _loc1_ = _loc1_ + this.titleTf.height;
            this.descTf.y = _loc1_;
            _loc1_ = _loc1_ + (this.descTf.height + GAP_DESC_BTN);
            this.okBtn.y = _loc1_;
        }

        private function onIconCompleteHandler(param1:UILoaderEvent) : void
        {
            invalidate(InvalidationType.SIZE);
        }
    }
}
