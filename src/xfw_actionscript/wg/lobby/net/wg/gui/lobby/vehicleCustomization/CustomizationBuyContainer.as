package net.wg.gui.lobby.vehicleCustomization
{
    import flash.display.Sprite;
    import net.wg.gui.interfaces.IContentSize;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.vehicleCustomization.controls.slotsGroup.CustomizationSlotsLayout;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.BuyWindowTittlesVO;

    public class CustomizationBuyContainer extends Sprite implements IContentSize, IDisposable
    {

        private static const OFFSET:int = 17;

        private static const OFFSET_SMALL:int = -18;

        private static const SCROLL_GAP:int = 20;

        public var summerSeason:CustomizationSeasonBuyRenderer = null;

        public var winterSeason:CustomizationSeasonBuyRenderer = null;

        public var dustSeason:CustomizationSeasonBuyRenderer = null;

        public function CustomizationBuyContainer()
        {
            super();
            this.summerSeason.seasonIcon.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_ITEMS_POPOVER_SUMMER16X16;
            this.winterSeason.seasonIcon.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_ITEMS_POPOVER_WINTER16X16;
            this.dustSeason.seasonIcon.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_ITEMS_POPOVER_DESERT16X16;
        }

        public final function dispose() : void
        {
            this.summerSeason.dispose();
            this.summerSeason = null;
            this.winterSeason.dispose();
            this.winterSeason = null;
            this.dustSeason.dispose();
            this.dustSeason = null;
        }

        public function layoutContent() : void
        {
            var _loc1_:* = false;
            this.summerSeason.layoutContent();
            this.winterSeason.layoutContent();
            this.dustSeason.layoutContent();
            _loc1_ = false;
            if(App.appWidth <= CustomizationSlotsLayout.SMALL_SCREEN_WIDTH || App.appHeight < CustomizationSlotsLayout.SMALL_SCREEN_HEIGHT)
            {
                _loc1_ = true;
            }
            this.winterSeason.y = this.summerSeason.y + this.summerSeason.height;
            this.winterSeason.y = this.winterSeason.y + (_loc1_?OFFSET_SMALL:OFFSET);
            this.dustSeason.y = this.winterSeason.y + this.winterSeason.height;
            this.dustSeason.y = this.dustSeason.y + (_loc1_?OFFSET_SMALL:OFFSET);
        }

        public function setDataProviders(param1:DataProvider, param2:DataProvider, param3:DataProvider) : void
        {
            this.summerSeason.setDataProvider(param1);
            this.winterSeason.setDataProvider(param2);
            this.dustSeason.setDataProvider(param3);
            this.layoutContent();
        }

        public function setTitles(param1:BuyWindowTittlesVO) : void
        {
            this.summerSeason.updateTitleText(param1.summerTitle,param1.summerSmallTitle);
            this.winterSeason.updateTitleText(param1.winterTitle,param1.winterSmallTitle);
            this.dustSeason.updateTitleText(param1.desertTitle,param1.desertSmallTitle);
        }

        public function get contentWidth() : Number
        {
            return width;
        }

        public function get contentHeight() : Number
        {
            return height + SCROLL_GAP;
        }
    }
}
