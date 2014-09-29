package xvm.tcarousel
{
    import com.xvm.*;
    import com.xvm.misc.*;
    import com.xvm.types.cfg.*;
    import com.xvm.types.dossier.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;
    import scaleform.clik.constants.*;

    public dynamic class UI_TankCarouselItemRenderer extends TankCarouselItemRendererUI
    {
        private var cfg:CCarousel;
        private var extraFields:MovieClip;

        public function UI_TankCarouselItemRenderer()
        {
            super();
            cfg = Config.config.hangar.carousel;
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
                var dataDirty:Boolean = _dataDirty;

                super.draw();
                if (_baseDisposed)
                    return;

                this.scaleX = this.scaleY = cfg.zoom;

                if (dataDirty)
                {
                    if (dataVO == null)
                        return;

                    var id:Number = dataVO.compactDescr;
                    var dossier:AccountDossier = Dossier.getAccountDossier();
                    if (dossier != null)
                    {
                        var vdata:VehicleDossierCut = dossier.getVehicleDossierCut(id);
                        vdata.elite = dataVO.elite ? "elite" : null;
                        ExtraFields.updateVehicleExtraFields(extraFields, vdata);
                    }
                }
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

                var zoom:Number = cfg.zoom;
                var w:int = width * zoom;
                var h:int = height * zoom;

                extraFields = new MovieClip();
                extraFields.scaleX = extraFields.scaleY = 1 / zoom;
                //extraFields.graphics.beginFill(0xFFFFFF, 0.3); extraFields.graphics.drawRect(0, 0, w, h); extraFields.graphics.endFill();
                vehicleIcon.addChild(extraFields);

                setupStandardField(vehicleIcon.tankTypeMc, cfg.fields.tankType);

                vehicleIcon.levelMc.visible = false;
                App.utils.scheduler.envokeInNextFrame(function():void {
                    if (vehicleIcon == null)
                        return;
                    setupStandardField(vehicleIcon.levelMc, cfg.fields.level);
                    vehicleIcon.levelMc.visible = true;
                });

                setupStandardField(vehicleIcon.xp, cfg.fields.xp);
                vehicleIcon.xp.x = w - vehicleIcon.xp.width - 2;

                setupStandardField(vehicleIcon.multyXp, cfg.fields.multiXp);
                vehicleIcon.multyXp.x = w - vehicleIcon.multyXp.width - 2;

                setupTankNameField(cfg.fields.tankName, zoom);

                ExtraFields.createExtraFields(extraFields, w, h, cfg.extraFields);
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
            vehicleIcon.tankNameField.x += cfg.dx + (width - 4) * (1 - cfg.scale);
            vehicleIcon.tankNameField.y += cfg.dy;
            vehicleIcon.tankNameBg.x += cfg.dx + (width - 4) * (1 - cfg.scale);
            vehicleIcon.tankNameBg.y += cfg.dy;
        }
    }
}
