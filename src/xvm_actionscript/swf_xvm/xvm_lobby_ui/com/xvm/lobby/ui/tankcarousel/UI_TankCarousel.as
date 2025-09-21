/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.tankcarousel
{
    import flash.geom.Rectangle;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.generated.HANGAR_ALIASES;
    import net.wg.data.constants.generated.PROFILE_DROPDOWN_KEYS;
    import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.dossier.AccountDossier;
    import com.xvm.types.cfg.CCarousel;

    public class UI_TankCarousel extends TankCarouselUI
    {
        private static const THRESHOLD:int = 650;

        private var _cfg:CCarousel;
        private var _enabled:Boolean = false;
        private var _rowCount:int = 2;

        
        //
        // Init
        //
        
        public function UI_TankCarousel()
        {
            super();
            _init();
        }
        
        private function _init():void
        {
            _cfg = Config.config.hangar.carousel;
            _enabled = Macros.FormatBooleanGlobal(_cfg.enabled, true);
            
            if (!_enabled)
            {
                return;
            }
            
            try
            {
                Dossier.requestAccountDossier(this, onAccountDossierLoaded, PROFILE_DROPDOWN_KEYS.ALL);
                startFadeMask.alpha = endFadeMask.alpha = Macros.FormatNumberGlobal(Config.config.hangar.carousel.edgeFadeAlpha, 100) / 100.0;
                background.alpha = Macros.FormatNumberGlobal(_cfg.backgroundAlpha, 100) / 100.0;
                CLIENT::LESTA {
                    tiledBackgroundTop.alpha = Macros.FormatNumberGlobal(_cfg.backgroundAlpha, 100) / 100.0;
                    tiledBackgroundCenter.alpha = Macros.FormatNumberGlobal(_cfg.backgroundAlpha, 100) / 100.0;
                }
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        
        //
        // Override Public
        //
        
        override public function as_rowCount(rows:int):void
        {
            if (_enabled && !isNaN(_cfg.rows) && _cfg.rows > 0)
            {
                rows = _cfg.rows;
            }
            this._rowCount = rows;
            super.as_rowCount(rows);
        }

        override public function as_useExtendedCarousel(value:Boolean):void 
        {
            super.as_useExtendedCarousel(_enabled ? false : value);
        }

        override public function get isSmall():Boolean
        {
            return !(this.helper is TankCarouselHelper && this._rowCount > 1);
        }

        override public function set isUiEffectsEnabled(value:Boolean):void
        {
            if (!_enabled)
            {
                super.isUiEffectsEnabled = value;
                return;
            }

            background.alpha = Macros.FormatNumberGlobal(_cfg.backgroundAlpha, 100) / 100.0;
        }

        override public function getRectangles():Vector.<Rectangle>
        {
            return (_enabled && background.alpha < 1) ? null : super.getRectangles();
        }

        //
        // Override Protected
        //
        
        override protected function configUI():void
        {
            super.configUI();
            if (_enabled)
            {
                try
                {
                    setupMouseWheelScrollingSpeed();
                    setupFilters();
                }
                catch (ex:Error)
                {
                    Logger.err(ex);
                }
            }
        }
        
        override protected function getNewHelper():ITankCarouselHelper
        {
            if (!_enabled)
            {
                return super.getNewHelper();
            }

            var newHelper:ITankCarouselHelper = this.helper;

            try {
                var cellType:String = StringUtils.trim(_cfg.cellType.toLowerCase());

                if (cellType != "small")
                {
                    if (cellType != "normal")
                    {
                        CLIENT::WG {
                            cellType = this.smallDoubleCarouselEnable ? "small" : "normal";
                        }
                        CLIENT::LESTA {
                            cellType = this.isSmallDoubleCarouselEnabled ? "small" : "normal";
                        }
                    }
                }

                switch (cellType)
                {
                    case "small":
                        if (!(newHelper is SmallTankCarouselHelper))
                        {
                            newHelper = new SmallTankCarouselHelper(_cfg.small);
                            invalidate(InvalidationType.SETTINGS);
                        }
                        break;
                    case "normal":
                        if (!(newHelper is TankCarouselHelper))
                        {
                            newHelper = new TankCarouselHelper(_cfg.normal);
                            invalidate(InvalidationType.SETTINGS);
                        }
                        break;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
                return super.getNewHelper();
            }

            return newHelper;
        }


        //
        // Private
        //
   
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
            scrollList.scrollConfig.mouseWheelScrollPercent = Macros.FormatNumberGlobal(_cfg.scrollingSpeed, 1);
            scrollList.scrollConfig = scrollList.scrollConfig; // reinitialize
        }

        // config: "filters"
        private function setupFilters():void
        {
            if (!_cfg.filters.params.enabled)
            {
                this.vehicleFilters.listHotFilter.height += vehicleFilters.paramsFilter.height;
                this.vehicleFilters.listHotFilter.y = vehicleFilters.paramsFilter.y;
                vehicleFilters.paramsFilter.visible = false;
            }
        }
    }
}
