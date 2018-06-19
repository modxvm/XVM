/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.battleloading
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

                ui.nameField.y -= 3;
                ui.nameField.scaleX = ui.nameField.scaleY = 1;
                ui.nameField.height = FIELD_HEIGHT;
                TextFieldEx.setVerticalAlign(ui.nameField, TextFieldEx.VALIGN_CENTER);

                ui.vehicleField.y = ui.nameField.y;
                ui.vehicleField.scaleX = ui.vehicleField.scaleY = 1;
                ui.vehicleField.height = FIELD_HEIGHT;
                ui.vehicleField.autoSize = TextFieldAutoSize.NONE;
                TextFieldEx.setVerticalAlign(ui.vehicleField, TextFieldEx.VALIGN_CENTER);

                Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
                Xvm.addEventListener(PlayerStateEvent.CHANGED, onPlayerStateChanged);
                Xvm.addEventListener(Defines.XVM_EVENT_ATLAS_LOADED, onAtlasLoaded);
                Xfw.addCommandListener(XvmCommands.AS_ON_CLAN_ICON_LOADED, onClanIconLoaded);
                Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, onStatLoaded, false, 0, true);

                _substrateHolder = ui.addChildAt(new Sprite(), 0) as Sprite;
                _bottomHolder = ui.addChildAt(new Sprite(), ui.selfBg ? ui.getChildIndex(ui.selfBg) + 1 : 0) as Sprite;
                _normalHolder = ui.addChildAt(new Sprite(), ui.getChildIndex(ui.playerActionMarker) + 1) as Sprite;
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
                ui.nameField.visible = true;
                ui.nameField.htmlText = "<font color='" + textColor + "'>" + Macros.FormatString(_isLeftPanel ? cfg.formatLeftNick : cfg.formatRightNick, currentPlayerState) + "</font>";
                alignNameField();

                ui.vehicleField.visible = true;
                ui.vehicleField.htmlText = "<font color='" + textColor + "'>" + Macros.FormatString(_isLeftPanel ? cfg.formatLeftVehicle : cfg.formatRightVehicle, currentPlayerState) + "</font>";
                alignVehicleField();

                var atlasName:String = _isLeftPanel ? UI_RankedBattleLoading.leftAtlas : UI_RankedBattleLoading.rightAtlas;
                if (!App.atlasMgr.isAtlasInitialized(atlasName))
                {
                    atlasName = ATLAS_CONSTANTS.BATTLE_ATLAS;
                }

                ui.vehicleIcon.graphics.clear();
                App.atlasMgr.drawGraphics(atlasName, _model.vehicleIconName, ui.vehicleIcon.graphics, "unknown" /*BattleLoadingHelper.VEHICLE_TYPE_UNKNOWN*/);

                var schemeName:String = getSchemeNameForVehicle(currentPlayerState);
                var scheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
                if (scheme)
                {
                    ui.vehicleIcon.transform.colorTransform = scheme.colorTransform;
                }
                schemeName = PlayerStatusSchemeName.getSchemeForVehicleLevel(!_model.isAlive());
                scheme = App.colorSchemeMgr.getScheme(schemeName);
                if (scheme)
                {
                    ui.vehicleLevelIcon.transform.colorTransform = scheme.colorTransform;
                }
                ui.vehicleIcon.alpha = cfg.vehicleIconAlpha / 100.0;
                ui.vehicleLevelIcon.alpha = cfg.removeVehicleLevel ? 0 : cfg.vehicleIconAlpha / 100.0;

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
                ui.rankIcon.alpha = 0;
            }

            if (cfg.removeVehicleTypeIcon)
            {
                ui.vehicleTypeIcon.alpha = 0;
            }

            if (cfg.nameFieldShowBorder)
            {
                ui.nameField.border = true;
                ui.nameField.borderColor = 0x00FF00;
            }

            if (cfg.vehicleFieldShowBorder)
            {
                ui.vehicleField.border = true;
                ui.vehicleField.borderColor = 0xFFFF00;
            }

            if (!_isLeftPanel)
            {
                if (Config.config.battle.mirroredVehicleIcons)
                {
                    ui.vehicleIcon.scaleX = 1;
                }
                else
                {
                    ui.vehicleIcon.scaleX = -1;
                }
            }

            createExtraFields();

            alignTextFields();
        }

        private function onPlayerStateChanged(e:PlayerStateEvent):void
        {
            if (_model && _model.vehicleID == e.vehicleID)
            {
                ui.invalidate2(INVALIDATE_PLAYER_STATE);
            }
        }

        private function onAtlasLoaded(e:Event):void
        {
            ui.invalidate2(INVALIDATE_PLAYER_STATE);
        }

        private function onClanIconLoaded(vehicleID:Number, playerName:String):void
        {
            if (_model && _model.vehicleID == vehicleID)
            {
                ui.invalidate2(INVALIDATE_PLAYER_STATE);
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
                ui.rankIcon.x = ui.DEFAULTS.RANKICON_X + cfg.squadIconOffsetXLeft;
            }
            else
            {
                ui.rankIcon.x = ui.DEFAULTS.RANKICON_X - cfg.squadIconOffsetXRight;
            }
        }

        private function alignNameField():void
        {
            ui.nameField.width = getNameFieldWidth();
            if (_isLeftPanel)
            {
                ui.nameField.x = ui.DEFAULTS.NAME_FIELD_X + cfg.nameFieldOffsetXLeft;
                if (ui.badgeIcon.visible)
                {
                    ui.badgeIcon.x = ui.nameField.x;
                    ui.nameField.x += ui.badgeIcon.width + 1;
                    ui.nameField.width -= ui.badgeIcon.width + 1;
                }
            }
            else
            {
                ui.nameField.x = ui.DEFAULTS.NAME_FIELD_X - cfg.nameFieldOffsetXRight + (ui.DEFAULTS.NAME_FIELD_WIDTH - ui.nameField.width);
                if (ui.badgeIcon.visible)
                {
                    ui.badgeIcon.x = ui.nameField.x + ui.nameField.width - ui.badgeIcon.width;
                    ui.nameField.width -= ui.badgeIcon.width + 1;
                }
            }
        }

        private function alignVehicleField():void
        {
            ui.vehicleField.width = getVehicleFieldWidth();
            if (_isLeftPanel)
            {
                ui.vehicleField.x = ui.DEFAULTS.VEHICLE_FIELD_X + cfg.vehicleFieldOffsetXLeft + (ui.DEFAULTS.VEHICLE_FIELD_WIDTH - ui.vehicleField.width);
                if (_model && _model.isIGR)
                {
                    var bounds:Rectangle = ui.vehicleField.getCharBoundaries(0);
                    ui.icoIGR.x = ui.vehicleField.x + (bounds ? bounds.x : 0) - ui.icoIGR.width >> 0;
                }
            }
            else
            {
                ui.vehicleField.x = ui.DEFAULTS.VEHICLE_FIELD_X - cfg.vehicleFieldOffsetXRight;
                if (_model && _model.isIGR)
                {
                    ui.icoIGR.x = ui.vehicleField.x - ui.icoIGR.width >> 0;
                }
            }
        }

        private function alignVehicleIcon():void
        {
            if (_isLeftPanel)
            {
                ui.vehicleIcon.x = ui.DEFAULTS.VEHICLE_ICON_X + cfg.vehicleIconOffsetXLeft;
                ui.vehicleLevelIcon.x = ui.DEFAULTS.VEHICLE_LEVEL_X + cfg.vehicleIconOffsetXLeft;
                ui.vehicleTypeIcon.x = ui.DEFAULTS.VEHICLE_TYPE_ICON_X + cfg.vehicleIconOffsetXLeft;
            }
            else
            {
                if (Config.config.battle.mirroredVehicleIcons)
                {
                    ui.vehicleIcon.x = ui.DEFAULTS.VEHICLE_ICON_X - cfg.vehicleIconOffsetXRight;
                    ui.vehicleLevelIcon.x = ui.DEFAULTS.VEHICLE_LEVEL_X - cfg.vehicleIconOffsetXRight;
                }
                else
                {
                    ui.vehicleIcon.x = ui.DEFAULTS.VEHICLE_ICON_X - cfg.vehicleIconOffsetXRight - ICONS_AREA_WIDTH;
                    ui.vehicleLevelIcon.x = ui.DEFAULTS.VEHICLE_LEVEL_X - cfg.vehicleIconOffsetXRight - ICONS_AREA_WIDTH + MIRRORED_VEHICLE_LEVEL_ICON_OFFSET;
                }
                ui.vehicleTypeIcon.x = ui.DEFAULTS.VEHICLE_TYPE_ICON_X - cfg.vehicleIconOffsetXRight;
            }
            ui.vehicleLevelIcon.isCetralize = true;
        }

        // extra fields

        private function createExtraFields():void
        {
            var formats:Array = _isLeftPanel ? cfg.extraFieldsLeft : cfg.extraFieldsRight;
            if (formats && formats.length)
            {
                extraFields = new ExtraFieldsGroup(this, formats);
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
                    bindToIconOffset = ui.vehicleIcon.x - offsetX;
                }
                else
                {
                    bindToIconOffset = ui.vehicleIcon.x - offsetX + (Config.config.battle.mirroredVehicleIcons ? 0 : ICONS_AREA_WIDTH);
                }
                extraFields.visible = true;
                extraFields.update(currentPlayerState, bindToIconOffset, offsetX, ui.vehicleIcon.y);
            }
        }
    }
}
