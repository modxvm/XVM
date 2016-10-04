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
        private static const THRESHOLD:int = 650;

        private var cfg:CCarousel;
        private var _enabled:Boolean = false;
        private var _rowCount:int = 1;

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
            _rowCount = rows;
            super.as_rowCount(rows);
        }

        override protected function getNewHelper():ITankCarouselHelper
        {
            if (_enabled)
            {
                try
                {
                var cellType:String = StringUtils.trim(cfg.cellType.toLowerCase());
                if (cellType != "small" && cellType != "normal")
                {
                    var normalHelper:TankCarouselHelper = new TankCarouselHelper(cfg.normal);
                    var h:int = (normalHelper.gap + normalHelper.rendererHeight) * _rowCount - normalHelper.gap;
                    if (App.appHeight - h < THRESHOLD)
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

        // PRIVATE

        private function init():void
        {
            try
            {
                Dossier.requestAccountDossier(this, onAccountDossierLoaded, PROFILE_DROPDOWN_KEYS.ALL);

                leftFadeEndItem.visible = rightFadeEndItem.visible = false;
                background.alpha = Macros.FormatNumberGlobal(cfg.backgroundAlpha, 100) / 100.0;
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

import com.xvm.*;
import com.xvm.lobby.ui.tankcarousel.*;
import com.xvm.types.cfg.*;
import flash.utils.*;
import net.wg.data.constants.*;
import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
import net.wg.infrastructure.exceptions.*;
import scaleform.clik.utils.Padding;

class TankCarouselHelperBase extends Object implements ITankCarouselHelper
{
    private var _gap:int;
    private var _padding:Padding;
    private var _width:int;
    private var _height:int;

    function TankCarouselHelperBase(cfg:CCarouselCell)
    {
        _gap = Macros.FormatNumberGlobal(cfg.gap, DEFAULT_GAP);
        _padding = new Padding(gap);
        _width = Macros.FormatNumberGlobal(cfg.width, DEFAULT_WIDTH - 2) + 2;
        _height = Macros.FormatNumberGlobal(cfg.height, DEFAULT_HEIGHT - 2) + 2;
    }

    public function get linkRenderer():String
    {
        throw new AbstractException("TankCarouselHelperBase.linkRenderer " + Errors.ABSTRACT_INVOKE);
    }

    public function get rendererWidth():Number
    {
        return _width;
    }

    public function get rendererHeight():Number
    {
        return _height;
    }

    public function get gap():Number
    {
        return _gap;
    }

    public function get padding():Padding
    {
        return _padding;
    }

    // protected

    protected function get DEFAULT_GAP():int
    {
        return 10;
    }

    protected function get DEFAULT_WIDTH():int
    {
        throw new AbstractException("TankCarouselHelperBase.DEFAULT_WIDTH " + Errors.ABSTRACT_INVOKE);
    }

    protected function get DEFAULT_HEIGHT():int
    {
        throw new AbstractException("TankCarouselHelperBase.DEFAULT_HEIGHT " + Errors.ABSTRACT_INVOKE);
    }
}

class TankCarouselHelper extends TankCarouselHelperBase implements ITankCarouselHelper
{
    function TankCarouselHelper(cfg:CCarouselCell)
    {
        super(cfg);
    }

    override public function get linkRenderer():String
    {
        return getQualifiedClassName(UI_TankCarouselItemRenderer);
    }

    // PROTECTED

    override protected function get DEFAULT_WIDTH():int
    {
        return UI_TankCarouselItemRenderer.DEFAULT_WIDTH;
    }

    override protected function get DEFAULT_HEIGHT():int
    {
        return UI_TankCarouselItemRenderer.DEFAULT_HEIGHT;
    }
}

class SmallTankCarouselHelper extends TankCarouselHelperBase implements ITankCarouselHelper
{
    function SmallTankCarouselHelper(cfg:CCarouselCell)
    {
        super(cfg);
    }

    override public function get linkRenderer():String
    {
        return getQualifiedClassName(UI_SmallTankCarouselItemRenderer);
    }

    // PROTECTED

    override protected function get DEFAULT_WIDTH():int
    {
        return UI_SmallTankCarouselItemRenderer.DEFAULT_WIDTH;
    }

    override protected function get DEFAULT_HEIGHT():int
    {
        return UI_SmallTankCarouselItemRenderer.DEFAULT_HEIGHT;
    }
}
