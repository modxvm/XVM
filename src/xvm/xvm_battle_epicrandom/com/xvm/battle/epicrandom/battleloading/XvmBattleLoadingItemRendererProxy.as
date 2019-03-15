/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.epicrandom.battleloading
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.vo.*;
    import com.xvm.extraFields.*;
    import com.xvm.vo.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.data.constants.generated.*;
    import net.wg.data.VO.daapi.*;
    import net.wg.gui.battle.views.stats.constants.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.gfx.*;

    public class XvmBattleLoadingItemRendererProxy implements IExtraFieldGroupHolder
    {
        public static const UI_TYPE_TABLE:String = "table";
        public static const UI_TYPE_TIPS:String = "tips";

        private static const INVALIDATE_PLAYER_STATE:uint = 1 << 15;

        private static const FIELD_HEIGHT:int = 26;
        private static const ICONS_AREA_WIDTH:int = 80;
        private static const BADGE_ICON_WIDTH:int = 24;

        private static const MIRRORED_VEHICLE_LEVEL_ICON_OFFSET:int = 36;

        private var ui:IXvmBattleLoadingItemRenderer;
        private var uiType:String;
        private var _isLeftPanel:Boolean;

        private var cfg:CBattleLoading;

        private var _model:DAAPIVehicleInfoVO;

        private var _vehicleIconLoaded:Boolean = false;

        private var _substrateHolder:Sprite;
        private var _bottomHolder:Sprite;
        private var _normalHolder:Sprite;
        private var _topHolder:Sprite;

        private var extraFields:ExtraFieldsGroup = null;

        private var currentPlayerState:VOPlayerState;

        public function XvmBattleLoadingItemRendererProxy(ui:IXvmBattleLoadingItemRenderer, uiType:String, isLeftPanel:Boolean)
        {
            try
            {
                this.ui = ui;
                this.uiType = uiType;
                this._isLeftPanel = isLeftPanel;

                // align fields

                ui.f_nameField.y -= 3;
                ui.f_nameField.scaleX = ui.f_nameField.scaleY = 1;
                ui.f_nameField.height = FIELD_HEIGHT;
                TextFieldEx.setVerticalAlign(ui.f_nameField, TextFieldEx.VALIGN_CENTER);

                ui.f_vehicleField.y = ui.f_nameField.y;
                ui.f_vehicleField.scaleX = ui.f_vehicleField.scaleY = 1;
                ui.f_vehicleField.height = FIELD_HEIGHT;
                ui.f_vehicleField.autoSize = TextFieldAutoSize.NONE;
                TextFieldEx.setVerticalAlign(ui.f_vehicleField, TextFieldEx.VALIGN_CENTER);

                Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
                Xvm.addEventListener(PlayerStateEvent.CHANGED, onPlayerStateChanged);
                Xvm.addEventListener(Defines.XVM_EVENT_ATLAS_LOADED, onAtlasLoaded);
                Xfw.addCommandListener(XvmCommands.AS_ON_CLAN_ICON_LOADED, onClanIconLoaded);
                Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, onStatLoaded, false, 0, true);

                _substrateHolder = ui.addChildAt(new Sprite(), 0) as Sprite;
                _bottomHolder = ui.addChildAt(new Sprite(), ui.f_selfBg ? ui.getChildIndex(ui.f_selfBg) + 1 : 0) as Sprite;
                _normalHolder = ui.addChildAt(new Sprite(), ui.getChildIndex(ui.f_playerActionMarker) + 1) as Sprite;
                _topHolder = ui.addChild(new Sprite()) as Sprite;

                setup();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            Xvm.removeEventListener(PlayerStateEvent.CHANGED, onPlayerStateChanged);
            Xvm.removeEventListener(Defines.XVM_EVENT_ATLAS_LOADED, onAtlasLoaded);
            Xfw.removeCommandListener(XvmCommands.AS_ON_CLAN_ICON_LOADED, onClanIconLoaded);
            Stat.instance.removeEventListener(Stat.COMPLETE_BATTLE, onStatLoaded)

            disposeExtraFields();

            _substrateHolder = null;
            _bottomHolder = null;
            _normalHolder = null;
            _topHolder = null;
        }

        public function setData(model:DAAPIVehicleInfoVO):void
        {
            _model = model;
            if (cfg.removeRankBadgeIcon)
            {
                _model.badgeType = "";
            }
        }

        public function draw():void
        {
            try
            {
                //Logger.add("draw");

                if (!_model || !_model.vehicleID)
                    return;

                currentPlayerState = BattleState.get(_model.vehicleID);

                var textColor:String = XfwUtils.toHtmlColor(App.colorSchemeMgr.getScheme(getSchemeNameForPlayer(currentPlayerState)).rgb);
                ui.f_nameField.visible = true;
                ui.f_nameField.htmlText = "<font color='" + textColor + "'>" + Macros.FormatString(_isLeftPanel ? cfg.formatLeftNick : cfg.formatRightNick, currentPlayerState) + "</font>";
                alignNameField();

                ui.f_vehicleField.visible = true;
                ui.f_vehicleField.htmlText = "<font color='" + textColor + "'>" + Macros.FormatString(_isLeftPanel ? cfg.formatLeftVehicle : cfg.formatRightVehicle, currentPlayerState) + "</font>";
                alignVehicleField();

                var atlasName:String = _isLeftPanel ? UI_EpicRandomBattleLoading.leftAtlas : UI_EpicRandomBattleLoading.rightAtlas;
                if (!App.atlasMgr.isAtlasInitialized(atlasName))
                {
                    atlasName = ATLAS_CONSTANTS.BATTLE_ATLAS;
                }

                ui.f_vehicleIcon.graphics.clear();
                App.atlasMgr.drawGraphics(atlasName, _model.vehicleIconName, ui.f_vehicleIcon.graphics, "unknown" /*BattleLoadingHelper.VEHICLE_TYPE_UNKNOWN*/);

                var schemeName:String = getSchemeNameForVehicle(currentPlayerState);
                var scheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
                if (scheme)
                {
                    ui.f_vehicleIcon.transform.colorTransform = scheme.colorTransform;
                }
                schemeName = PlayerStatusSchemeName.getSchemeForVehicleLevel(!_model.isAlive());
                scheme = App.colorSchemeMgr.getScheme(schemeName);
                if (scheme)
                {
                    ui.f_vehicleLevelIcon.transform.colorTransform = scheme.colorTransform;
                }
                ui.f_vehicleIcon.alpha = cfg.vehicleIconAlpha / 100.0;
                ui.f_vehicleLevelIcon.alpha = cfg.removeVehicleLevel ? 0 : cfg.vehicleIconAlpha / 100.0;

                updateExtraFields();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // IExtraFieldGroupHolder

        public function get isLeftPanel():Boolean
        {
            return _isLeftPanel;
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
            var highlightVehicleIcon:Boolean = Config.config.battle.highlightVehicleIcon;
            return PlayerStatusSchemeName.getSchemeNameForVehicle(
                UserTags.isCurrentPlayer(_model.userTags) && highlightVehicleIcon,
                _model.isSquadPersonal() && highlightVehicleIcon,
                _model.isTeamKiller(),
                !_model.isAlive(),
                cfg.darkenNotReadyIcon && !_model.isReady());
        }

        // TODO
        public function getSchemeNameForPlayer(options:IVOMacrosOptions):String
        {
            return PlayerStatusSchemeName.getSchemeNameForPlayer(
                UserTags.isCurrentPlayer(_model.userTags),
                _model.isSquadPersonal(),
                _model.isTeamKiller(),
                !_model.isAlive(),
                !_model.isReady());
        }

        // XVM events handlers

        private function setup():void
        {
            cfg = uiType == UI_TYPE_TABLE ? Config.config.battleLoading : Config.config.battleLoadingTips;

            disposeExtraFields();

            if (cfg.removeSquadIcon)
            {
                ui.f_rankIcon.alpha = 0;
            }

            if (cfg.removeVehicleTypeIcon)
            {
                ui.f_vehicleTypeIcon.alpha = 0;
            }

            if (cfg.nameFieldShowBorder)
            {
                ui.f_nameField.border = true;
                ui.f_nameField.borderColor = 0x00FF00;
            }

            if (cfg.vehicleFieldShowBorder)
            {
                ui.f_vehicleField.border = true;
                ui.f_vehicleField.borderColor = 0xFFFF00;
            }

            if (!_isLeftPanel)
            {
                if (Config.config.battle.mirroredVehicleIcons)
                {
                    ui.f_vehicleIcon.scaleX = 1;
                }
                else
                {
                    ui.f_vehicleIcon.scaleX = -1;
                }
            }

            createExtraFields();

            alignTextFields();
        }

        private function onPlayerStateChanged(e:PlayerStateEvent):void
        {
            if (_model)
            {
                if (_model.vehicleID == e.vehicleID)
                {
                    ui.invalidate2(INVALIDATE_PLAYER_STATE);
                }
            }
        }

        private function onAtlasLoaded(e:Event):void
        {
            ui.invalidate2(INVALIDATE_PLAYER_STATE);
        }

        private function onClanIconLoaded(vehicleID:Number, playerName:String):void
        {
            if (_model)
            {
                if (_model.vehicleID == vehicleID)
                {
                    ui.invalidate2(INVALIDATE_PLAYER_STATE);
                }
            }
        }

        private function onStatLoaded():void
        {
            //Logger.add("onStatLoaded: " + _model.playerName);
            ui.invalidate2(INVALIDATE_PLAYER_STATE);
        }

        // PRIVATE

        private function getNameFieldWidth():int
        {
            var w:Number = ui.DEFAULTS.NAME_FIELD_WIDTH;
            if (isLeftPanel)
            {
                w += cfg.nameFieldWidthDeltaLeft;
            }
            else
            {
                w += cfg.nameFieldWidthDeltaRight;
            }
            return w;
        }

        private function getVehicleFieldWidth():int
        {
            var w:Number = ui.DEFAULTS.VEHICLE_FIELD_WIDTH;
            if (isLeftPanel)
            {
                w += cfg.vehicleFieldWidthDeltaLeft;
            }
            else
            {
                w += cfg.vehicleFieldWidthDeltaRight;
            }
            return w;
        }

        private function alignTextFields():void
        {
            alignRankIcon();
            alignNameField();
            alignVehicleField();
            alignVehicleIcon();
        }

        private function alignRankIcon():void
        {
            if (_isLeftPanel)
            {
                ui.f_rankIcon.x = ui.DEFAULTS.RANKICON_X + cfg.squadIconOffsetXLeft;
            }
            else
            {
                ui.f_rankIcon.x = ui.DEFAULTS.RANKICON_X - cfg.squadIconOffsetXRight;
            }
        }

        private function alignNameField():void
        {
            ui.f_nameField.width = getNameFieldWidth();
            if (_isLeftPanel)
            {
                ui.f_nameField.x = ui.DEFAULTS.NAME_FIELD_X + cfg.nameFieldOffsetXLeft;
                if (!cfg.removeRankBadgeIcon)
                {
                    ui.f_badgeIcon.x = ui.f_nameField.x;
                    ui.f_nameField.x += BADGE_ICON_WIDTH + 1;
                    ui.f_nameField.width -= BADGE_ICON_WIDTH + 1;
                }
            }
            else
            {
                ui.f_nameField.x = ui.DEFAULTS.NAME_FIELD_X - cfg.nameFieldOffsetXRight + (ui.DEFAULTS.NAME_FIELD_WIDTH - ui.f_nameField.width);
                if (!cfg.removeRankBadgeIcon)
                {
                    ui.f_badgeIcon.x = ui.f_nameField.x + ui.f_nameField.width - BADGE_ICON_WIDTH;
                    ui.f_nameField.width -= BADGE_ICON_WIDTH + 1;
                }
            }
        }

        private function alignVehicleField():void
        {
            ui.f_vehicleField.width = getVehicleFieldWidth();
            if (_isLeftPanel)
            {
                ui.f_vehicleField.x = ui.DEFAULTS.VEHICLE_FIELD_X + cfg.vehicleFieldOffsetXLeft + (ui.DEFAULTS.VEHICLE_FIELD_WIDTH - ui.f_vehicleField.width);
                if (_model)
                {
                    if (_model.isIGR)
                    {
                        var bounds:Rectangle = ui.f_vehicleField.getCharBoundaries(0);
                        ui.f_icoIGR.x = ui.f_vehicleField.x + (bounds ? bounds.x : 0) - ui.f_icoIGR.width >> 0;
                    }
                }
            }
            else
            {
                ui.f_vehicleField.x = ui.DEFAULTS.VEHICLE_FIELD_X - cfg.vehicleFieldOffsetXRight;
                if (_model)
                {
                    if (_model.isIGR)
                    {
                        ui.f_icoIGR.x = ui.f_vehicleField.x - ui.f_icoIGR.width >> 0;
                    }
                }
            }
        }

        private function alignVehicleIcon():void
        {
            if (_isLeftPanel)
            {
                ui.f_vehicleIcon.x = ui.DEFAULTS.VEHICLE_ICON_X + cfg.vehicleIconOffsetXLeft;
                ui.f_vehicleLevelIcon.x = ui.DEFAULTS.VEHICLE_LEVEL_X + cfg.vehicleIconOffsetXLeft;
                ui.f_vehicleTypeIcon.x = ui.DEFAULTS.VEHICLE_TYPE_ICON_X + cfg.vehicleIconOffsetXLeft;
            }
            else
            {
                if (Config.config.battle.mirroredVehicleIcons)
                {
                    ui.f_vehicleIcon.x = ui.DEFAULTS.VEHICLE_ICON_X - cfg.vehicleIconOffsetXRight;
                    ui.f_vehicleLevelIcon.x = ui.DEFAULTS.VEHICLE_LEVEL_X - cfg.vehicleIconOffsetXRight;
                }
                else
                {
                    ui.f_vehicleIcon.x = ui.DEFAULTS.VEHICLE_ICON_X - cfg.vehicleIconOffsetXRight - ICONS_AREA_WIDTH;
                    ui.f_vehicleLevelIcon.x = ui.DEFAULTS.VEHICLE_LEVEL_X - cfg.vehicleIconOffsetXRight - ICONS_AREA_WIDTH + MIRRORED_VEHICLE_LEVEL_ICON_OFFSET;
                }
                ui.f_vehicleTypeIcon.x = ui.DEFAULTS.VEHICLE_TYPE_ICON_X - cfg.vehicleIconOffsetXRight;
            }
            ui.f_vehicleLevelIcon.isCetralize = true;
        }

        // extra fields

        private function createExtraFields():void
        {
            var formats:Array = _isLeftPanel ? cfg.extraFieldsLeft : cfg.extraFieldsRight;
            if (formats)
            {
                if (formats.length)
                {
                    extraFields = new ExtraFieldsGroup(this, formats);
                }
            }
        }

        private function disposeExtraFields():void
        {
            if (extraFields)
            {
                extraFields.dispose();
                extraFields = null;
            }
        }

        private function updateExtraFields():void
        {
            if (extraFields)
            {
                var offsetX:int = ui.DEFAULTS.EXTRA_FIELDS_X;
                var bindToIconOffset:Number;
                if (_isLeftPanel)
                {
                    bindToIconOffset = ui.f_vehicleIcon.x - offsetX;
                }
                else
                {
                    bindToIconOffset = ui.f_vehicleIcon.x - offsetX + (Config.config.battle.mirroredVehicleIcons ? 0 : ICONS_AREA_WIDTH);
                }
                extraFields.visible = true;
                extraFields.update(currentPlayerState, bindToIconOffset, offsetX, ui.f_vehicleIcon.y);
            }
        }
    }
}
