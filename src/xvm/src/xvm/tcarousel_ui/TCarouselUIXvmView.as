/**
 * XVM - hangar
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.tcarousel_ui
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.dossier.*;
    import net.wg.data.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class TCarouselUIXvmView extends XvmViewBase
    {
        public function TCarouselUIXvmView(view:IView)
        {
            super(view);
        }

        public function get page():net.wg.gui.lobby.hangar.Hangar
        {
            return super.view as net.wg.gui.lobby.hangar.Hangar;
        }

        override public function onBeforePopulate(e:LifeCycleEvent):void
        {
            //Logger.add((new Error()).getStackTrace());

            replaceCarouselControl();
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            Logger.add("onAfterPopulate: " + view.as_alias);
            try
            {
                init();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            super.onBeforeDispose(e);
        }

        // PRIVATE

        private function replaceCarouselControl():void
        {
            try
            {
                if (Config.config.hangar.carousel.enabled != true)
                    return;

                if (isNaN(Config.config.hangar.carousel.rows) || Config.config.hangar.carousel.rows <= 0)
                    Config.config.hangar.carousel.rows = 1;

                var index:int = page.getChildIndex(page.carousel);
                page.removeChildAt(index);
                //page.carousel.dispose(); // TODO: exception
                //page.unregisterComponent(Aliases.TANK_CAROUSEL);
                page.carousel = null;
                var carousel:TankCarousel = new UI_TankCarousel();
                page.carousel = carousel;
                //page.addChildAt(carousel, index);
                page.addChild(carousel);
                //Logger.add("registerComponent");
                //page.registerComponent(carousel, Aliases.TANK_CAROUSEL);
                //Logger.add("done");
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function init():void
        {
            if (Config.config.hangar.carousel.enabled != true)
                return;
            Macros.RegisterVehiclesMacros();
            Dossier.requestAccountDossier(this, onAccountDossierLoaded, PROFILE.PROFILE_DROPDOWN_LABELS_ALL);
        }

        private function onAccountDossierLoaded():void
        {
            var dossier:AccountDossier = Dossier.getAccountDossier();
            //Logger.addObject(dossier);
            if (dossier != null)
            {
                for (var vehId:String in dossier.vehicles)
                    Dossier.requestVehicleDossier(null, null, PROFILE.PROFILE_DROPDOWN_LABELS_ALL, parseInt(vehId));
            }
            page.carousel.invalidateData();
        }
    }
}
