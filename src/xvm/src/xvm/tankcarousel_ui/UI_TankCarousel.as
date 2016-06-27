/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.tankcarousel_ui
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.dossier.*;
    import com.xvm.types.cfg.*;
    import flash.utils.*;
    import net.wg.data.constants.generated.*;

    public dynamic class UI_TankCarousel extends TankCarouselUI
    {
        private var cfg:CCarousel;

        public function UI_TankCarousel()
        {
            //Logger.add(getQualifiedClassName(this));
            super();

            this.cfg = Config.config.hangar.carousel;

            if (Macros.FormatBooleanGlobal(Config.config.hangar.carousel.enabled, true))
            {
                init();
            }
        }

        override protected function configUI():void
        {
            super.configUI();
        }

        // PRIVATE

        private function init():void
        {
            Dossier.requestAccountDossier(this, onAccountDossierLoaded, PROFILE_DROPDOWN_KEYS.ALL);
            itemRenderer = getQualifiedClassName(UI_TankCarouselItemRenderer);
        }

        private function onAccountDossierLoaded():void
        {
            var dossier:AccountDossier = Dossier.getAccountDossier();
            //Logger.addObject(dossier);
            if (dossier != null)
            {
                for (var vehCD:String in dossier.vehicles)
                    Dossier.requestVehicleDossier(null, null, PROFILE_DROPDOWN_KEYS.ALL, parseInt(vehCD));
            }
            invalidateData();
        }
    }
}
