package net.wg.gui.battle.views.battleTankCarousel
{
    import net.wg.gui.components.carousels.filters.TankCarouselFilters;
    import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;

    public class BattleTankCarouselFilters extends TankCarouselFilters
    {

        public function BattleTankCarouselFilters()
        {
            super();
        }

        override protected function showPopup() : void
        {
            popoverMgr.show(this,BATTLE_VIEW_ALIASES.BATTLE_TANK_CAROUSEL_FILTER_POPOVER);
        }
    }
}
