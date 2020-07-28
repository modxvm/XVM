/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
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
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.hangar.tcarousel.*;
    import scaleform.clik.interfaces.*;
    import scaleform.gfx.*;

    public class TankCarouselItemRendererHelper
    {
        private static const COMMAND_XVM_CAROUSEL_GET_USED_SLOTS_COUNT:String = 'xvm_carousel.get_used_slots_count';
        private static const COMMAND_XVM_CAROUSEL_GET_TOTAL_SLOTS_COUNT:String = 'xvm_carousel.get_total_slots_count';

        private var cfg:CCarouselCell;
        private var item:ITankCarouselItemRenderer;
        private var renderer:TankCarouselItemRenderer;
        private var DEFAULT_WIDTH:int;
        private var DEFAULT_HEIGHT:int;

        public function TankCarouselItemRendererHelper(item:ITankCarouselItemRenderer, cfg:CCarouselCell, defaultWidth:int, defaultHeight:int):void
        {
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init(item, cfg, defaultWidth, defaultHeight);
        }

        private function _init(item:ITankCarouselItemRenderer, cfg:CCarouselCell, defaultWidth:int, defaultHeight:int):void
        {
            this.cfg = cfg;
            this.item = item;
            this.DEFAULT_WIDTH = defaultWidth;
            this.DEFAULT_HEIGHT = defaultHeight;

            renderer = item as TankCarouselItemRenderer;
            //XfwUtils.logChilds(renderer);

            renderer.width = int(Macros.FormatNumberGlobal(cfg.width, DEFAULT_WIDTH - 2) + 2);
            renderer.height = int(Macros.FormatNumberGlobal(cfg.height, DEFAULT_HEIGHT - 2) + 2);
            renderer.content.scrollRect = new Rectangle(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT);
            renderer.setActualSize(renderer.width, renderer.height);

            var formats:Array = cfg.extraFields;
            if (formats)
            {
                if (formats.length)
                {
                    item.substrateHolder = _createExtraFieldsHolder(renderer, 0);
                    item.bottomHolder = _createExtraFieldsHolder(renderer, renderer.getChildIndex(renderer.content));
                    item.normalHolder = _createExtraFieldsHolder(renderer.content, renderer.content.getChildIndex(renderer.content.clanLock));
                    item.topHolder = _createExtraFieldsHolder(renderer, renderer.getChildIndex(renderer.focusIndicator) + 1);
                    item.extraFields = new ExtraFieldsGroup(item as IExtraFieldGroupHolder, formats, false, CTextFormat.GetDefaultConfigForLobby());
                }
            }

            //App.utils.scheduler.scheduleTask(function():void {
            _setupStandardFieldFlag();
            _setupStandardFieldTankIcon();
            _setupStandardFieldTankType();
            _setupStandardFieldLevel();
            _setupStandardFieldXp();
            _setupStandardFieldTankName();
            _setupStandardFieldRentInfo();
            _setupStandardFieldClanLock();
            _setupStandardFieldPrice();
            _setupStandardFieldActionPrice();
            _setupStandardFieldFavorite();
            _setupStandardFieldCrystalsBorder();
            _setupStandardFieldCrystalsIcon();
            _setupStandardFieldStats();
            //}, 1000);
        }

        public function dispose():void
        {
            if (item.extraFields)
            {
                item.extraFields.dispose();
                item.extraFields = null;
            }

            item.substrateHolder = null;
            item.bottomHolder = null;
            item.normalHolder = null;
            item.topHolder = null;
        }

        public function draw():void
        {
            _setupStandardFieldAlpha(renderer.content.txtTankName, cfg.fields.tankName);
        }

        // extra fields

        public function fixData(value:Object):void
        {
            if (cfg.fields.infoImg.enabled == false)
            {
                value.infoImgSrc = "";
            }
        }

        public function updateDataXvm():void
        {
            try
            {
                var isExtraFieldsVisible:Boolean = false;
                if (item.vehicleCarouselVO)
                {
                    _setupStandardFieldInfo();
                    _setupStandardFieldTankName();
                    if (!(item.vehicleCarouselVO.buySlot || item.vehicleCarouselVO.buyTank || item.vehicleCarouselVO.restoreTank))
                    {
                        if (item.extraFields)
                        {
                            if (item.vehicleCarouselVO.icon)
                            {
                                var options:VOLobbyMacrosOptions = new VOLobbyMacrosOptions();
                                options.vehicleData = VehicleInfo.getByIcon(item.vehicleCarouselVO.icon);
                                var dossier:AccountDossier = Dossier.getAccountDossier();
                                if (dossier)
                                {
                                    var vdata:VehicleDossierCut = dossier.getVehicleDossierCut(options.vehCD);
                                    //Logger.addObject(item.vehicleCarouselVO);
                                    vdata.elite = XfwUtils.endsWith(item.vehicleCarouselVO.tankType, "_elite") ? "elite" : null; // FIXIT: why item.vehicleCarouselVO.elite altays false?
                                    vdata.selected = renderer.selected ? "sel" : null;
                                    if (options.vehicleData)
                                    {
                                        options.vehicleData.__vehicleDossierCut = vdata;
                                    }
                                    item.extraFields.update(options);
                                    isExtraFieldsVisible = true;
                                }
                            }
                        }
                    }
                    else
                    {
                        _addSlotsCount();
                    }
                }
                if (item.extraFields)
                {
                    item.extraFields.visible = isExtraFieldsVisible;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function handleRollOver():void
        {
            _setupStandardFieldInfo();
            if (item.vehicleCarouselVO)
            {
                _addSlotsCount();
            }
            //updateDataXvm();
        }

        public function handleRollOut():void
        {
            _setupStandardFieldInfo();
            if (item.vehicleCarouselVO)
            {
                _addSlotsCount();
            }
            //updateDataXvm()
        }

        // PRIVATE

        private function _addSlotsCount():void
        {
            if (item.vehicleCarouselVO.buySlot)
            {
                if (Config.config.hangar.carousel.showUsedSlots)
                {
                    var height:Number = renderer.content.txtInfo.height;
                    renderer.content.txtInfo.htmlText =
                        "<p align='center'>" + item.vehicleCarouselVO.infoText + "\n" +
                        "<font face='$FieldFont' size='14' color='#8C8C7E'>" +
                        Locale.get("Used slots") + ": " + Xfw.cmd(COMMAND_XVM_CAROUSEL_GET_USED_SLOTS_COUNT) + "</font></p>";
                    // Centering in height
                    renderer.content.txtInfo.y -= 8;
                }
            }
            if (item.vehicleCarouselVO.buyTank)
            {
                if (Config.config.hangar.carousel.showTotalSlots)
                {
                    renderer.content.txtInfo.htmlText =
                        "<p align='center'>" + item.vehicleCarouselVO.infoText + " " +
                        "<font face='$FieldFont' size='14' color='#8C8C7E'>" +
                        Locale.get("from") + " " + Xfw.cmd(COMMAND_XVM_CAROUSEL_GET_TOTAL_SLOTS_COUNT) + "</font></p>";
                }
            }
        }

        private function _createExtraFieldsHolder(owner:IUIComponent, index:int):Sprite
        {
            var sprite:Sprite = new Sprite();
            sprite.x = 0;
            sprite.y = 0;
            sprite.mouseEnabled = false;
            sprite.mouseChildren = false;
            sprite.scaleX = DEFAULT_WIDTH / item.width;
            sprite.scaleY = DEFAULT_HEIGHT / item.height;
            sprite.scrollRect = new Rectangle(0, 0, item.width, item.height);
            owner.addChildAt(sprite, index);
            return sprite;
        }

        // standard fields

        private function _setupStandardFieldAlpha(field:InteractiveObject, cfg:CCarouselCellStandardField):void
        {
            field.alpha = cfg.enabled ? Math.max(Math.min(cfg.alpha, 100), 0) / 100.0 : 0;
        }

        private function _setupStandardFieldScale(field:InteractiveObject, cfg:CCarouselCellStandardField):void
        {
            var scale:Number = isNaN(cfg.scale) ? 1 : cfg.scale;
            field.scaleX = DEFAULT_WIDTH / item.width * scale;
            field.scaleY = DEFAULT_HEIGHT / item.height * scale;
            field.x = (field.x * field.scaleX) + cfg.dx;
            field.y = (field.y * field.scaleY) + cfg.dy;
        }

        private function _setupStandardFieldFlag():void
        {
            _setupStandardFieldAlpha(renderer.content.mcFlag, cfg.fields.flag);
            _setupStandardFieldScale(renderer.content.mcFlag, cfg.fields.flag);
        }

        private function _setupStandardFieldTankIcon():void
        {
            _setupStandardFieldAlpha(renderer.content.imgIcon, cfg.fields.tankIcon);
            //_setupStandardFieldScale(renderer.content.imgIcon, cfg.fields.tankIcon);
            renderer.content.imgIcon.x += cfg.fields.tankIcon.dx;
            renderer.content.imgIcon.y += cfg.fields.tankIcon.dy;
        }

        private function _setupStandardFieldTankType():void
        {
            _setupStandardFieldAlpha(renderer.content.mcTankType, cfg.fields.tankType);
            _setupStandardFieldScale(renderer.content.mcTankType, cfg.fields.tankType);
        }

        private function _setupStandardFieldLevel():void
        {
            _setupStandardFieldAlpha(renderer.content.mcLevel, cfg.fields.level);
            _setupStandardFieldScale(renderer.content.mcLevel, cfg.fields.level);
        }

        private function _setupStandardFieldXp():void
        {
            var dx:Number = DEFAULT_WIDTH - renderer.content.imgXp.x - 2;
            _setupStandardFieldAlpha(renderer.content.imgXp, cfg.fields.xp);
            _setupStandardFieldScale(renderer.content.imgXp, cfg.fields.xp);
            renderer.content.imgXp.x = DEFAULT_WIDTH - dx * renderer.content.imgXp.scaleX + cfg.fields.xp.dx;
        }

        private function _setupStandardTextField(field:TextField, cfg:CCarouselCellStandardField, dy:Number):void
        {
            field.antiAliasType = AntiAliasType.ADVANCED;
            field.x = cfg.dx + 2;
            field.width = (DEFAULT_WIDTH - 4) / field.scaleX;
            field.autoSize = TextFieldAutoSize.NONE;
            field.defaultTextFormat.align = TextFormatAlign.RIGHT;
            _setupTextFormat(field, cfg.textFormat);
            _setupShadow(field, cfg.shadow);
            //field.border = true; field.borderColor = 0xFFFF00; // DEBUG
        }

        private function _setupTextFormat(field:TextField, cfg:CTextFormat):void
        {
            if (cfg != null)
            {
                cfg = cfg.clone();
                if (Macros.FormatBooleanGlobal(cfg.enabled, true))
                {
                    var tf:TextFormat = field.getTextFormat();

                    if (cfg.font != null)
                        tf.font = Macros.FormatStringGlobal(cfg.font, tf.font);
                    if (cfg.size != null)
                        tf.size = Macros.FormatNumberGlobal(cfg.size);
                    if (cfg.color != null)
                        tf.color = Macros.FormatNumberGlobal(cfg.color);
                    if (cfg.bold != null)
                        tf.bold = Macros.FormatBooleanGlobal(cfg.bold);
                    if (cfg.italic != null)
                        tf.italic = Macros.FormatBooleanGlobal(cfg.italic);
                    if (cfg.underline != null)
                        tf.underline = Macros.FormatBooleanGlobal(cfg.underline);
                    if (cfg.align != null)
                        tf.align = Macros.FormatStringGlobal(cfg.align);
                    if (cfg.leftMargin != null)
                        tf.leftMargin = Macros.FormatNumberGlobal(cfg.leftMargin);
                    if (cfg.rightMargin != null)
                        tf.rightMargin = Macros.FormatNumberGlobal(cfg.rightMargin);
                    if (cfg.indent != null)
                        tf.indent = Macros.FormatNumberGlobal(cfg.indent);
                    if (cfg.leading != null)
                        tf.leading = Macros.FormatNumberGlobal(cfg.leading);
                    if (cfg.valign != null)
                        TextFieldEx.setVerticalAlign(field, Macros.FormatStringGlobal(cfg.valign));
                    field.setTextFormat(tf);
                }
            }
        }

        private function _setupShadow(field:TextField, cfg:CShadow):void
        {
            if (cfg != null)
            {
                cfg = cfg.clone();
                if (Macros.FormatBooleanGlobal(cfg.enabled, true))
                {
                    var filter:DropShadowFilter = null;
                    var filters:Array = field.filters;
                    if (filters)
                    {
                        var len:int = filters.length;
                        for (var i:int = 0; i < len; ++i)
                        {
                            filter = filters[i] as DropShadowFilter;
                            if (filter != null)
                            {
                                break;
                            }
                        }
                    }
                    if (filter == null)
                    {
                        filter = Utils.createShadowFiltersFromConfig(CShadow.GetDefaultConfig())[0];
                    }
                    if (cfg.distance != null)
                        filter.distance = Macros.FormatNumberGlobal(cfg.distance);
                    if (cfg.angle != null)
                        filter.angle = Macros.FormatNumberGlobal(cfg.angle);
                    if (cfg.color != null)
                        filter.color = Macros.FormatNumberGlobal(cfg.color);
                    if (cfg.alpha != null)
                        filter.alpha = Macros.FormatNumberGlobal(cfg.alpha);
                    if (cfg.blur != null)
                        filter.blurX = filter.blurY = Macros.FormatNumberGlobal(cfg.blur);
                    if (cfg.strength != null)
                        filter.strength = Macros.FormatNumberGlobal(cfg.strength);
                    if (cfg.quality != null)
                        filter.quality = Macros.FormatNumberGlobal(cfg.quality);
                    if (cfg.inner != null)
                        filter.inner = Macros.FormatBooleanGlobal(cfg.inner);
                    if (cfg.knockout != null)
                        filter.knockout = Macros.FormatBooleanGlobal(cfg.knockout);
                    if (cfg.hideObject != null)
                        filter.hideObject = Macros.FormatBooleanGlobal(cfg.hideObject);
                    field.filters = [filter];
                }
            }
        }
        private var orig_TankName_x:Number = NaN;
        private var orig_TankName_y:Number = NaN;
        private function _setupStandardFieldTankName():void
        {
            var cfg_tankName:CCarouselCellStandardField = cfg.fields.tankName;
            var tankName:InteractiveObject = renderer.content.txtTankName;
            var scale:Number = isNaN(cfg_tankName.scale) ? 1 : cfg_tankName.scale;
            if (isNaN(orig_TankName_x))
            {
                orig_TankName_x = tankName.x;
                orig_TankName_y = tankName.y;
            }
            tankName.scaleX = DEFAULT_WIDTH / item.width * scale;
            tankName.scaleY = DEFAULT_HEIGHT / item.height * scale;
            tankName.x = (orig_TankName_x * tankName.scaleX) + cfg_tankName.dx;
            tankName.y = (orig_TankName_y * tankName.scaleY) + cfg_tankName.dy;
            //var dy:Number = DEFAULT_HEIGHT - renderer.content.txtTankName.y - 2;
            _setupStandardFieldAlpha(renderer.content.txtTankName, cfg_tankName);
            //_setupStandardFieldScale(renderer.content.txtTankName, cfg.fields.tankName);
            _setupStandardTextField(renderer.content.txtTankName, cfg_tankName, 0);
            //renderer.content.txtTankName.y = DEFAULT_HEIGHT - dy * renderer.content.txtTankName.scaleY + cfg.fields.xp.dy;
            if (item.vehicleCarouselVO && item.vehicleCarouselVO.isNationChangeAvailable)
            {
                renderer.content.txtTankName.width = (DEFAULT_WIDTH - 4 - 23) / tankName.scaleX;
            }
        }

        private function _setupStandardFieldRentInfo():void
        {
            var tankicon:TankIcon = renderer.content as TankIcon;
            if (tankicon)
            {
                var field:TextField = tankicon.txtRentInfo;
                //var dy:Number = DEFAULT_HEIGHT - field.y - 2;
                _setupStandardFieldAlpha(field, cfg.fields.rentInfo);
                _setupStandardFieldScale(field, cfg.fields.rentInfo);
                _setupStandardTextField(field, cfg.fields.rentInfo, DEFAULT_HEIGHT - field.y - field.height - 2);
                //field.y = DEFAULT_HEIGHT - dy * field.scaleY + cfg.fields.xp.dy;
                //field.visible = true; field.htmlText = "<font color='#ffffff'>txtRentInfo</font>"; // DEBUG
            }
        }

        private function _setupStandardFieldClanLock():void
        {
            _setupStandardFieldAlpha(renderer.content.clanLock, cfg.fields.clanLock);
            renderer.content.clanLock.x += cfg.fields.clanLock.dx;
            renderer.content.clanLock.y += cfg.fields.clanLock.dy;
            // DEBUG
            /*
            App.utils.scheduler.scheduleTask(function():void {
                renderer.content.clanLock.visible = true;
                renderer.content.clanLock.textField.htmlText = "<font color='#ffffff'>clanLock</font>";
            }, 1000);
            */
        }

        private function _setupStandardFieldPrice():void
        {
            _setupStandardFieldAlpha(renderer.content.price, cfg.fields.price);
            renderer.content.price.x += cfg.fields.price.dx;
            renderer.content.price.y += cfg.fields.price.dy;
            //renderer.content.price.visible = true; renderer.content.price.text = "price"; // DEBUG
        }

        private function _setupStandardFieldActionPrice():void
        {
            _setupStandardFieldAlpha(renderer.content.actionPrice, cfg.fields.actionPrice);
            renderer.content.actionPrice.x += cfg.fields.actionPrice.dx;
            renderer.content.actionPrice.y += cfg.fields.actionPrice.dy;
            //renderer.content.actionPrice.visible = true; renderer.content.actionPrice.iconText.text = "act"; // DEBUG
        }

        private function _setupStandardFieldFavorite():void
        {
            _setupStandardFieldAlpha(renderer.content.imgFavorite, cfg.fields.favorite);
            _setupStandardFieldScale(renderer.content.imgFavorite, cfg.fields.favorite);
        }

        private function _setupStandardFieldCrystalsBorder():void
        {
            _setupStandardFieldAlpha(renderer.crystalsBorder, cfg.fields.crystalsBorder);
            _setupStandardFieldAlpha(renderer.content.crystalsGlow, cfg.fields.crystalsBorder);
            _setupStandardFieldAlpha(renderer.content.crystalsGlowBlend, cfg.fields.crystalsBorder);
        }

        private function _setupStandardFieldCrystalsIcon():void
        {
            _setupStandardFieldAlpha(renderer.content.crystalsIcon, cfg.fields.crystalsIcon);
        }

        private function _setupStandardFieldStats():void
        {
            _setupStandardFieldAlpha(renderer.content.statsBg, cfg.fields.stats);

            var _scaleX:Number = renderer.content.statsBg.scaleX;
            _setupStandardFieldScale(renderer.content.statsBg, cfg.fields.stats);
            renderer.content.statsBg.scaleX *= _scaleX;

            _setupStandardFieldAlpha(renderer.content.statsTF, cfg.fields.stats);
            _setupStandardFieldScale(renderer.content.statsTF, cfg.fields.stats);
            _setupStandardTextField(renderer.content.statsTF, cfg.fields.stats, 0);
        }
//
        private var orig_txtInfo_x:Number = NaN;
        private var orig_txtInfo_y:Number = NaN;
        private var orig_infoImg_x:Number = NaN;
        private var orig_infoImg_y:Number = NaN;
        private function _setupStandardFieldInfo():void
        {
            var cfgInfo:CCarouselCellStandardField = null;
            if (item.vehicleCarouselVO)
            {
                if (!(item.vehicleCarouselVO.buySlot || item.vehicleCarouselVO.buyTank || item.vehicleCarouselVO.restoreTank))
                {
                    cfgInfo = cfg.fields.info;
                }
                else
                {
                    cfgInfo = cfg.fields.infoBuy;
                }
            }
            else
            {
                return;
            }

            var field:TextField = renderer.content.txtInfo;
            var tf:TextFormat = field.getTextFormat();
            var img:Image = renderer.content.infoImg as Image;
            if (isNaN(orig_txtInfo_x))
            {
                orig_txtInfo_x = field.x;
                orig_txtInfo_y = field.y;
                orig_infoImg_x = img.x;
                orig_infoImg_y = img.y;
            }

            //var orig_txtInfo_x:Number = field.x;
            //var orig_txtInfo_y:Number = field.y;
            //var orig_infoImg_x:Number = img.x;
            //var orig_infoImg_y:Number = img.y;

            _setupStandardFieldAlpha(field, cfgInfo);
            _setupStandardFieldScale(field, cfgInfo);
            field.antiAliasType = AntiAliasType.ADVANCED;
            if (cfg.fields.infoImg.enabled && img.visible)
            {
                field.x = orig_txtInfo_x + cfgInfo.dx;
                tf.align = TEXT_ALIGN.LEFT;
            }
            else
            {
                field.x = cfgInfo.dx;
                tf.align = TEXT_ALIGN.CENTER;
            }
            field.setTextFormat(tf);
            field.y = orig_txtInfo_y + cfgInfo.dy;
            field.width = DEFAULT_WIDTH / cfgInfo.scale;
            field.height = DEFAULT_HEIGHT / cfgInfo.scale;
            _setupTextFormat(field, cfgInfo.textFormat);
            _setupShadow(field, cfgInfo.shadow);
            //field.border = true; field.borderColor = 0xFFFF00; // DEBUG

            if (img)
            {
                _setupStandardFieldAlpha(img, cfg.fields.infoImg);
                _setupStandardFieldScale(img, cfg.fields.infoImg);
                img.x = orig_infoImg_x + cfg.fields.infoImg.dx;
                img.y = orig_infoImg_y + cfg.fields.infoImg.dy;
            }
        }
    }
}
