package xvm.tcarousel
{
    import com.xvm.*;
    import com.xvm.misc.*;
    import com.xvm.types.dossier.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;

    public dynamic class UI_TankCarouselItemRenderer extends TankCarouselItemRendererUI
    {
        private var extraFields:MovieClip;

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
            try
            {
                //Logger.add("draw");
                super.draw();
                scaleX = scaleY = Config.config.hangar.carousel.zoom;

                if (dataVO == null)
                    return;

                var id:Number = dataVO.compactDescr;
                var dossier:AccountDossier = Dossier.getAccountDossier();
                if (dossier != null)
                    ExtraFields.updateVehicleExtraFields(extraFields, dossier.getVehicleDossierCut(id));
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        // PRIVATE

        private function createExtraFields():void
        {
            if (!vehicleIcon)
                return;

            try
            {
                scrollRect = new Rectangle(0, 0, width, height);

                var zoom:Number = Config.config.hangar.carousel.zoom;
                var w:int = width * zoom;
                var h:int = height * zoom;

                extraFields = new MovieClip();
                extraFields.scaleX = extraFields.scaleY = 1 / zoom;
                //extraFields.graphics.beginFill(0xFFFFFF, 0.3); extraFields.graphics.drawRect(0, 0, w, h); extraFields.graphics.endFill();
                vehicleIcon.addChild(extraFields);

                setupStandardField(vehicleIcon.tankTypeMc, Config.config.hangar.carousel.fields.tankType);

                setupStandardField(vehicleIcon.levelMc, Config.config.hangar.carousel.fields.level);

                vehicleIcon.xp.x = w - vehicleIcon.xp.width - 2;
                setupStandardField(vehicleIcon.xp, Config.config.hangar.carousel.fields.xp);

                vehicleIcon.multyXp.x = w - vehicleIcon.multyXp.width - 2;
                setupStandardField(vehicleIcon.multyXp, Config.config.hangar.carousel.fields.multiXp);

                setupTankNameField(Config.config.hangar.carousel.fields.tankName, zoom);

                ExtraFields.createExtraFields(extraFields, w, h, Config.config.hangar.carousel.extraFields);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function setupStandardField(mc:MovieClip, cfg:Object):void
        {
            vehicleIcon.removeChild(mc);
            extraFields.addChild(mc);

            mc.scaleX = mc.scaleY = cfg.scale;
            mc.alpha = cfg.visible ? Math.max(Math.min(cfg.alpha / 100.0, 100), 0) : 0;
            mc.x += cfg.dx;
            mc.y += cfg.dy;
        }

        private function setupTankNameField(cfg:Object, zoom:Number):void
        {
            var w:int = width * zoom;
            var h:int = height * zoom;

            vehicleIcon.tankNameField.scaleX = vehicleIcon.tankNameField.scaleY =
                vehicleIcon.tankNameBg.scaleX = vehicleIcon.tankNameBg.scaleY = cfg.scale;
            vehicleIcon.tankNameField.alpha = vehicleIcon.tankNameBg.alpha =
                cfg.visible ? Math.max(Math.min(cfg.alpha / 100.0, 100), 0) : 0;
            vehicleIcon.tankNameField.x += cfg.dx;
            vehicleIcon.tankNameField.y += cfg.dy;
            vehicleIcon.tankNameBg.x += cfg.dx;
            vehicleIcon.tankNameBg.y += cfg.dy;
        }
    }
}
