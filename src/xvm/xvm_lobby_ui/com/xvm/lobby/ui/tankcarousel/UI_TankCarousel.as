/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.tankcarousel
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
        private var _enabled:Boolean = false;

        public function UI_TankCarousel()
        {
            //Logger.add(getQualifiedClassName(this));
            super();

            this.cfg = Config.config.hangar.carousel;

            _enabled = Macros.FormatBooleanGlobal(Config.config.hangar.carousel.enabled, true);
            if (_enabled)
            {
                init();
            }
        }

        override protected function configUI():void
        {
            super.configUI();
            if (_enabled)
            {
                try
                {
                    setupMouseWheelScrollingSpeed();
                    setupPadding();
                    setupBackgroundAlpha();
                    setupFilters();
                }
                catch (ex:Error)
                {
                    Logger.err(ex);
                }
            }
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
            if (dossier)
            {
                for (var vehCD:String in dossier.vehicles)
                    Dossier.requestVehicleDossier(null, null, PROFILE_DROPDOWN_KEYS.ALL, parseInt(vehCD));
            }
            invalidateData();
        }

        // config: "scrollingSpeed"
        private function setupMouseWheelScrollingSpeed():void
        {
            scrollList.scrollConfig.mouseWheelScrollPercent = Macros.FormatNumberGlobal(cfg.scrollingSpeed, 1);
            scrollList.scrollConfig = scrollList.scrollConfig; // reinitialize
        }

        // config: "padding"
        private function setupPadding():void
        {
            var horizontalPadding:Number = Macros.FormatNumberGlobal(cfg.padding.horizontal, scrollList.gap);
            scrollList.gap = horizontalPadding;

            // TODO: cfg.padding.vertical
        }

        // config: "backgroundAlpha"
        private function setupBackgroundAlpha():void
        {
            // background alpha
            background.alpha = Macros.FormatNumberGlobal(cfg.backgroundAlpha, background.alpha) / 100.0;
        }

        // config: "filters"
        private function setupFilters():void
        {
            // TODO: broken, is required?
            /*
            vehicleFilters.validateNow();
            if (!cfg.filters.params.enabled)
                resetFiltersS();
            if (!cfg.filters.bonus.enabled)
                vehicleFilters.bonusFilter.selected = false;
            if (!cfg.filters.favorite.enabled)
                vehicleFilters.favoriteFilter.selected = false;
            call_setVehiclesFilter();
            */
        }
    }
}
