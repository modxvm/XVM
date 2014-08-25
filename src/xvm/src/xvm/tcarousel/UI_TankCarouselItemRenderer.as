package xvm.tcarousel
{
    import com.xvm.*;
    import com.xvm.misc.*;
    import com.xvm.types.dossier.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;

    public dynamic class UI_TankCarouselItemRenderer extends TankCarouselItemRendererUI
    {
        private var extraFields:Sprite;

        public function UI_TankCarouselItemRenderer()
        {
            super();
            createExtraFields();
        }

        override protected function draw():void
        {
            super.draw();

            scaleX = scaleY = Config.config.hangar.carousel.zoom;

            /*
            if (!masteryTF)
                return;

            if (Config.config.hangar.masteryMarkInTankCarousel)
            {
                var masteryStr:String = "";
                try
                {
                    if (dataVO == null)
                        return;

                    var id:Number = dataVO.compactDescr;
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
            }*/
        }

        // PRIVATE

        private function createExtraFields():void
        {
            if (!vehicleIcon)
                return;
            extraFields = new Sprite();
            this.addChild(extraFields);

            var tf:TextField = new TextField();
            tf.x = -1;
            tf.y = 14;
            tf.width = 32;
            tf.height = 32;
            tf.selectable = false;
            //tf.htmlText = "<img src='img://gui/maps/icons/library/proficiency/class_icons_3.png' width='23' height='23'>";
            extraFields.addChild(tf);
            /*masteryTF = null;
            masteryTF = new TextField();
            masteryTF.x = -1;
            masteryTF.y = 14;
            masteryTF.width = 32;
            masteryTF.height = 32;
            masteryTF.selectable = false;
            vehicleIcon.addChild(masteryTF);*/
        }

    }
}
