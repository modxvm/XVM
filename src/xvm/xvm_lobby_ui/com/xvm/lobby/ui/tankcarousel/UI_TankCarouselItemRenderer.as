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
    import net.wg.gui.lobby.hangar.tcarousel.*;
    import net.wg.gui.lobby.hangar.tcarousel.data.*;

    public /*dynamic*/ class UI_TankCarouselItemRenderer extends TankCarouselItemRendererUI
    {
        public static const ITEM_WIDTH:int = 160;
        public static const ITEM_HEIGHT:int = 100;

        private static const COMMAND_XVM_CAROUSEL_GET_USED_SLOTS_COUNT:String = 'xvm_carousel.get_used_slots_count';
        private static const COMMAND_XVM_CAROUSEL_GET_TOTAL_SLOTS_COUNT:String = 'xvm_carousel.get_total_slots_count';

        private var cfg:CCarousel;
        private var _extraFieldsHolder:MovieClip = null;
        private var _extraFields:ExtraFields = null;

        public function UI_TankCarouselItemRenderer()
        {
            //Logger.add(getQualifiedClassName(this));
            super();
            cfg = Config.config.hangar.carousel;
            try
            {
                scaleX = scaleY = cfg.zoom;
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
            super.onDispose();
        }

        override public function set data(value:Object):void
        {
            if (!value)
            {
                _extraFieldsHolder.visible = false;
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
                _extraFieldsHolder = new MovieClip();
                _extraFieldsHolder.x = this.content.x + 1;
                _extraFieldsHolder.y = this.content.y + 1;
                _extraFieldsHolder.mouseEnabled = false;
                _extraFieldsHolder.mouseChildren = false;
                addChildAt(_extraFieldsHolder, this.getChildIndex(this.content) + 1);

                _extraFields = new ExtraFields(cfg.extraFields, true, null, null, null, null, null, CTextFormat.GetDefaultConfigForLobby());
                _extraFields.scaleX = _extraFields.scaleY = 1 / zoom;
                // TODO
                //_extraFieldsHolder.addChild(_extraFields);
                _extraFieldsHolder.mask = _extraFieldsHolder.addChild(createMask(-2, -2, ITEM_WIDTH + 4, ITEM_HEIGHT + 4));
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function setupStandardFields():void
        {
            var zoom:Number = cfg.zoom;
            var w:int = Math.ceil(ITEM_WIDTH * zoom);
            var h:int = Math.ceil(ITEM_HEIGHT * zoom);

            setupStandardField(content.imgXp, cfg.fields.multiXp);
            content.imgXp.x = w - content.imgXp.width + cfg.fields.multiXp.dx;

            setupStandardField(content.mcTankType, cfg.fields.tankType);

            // TODO
            /*
            content.txtInfo.x -= 10;
            content.txtInfo.width += 20;*/

            //content.mcLevel.visible = false;
            //App.utils.scheduler.scheduleOnNextFrame(function():void {
            //    if (content == null)
            //        return;
                setupStandardField(content.mcLevel, cfg.fields.level);
            //    content.mcLevel.visible = true;
            //});

            setupTankNameField(cfg.fields.tankName);
            setupInfoTextField(cfg.fields.statusText);
            setupClanLockField(cfg.fields.clanLock);
        }

        private function setupStandardField(sprite:Sprite, cfg:Object):void
        {
            _extraFields.addChildAt(sprite, 0);
            sprite.scaleX = sprite.scaleY = cfg.scale;
            sprite.alpha = cfg.enabled ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
            sprite.x += cfg.dx;
            sprite.y += cfg.dy;
        }

        private var orig_tankIcon_txtTankName_y:Number = NaN;
        private function setupTankNameField(cfg:Object):void
        {
            content.txtTankName.scaleX = content.txtTankName.scaleY = cfg.scale;
            content.txtTankName.alpha = cfg.enabled ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
            content.txtTankName.x = 2 + cfg.dx;
            content.txtTankName.width = ITEM_WIDTH - 4;
            if (isNaN(orig_tankIcon_txtTankName_y))
                orig_tankIcon_txtTankName_y = content.txtTankName.y;
            content.txtTankName.y = orig_tankIcon_txtTankName_y + cfg.dy;
        }

        private var orig_infoText_x:Number = NaN;
        private var orig_infoText_y:Number = NaN;
        private function setupInfoTextField(cfg:Object):void
        {
            // TODO
            /*
            infoText.scaleX = infoText.scaleY = cfg.scale;
            infoText.alpha = cfg.enabled ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
            if (isNaN(orig_infoText_x))
                orig_infoText_x = infoText.x;
            infoText.x = orig_infoText_x + cfg.dx;
            if (isNaN(orig_infoText_y))
                orig_infoText_y = infoText.y;
            infoText.y = orig_infoText_y + cfg.dy;
            */
        }

        private var orig_clanLock_x:Number = NaN;
        private var orig_clanLock_y:Number = NaN;
        private function setupClanLockField(cfg:Object):void
        {
            // TODO
            /*
            clanLock.scaleX = clanLock.scaleY = cfg.scale;
            clanLock.alpha = cfg.enabled ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
            if (isNaN(orig_clanLock_x))
                orig_clanLock_x = clanLock.x;
            clanLock.x = orig_clanLock_x + cfg.dx;
            if (isNaN(orig_clanLock_y))
                orig_clanLock_y = clanLock.y;
            clanLock.y = orig_clanLock_y + cfg.dy;
            */
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
                if (dataVO)
                {
                    if (!(dataVO.buySlot || dataVO.buyTank))
                    {
                        setupInfoTextField(cfg.fields.statusText);
                        if (dataVO.id)
                        {
                            var options:VOLobbyMacrosOptions = new VOLobbyMacrosOptions();
                            options.vehicleData = VehicleInfo.get(dataVO.id);
                            var dossier:AccountDossier = Dossier.getAccountDossier();
                            if (dossier)
                            {
                                var vdata:VehicleDossierCut = dossier.getVehicleDossierCut(options.vehCD);
                                vdata.elite = dataVO.elite ? "elite" : null;
                                vdata.selected = this.selected ? "sel" : null;
                                if (options.vehicleData)
                                {
                                    options.vehicleData.__vehicleDossierCut = vdata;
                                }
                                _extraFields.update(options);
                                isExtraFieldsVisible = true;
                            }
                        }
                    }
                    else
                    {
                        setupInfoTextField(cfg.fields.statusTextBuy);
                        // Add used slots count
                        // TODO
                        /*
                        if (dataVO.buySlot && Config.config.hangar.carousel.showUsedSlots)
                        {
                            additionalText.visible = true;
                            additionalText.text = Locale.get("Used slots") + ": " + Xfw.cmd(COMMAND_XVM_CAROUSEL_GET_USED_SLOTS_COUNT);
                        }
                        if (dataVO.buyTank && Config.config.hangar.carousel.showTotalSlots)
                        {
                            additionalText.text += " " + Locale.get("from") + " " + Xfw.cmd(COMMAND_XVM_CAROUSEL_GET_TOTAL_SLOTS_COUNT);
                        }
                        */
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
