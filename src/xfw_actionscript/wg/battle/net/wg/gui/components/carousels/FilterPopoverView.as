package net.wg.gui.components.carousels
{
    import net.wg.gui.components.controls.BlackButton;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.components.carousels.data.FilterCarouseInitVO;
    import net.wg.gui.components.popovers.PopOverConst;

    public class FilterPopoverView extends VehiclesFilterPopoverView
    {

        private static const DEFAULT_BTN_OFFSET:uint = 20;

        public var switchCarouselBtn:BlackButton = null;

        public function FilterPopoverView()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.switchCarouselBtn.toggleEnable = true;
            this.switchCarouselBtn.addEventListener(ButtonEvent.CLICK,this.onSwitchCarouselBtnClickHandler);
        }

        override protected function onDispose() : void
        {
            this.switchCarouselBtn.removeEventListener(ButtonEvent.CLICK,this.onSwitchCarouselBtnClickHandler);
            this.switchCarouselBtn.dispose();
            this.switchCarouselBtn = null;
            super.onDispose();
        }

        override protected function setInitData(param1:FilterCarouseInitVO) : void
        {
            super.setInitData(param1);
            this.switchCarouselBtn.iconSource = initData.toggleSwitchCarouselIcon;
            this.switchCarouselBtn.tooltip = initData.toggleSwitchCarouselTooltip;
            this.switchCarouselBtn.selected = initData.toggleSwitchCarouselSelected;
            this.switchCarouselBtn.visible = initData.searchSectionVisible;
        }

        override protected function getPreferredLayout() : int
        {
            return PopOverConst.ARROW_BOTTOM;
        }

        override protected function initLayout() : void
        {
            popoverLayout.preferredLayout = this.getPreferredLayout();
            super.initLayout();
        }

        override protected function updateSize() : void
        {
            super.updateSize();
            if(initData != null && initData.searchSectionVisible)
            {
                this.switchCarouselBtn.y = separatorBottom.y + separatorBottom.height + DEFAULT_BTN_OFFSET;
                currentPopoverHeight = this.switchCarouselBtn.y + this.switchCarouselBtn.height + PADDING;
            }
            setViewSize(width,currentPopoverHeight);
        }

        private function onSwitchCarouselBtnClickHandler(param1:ButtonEvent) : void
        {
            this.switchCarouselBtn.selected = !this.switchCarouselBtn.selected;
            switchCarouselTypeS(this.switchCarouselBtn.selected);
        }
    }
}
