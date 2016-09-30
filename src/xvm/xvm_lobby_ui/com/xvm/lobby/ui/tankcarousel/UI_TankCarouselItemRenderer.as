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
    import flash.utils.*;
    import flash.geom.*;
    import net.wg.gui.lobby.hangar.tcarousel.*;
    import net.wg.gui.lobby.hangar.tcarousel.data.*;

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
            try
            {
                _substrateHolder = createExtraFieldsHolder(this, 0);
                _substrateHolder = createExtraFieldsHolder(this, getChildIndex(content));
                _normalHolder = createExtraFieldsHolder(content, content.getChildIndex(content.clanLock));
                _topHolder = createExtraFieldsHolder(this, getChildIndex(focusIndicator) + 1);

                createExtraFields();

                setupStandardFields();
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
//            var w:int = width - 2;
//            var h:int = height - 2;
//
//            setupStandardField(content.imgXp, cfg.fields.xp);
//            content.imgXp.x = w - content.imgXp.width + cfg.fields.xp.dx;
//
//            setupStandardField(content.mcTankType, cfg.fields.tankType);
//
//            // TODO
//            /*
//            content.txtInfo.x -= 10;
//            content.txtInfo.width += 20;*/
//
//            //content.mcLevel.visible = false;
//            //App.utils.scheduler.scheduleOnNextFrame(function():void {
//            //    if (content == null)
//            //        return;
//                setupStandardField(content.mcLevel, cfg.fields.level);
//            //    content.mcLevel.visible = true;
//            //});
//
//            setupTankNameField(cfg.fields.tankName);
//            setupInfoTextField(cfg.fields.statusText);
//            setupClanLockField(cfg.fields.clanLock);
        }

        private function setupStandardField(sprite:Sprite, cfg:Object):void
        {
//            _extraFields.addChildAt(sprite, 0);
//            sprite.scaleX = sprite.scaleY = cfg.scale;
//            sprite.alpha = cfg.enabled ? Math.max(Math.min(cfg.alpha / 100.0, 1), 0) : 0;
//            sprite.x += cfg.dx;
//            sprite.y += cfg.dy;
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
            sprite.scrollRect = new Rectangle(0, 0, width, height);
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
