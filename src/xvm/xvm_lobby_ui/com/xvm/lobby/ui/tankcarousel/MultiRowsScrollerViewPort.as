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
            super.visibleWidth = value + Math.ceil(value / (rendererWidth + gap)) * (rendererWidth + gap) * cfg.rows;
        }

        override public function updateDataCount():void
        {
            _dataCount = (dataProvider != null) ? dataProvider.length : 0;
            xfw_dataCount = _dataCount;
        }

        override public function resize():void
        {
            var w:Number = (rendererWidth + gap) * int((_dataCount + cfg.rows - 1) / cfg.rows) - gap;
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
            var w:int = int(UI_TankCarouselItemRenderer.ITEM_WIDTH * zoom);
            var h:int = int(UI_TankCarouselItemRenderer.ITEM_HEIGHT * zoom);
            for each (renderer in this.xfw_activeRenderers)
            {
                var idx:int = renderer.index;
                renderer.x = int(int(idx / cfg.rows) * (w + cfg.padding.horizontal) - cfg.padding.horizontal / 2);
                renderer.y = int(int(idx % cfg.rows) * (h + cfg.padding.vertical) - cfg.padding.vertical / 2 + 2);
            }
        }
    }
}
