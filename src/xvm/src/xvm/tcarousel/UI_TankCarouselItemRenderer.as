package xvm.tcarousel
{
    import com.xvm.*;
    import com.xvm.misc.*;
    import com.xvm.types.dossier.*;
    import flash.text.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;

    public dynamic class UI_TankCarouselItemRenderer extends TankCarouselItemRendererUI
    {
        private var masteryTF:TextField;

        public function UI_TankCarouselItemRenderer()
        {
            super();
            createControls();
        }

        override protected function draw():void
        {
            super.draw();

            if (!masteryTF)
                return;

            if (Config.config.hangar.masteryMarkInTankCarousel)
            {
                var masteryStr:String = "";
                try
                {
                    if (!data || !data.hasOwnProperty("compactDescr"))
                        return;

                    var id:Number = data.compactDescr;
                    var dossier:AccountDossier = Dossier.getAccountDossier();
                    if (dossier != null && dossier.vehicles.hasOwnProperty(id))
                    {
                        var vdata:VehicleDossierCut = dossier.vehicles[id];
                        masteryStr = "<img src='img://gui/maps/icons/library/proficiency/class_icons_" + vdata.mastery + ".png' width='23' height='23'>";
                        masteryTF.scaleX = 1 / scaleX;
                        masteryTF.scaleY = 1 / scaleY;
                    }
                }
                catch (ex:Error)
                {
                    Logger.add(ex.getStackTrace());
                }
                finally
                {
                    masteryTF.htmlText = masteryStr;
                }
            }
        }

        // PRIVATE

        private function createControls():void
        {
            masteryTF = null;
            if (!vehicleIcon)
                return;
            masteryTF = new TextField();
            masteryTF.x = -1;
            masteryTF.y = 14;
            masteryTF.width = 32;
            masteryTF.height = 32;
            masteryTF.selectable = false;
            vehicleIcon.addChild(masteryTF);
        }

    }
}
