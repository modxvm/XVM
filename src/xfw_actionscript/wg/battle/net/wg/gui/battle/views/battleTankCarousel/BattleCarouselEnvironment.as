package net.wg.gui.battle.views.battleTankCarousel
{
    import net.wg.gui.components.carousels.CarouselEnvironment;
    import net.wg.gui.battle.views.battleTankCarousel.data.BattleVehicleCarouselVO;

    public class BattleCarouselEnvironment extends CarouselEnvironment
    {

        public function BattleCarouselEnvironment()
        {
            super();
        }

        override protected function getRendererVo() : Class
        {
            return BattleVehicleCarouselVO;
        }
    }
}
