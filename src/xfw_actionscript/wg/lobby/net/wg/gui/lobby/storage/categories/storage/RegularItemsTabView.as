package net.wg.gui.lobby.storage.categories.storage
{
    import net.wg.infrastructure.base.meta.impl.RegularItemsTabViewMeta;
    import net.wg.infrastructure.base.meta.IRegularItemsTabViewMeta;
    import net.wg.gui.lobby.storage.categories.NoItemsView;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.data.ListDAAPIDataProvider;
    import net.wg.gui.lobby.storage.categories.cards.BaseCardVO;
    import flash.events.Event;
    import net.wg.gui.lobby.storage.categories.cards.CardEvent;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.core.UIComponent;

    public class RegularItemsTabView extends RegularItemsTabViewMeta implements IRegularItemsTabViewMeta
    {

        private static const CAROUSEL_PADDING_TOP:int = 5;

        private static const CAROUSEL_PADDING_BOTTOM:int = 30;

        public var noItemsView:NoItemsView;

        public function RegularItemsTabView()
        {
            super();
        }

        override protected function getNewCardDP() : IDataProvider
        {
            return new ListDAAPIDataProvider(BaseCardVO);
        }

        override protected function onDispose() : void
        {
            this.noItemsView.removeEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
            this.noItemsView.dispose();
            this.noItemsView = null;
            carousel.removeEventListener(CardEvent.SELL,this.onCardSellHandler);
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            carousel.scrollList.itemRendererClassReference = Linkages.DEFAULT_CARD_RENDERER;
            carousel.scrollList.paddingTop = CAROUSEL_PADDING_TOP;
            carousel.scrollList.paddingBottom = CAROUSEL_PADDING_BOTTOM;
            carousel.addEventListener(CardEvent.SELL,this.onCardSellHandler);
            this.noItemsView.setTexts(STORAGE.STORAGE_NOITEMS_TITLE,STORAGE.STORAGE_NOITEMS_NAVIGATIONBUTTON);
            this.noItemsView.addEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.noItemsView.width = width;
                this.noItemsView.validateNow();
                this.noItemsView.y = height - this.noItemsView.actualHeight >> 1;
            }
        }

        override public function get noItemsComponent() : UIComponent
        {
            return this.noItemsView;
        }

        private function onCardSellHandler(param1:CardEvent) : void
        {
            param1.stopImmediatePropagation();
            sellItemS(param1.data.id);
        }

        private function onNoItemViewCloseHandler(param1:Event) : void
        {
            navigateToStoreS();
        }
    }
}
