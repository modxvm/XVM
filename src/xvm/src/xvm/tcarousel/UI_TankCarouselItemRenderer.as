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

        override protected function configUI():void
        {
            super.configUI();
        }

        override protected function draw():void
        {
            //Logger.add("draw");
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

            var w:int = width * Config.config.hangar.carousel.zoom;
            var h:int = height * Config.config.hangar.carousel.zoom;

            extraFields = new Sprite();
            extraFields.scaleX = extraFields.scaleY = 1 / Config.config.hangar.carousel.zoom;
            //extraFields.graphics.beginFill(0xFFFFFF, 0.3); extraFields.graphics.drawRect(0, 0, w, h); extraFields.graphics.endFill();
            vehicleIcon.addChild(extraFields);

            vehicleIcon.removeChild(vehicleIcon.tankTypeMc);
            extraFields.addChild(vehicleIcon.tankTypeMc);

            vehicleIcon.removeChild(vehicleIcon.levelMc);
            extraFields.addChild(vehicleIcon.levelMc);

            vehicleIcon.removeChild(vehicleIcon.xp);
            extraFields.addChild(vehicleIcon.xp);

            vehicleIcon.removeChild(vehicleIcon.multyXp);
            extraFields.addChild(vehicleIcon.multyXp);
            vehicleIcon.multyXp.x = w - vehicleIcon.multyXp.width - 2;
            vehicleIcon.multyXp.y = 1;

            /*
            vehicleIcon.removeChild(vehicleIcon.tankNameField);
            extraFields.addChild(vehicleIcon.tankNameField);
            vehicleIcon.tankNameField.x = w - vehicleIcon.tankNameField.width - 2;
            vehicleIcon.tankNameField.y = h - vehicleIcon.tankNameField.height - 2;

            vehicleIcon.removeChild(vehicleIcon.tankNameBg);
            extraFields.addChild(vehicleIcon.tankNameBg);
            vehicleIcon.tankNameBg.x = w - vehicleIcon.tankNameBg.width - 2;
            vehicleIcon.tankNameBg.y = h - vehicleIcon.tankNameBg.height - 2;
            */

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
