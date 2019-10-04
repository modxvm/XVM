package net.wg.gui.lobby.storage.categories.cards
{
    import net.wg.utils.StageSizeBoundaries;
    import flash.geom.Rectangle;

    public class CardSizeConfig extends Object
    {

        private static const CARD_SIZES_BY_RESOLUTION:Object = {};

        public static const ALLOW_CARDS_RESOLUTION:Array = [StageSizeBoundaries.WIDTH_1024,StageSizeBoundaries.WIDTH_1366,StageSizeBoundaries.WIDTH_1600,StageSizeBoundaries.WIDTH_1920];

        {
            CARD_SIZES_BY_RESOLUTION[StageSizeBoundaries.WIDTH_1024] = new CardSizeVO(new Rectangle(0,0,260,171),new Rectangle(12,12,260 - 8 - 12 - 2,171 - 8 - 12 - 2),16,new Rectangle(0,0,144,108),0,0);
            CARD_SIZES_BY_RESOLUTION[StageSizeBoundaries.WIDTH_1366] = new CardSizeVO(new Rectangle(0,0,260,171),new Rectangle(12,12,260 - 8 - 12 - 2,171 - 8 - 12 - 2),16,new Rectangle(0,0,144,108),0,0);
            CARD_SIZES_BY_RESOLUTION[StageSizeBoundaries.WIDTH_1600] = new CardSizeVO(new Rectangle(0,0,312,205),new Rectangle(12,12,312 - 14 - 12,205 - 11 - 12),19,new Rectangle(0,0,180,135),0,8);
            CARD_SIZES_BY_RESOLUTION[StageSizeBoundaries.WIDTH_1920] = new CardSizeVO(new Rectangle(0,0,312,205),new Rectangle(12,12,312 - 14 - 12,205 - 11 - 12),19,new Rectangle(0,0,180,135),0,8);
        }

        public function CardSizeConfig()
        {
            super();
        }

        public static function getConfig(param1:int) : CardSizeVO
        {
            return CARD_SIZES_BY_RESOLUTION[param1];
        }
    }
}
