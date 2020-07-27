package net.wg.gui.lobby.storage.categories.storage
{
    import net.wg.infrastructure.base.meta.impl.ItemsWithTypeFilterTabViewMeta;
    import net.wg.gui.lobby.storage.categories.NoItemsView;
    import net.wg.gui.lobby.components.data.ButtonFiltersVO;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.data.ListDAAPIDataProvider;
    import net.wg.gui.lobby.storage.categories.cards.BaseCardVO;
    import net.wg.gui.events.FiltersEvent;
    import net.wg.gui.lobby.storage.categories.cards.CardEvent;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    import scaleform.clik.core.UIComponent;

    public class ItemsWithTypeFilterTabView extends ItemsWithTypeFilterTabViewMeta
    {

        private static const CAROUSEL_PADDING_TOP:int = 20;

        private static const CAROUSEL_PADDING_BOTTOM:int = 30;

        public var noItemsView:NoItemsView;

        public var filtersBlock:StorageTypeFilterBlock = null;

        public function ItemsWithTypeFilterTabView()
        {
            super();
        }

        override protected function hasNoFilterWarningView() : Boolean
        {
            return true;
        }

        override protected function doPartlyVisibility(param1:Boolean, param2:Boolean) : void
        {
            super.doPartlyVisibility(param1,param2);
            this.filtersBlock.visible = !param1;
        }

        override protected function initTypeFilter(param1:ButtonFiltersVO) : void
        {
            this.filtersBlock.initTypeFilter(param1);
        }

        override protected function getNewCardDP() : IDataProvider
        {
            return new ListDAAPIDataProvider(BaseCardVO);
        }

        override protected function onDispose() : void
        {
            this.disposeNoItemsView();
            this.noItemsView.dispose();
            this.noItemsView = null;
            this.filtersBlock.removeEventListener(FiltersEvent.FILTERS_CHANGED,this.onFiltersBlockFiltersChangedHandler);
            this.filtersBlock.removeEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onFiltersBlockResetAllFiltersHandler);
            this.filtersBlock.dispose();
            this.filtersBlock = null;
            carousel.removeEventListener(CardEvent.SELL,this.onCardSellHandler);
            carousel.removeEventListener(CardEvent.UPGRADE,this.onCardUpgradeHandler);
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            carousel.scrollList.itemRendererClassReference = Linkages.DEFAULT_CARD_RENDERER;
            carousel.scrollList.paddingTop = CAROUSEL_PADDING_TOP;
            carousel.scrollList.paddingBottom = CAROUSEL_PADDING_BOTTOM;
            carousel.addEventListener(CardEvent.SELL,this.onCardSellHandler);
            carousel.addEventListener(CardEvent.UPGRADE,this.onCardUpgradeHandler);
            this.initNoItemsView();
            this.filtersBlock.addEventListener(FiltersEvent.FILTERS_CHANGED,this.onFiltersBlockFiltersChangedHandler);
            this.filtersBlock.addEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onFiltersBlockResetAllFiltersHandler);
        }

        private function onCardUpgradeHandler(param1:CardEvent) : void
        {
            param1.stopImmediatePropagation();
            upgradeItemS(param1.data.id);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.filtersBlock.x = carousel.x;
                this.filtersBlock.width = carousel.width;
                this.noItemsView.width = width;
                this.noItemsView.validateNow();
                this.noItemsView.y = height - this.noItemsView.actualHeight >> 1;
            }
        }

        override protected function onDummyEvent(param1:String) : void
        {
            resetFilterS();
        }

        protected function onCardSellHandler(param1:CardEvent) : void
        {
            param1.stopImmediatePropagation();
            sellItemS(param1.data.id);
        }

        public function as_resetFilter(param1:int) : void
        {
            if(param1 >= 0)
            {
                this.filtersBlock.resetFilters(param1);
            }
        }

        public function as_updateCounter(param1:Boolean, param2:String, param3:Boolean) : void
        {
            this.filtersBlock.updateCounter(param1,param2,param3);
        }

        protected function initNoItemsView() : void
        {
            this.noItemsView.setTexts(STORAGE.STORAGE_NOITEMS_TITLE,STORAGE.STORAGE_NOITEMS_NAVIGATIONBUTTON);
            this.noItemsView.addEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
        }

        protected function disposeNoItemsView() : void
        {
            this.noItemsView.removeEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
        }

        override public function get noItemsComponent() : UIComponent
        {
            return this.noItemsView;
        }

        private function onFiltersBlockFiltersChangedHandler(param1:FiltersEvent) : void
        {
            onFiltersChangeS(param1.filtersValue);
        }

        private function onFiltersBlockResetAllFiltersHandler(param1:FiltersEvent) : void
        {
            resetFilterS();
        }

        private function onNoItemViewCloseHandler(param1:Event) : void
        {
            navigateToStoreS();
        }
    }
}
