package xvm.tcarousel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import com.xvm.types.dossier.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.gui.lobby.hangar.tcarousel.data.VehicleCarouselVO;
    import net.wg.gui.lobby.profile.pages.technique.data.*;
    import scaleform.clik.constants.*;

    public dynamic class UI_TankCarouselItemRenderer extends TankCarouselItemRendererUI
    {
        private var cfg:CCarousel;
        private var extraFields:MovieClip;
        private var lastSelectedState:Boolean;

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

        /* for tests
        override public function setDataVO(param1:VehicleCarouselVO):void
        {
            if (param1 != null && param1.compactDescr == 273)
                param1.clanLock = (new Date()).valueOf() / 1000 + 100;
            super.setDataVO(param1);
        }*/

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

                if (dataVO == null)
                    return;

                if (dataDirty || lastSelectedState != this.selected)
                {
                    lastSelectedState = this.selected;

                    var id:Number = dataVO.compactDescr;
                    var dossier:AccountDossier = Dossier.getAccountDossier();
                    if (dossier != null)
                    {
                        var vdata:VehicleDossierCut = dossier.getVehicleDossierCut(id);
                        vdata.elite = dataVO.elite ? "elite" : null;
                        vdata.selected = this.selected ? "sel" : null;
                        ExtraFields.updateVehicleExtraFields(extraFields, vdata);
                    }

                    // Fix statusText position
                    if (this.statusText && this.statusText.visible)
                    {
                        if (this.clanLockUI.visible && cfg.fields.clanLock.dy == 0 && cfg.fields.statusText.dy == 0)
                        {
                            statusText.y = Math.round(clanLockUI.y / scaleY + clanLockUI.textField.height * cfg.fields.clanLock.scale + 5);
                        }
                        else
                        {
                            statusText.y = Math.round((_height / scaleY - statusText.textHeight) / 2 + cfg.fields.statusText.dy);
                        }
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
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
                vehicleIcon.xp.x = w - vehicleIcon.xp.width - 2 + cfg.fields.xp.dx;

                setupStandardField(vehicleIcon.multyXp, cfg.fields.multiXp);
                vehicleIcon.multyXp.x = w - vehicleIcon.multyXp.width - 2 + cfg.fields.multiXp.dx;

                setupTankNameField(cfg.fields.tankName, zoom);

                setupStatusTextField(cfg.fields.statusText);
                setupClanLockField(cfg.fields.clanLock);

                ExtraFields.createExtraFields(extraFields, w, h, cfg.extraFields);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function setupStandardField(mc:MovieClip, cfg:Object):void
        {
            vehicleIcon.removeChild(mc);
            extraFields.addChild(mc);

            mc.scaleX = mc.scaleY = cfg.scale;
            mc.alpha = cfg.visible ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
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
                cfg.visible ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
            vehicleIcon.tankNameField.x = (width - 4) * (1 - cfg.scale) + cfg.dx;
            vehicleIcon.tankNameField.y += cfg.dy;
            vehicleIcon.tankNameBg.x = vehicleIcon.tankNameField.x + vehicleIcon.tankNameField.width - vehicleIcon.tankNameBg.width;
            vehicleIcon.tankNameBg.y = vehicleIcon.tankNameField.y + vehicleIcon.tankNameField.height - vehicleIcon.tankNameBg.height;
        }

        private function setupStatusTextField(cfg:Object):void
        {
            statusText.scaleX = statusText.scaleY = cfg.scale;
            statusText.alpha = cfg.visible ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
            statusText.x += cfg.dx;
            statusText.y += cfg.dy;
        }

        private function setupClanLockField(cfg:Object):void
        {
            clanLockUI.scaleX = clanLockUI.scaleY = cfg.scale;
            clanLockUI.alpha = cfg.visible ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
            clanLockUI.x += cfg.dx;
            clanLockUI.y += cfg.dy;
        }
    }
}
