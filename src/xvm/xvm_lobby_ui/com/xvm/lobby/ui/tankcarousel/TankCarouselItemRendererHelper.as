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
    import scaleform.gfx.*;
    import scaleform.clik.interfaces.IUIComponent;

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
            this.cfg = cfg;
            this.item = item;
            this.DEFAULT_WIDTH = defaultWidth;
            this.DEFAULT_HEIGHT = defaultHeight;

            renderer = item as TankCarouselItemRenderer;

            renderer.width = int(Macros.FormatNumberGlobal(cfg.width, DEFAULT_WIDTH - 2) + 2);
            renderer.height = int(Macros.FormatNumberGlobal(cfg.height, DEFAULT_HEIGHT - 2) + 2);
            renderer.scrollRect = new Rectangle(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT);

            item.substrateHolder = _createExtraFieldsHolder(renderer, 0);
            item.bottomHolder = _createExtraFieldsHolder(renderer, renderer.getChildIndex(renderer.content));
            item.normalHolder = _createExtraFieldsHolder(renderer.content, renderer.content.getChildIndex(renderer.content.clanLock));
            item.topHolder = _createExtraFieldsHolder(renderer, renderer.getChildIndex(renderer.focusIndicator) + 1);

            var formats:Array = cfg.extraFields;
            if (formats && formats.length)
            {
                item.extraFields = new ExtraFieldsGroup(item as IExtraFieldGroupHolder, formats, CTextFormat.GetDefaultConfigForLobby());
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
            _setupStandardFieldInfo(cfg.fields.info);
            _setupStandardFieldPrice();
            _setupStandardFieldActionPrice();
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

        // extra fields

        public function updateDataXvm():void
        {
            try
            {
                var isExtraFieldsVisible:Boolean = false;
                if (item.vehicleCarouselVO)
                {
                    if (!(item.vehicleCarouselVO.buySlot || item.vehicleCarouselVO.buyTank))
                    {
                        _setupStandardFieldInfo(cfg.fields.info);
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
                                item.extraFields.update(options, 0);
                                isExtraFieldsVisible = true;
                            }
                        }
                    }
                    else
                    {
                        _setupStandardFieldInfo(cfg.fields.infoBuy);
                        // Add used slots count
                        if (item.vehicleCarouselVO.buySlot && Config.config.hangar.carousel.showUsedSlots)
                        {
                            renderer.content.txtInfo.htmlText = item.vehicleCarouselVO.infoText + "\n<font face='$TextFont' size='12' color='#8C8C7E'>" +
                                Locale.get("Used slots") + ": " + Xfw.cmd(COMMAND_XVM_CAROUSEL_GET_USED_SLOTS_COUNT) + "</font>";
                        }
                        if (item.vehicleCarouselVO.buyTank && Config.config.hangar.carousel.showTotalSlots)
                        {
                            renderer.content.txtInfo.htmlText = item.vehicleCarouselVO.infoText + " <font face='$TextFont' size='12' color='#8C8C7E'>" +
                                Locale.get("from") + " " + Xfw.cmd(COMMAND_XVM_CAROUSEL_GET_TOTAL_SLOTS_COUNT) + "</font>";
                        }
                    }
                }
                item.extraFields.visible = isExtraFieldsVisible;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE

        private function _createExtraFieldsHolder(owner:IUIComponent, index:int):Sprite
        {
            var sprite:Sprite = new Sprite();
            sprite.x = 0;
            sprite.y = 0;
            sprite.mouseEnabled = false;
            sprite.mouseChildren = false;
            sprite.scaleX = DEFAULT_WIDTH / item.width;
            sprite.scaleY = DEFAULT_HEIGHT / item.height;
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
            field.scaleX = DEFAULT_WIDTH / item.width * cfg.scale;
            field.scaleY = DEFAULT_HEIGHT / item.height * cfg.scale;
            field.x = (field.x * field.scaleX) + cfg.dx;
            field.y = (field.y * field.scaleY) + cfg.dy;
        }

        public function _setupStandardFieldFlag():void
        {
            _setupStandardFieldAlpha(renderer.content.mcFlag, cfg.fields.flag);
            _setupStandardFieldScale(renderer.content.mcFlag, cfg.fields.flag);
        }

        public function _setupStandardFieldTankIcon():void
        {
            _setupStandardFieldAlpha(renderer.content.imgIcon, cfg.fields.tankIcon);
            _setupStandardFieldScale(renderer.content.imgIcon, cfg.fields.tankIcon);
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
            //field.border = true; field.borderColor = 0xFFFF00; // DEBUG
        }

        public function _setupStandardFieldTankName():void
        {
            _setupStandardFieldAlpha(renderer.content.txtTankName, cfg.fields.tankName);
            _setupStandardFieldScale(renderer.content.txtTankName, cfg.fields.tankName);
            _setupStandardTextField(renderer.content.txtTankName, cfg.fields.tankName, 0);
        }

        public function _setupStandardFieldRentInfo():void
        {
            var tankicon:TankIcon = renderer.content as TankIcon;
            if (tankicon)
            {
                var field:TextField = tankicon.txtRentInfo;
                _setupStandardFieldAlpha(field, cfg.fields.rentInfo);
                _setupStandardFieldScale(field, cfg.fields.rentInfo);
                _setupStandardTextField(field, cfg.fields.rentInfo, DEFAULT_HEIGHT - field.y - field.height - 2);
                //field.visible = true; field.htmlText = "<font color='#ffffff'>txtRentInfo</font>"; // DEBUG
            }
        }

        public function _setupStandardFieldClanLock():void
        {
            _setupStandardFieldAlpha(renderer.content.clanLock, cfg.fields.clanLock);
            renderer.content.clanLock.x += cfg.fields.clanLock.dx;
            renderer.content.clanLock.y += cfg.fields.clanLock.dy;
            //renderer.content.clanLock.visible = true; renderer.content.clanLock.textField.htmlText = "<font color='#ffffff'>clanLock</font>"; // DEBUG
        }

        public function _setupStandardFieldPrice():void
        {
            _setupStandardFieldAlpha(renderer.content.price, cfg.fields.price);
            renderer.content.price.x += cfg.fields.price.dx;
            renderer.content.price.y += cfg.fields.price.dy;
            //renderer.content.price.visible = true; renderer.content.price.text = "price"; // DEBUG
        }

        public function _setupStandardFieldActionPrice():void
        {
            _setupStandardFieldAlpha(renderer.content.actionPrice, cfg.fields.actionPrice);
            renderer.content.actionPrice.x += cfg.fields.actionPrice.dx;
            renderer.content.actionPrice.y += cfg.fields.actionPrice.dy;
            //renderer.content.actionPrice.visible = true; renderer.content.actionPrice.iconText.text = "act"; // DEBUG
        }

        private var orig_txtInfo_y:Number = NaN;
        public function _setupStandardFieldInfo(cfg:CCarouselCellStandardField):void
        {
            var field:TextField = renderer.content.txtInfo;
            if (isNaN(orig_txtInfo_y))
            {
                orig_txtInfo_y = field.y;
            }
            else
            {
                field.y = orig_txtInfo_y;
            }
            _setupStandardFieldAlpha(field, cfg);
            _setupStandardFieldScale(field, cfg);
            field.antiAliasType = AntiAliasType.ADVANCED;
            field.x = cfg.dx;
            field.width = DEFAULT_WIDTH / cfg.scale;
            field.defaultTextFormat.align = TextFormatAlign.CENTER;
            //field.border = true; field.borderColor = 0xFFFF00; // DEBUG
        }
    }
}
