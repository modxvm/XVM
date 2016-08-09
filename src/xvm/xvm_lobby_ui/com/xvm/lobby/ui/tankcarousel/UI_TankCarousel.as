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
    import flash.display.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.components.carousels.HorizontalScrollerViewPort;
    import net.wg.gui.components.controls.SoundButton;
    import net.wg.gui.components.controls.scroller.IViewPort;
    import scaleform.clik.constants.*;

    public dynamic class UI_TankCarousel extends TankCarouselUI
    {
        private var cfg:CCarousel;
        private var _enabled:Boolean = false;

        private var _bg:MovieClip = null;
        private var _carousel_height:int;

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
                    setupScrollList();
                    setupFilters();
                }
                catch (ex:Error)
                {
                    Logger.err(ex);
                }
            }
        }

        override protected function onDispose():void
        {
            if (_bg)
            {
                _bg = null;
            }

            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if (isInvalid(InvalidationType.SIZE))
            {
                _bg.graphics.clear();
                _bg.graphics.beginFill(0x000000, cfg.backgroundAlpha / 100.0);
                _bg.graphics.drawRect(0, 0, width, getBottom());
                _bg.graphics.endFill();
            }
        }

        override public function getBottom():Number
        {
            return _carousel_height + 16;
        }

        // PRIVATE

        private function init():void
        {
            try
            {
                Dossier.requestAccountDossier(this, onAccountDossierLoaded, PROFILE_DROPDOWN_KEYS.ALL);
                itemRenderer = getQualifiedClassName(UI_TankCarouselItemRenderer);

                _carousel_height = (UI_TankCarouselItemRenderer.ITEM_HEIGHT * cfg.zoom + cfg.padding.vertical) * cfg.rows - cfg.padding.vertical + 4;
                scrollList.height = (leftArrow as MovieClip).height = (rightArrow as MovieClip).height = _carousel_height;
                (rightArrow as MovieClip).y = (leftArrow as MovieClip).y + _carousel_height; // FIXIT: why vertically aligned to bottom?
                //leftFadeEndItem.visible = rightFadeEndItem.visible = false;

                background.alpha = 0;
                _bg = new MovieClip();
                addChildAt(_bg, 0);
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

        private function setupScrollList():void
        {
            var horizontalPadding:Number = Macros.FormatNumberGlobal(cfg.padding.horizontal, scrollList.gap);
            scrollList.gap = horizontalPadding;

            scrollList.validateNow();

            var viewPort:MultiRowsScrollerViewPort = new MultiRowsScrollerViewPort();
            viewPort.owner = scrollList;
            viewPort.gap = horizontalPadding;
            viewPort.setSelectedIndex(scrollList.selectedIndex);
            viewPort.tooltipDecorator = scrollList.xfw_tooltipDecorator;
            scrollList.viewPort = viewPort;
            scrollList.invalidate();
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
