package net.wg.gui.lobby.hangar.wtEvent
{
    import net.wg.infrastructure.base.meta.impl.WTEventCarouselWidgetMeta;
    import net.wg.infrastructure.base.meta.IWTEventCarouselWidgetMeta;

    public class WTEventCarouselWidget extends WTEventCarouselWidgetMeta implements IWTEventCarouselWidgetMeta
    {

        public static const WIDGET_WIDTH:int = 880;

        public static const WIDGET_WIDTH_LARGE:int = 1180;

        public static const WIDGET_HEIGHT:int = 260;

        public static const WIDGET_HEIGHT_LARGE:int = 320;

        public function WTEventCarouselWidget()
        {
            super();
        }

        public function as_hideWidget() : void
        {
            this.visible = false;
        }

        public function as_showWidget() : void
        {
            this.visible = true;
        }
    }
}
