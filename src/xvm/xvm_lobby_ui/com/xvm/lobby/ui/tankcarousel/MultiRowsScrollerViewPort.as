/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.tankcarousel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.gui.components.carousels.*;
    import net.wg.gui.components.controls.scroller.*;
    import scaleform.clik.constants.*;

    public /*dynamic*/ class MultiRowsScrollerViewPort extends HorizontalScrollerViewPort
    {
        private var cfg:CCarousel;
        private var _dataCount:int = 0;

        public function MultiRowsScrollerViewPort():void
        {
            //Logger.add("MultiRowsScrollerViewPort");
            cfg = Config.config.hangar.carousel;
        }

        override public function set visibleWidth(value:Number):void
        {
            super.visibleWidth = value + Math.ceil(Math.ceil(value / (rendererWidth + gap)) * (rendererWidth + gap) * cfg.rows / cfg.zoom);
        }

        override public function updateDataCount():void
        {
            _dataCount = (dataProvider != null) ? dataProvider.length : 0;
            xfw_dataCount = _dataCount;
        }

        override public function resize():void
        {
            var w:Number = (rendererWidth + gap) * Math.ceil(_dataCount / cfg.rows * cfg.zoom) - gap;
            if (_width !== w || _height !== visibleHeight)
            {
                _width = w;
                _height = this.visibleHeight;
                if (hasEventListener(Event.RESIZE))
                {
                    dispatchEvent(new Event(Event.RESIZE));
                }
            }
        }

        override public function layoutItemRenderers():void
        {
            var renderer:IScrollerItemRenderer = null;
            if (this.xfw_activeRenderers.length == 0)
            {
                return;
            }
            var zoom:Number = cfg.zoom;
            var w:int = Math.ceil(UI_TankCarouselItemRenderer.ITEM_WIDTH * zoom) + UI_TankCarouselItemRenderer.ITEM_MARGIN * 2;
            var h:int = Math.ceil(UI_TankCarouselItemRenderer.ITEM_HEIGHT * zoom) + UI_TankCarouselItemRenderer.ITEM_MARGIN * 2;
            for each (renderer in this.xfw_activeRenderers)
            {
                var idx:int = renderer.index;
                renderer.x = int(idx / cfg.rows) * (w + cfg.padding.horizontal);
                renderer.y = int(idx % cfg.rows) * (h + cfg.padding.vertical) + UI_TankCarousel.VERTICAL_MARGIN;
            }
        }
    }
}
