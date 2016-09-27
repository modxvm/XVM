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
    import flash.display.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.lobby.hangar.tcarousel.helper.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.utils.*;
    import org.idmedia.as3commons.util.*;

    public /*dynamic*/ class UI_TankCarousel extends TankCarouselUI
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
                if (!isNaN(cfg.rows) && cfg.rows > 0)
                {
                    rows = cfg.rows;
                }
            }
            super.as_rowCount(rows);
        }

        override protected function getNewHelper():ITankCarouselHelper
        {
            if (_enabled)
            {
                var cellType:String = StringUtils.trim(cfg.cellType.toLowerCase());
                if (cellType != "small" && cellType != "normal")
                {
                    if (super.getNewHelper().linkRenderer == "SmallTankCarouselItemRendererUI")
                    {
                        cellType = "small";
                    }
                    else
                    {
                        cellType = "normal";
                    }
                }

                var newHelper:ITankCarouselHelper = this.helper;
                switch (cellType)
                {
                    case "small":
                        if (!(newHelper is SmallTankCarouselHelper))
                        {
                            newHelper = new SmallTankCarouselHelper();
                            invalidate(InvalidationType.SETTINGS);
                        }
                        break;
                    case "normal":
                        if (!(newHelper is TankCarouselHelper))
                        {
                            newHelper = new TankCarouselHelper();
                            invalidate(InvalidationType.SETTINGS);
                        }
                        break;
                }

                return newHelper;
            }
            else
            {
                return super.getNewHelper();
            }
        }

        // PRIVATE

        private function init():void
        {
            try
            {
                Dossier.requestAccountDossier(this, onAccountDossierLoaded, PROFILE_DROPDOWN_KEYS.ALL);

                leftFadeEndItem.visible = rightFadeEndItem.visible = false;
                background.alpha = Macros.FormatNumberGlobal(cfg.backgroundAlpha, 100) / 100.0;

                TankCarouselHelper.PADDING = SmallTankCarouselHelper.PADDING = new Padding(
                    Macros.FormatNumberGlobal(cfg.padding.vertical, TankCarouselHelper.PADDING.vertical) / 2.0,
                    Macros.FormatNumberGlobal(cfg.padding.horizontal, TankCarouselHelper.PADDING.horizontal) / 2.0);
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

import com.xvm.lobby.ui.tankcarousel.*;
import flash.utils.*;
import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
import scaleform.clik.utils.Padding;

class TankCarouselHelper extends Object implements ITankCarouselHelper
{
    public static var PADDING:Padding = new Padding(10);

    function TankCarouselHelper()
    {
        super();
    }

    public function get linkRenderer() : String
    {
        return getQualifiedClassName(UI_TankCarouselItemRenderer);
    }

    public function get rendererWidth() : Number
    {
        return 162;
    }

    public function get rendererHeight() : Number
    {
        return 102;
    }

    public function get gap() : Number
    {
        return PADDING.horizontal / 2;
    }

    public function get padding() : Padding
    {
        return PADDING;
    }
}

import com.xvm.lobby.ui.tankcarousel.*;
import flash.utils.*;
import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
import scaleform.clik.utils.Padding;

class SmallTankCarouselHelper extends Object implements ITankCarouselHelper
{
    public static var PADDING:Padding = new Padding(10);

    function SmallTankCarouselHelper()
    {
        super();
    }

    public function get linkRenderer() : String
    {
        return getQualifiedClassName(UI_SmallTankCarouselItemRenderer);
    }

    public function get rendererWidth() : Number
    {
        return 162;
    }

    public function get rendererHeight() : Number
    {
        return 37;
    }

    public function get gap() : Number
    {
        return PADDING.horizontal / 2;
    }

    public function get padding() : Padding
    {
        return PADDING;
    }
}
