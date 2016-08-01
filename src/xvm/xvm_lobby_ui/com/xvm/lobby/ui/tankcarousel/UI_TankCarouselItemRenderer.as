/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.tankcarousel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.extraFields.*;
    import com.xvm.lobby.vo.*;
    import com.xvm.types.cfg.*;
    import com.xvm.types.dossier.*;
    import flash.display.*;
    import flash.utils.*;
    import net.wg.gui.lobby.hangar.tcarousel.data.*;

    public /*dynamic*/ class UI_TankCarouselItemRenderer extends TankCarouselItemRendererUI
    {
        public static const ITEM_WIDTH:int = 160;
        public static const ITEM_HEIGHT:int = 100;

        private static const COMMAND_XVM_CAROUSEL_GET_USED_SLOTS_COUNT:String = 'xvm_carousel.get_used_slots_count';
        private static const COMMAND_XVM_CAROUSEL_GET_TOTAL_SLOTS_COUNT:String = 'xvm_carousel.get_total_slots_count';

        private var cfg:CCarousel;
        private var _lastSelectedState:Boolean;
        private var _extraFieldsHolder:MovieClip = null;
        private var _extraFields:ExtraFields = null;
        private var _dataVO:VehicleCarouselVO = null;

        public function UI_TankCarouselItemRenderer()
        {
            //Logger.add(getQualifiedClassName(this));
            super();
            cfg = Config.config.hangar.carousel;
            try
            {
                createExtraFields();
                setupStandardFields();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override protected function onDispose():void
        {
            if (_extraFields)
            {
                _extraFields.dispose();
                _extraFields = null;
            }
            _extraFieldsHolder = null;
            this._dataVO = null;
            super.onDispose();
        }

        override public function set data(value:Object):void
        {
            try
            {
                if (_dataVO)
                {
                    _dataVO = null;
                }
                if (value)
                {
                    _dataVO = VehicleCarouselVO(value);
                }
                else
                {
                    _extraFieldsHolder.visible = false;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            super.data = value;
        }

        override public function set selected(value:Boolean):void
        {
            if (selected != value)
            {
                super.selected = value;
                updateDataXvm();
            }
        }

        override protected function updateData():void
        {
            super.updateData();
            updateDataXvm();
        }

        // PRIVATE

        private function createExtraFields():void
        {
            try
            {
                var zoom:Number = cfg.zoom;
                var w:int = int(ITEM_WIDTH * zoom);
                var h:int = int(ITEM_HEIGHT * zoom);

                _extraFieldsHolder = new MovieClip();
                _extraFieldsHolder.x = this.slot.x + 1;
                _extraFieldsHolder.y = this.slot.y + 1;
                _extraFieldsHolder.mouseEnabled = false;
                _extraFieldsHolder.mouseChildren = false;
                addChildAt(_extraFieldsHolder, this.getChildIndex(this.slot) + 1);

                _extraFields = new ExtraFields(cfg.extraFields, true, null, null, null, null, null, CTextFormat.GetDefaultConfigForLobby());
                _extraFields.scaleX = _extraFields.scaleY = 1 / zoom;
                _extraFieldsHolder.addChild(_extraFields);
                _extraFieldsHolder.mask = _extraFieldsHolder.addChild(createMask(-2, -2, ITEM_WIDTH + 3, ITEM_HEIGHT + 3));
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // price:IconText = null;
        // infoText:TextField = null;
        // additionalText:TextField = null;
        // clanLock:ClanLockUI = null;
        // actionPrice:ActionPrice = null;
        // slot:TankCarouselRendererSlot = null;
        private function setupStandardFields():void
        {
                var zoom:Number = cfg.zoom;
                var w:int = int(ITEM_WIDTH * zoom);
                var h:int = int(ITEM_HEIGHT * zoom);

                setupStandardField(slot.tankIcon.multyXp, cfg.fields.multiXp);
                slot.tankIcon.multyXp.x = w - slot.tankIcon.multyXp.width + cfg.fields.multiXp.dx;

                setupStandardField(slot.tankIcon.xp, cfg.fields.xp);
                slot.tankIcon.xp.x = w - slot.tankIcon.xp.width + cfg.fields.xp.dx;

                setupStandardField(slot.tankIcon.tankTypeMc, cfg.fields.tankType);

                slot.tankIcon.levelMc.visible = false;
                App.utils.scheduler.scheduleOnNextFrame(function():void {
                    if (slot.tankIcon == null)
                        return;
                    setupStandardField(slot.tankIcon.levelMc, cfg.fields.level);
                    slot.tankIcon.levelMc.visible = true;
                });

                setupTankNameField(cfg.fields.tankName);

                setupInfoTextField(cfg.fields.statusText);
                setupClanLockField(cfg.fields.clanLock);
        }

        private function setupStandardField(mc:MovieClip, cfg:Object):void
        {
            _extraFields.addChildAt(mc, 0);

            mc.scaleX = mc.scaleY = cfg.scale;
            mc.alpha = cfg.enabled ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
            mc.x += cfg.dx;
            mc.y += cfg.dy;
        }

        private var orig_tankIcon_tankNameField_y:Number = NaN;
        private function setupTankNameField(cfg:Object):void
        {
            slot.tankIcon.tankNameField.scaleX = slot.tankIcon.tankNameField.scaleY =
                slot.tankIcon.tankNameBg.scaleX = slot.tankIcon.tankNameBg.scaleY = cfg.scale;
            slot.tankIcon.tankNameField.alpha = slot.tankIcon.tankNameBg.alpha =
                cfg.enabled ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
            slot.tankIcon.tankNameField.x = 2 + cfg.dx;
            slot.tankIcon.tankNameField.width = ITEM_WIDTH - 4;
            if (isNaN(orig_tankIcon_tankNameField_y))
                orig_tankIcon_tankNameField_y = slot.tankIcon.tankNameField.y;
            slot.tankIcon.tankNameField.y = orig_tankIcon_tankNameField_y + cfg.dy;
            slot.tankIcon.tankNameBg.x = slot.tankIcon.tankNameField.x + slot.tankIcon.tankNameField.width - slot.tankIcon.tankNameBg.width;
            slot.tankIcon.tankNameBg.y = slot.tankIcon.tankNameField.y + slot.tankIcon.tankNameField.height - slot.tankIcon.tankNameBg.height;
        }

        private var orig_infoText_x:Number = NaN;
        private var orig_infoText_y:Number = NaN;
        private function setupInfoTextField(cfg:Object):void
        {
            infoText.scaleX = infoText.scaleY = cfg.scale;
            infoText.alpha = cfg.enabled ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
            if (isNaN(orig_infoText_x))
                orig_infoText_x = infoText.x;
            infoText.x = orig_infoText_x + cfg.dx;
            if (isNaN(orig_infoText_y))
                orig_infoText_y = infoText.y;
            infoText.y = orig_infoText_y + cfg.dy;
        }

        private var orig_clanLock_x:Number = NaN;
        private var orig_clanLock_y:Number = NaN;
        private function setupClanLockField(cfg:Object):void
        {
            clanLock.scaleX = clanLock.scaleY = cfg.scale;
            clanLock.alpha = cfg.enabled ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
            if (isNaN(orig_clanLock_x))
                orig_clanLock_x = clanLock.x;
            clanLock.x = orig_clanLock_x + cfg.dx;
            if (isNaN(orig_clanLock_y))
                orig_clanLock_y = clanLock.y;
            clanLock.y = orig_clanLock_y + cfg.dy;
        }

        private function createMask(x:Number, y:Number, width:Number, height:Number):Shape
        {
            var mask:Shape = new Shape();
            mask.graphics.beginFill(0xFFFFFF, 1);
            mask.graphics.drawRect(x, y, width, height);
            mask.graphics.endFill();
            mask.visible = false;
            return mask;
        }

        private function updateDataXvm():void
        {
            try
            {
                var isExtraFieldsVisible:Boolean = false;
                if (_dataVO)
                {
                    if (!(_dataVO.buySlot || _dataVO.buyTank))
                    {
                        var tankIconVO:TankIconVO = _dataVO.getTankIconVO();
                        if (tankIconVO)
                        {
                            var options:VOLobbyMacrosOptions = new VOLobbyMacrosOptions();
                            options.vehicleData = VehicleInfo.getByIcon(tankIconVO.image);
                            var dossier:AccountDossier = Dossier.getAccountDossier();
                            if (dossier)
                            {
                                var vdata:VehicleDossierCut = dossier.getVehicleDossierCut(options.vehCD);
                                vdata.elite = tankIconVO.elite ? "elite" : null;
                                vdata.selected = this.selected ? "sel" : null;
                                options.vehicleData.__vehicleDossierCut = vdata;
                                _extraFields.update(options);
                                isExtraFieldsVisible = true;
                            }
                        }
                    }
                    else
                    {
                        // Add used slots count
                        if (_dataVO.buySlot && Config.config.hangar.carousel.showUsedSlots)
                        {
                            additionalText.visible = true;
                            additionalText.text = Locale.get("Used slots") + ": " + Xfw.cmd(COMMAND_XVM_CAROUSEL_GET_USED_SLOTS_COUNT);
                        }
                        if (_dataVO.buyTank && Config.config.hangar.carousel.showTotalSlots)
                        {
                            additionalText.text += " " + Locale.get("from") + " " + Xfw.cmd(COMMAND_XVM_CAROUSEL_GET_TOTAL_SLOTS_COUNT);
                        }
                    }
                }
                if (_extraFieldsHolder.visible != isExtraFieldsVisible)
                {
                    _extraFieldsHolder.visible = isExtraFieldsVisible;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
