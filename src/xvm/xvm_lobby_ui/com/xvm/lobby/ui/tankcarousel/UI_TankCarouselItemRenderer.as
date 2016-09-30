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
    import com.xvm.vo.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.lobby.hangar.tcarousel.*;
    import net.wg.gui.lobby.hangar.tcarousel.data.*;
    import scaleform.gfx.TextFieldEx;

    public /*dynamic*/ class UI_TankCarouselItemRenderer extends TankCarouselItemRendererUI implements IExtraFieldGroupHolder
    {
        public static const DEFAULT_WIDTH:int = 162;
        public static const DEFAULT_HEIGHT:int = 102;

        private static const COMMAND_XVM_CAROUSEL_GET_USED_SLOTS_COUNT:String = 'xvm_carousel.get_used_slots_count';
        private static const COMMAND_XVM_CAROUSEL_GET_TOTAL_SLOTS_COUNT:String = 'xvm_carousel.get_total_slots_count';

        private var cfg:CCarouselCell;

        private var _substrateHolder:Sprite;
        private var _bottomHolder:Sprite;
        private var _normalHolder:Sprite;
        private var _topHolder:Sprite;
        private var _extraFields:ExtraFieldsGroup = null;

        public function UI_TankCarouselItemRenderer()
        {
            //Logger.add(getQualifiedClassName(this));
            super();
            cfg = Config.config.hangar.carousel.normal;
            width = int(Macros.FormatNumberGlobal(cfg.width, DEFAULT_WIDTH - 2) + 2);
            height = int(Macros.FormatNumberGlobal(cfg.height, DEFAULT_HEIGHT - 2) + 2);
            scrollRect = new Rectangle(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT);
            try
            {
                _substrateHolder = createExtraFieldsHolder(this, 0);
                _substrateHolder = createExtraFieldsHolder(this, getChildIndex(content));
                _normalHolder = createExtraFieldsHolder(content, content.getChildIndex(content.clanLock));
                _topHolder = createExtraFieldsHolder(this, getChildIndex(focusIndicator) + 1);

                createExtraFields();
                //App.utils.scheduler.scheduleTask(function():void {
                setupStandardFields();
                //}, 3000);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override protected function configUI():void
        {
            super.configUI();
        }

        override protected function onDispose():void
        {
            disposeExtraFields();

            _substrateHolder = null;
            _bottomHolder = null;
            _normalHolder = null;
            _topHolder = null;

            super.onDispose();
        }

        override public function set data(value:Object):void
        {
            if (!value)
            {
                _extraFields.visible = false;
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

        // IExtraFieldGroupHolder

        public function get isLeftPanel():Boolean
        {
            return true;
        }

        public function get substrateHolder():Sprite
        {
            return _substrateHolder;
        }

        public function get bottomHolder():Sprite
        {
            return _bottomHolder;
        }

        public function get normalHolder():Sprite
        {
            return _normalHolder;
        }

        public function get topHolder():Sprite
        {
            return _topHolder;
        }

        public function getSchemeNameForVehicle(options:IVOMacrosOptions):String
        {
            return null;
        }

        public function getSchemeNameForPlayer(options:IVOMacrosOptions):String
        {
            return null;
        }

        // PRIVATE

        private function setupStandardFields():void
        {
            setupStandardFieldTankType();
            setupStandardFieldLevel();
            setupStandardFieldXp();
            setupStandardFieldTankName();
            setupStandardFieldRentInfo();
            setupStandardFieldClanLock();
            setupStandardFieldInfo();
            setupStandardFieldPrice();
            setupStandardFieldActionPrice();
        }

        private function setupStandardFieldAlpha(field:InteractiveObject, cfg:Object):void
        {
            field.alpha = cfg.enabled ? Math.max(Math.min(cfg.alpha, 100), 0) / 100.0 : 0;
        }

        private function setupStandardFieldScale(field:InteractiveObject, cfg:Object):void
        {
            field.scaleX = DEFAULT_WIDTH / width * cfg.scale;
            field.scaleY = DEFAULT_HEIGHT / height * cfg.scale;
            field.x = (field.x * field.scaleX) + cfg.dx;
            field.y = (field.y * field.scaleY) + cfg.dy;
        }

        private function setupStandardFieldTankType():void
        {
            setupStandardFieldAlpha(content.mcTankType, cfg.fields.tankType);
            setupStandardFieldScale(content.mcTankType, cfg.fields.tankType);
        }

        private function setupStandardFieldLevel():void
        {
            setupStandardFieldAlpha(content.mcLevel, cfg.fields.level);
            setupStandardFieldScale(content.mcLevel, cfg.fields.level);
        }

        private function setupStandardFieldXp():void
        {
            var dx:Number = DEFAULT_WIDTH - content.imgXp.x - 2;
            setupStandardFieldAlpha(content.imgXp, cfg.fields.xp);
            setupStandardFieldScale(content.imgXp, cfg.fields.xp);
            content.imgXp.x = DEFAULT_WIDTH - dx * content.imgXp.scaleX + cfg.fields.xp.dx;
        }

        private function setupStandardFieldTankName():void
        {
            setupStandardFieldAlpha(content.txtTankName, cfg.fields.tankName);
            content.txtTankName.scaleX = cfg.fields.tankName.scale;
            content.txtTankName.scaleY = cfg.fields.tankName.scale;
            content.txtTankName.antiAliasType = AntiAliasType.ADVANCED;
            content.txtTankName.x = 0;
            content.txtTankName.y = 0;
            content.txtTankName.width = DEFAULT_WIDTH / content.txtTankName.scaleX - 2 + cfg.fields.tankName.dx;
            content.txtTankName.height = DEFAULT_HEIGHT / content.txtTankName.scaleY - 2 + cfg.fields.tankName.dy;
            content.txtTankName.autoSize = TextFieldAutoSize.NONE;
            content.txtTankName.defaultTextFormat.align = TextFormatAlign.RIGHT;
            TextFieldEx.setVerticalAlign(content.txtTankName, TextFieldEx.VALIGN_BOTTOM);
        }

        private function setupStandardFieldRentInfo():void
        {
            setupStandardFieldAlpha((content as TankIcon).txtRentInfo, cfg.fields.rentInfo);
            //(content as TankIcon).txtRentInfo.visible = true;
            //(content as TankIcon).txtRentInfo.htmlText = "<font color='#ffffff'>txtRentInfo</font>";
        }

        private function setupStandardFieldClanLock():void
        {
            setupStandardFieldAlpha(content.clanLock, cfg.fields.clanLock);
            //content.clanLock.visible = true;
            //content.clanLock.textField.htmlText = "<font color='#ffffff'>clanLock</font>";
        }

        private function setupStandardFieldInfo():void
        {
            setupStandardFieldAlpha(content.txtInfo, cfg.fields.info);
            //content.txtInfo.visible = true;
            //content.txtInfo.htmlText = "<font color='#ffffff'>txtInfo</font>";
        }

        private function setupStandardFieldPrice():void
        {
            setupStandardFieldAlpha(content.price, cfg.fields.price);
            //content.price.visible = true;
            //content.price.text = "price";
        }

        private function setupStandardFieldActionPrice():void
        {
            setupStandardFieldAlpha(content.actionPrice, cfg.fields.actionPrice);
            //content.actionPrice.visible = true;
            //content.actionPrice.iconText.text = "act";
        }

        private var orig_tankIcon_txtTankName_y:Number = NaN;
        private function setupTankNameField(cfg:Object):void
        {
//            content.txtTankName.scaleX = content.txtTankName.scaleY = cfg.scale;
//            content.txtTankName.alpha = cfg.enabled ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
//            content.txtTankName.x = 2 + cfg.dx;
//            content.txtTankName.width = width - 6;
//            if (isNaN(orig_tankIcon_txtTankName_y))
//                orig_tankIcon_txtTankName_y = content.txtTankName.y;
//            content.txtTankName.y = orig_tankIcon_txtTankName_y + cfg.dy;
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

        // extra fields

        private function createExtraFieldsHolder(owner:Sprite, index:int):Sprite
        {
            var sprite:Sprite = new Sprite();
            sprite.x = 0;
            sprite.y = 0;
            sprite.mouseEnabled = false;
            sprite.mouseChildren = false;
            sprite.scaleX = DEFAULT_WIDTH / width;
            sprite.scaleY = DEFAULT_HEIGHT / height;
            owner.addChildAt(sprite, index);
            return sprite;
        }

        private function createExtraFields():void
        {
            var formats:Array = cfg.extraFields;
            if (formats && formats.length)
            {
                _extraFields = new ExtraFieldsGroup(this, formats, CTextFormat.GetDefaultConfigForLobby());
            }
        }

        private function disposeExtraFields():void
        {
            if (_extraFields)
            {
                _extraFields.dispose();
                _extraFields = null;
            }
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
                        if (dataVO.icon)
                        {
                            var options:VOLobbyMacrosOptions = new VOLobbyMacrosOptions();
                            options.vehicleData = VehicleInfo.getByIcon(dataVO.icon);
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
                                _extraFields.update(options, 0);
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
                _extraFields.visible = isExtraFieldsVisible;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
