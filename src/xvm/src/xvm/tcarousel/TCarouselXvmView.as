/**
 * XVM - hangar
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.tcarousel
{
    import com.xfw.*;
    import com.xfw.infrastructure.*;
    import com.xfw.misc.*;
    import com.xfw.utils.*;
    import com.xfw.types.dossier.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

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
            //Logger.add((new Error()).getStackTrace());
            replaceCarouselControl();
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.addObject("onAfterPopulate: " + view.as_alias);
            try
            {
                init();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
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
                var carousel:UI_TankCarousel = new UI_TankCarousel();
                page.carousel = carousel;
                page.addChildAt(carousel, index);
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
            Dossier.loadAccountDossier(this, onAccountDossierLoaded, PROFILE.PROFILE_DROPDOWN_LABELS_ALL);
        }

        private function remove():void
        {
        }

        private function onAccountDossierLoaded():void
        {
            var dossier:AccountDossier = Dossier.getAccountDossier();
            //Logger.addObject(dossier);
            if (dossier != null)
            {
                for (var vehId:String in dossier.vehicles)
                    Dossier.loadVehicleDossier(null, null, PROFILE.PROFILE_DROPDOWN_LABELS_ALL, parseInt(vehId));
            }
            page.carousel.invalidateData();
        }
    }
}
