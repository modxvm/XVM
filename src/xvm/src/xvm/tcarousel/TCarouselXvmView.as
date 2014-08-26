/**
 * XVM - hangar
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.tcarousel
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.misc.*;
    import com.xvm.types.dossier.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.utils.Padding;

    public class TCarouselXvmView extends XvmViewBase
    {
        public function TCarouselXvmView(view:IView)
        {
            super(view);
        }

        public function get page():net.wg.gui.lobby.hangar.Hangar
        {
            return super.view as net.wg.gui.lobby.hangar.Hangar;
        }

        override public function onBeforePopulate(e:LifeCycleEvent):void
        {
            if (Config.config.hangar.carousel.enabled)
                replaceCarouselControl();
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.addObject("onAfterPopulate: " + view.as_alias);
            try
            {
                if (Config.config.hangar.carousel.enabled)
                    init();
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function replaceCarouselControl():void
        {
            if (isNaN(Config.config.hangar.carousel.rows) || Config.config.hangar.carousel.rows <= 0)
                Config.config.hangar.carousel.rows = 1;

            var c:TankCarousel = new UI_TankCarousel(Config.config.hangar.carousel);
            c.componentInspectorSetting = true;
            c.dragEnabled = page.carousel.dragEnabled;
            c.enabled = page.carousel.enabled;
            c.enableInitCallback = page.carousel.enableInitCallback;
            c.focusable = page.carousel.focusable;
            c.margin = page.carousel.margin;
            c.inspectablePadding = {
                top: 0,
                right: Config.config.hangar.carousel.padding.horizontal / 2,
                bottom: Config.config.hangar.carousel.padding.vertical,
                left: Config.config.hangar.carousel.padding.horizontal / 2
            };
            c.useRightButton = page.carousel.useRightButton;
            c.useRightButtonForSelect = page.carousel.useRightButtonForSelect;
            c.visible = page.carousel.visible;
            c.slotImageWidth = page.carousel.slotImageWidth * Config.config.hangar.carousel.zoom;
            c.slotImageHeight = page.carousel.slotImageHeight * Config.config.hangar.carousel.zoom;
            var h:int = (c.slotImageHeight + c.padding.vertical) * Config.config.hangar.carousel.rows - c.padding.vertical;
            c.height = h + 10;
            c.leftArrow.height = c.rightArrow.height = c.renderersMask.height = c.dragHitArea.height = h;
            c.itemRenderer = UI_TankCarouselItemRenderer;
            c.componentInspectorSetting = false;

            var index:int = page.getChildIndex(page.carousel);
            page.removeChildAt(index);
            page.carousel.dispose();
            page.carousel = c;
            page.addChildAt(page.carousel, index);
        }

        private function init():void
        {
            Dossier.loadAccountDossier(page.carousel, page.carousel.invalidateData, PROFILE.PROFILE_DROPDOWN_LABELS_ALL);
        }
    }
}
