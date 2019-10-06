package net.wg.gui.lobby.store.actions.data
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.data.constants.generated.STORE_CONSTANTS;
    import net.wg.gui.lobby.store.actions.cards.StoreActionDiscount;

    public class CardsSettings extends Object implements IDisposable
    {

        private static const ASSERT_NO_SETTINGS:String = "Didn\'t find settings for cardId: ";

        public var heroCardSettings:CardSettings = null;

        public var normalCardSettings:CardSettings = null;

        public var smallCardSettings:CardSettings = null;

        public var comingSoonCardSettings:CardSettings = null;

        public function CardsSettings()
        {
            super();
            this.heroCardSettings = new CardSettings();
            this.heroCardSettings.cardId = STORE_CONSTANTS.ACTION_CARD_HERO_LINKAGE;
            this.heroCardSettings.permanentWidth = 950;
            this.heroCardSettings.permanentHeight = 500;
            this.heroCardSettings.cardBottomMargin = 15;
            this.heroCardSettings.cardLeftMargin = 18;
            this.heroCardSettings.contentRightPadding = 0;
            this.heroCardSettings.contentAvailableHeight = 315;
            this.heroCardSettings.timeLeftRightShift = -22;
            this.heroCardSettings.gapFromTitleToTimeLeft = 150;
            this.heroCardSettings.marginFromHeaderToDescriptionText = 27;
            this.heroCardSettings.marginFromHeaderToDescriptionTable = 27;
            this.heroCardSettings.discountFrameLabel = StoreActionDiscount.LABEL_HERO;
            this.heroCardSettings.isUsePictureAnim = false;
            this.heroCardSettings.isUseDiscountAnim = false;
            this.heroCardSettings.isUseDescrAnim = false;
            this.normalCardSettings = new CardSettings();
            this.normalCardSettings.cardId = STORE_CONSTANTS.ACTION_CARD_NORMAL_LINKAGE;
            this.normalCardSettings.permanentWidth = 470;
            this.normalCardSettings.permanentHeight = 418;
            this.normalCardSettings.cardBottomMargin = 18;
            this.normalCardSettings.cardLeftMargin = 20;
            this.normalCardSettings.contentRightPadding = -20;
            this.normalCardSettings.contentAvailableHeight = 230;
            this.normalCardSettings.timeLeftRightShift = -23;
            this.normalCardSettings.gapFromTitleToTimeLeft = 50;
            this.normalCardSettings.marginFromHeaderToDescriptionText = 20;
            this.normalCardSettings.marginFromHeaderToDescriptionTable = 25;
            this.normalCardSettings.discountFrameLabel = StoreActionDiscount.LABEL_NORMAL;
            this.normalCardSettings.selectFrameLabel = STORE_CONSTANTS.ACTION_CARD_NORMAL_SELECT_FRAME_LABEL;
            this.normalCardSettings.pictureScale = 0.72;
            this.smallCardSettings = new CardSettings();
            this.smallCardSettings.cardId = STORE_CONSTANTS.ACTION_CARD_SMALL_LINKAGE;
            this.smallCardSettings.permanentWidth = 470;
            this.smallCardSettings.permanentHeight = 200;
            this.smallCardSettings.cardBottomMargin = 18;
            this.smallCardSettings.cardLeftMargin = 20;
            this.smallCardSettings.contentRightPadding = -18;
            this.smallCardSettings.contentAvailableHeight = 76;
            this.smallCardSettings.timeLeftRightShift = -17;
            this.smallCardSettings.gapFromTitleToTimeLeft = 50;
            this.smallCardSettings.marginFromHeaderToDescriptionText = 0;
            this.smallCardSettings.marginFromHeaderToDescriptionTable = 0;
            this.smallCardSettings.discountFrameLabel = StoreActionDiscount.LABEL_SMALL;
            this.smallCardSettings.selectFrameLabel = STORE_CONSTANTS.ACTION_CARD_SMALL_SELECT_FRAME_LABEL;
            this.smallCardSettings.pictureScale = 0.5;
            this.comingSoonCardSettings = new CardSettings();
            this.comingSoonCardSettings.cardId = STORE_CONSTANTS.ACTION_COMING_SOON_LINKAGE;
            this.comingSoonCardSettings.permanentWidth = 700;
            this.comingSoonCardSettings.permanentHeight = 70;
            this.comingSoonCardSettings.pictureScale = 0.35;
        }

        public final function dispose() : void
        {
            this.heroCardSettings = null;
            this.normalCardSettings = null;
            this.smallCardSettings = null;
            this.comingSoonCardSettings = null;
        }

        public function getSettingsById(param1:String) : CardSettings
        {
            if(param1 == STORE_CONSTANTS.ACTION_CARD_HERO_LINKAGE)
            {
                return this.heroCardSettings;
            }
            if(param1 == STORE_CONSTANTS.ACTION_CARD_NORMAL_LINKAGE)
            {
                return this.normalCardSettings;
            }
            if(param1 == STORE_CONSTANTS.ACTION_CARD_SMALL_LINKAGE)
            {
                return this.smallCardSettings;
            }
            if(param1 == STORE_CONSTANTS.ACTION_COMING_SOON_LINKAGE)
            {
                return this.comingSoonCardSettings;
            }
            App.utils.asserter.assert(false,ASSERT_NO_SETTINGS + param1);
            return null;
        }
    }
}
