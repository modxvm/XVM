package net.wg.gui.lobby.storage.categories.customization
{
    import net.wg.infrastructure.base.meta.impl.StorageCategoryCustomizationViewMeta;
    import net.wg.infrastructure.base.meta.IStorageCategoryCustomizationViewMeta;
    import net.wg.gui.lobby.storage.categories.NoItemsView;
    import flash.text.TextField;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.data.ListDAAPIDataProvider;
    import net.wg.gui.lobby.storage.categories.cards.BaseCardVO;
    import scaleform.clik.core.UIComponent;
    import flash.events.Event;
    import net.wg.gui.lobby.storage.categories.cards.CardEvent;
    import flash.text.TextFieldAutoSize;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.constants.InvalidationType;

    public class StorageCategoryCustomizationView extends StorageCategoryCustomizationViewMeta implements IStorageCategoryCustomizationViewMeta
    {

        private static const CAROUSEL_TOP_OFFSET:int = 10;

        private static const CAROUSEL_BOTTOM_OFFSET:int = 30;

        public var noItemsView:NoItemsView;

        public var title:TextField;

        public function StorageCategoryCustomizationView()
        {
            super();
        }

        override protected function getNewCardDP() : IDataProvider
        {
            return new ListDAAPIDataProvider(BaseCardVO);
        }

        override public function get noItemsComponent() : UIComponent
        {
            return this.noItemsView;
        }

        override protected function onDispose() : void
        {
            this.noItemsView.removeEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
            carousel.removeEventListener(CardEvent.SELL,this.onCardSellHandler);
            this.noItemsView.dispose();
            this.noItemsView = null;
            this.title = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.title.autoSize = TextFieldAutoSize.LEFT;
            this.title.text = STORAGE.CUSTOMIZATION_SECTIONTITLE;
            this.title.mouseWheelEnabled = this.title.mouseEnabled = false;
            this.noItemsView.setTexts(STORAGE.CUSTOMIZATION_NOITEMS_TITLE,STORAGE.CUSTOMIZATION_NOITEMS_NAVIGATIONBUTTON);
            this.noItemsView.addEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
            carousel.scrollList.itemRendererClassReference = Linkages.CUSTOMIZATION_CARD_RENDERER;
            carousel.scrollList.paddingTop = CAROUSEL_TOP_OFFSET;
            carousel.scrollList.paddingBottom = CAROUSEL_BOTTOM_OFFSET;
            carousel.addEventListener(CardEvent.SELL,this.onCardSellHandler);
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.title.x = carousel.x;
                _loc1_ = this.title.y + this.title.height;
                this.noItemsView.width = width;
                this.noItemsView.validateNow();
                this.noItemsView.y = _loc1_ + (height - _loc1_ - this.noItemsView.actualHeight >> 1);
            }
        }

        private function onCardSellHandler(param1:CardEvent) : void
        {
            param1.stopImmediatePropagation();
            sellItemS(param1.data.id);
        }

        private function onNoItemViewCloseHandler(param1:Event) : void
        {
            navigateToCustomizationS();
        }
    }
}
