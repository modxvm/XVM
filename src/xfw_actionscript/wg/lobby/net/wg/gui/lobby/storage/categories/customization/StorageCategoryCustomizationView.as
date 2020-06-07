package net.wg.gui.lobby.storage.categories.customization
{
    import net.wg.infrastructure.base.meta.impl.StorageCategoryCustomizationViewMeta;
    import net.wg.infrastructure.base.meta.IStorageCategoryCustomizationViewMeta;
    import flash.text.TextField;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.data.ListDAAPIDataProvider;
    import net.wg.gui.lobby.storage.categories.cards.CustomizationCardVO;
    import flash.text.TextFieldAutoSize;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.lobby.storage.categories.cards.CardEvent;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;

    public class StorageCategoryCustomizationView extends StorageCategoryCustomizationViewMeta implements IStorageCategoryCustomizationViewMeta
    {

        public var title:TextField;

        public function StorageCategoryCustomizationView()
        {
            super();
        }

        override protected function getNewCardDP() : IDataProvider
        {
            return new ListDAAPIDataProvider(CustomizationCardVO);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.title.autoSize = TextFieldAutoSize.LEFT;
            this.title.text = STORAGE.CUSTOMIZATION_SECTIONTITLE;
            this.title.mouseWheelEnabled = this.title.mouseEnabled = false;
            carousel.scrollList.itemRendererClassReference = Linkages.CUSTOMIZATION_CARD_RENDERER;
            carousel.addEventListener(CardEvent.PREVIEW,this.onCardPreviewHandler);
        }

        override protected function onDispose() : void
        {
            noItemsView.removeEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
            carousel.removeEventListener(CardEvent.PREVIEW,this.onCardPreviewHandler);
            this.title = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.title.x = carousel.x;
            }
        }

        override protected function initNoItemsView() : void
        {
            noItemsView.setTexts(STORAGE.CUSTOMIZATION_NOITEMS_TITLE,STORAGE.CUSTOMIZATION_NOITEMS_NAVIGATIONBUTTON);
            noItemsView.addEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
        }

        private function onCardPreviewHandler(param1:CardEvent) : void
        {
            param1.stopImmediatePropagation();
            var _loc2_:CustomizationCardVO = param1.data as CustomizationCardVO;
            if(_loc2_ != null)
            {
                previewItemS(_loc2_.id,_loc2_.vehicleCD);
            }
        }

        override protected function onCardSellHandler(param1:CardEvent) : void
        {
            param1.stopImmediatePropagation();
            var _loc2_:CustomizationCardVO = param1.data as CustomizationCardVO;
            if(_loc2_ != null)
            {
                sellCustomizationItemS(_loc2_.id,_loc2_.vehicleCD);
            }
        }

        private function onNoItemViewCloseHandler(param1:Event) : void
        {
            navigateToCustomizationS();
        }
    }
}
