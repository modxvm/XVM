/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.tankcarousel
{
    import flash.geom.Rectangle;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.generated.PROFILE_DROPDOWN_KEYS;
    import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import com.xfw.Logger;
    import com.xvm.Config;
    import com.xvm.Dossier;
    import com.xvm.Macros;
    import com.xvm.types.dossier.AccountDossier;
    import com.xvm.types.cfg.CCarousel;

    public class UI_TankCarousel extends TankCarouselUI
    {
        private static const THRESHOLD:int = 650;
        private static const FRONTLINE_ROW_LIMIT:int = 2;

        private var cfg:CCarousel;
        private var _enabled:Boolean = false;
        private var _rowCount:int = 1;
        private var _frontline:Boolean = false; //TODO: handle it correctly

        public function UI_TankCarousel()
        {
            //Logger.add("UI_TankCarousel");
            super();
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init();
        }

        private function _init():void
        {
            cfg = Config.config.hangar.carousel;

            _enabled = Macros.FormatBooleanGlobal(cfg.enabled, true);
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
                    setupFilters();
                }
                catch (ex:Error)
                {
                    Logger.err(ex);
                }
            }
        }

        override public function as_rowCount(rows:int):void
        {
            if (_enabled)
            {
                if (!isNaN(cfg.rows))
                {
                    if (cfg.rows > 0)
                    {
                        rows = cfg.rows;
                        if (_frontline){
                            rows = Math.min(rows, FRONTLINE_ROW_LIMIT);
                        }
                    }
                }
            }
            _rowCount = rows;
            super.as_rowCount(_rowCount);
        }

        override protected function getNewHelper():ITankCarouselHelper
        {
            if (_enabled)
            {
                try
                {
                    var cellType:String = StringUtils.trim(cfg.cellType.toLowerCase());
                    if (cellType != "small")
                    {
                        if (cellType != "normal")
                        {
                            var normalHelper:TankCarouselHelper = new TankCarouselHelper(cfg.normal);
                            var h:int = (normalHelper.verticalGap + normalHelper.rendererHeight) * _rowCount - normalHelper.verticalGap;
                            if (App.appHeight - h < THRESHOLD)
                            {
                                cellType = "small";
                            }
                            else
                            {
                                cellType = "normal";
                            }
                        }
                    }

                    var newHelper:ITankCarouselHelper = this.helper;
                    switch (cellType)
                    {
                        case "small":
                            if (!(newHelper is SmallTankCarouselHelper))
                            {
                                newHelper = new SmallTankCarouselHelper(cfg.small);
                                invalidate(InvalidationType.SETTINGS);
                            }
                            break;
                        case "normal":
                            if (!(newHelper is TankCarouselHelper))
                            {
                                newHelper = new TankCarouselHelper(cfg.normal);
                                invalidate(InvalidationType.SETTINGS);
                            }
                            break;
                    }
                }
                catch (ex:Error)
                {
                        Logger.err(ex);
                }
                return newHelper;
            }
            else
            {
                return super.getNewHelper();
            }
        }

        override public function getRectangles():Vector.<Rectangle>
        {
            return (background.alpha < 1) ? null : super.getRectangles();
        }

        // PRIVATE

        private function init():void
        {
            try
            {
                Dossier.requestAccountDossier(this, onAccountDossierLoaded, PROFILE_DROPDOWN_KEYS.ALL);
                startFadeMask.alpha = endFadeMask.alpha = Macros.FormatNumberGlobal(Config.config.hangar.carousel.edgeFadeAlpha, 100) / 100.0;
                background.alpha = Macros.FormatNumberGlobal(cfg.backgroundAlpha, 100) / 100.0;
                dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
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

        // config: "filters"
        private function setupFilters():void
        {
            if (!cfg.filters.params.enabled)
            {
                this.vehicleFilters.listHotFilter.height += vehicleFilters.paramsFilter.height;
                this.vehicleFilters.listHotFilter.y = vehicleFilters.paramsFilter.y;
                vehicleFilters.paramsFilter.visible = false;
            }
        }
    }
}
