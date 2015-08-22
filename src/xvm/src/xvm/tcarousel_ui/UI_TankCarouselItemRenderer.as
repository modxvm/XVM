/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.tcarousel_ui
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
    import xvm.tcarousel_ui.components.*;

    public dynamic class UI_TankCarouselItemRenderer extends TankCarouselItemRendererUI
    {
        private static const ITEM_WIDTH:int = 162;
        private static const ITEM_HEIGHT:int = 102;

        private var cfg:CCarousel;
        private var extraFields:MovieClip;
        private var lastSelectedState:Boolean;

        public function UI_TankCarouselItemRenderer()
        {
            //Logger.add("UI_TankCarouselItemRenderer()");
            super();
            cfg = Config.config.hangar.carousel;
        }

        override protected function configUI():void
        {
            super.configUI();
            createExtraFields();
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
                    var c:Object = (dataVO.buySlot || dataVO.buyTank) ? cfg.fields.statusTextBuy : cfg.fields.statusText;
                    setupStatusTextField(c);
                    if (this.statusText && this.statusText.visible)
                    {
                        if (this.clanLockUI.visible && cfg.fields.clanLock.dy == 0 && c.dy == 0)
                        {
                            statusText.y = Math.round(orig_clanLockUI_y / scaleY + clanLockUI.textField.height * cfg.fields.clanLock.scale + 5);
                        }
                        else
                        {
                            statusText.y = orig_statusText_y + c.dy;
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
                scrollRect = new Rectangle(-1, -1, ITEM_WIDTH + 2, ITEM_HEIGHT + 2);
                //graphics.beginFill(0xFFFFFF, 0.3); graphics.drawRect(-1, -1, ITEM_WIDTH + 2, ITEM_HEIGHT + 2); graphics.endFill();

                var zoom:Number = cfg.zoom;
                var w:int = int(ITEM_WIDTH * zoom);
                var h:int = int(ITEM_HEIGHT * zoom);

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
                vehicleIcon.xp.x = w - vehicleIcon.xp.width + cfg.fields.xp.dx - 2;

                setupStandardField(vehicleIcon.multyXp, cfg.fields.multiXp);
                vehicleIcon.multyXp.x = w - vehicleIcon.multyXp.width + cfg.fields.multiXp.dx - 2;

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

        private var orig_vehicleIcon_tankNameField_y:Number = NaN;
        private function setupTankNameField(cfg:Object, zoom:Number):void
        {
            var w:int = width * zoom;
            var h:int = height * zoom;

            vehicleIcon.tankNameField.scaleX = vehicleIcon.tankNameField.scaleY =
                vehicleIcon.tankNameBg.scaleX = vehicleIcon.tankNameBg.scaleY = cfg.scale;
            vehicleIcon.tankNameField.alpha = vehicleIcon.tankNameBg.alpha =
                cfg.visible ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
            vehicleIcon.tankNameField.x = (width - 4) * (1 - cfg.scale) + cfg.dx;
            if (isNaN(orig_vehicleIcon_tankNameField_y))
                orig_vehicleIcon_tankNameField_y = vehicleIcon.tankNameField.y;
            vehicleIcon.tankNameField.y = orig_vehicleIcon_tankNameField_y + cfg.dy;
            vehicleIcon.tankNameBg.x = vehicleIcon.tankNameField.x + vehicleIcon.tankNameField.width - vehicleIcon.tankNameBg.width;
            vehicleIcon.tankNameBg.y = vehicleIcon.tankNameField.y + vehicleIcon.tankNameField.height - vehicleIcon.tankNameBg.height;
        }

        private var orig_statusText_x:Number = NaN;
        private var orig_statusText_y:Number = NaN;
        private function setupStatusTextField(cfg:Object):void
        {
            statusText.scaleX = statusText.scaleY = cfg.scale;
            statusText.alpha = cfg.visible ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
            if (isNaN(orig_statusText_x))
                orig_statusText_x = statusText.x;
            statusText.x = orig_statusText_x + cfg.dx;
            if (isNaN(orig_statusText_y))
                orig_statusText_y = statusText.y;
            statusText.y = orig_statusText_y + cfg.dy;
        }

        private var orig_clanLockUI_x:Number = NaN;
        private var orig_clanLockUI_y:Number = NaN;
        private function setupClanLockField(cfg:Object):void
        {
            clanLockUI.scaleX = clanLockUI.scaleY = cfg.scale;
            clanLockUI.alpha = cfg.visible ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
            if (isNaN(orig_clanLockUI_x))
                orig_clanLockUI_x = clanLockUI.x;
            clanLockUI.x = orig_clanLockUI_x + cfg.dx;
            if (isNaN(orig_clanLockUI_y))
                orig_clanLockUI_y = clanLockUI.y;
            clanLockUI.y = orig_clanLockUI_y + cfg.dy;
        }
    }
}
