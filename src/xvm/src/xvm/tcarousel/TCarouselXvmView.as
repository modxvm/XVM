/**
 * XVM - hangar
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.tcarousel
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.misc.*;
    import com.xvm.utils.*;
    import com.xvm.types.dossier.*;
    import net.wg.data.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
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

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.addObject("onAfterPopulate: " + view.as_alias);
            try
            {
                if (Config.config.hangar.carousel.enabled)
                {
                    replaceCarouselControl();
                    init();
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function replaceCarouselControl():void
        {
            try
            {
                if (isNaN(Config.config.hangar.carousel.rows) || Config.config.hangar.carousel.rows <= 0)
                    Config.config.hangar.carousel.rows = 1;

                var index:int = page.getChildIndex(page.carousel);
                page.removeChildAt(index);
                //page.carousel.dispose(); // TODO: exception
                page.carousel = new UI_TankCarousel();
                page.addChildAt(page.carousel, index);
                page.unregisterComponent(Aliases.TANK_CAROUSEL);
                page.registerComponent(page.carousel, Aliases.TANK_CAROUSEL);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function init():void
        {
            Macros.RegisterVehiclesMacros();
            Dossier.loadAccountDossier(this, onAccountDossierLoaded, PROFILE.PROFILE_DROPDOWN_LABELS_ALL);
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
