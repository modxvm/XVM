/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.battleloading
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.BattleState;
    import com.xvm.battle.events.PlayerStateEvent;
    import com.xvm.battle.vo.VOPlayerState;
    import com.xvm.extraFields.ExtraFieldsGroup;
    import com.xvm.extraFields.IExtraFieldGroupHolder;
    import com.xvm.types.cfg.CBattleLoading;
    import com.xvm.vo.IVOMacrosOptions;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
    import net.wg.data.constants.UserTags;
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;
    import net.wg.gui.battle.battleloading.renderers.BasePlayerItemRenderer;
    import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    CLIENT::WG {
        import net.wg.gui.battle.components.PrestigeLevel;
    }
    import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
    import net.wg.gui.components.controls.BadgeComponent;
    import net.wg.gui.components.icons.PlayerActionMarker;
    import net.wg.infrastructure.interfaces.IColorScheme;
    import scaleform.gfx.TextFieldEx;

    public class XvmBattleLoadingItemRendererProxyBase implements IXvmBattleLoadingItemRendererBase, IExtraFieldGroupHolder
    {
        // PUBLIC CONSTS

        public static const UI_TYPE_TABLE:String = "table";
        public static const UI_TYPE_TIP:String = "tip";

        // PRIVATE CONSTS

        private static const _INVALIDATE_PLAYER_STATE:uint = 1 << 15;

        private static const _FIELD_HEIGHT:int = 26;
        private static const _ICONS_AREA_WIDTH:int = 80;
        private static const _BADGE_ICON_WIDTH:int = 24;

        private static const _MIRRORED_VEHICLE_LEVEL_ICON_OFFSET:int = 36;

        // PROTECTED VARS

        protected var cfg:CBattleLoading;

        // PRIVATE VARS
        private var _invalidateFunc:Function;

        private var _ui:BasePlayerItemRenderer;
        private var _uiType:String;
        private var _isEnemy:Boolean;

        private var _model:DAAPIVehicleInfoVO;

        private var _vehicleIconLoaded:Boolean = false;

        private var _defaults:XvmItemRendererDefaults;
        private var _badge:BadgeComponent;
        private var _nameField:TextField;
        private var _vehicleField:TextField;
        private var _vehicleIcon:BattleAtlasSprite;
        private var _vehicleLevelIcon:BattleAtlasSprite;
        private var _vehicleTypeIcon:BattleAtlasSprite;
        private var _playerActionMarker:PlayerActionMarker;
        private var _icoIGR:BattleAtlasSprite;
        private var _icoTester:BattleAtlasSprite;
        private var _backTester:BattleAtlasSprite;
        private var _selfBg:*;
        CLIENT::WG {
            private var _prestigeLevel:PrestigeLevel;
        }

        private var _substrateHolder:Sprite;
        private var _bottomHolder:Sprite;
        private var _normalHolder:Sprite;
        private var _topHolder:Sprite;

        private var _extraFields:ExtraFieldsGroup = null;

        private var _currentPlayerState:VOPlayerState;

        // STATIC PROPERTIES

        static private var _leftAtlas:String = ATLAS_CONSTANTS.BATTLE_ATLAS;

        static public function get leftAtlas():String
        {
            return _leftAtlas;
        }

        static public function set leftAtlas(value:String):void
        {
            _leftAtlas = value;
        }

        static private var _rightAtlas:String = ATLAS_CONSTANTS.BATTLE_ATLAS;

        static public function get rightAtlas():String
        {
            return _rightAtlas;
        }

        static public function set rightAtlas(value:String):void
        {
            _rightAtlas = value;
        }

        // CTOR

        public function XvmBattleLoadingItemRendererProxyBase(ui:BasePlayerItemRenderer, uiType:String,
            container:BaseRendererContainer, position:int, isEnemy:Boolean, selfBg:*, invalidateFunc:Function)
        {
            _ui = ui;
            _uiType = uiType;
            _isEnemy = isEnemy;

            _invalidateFunc = invalidateFunc;

            if (uiType == XvmBattleLoadingItemRendererProxyBase.UI_TYPE_TABLE)
            {
                _defaults = _isEnemy ? XvmItemRendererDefaults.DEFAULTS_RIGHT_TABLE : XvmItemRendererDefaults.DEFAULTS_LEFT_TABLE;
            }
            else
            {
                _defaults = _isEnemy ? XvmItemRendererDefaults.DEFAULTS_RIGHT_TIP : XvmItemRendererDefaults.DEFAULTS_LEFT_TIP;
            }

            _selfBg = selfBg;
            if (_isEnemy)
            {
                _vehicleField = container.vehicleFieldsEnemy[position];
                _nameField = container.textFieldsEnemy[position];
                _vehicleIcon = container.vehicleIconsEnemy[position];
                _vehicleTypeIcon = container.vehicleTypeIconsEnemy[position];
                _vehicleLevelIcon = container.vehicleLevelIconsEnemy[position];
                _playerActionMarker = container.playerActionMarkersEnemy[position];
                _icoIGR = container.icoIGRsEnemy[position];
                _icoTester = container.icoTestersEnemy[position];
                _backTester = container.backTestersEnemy[position];
                _badge = container.badgesEnemy[position];
                CLIENT::WG {
                    _prestigeLevel = container.prestigeLevelsEnemy[position];
                }
            }
            else
            {
                _vehicleField = container.vehicleFieldsAlly[position];
                _nameField = container.textFieldsAlly[position];
                _vehicleIcon = container.vehicleIconsAlly[position];
                _vehicleTypeIcon = container.vehicleTypeIconsAlly[position];
                _vehicleLevelIcon = container.vehicleLevelIconsAlly[position];
                _playerActionMarker = container.playerActionMarkersAlly[position];
                _icoIGR = container.icoIGRsAlly[position];
                _icoTester = container.icoTestersAlly[position];
                _backTester = container.backTestersAlly[position];
                _badge = container.badgesAlly[position];
                CLIENT::WG {
                    _prestigeLevel = container.prestigeLevelsAlly[position];
                }
            }

            // align fields
            nameField.y -= 3;
            nameField.scaleX = nameField.scaleY = 1;
            nameField.height = _FIELD_HEIGHT;
            TextFieldEx.setVerticalAlign(nameField, TextFieldEx.VALIGN_CENTER);

            vehicleField.y = nameField.y;
            vehicleField.scaleX = vehicleField.scaleY = 1;
            vehicleField.height = _FIELD_HEIGHT;
            vehicleField.autoSize = TextFieldAutoSize.NONE;
            TextFieldEx.setVerticalAlign(vehicleField, TextFieldEx.VALIGN_CENTER);

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, _setup);
            Xvm.addEventListener(PlayerStateEvent.CHANGED, _onPlayerStateChanged);
            Xvm.addEventListener(Defines.XVM_EVENT_ATLAS_LOADED, _onAtlasLoaded);
            Xfw.addCommandListener(XvmCommands.AS_ON_CLAN_ICON_LOADED, _onClanIconLoaded);
            Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, _onStatLoaded, false, 0, true);

            _substrateHolder = container.addChildAt(new Sprite(), 0) as Sprite;
            _bottomHolder = container.addChildAt(new Sprite(), selfBg ? container.getChildIndex(selfBg) + 1 : 0) as Sprite;
            _normalHolder = container.addChildAt(new Sprite(), container.getChildIndex(playerActionMarker) + 1) as Sprite;
            _topHolder = container.addChild(new Sprite()) as Sprite;

            _setup();
        }

        public function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, _setup);
            Xvm.removeEventListener(PlayerStateEvent.CHANGED, _onPlayerStateChanged);
            Xvm.removeEventListener(Defines.XVM_EVENT_ATLAS_LOADED, _onAtlasLoaded);
            Xfw.removeCommandListener(XvmCommands.AS_ON_CLAN_ICON_LOADED, _onClanIconLoaded);
            Stat.instance.removeEventListener(Stat.COMPLETE_BATTLE, _onStatLoaded)

            _disposeExtraFields();

            _substrateHolder = null;
            _bottomHolder = null;
            _normalHolder = null;
            _topHolder = null;

            _badge = null;
            _nameField = null;
            _vehicleField = null;
            _vehicleIcon = null;
            _vehicleLevelIcon = null;
            _vehicleTypeIcon = null;
            _playerActionMarker = null;
            _icoIGR = null;
            _icoTester = null;
            _backTester = null;
            _selfBg = null;
            CLIENT::WG {
                _prestigeLevel = null;
            }

            _ui = null;
        }

        public function setData(model:DAAPIVehicleInfoVO):void
        {
            _model = model;
            if (cfg.removeRankBadgeIcon)
            {
                //_model.badgeVO = null;
                //temporary solution
                if (_model.badgeVO)
                {
                    _model.badgeVO.icon = "";
                    _model.badgeVO.content = "";
                    _model.badgeVO.sizeContent = "";
                    _model.badgeVO.isDynamic = false;
                    _model.badgeVO.isAtlasSource = false;
                }
            }
            if (cfg.removeTesterIcon)
            {
                _model.suffixBadgeType = "";
            }
            CLIENT::WG {
                if (cfg.removePrestigeLevel)
                {
                    _model.prestigeMarkId = 0;
                    _model.prestigeLevel = 0;
                }
            }
        }

        public function draw():void
        {
            try
            {
                //Logger.add("draw");

                if (!_model || !_model.vehicleID)
                    return;

                _currentPlayerState = BattleState.get(_model.vehicleID);

                var textColor:String = XfwUtils.toHtmlColor(App.colorSchemeMgr.getScheme(getSchemeNameForPlayer(_currentPlayerState)).rgb);
                nameField.visible = true;
                nameField.htmlText = "<font color='" + textColor + "'>" + Macros.FormatString(_isEnemy ? cfg.formatRightNick : cfg.formatLeftNick, _currentPlayerState) + "</font>";
                _alignNameField();

                vehicleField.visible = true;
                vehicleField.htmlText = "<font color='" + textColor + "'>" + Macros.FormatString(_isEnemy ? cfg.formatRightVehicle : cfg.formatLeftVehicle, _currentPlayerState) + "</font>";
                _alignVehicleField();

                var atlasName:String = _isEnemy ? rightAtlas : leftAtlas;
                if (!App.atlasMgr.isAtlasInitialized(atlasName))
                {
                    atlasName = ATLAS_CONSTANTS.BATTLE_ATLAS;
                }

                vehicleIcon.graphics.clear();
                App.atlasMgr.drawGraphics(atlasName, _model.vehicleIconName, vehicleIcon.graphics, "unknown" /*BattleLoadingHelper.VEHICLE_TYPE_UNKNOWN*/);

                var schemeName:String = getSchemeNameForVehicle(_currentPlayerState);
                var scheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
                if (scheme)
                {
                    vehicleIcon.transform.colorTransform = scheme.colorTransform;
                }
                schemeName = PlayerStatusSchemeName.getSchemeForVehicleLevel(!_model.isAlive());
                scheme = App.colorSchemeMgr.getScheme(schemeName);
                if (scheme)
                {
                    vehicleLevelIcon.transform.colorTransform = scheme.colorTransform;
                }
                vehicleIcon.alpha = cfg.vehicleIconAlpha / 100.0;
                vehicleLevelIcon.alpha = cfg.removeVehicleLevel ? 0 : cfg.vehicleIconAlpha / 100.0;

                _updateExtraFields();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // IXvmBattleLoadingItemRendererBase

        public function get DEFAULTS():XvmItemRendererDefaults
        {
            return _defaults;
        }

        public function get badgeIcon():BadgeComponent
        {
            return _badge;
        }

        public function get nameField():TextField
        {
            return _nameField;
        }

        public function get vehicleField():TextField
        {
            return _vehicleField;
        }

        public function get vehicleIcon():BattleAtlasSprite
        {
            return _vehicleIcon;
        }

        public function get vehicleLevelIcon():BattleAtlasSprite
        {
            return _vehicleLevelIcon;
        }

        public function get vehicleTypeIcon():BattleAtlasSprite
        {
            return _vehicleTypeIcon;
        }

        public function get playerActionMarker():PlayerActionMarker
        {
            return _playerActionMarker;
        }

        public function get selfBg():*
        {
            return _selfBg;
        }

        public function get icoIGR():BattleAtlasSprite
        {
            return _icoIGR;
        }

        CLIENT::WG {
            public function get prestigeLevel():PrestigeLevel
            {
                return _prestigeLevel;
            }
        }

        // IExtraFieldGroupHolder

        public function get isLeftPanel():Boolean
        {
            return !_isEnemy;
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

        // VIRTUAL

        protected function setup():void
        {
            // virtual
        }

        protected function alignTextFields():void
        {
            // virtual
        }

        // PRIVATE

        private function _setup():void
        {
            cfg = _uiType == UI_TYPE_TABLE ? Config.config.battleLoading : Config.config.battleLoadingTips;

            _disposeExtraFields();

            setup();

            if (cfg.removeVehicleTypeIcon)
            {
                vehicleTypeIcon.alpha = 0;
            }

            if (cfg.nameFieldShowBorder)
            {
                nameField.border = true;
                nameField.borderColor = 0x00FF00;
            }

            if (cfg.vehicleFieldShowBorder)
            {
                vehicleField.border = true;
                vehicleField.borderColor = 0xFFFF00;
            }

            if (_isEnemy)
            {
                if (Config.config.battle.mirroredVehicleIcons)
                {
                    vehicleIcon.scaleX = 1;
                }
                else
                {
                    vehicleIcon.scaleX = -1;
                }
            }

            _createExtraFields();

            _alignTextFields();
        }

        private function _onPlayerStateChanged(e:PlayerStateEvent):void
        {
            if (_model)
            {
                if (_model.vehicleID == e.vehicleID)
                {
                    _invalidateFunc(_INVALIDATE_PLAYER_STATE);
                }
            }
        }

        private function _onAtlasLoaded(e:Event):void
        {
            _invalidateFunc(_INVALIDATE_PLAYER_STATE);
        }

        private function _onClanIconLoaded(vehicleID:Number, playerName:String):void
        {
            if (_model)
            {
                if (_model.vehicleID == vehicleID)
                {
                    _invalidateFunc(_INVALIDATE_PLAYER_STATE);
                }
            }
        }

        private function _onStatLoaded():void
        {
            //Logger.add("onStatLoaded: " + _model.playerName);
            _invalidateFunc(_INVALIDATE_PLAYER_STATE);
        }

        private function _getNameFieldWidth():int
        {
            var w:Number = DEFAULTS.NAME_FIELD_WIDTH;
            if (_isEnemy)
            {
                w += cfg.nameFieldWidthDeltaRight;
            }
            else
            {
                w += cfg.nameFieldWidthDeltaLeft;
            }
            return w;
        }

        private function _getVehicleFieldWidth():int
        {
            var w:Number = DEFAULTS.VEHICLE_FIELD_WIDTH;
            if (_isEnemy)
            {
                w += cfg.vehicleFieldWidthDeltaRight;
            }
            else
            {
                w += cfg.vehicleFieldWidthDeltaLeft;
            }
            return w;
        }

        private function _alignTextFields():void
        {
            alignTextFields();

            _alignNameField();
            _alignVehicleField();
            _alignVehicleIcon();
        }

        private function _alignNameField():void
        {
            nameField.width = _getNameFieldWidth();
            if (_isEnemy)
            {
                nameField.x = DEFAULTS.NAME_FIELD_X - cfg.nameFieldOffsetXRight + (DEFAULTS.NAME_FIELD_WIDTH - nameField.width);
                if (!cfg.removeRankBadgeIcon)
                {
                    badgeIcon.x = nameField.x + nameField.width - _BADGE_ICON_WIDTH;
                    nameField.width -= _BADGE_ICON_WIDTH + 1;
                }
                if (!cfg.removeTesterIcon)
                {
                    _icoTester.x = nameField.x + nameField.width - _BADGE_ICON_WIDTH - nameField.textWidth;
                    _backTester.x = nameField.x + nameField.width - _BADGE_ICON_WIDTH / 2 - nameField.textWidth + _backTester.width;
                }
            }
            else
            {
                nameField.x = DEFAULTS.NAME_FIELD_X + cfg.nameFieldOffsetXLeft;
                if (!cfg.removeRankBadgeIcon)
                {
                    badgeIcon.x = nameField.x;
                    nameField.x += _BADGE_ICON_WIDTH + 1;
                    nameField.width -= _BADGE_ICON_WIDTH + 1;
                }
                if (!cfg.removeTesterIcon)
                {
                    _icoTester.x = nameField.x + nameField.textWidth;
                    _backTester.x = nameField.x + _BADGE_ICON_WIDTH / 2 + nameField.textWidth - _backTester.width;
                }
            }
        }

        private function _alignVehicleField():void
        {
            vehicleField.width = _getVehicleFieldWidth();
            if (_isEnemy)
            {
                vehicleField.x = DEFAULTS.VEHICLE_FIELD_X - cfg.vehicleFieldOffsetXRight;
                if (_model)
                {
                    if (_model.isIGR)
                    {
                        icoIGR.x = vehicleField.x - icoIGR.width >> 0;
                    }
                }
            }
            else
            {
                vehicleField.x = DEFAULTS.VEHICLE_FIELD_X + cfg.vehicleFieldOffsetXLeft + (DEFAULTS.VEHICLE_FIELD_WIDTH - vehicleField.width);
                if (_model)
                {
                    if (_model.isIGR)
                    {
                        var bounds:Rectangle = vehicleField.getCharBoundaries(0);
                        icoIGR.x = vehicleField.x + (bounds ? bounds.x : 0) - icoIGR.width >> 0;
                    }
                }
            }
        }

        private function _alignVehicleIcon():void
        {
            if (_isEnemy)
            {
                if (Config.config.battle.mirroredVehicleIcons)
                {
                    vehicleIcon.x = DEFAULTS.VEHICLE_ICON_X - cfg.vehicleIconOffsetXRight;
                    vehicleLevelIcon.x = DEFAULTS.VEHICLE_LEVEL_X - cfg.vehicleIconOffsetXRight;
                }
                else
                {
                    vehicleIcon.x = DEFAULTS.VEHICLE_ICON_X - cfg.vehicleIconOffsetXRight - _ICONS_AREA_WIDTH;
                    vehicleLevelIcon.x = DEFAULTS.VEHICLE_LEVEL_X - cfg.vehicleIconOffsetXRight - _ICONS_AREA_WIDTH + _MIRRORED_VEHICLE_LEVEL_ICON_OFFSET;
                }
                vehicleTypeIcon.x = DEFAULTS.VEHICLE_TYPE_ICON_X - cfg.vehicleIconOffsetXRight;
            }
            else
            {
                vehicleIcon.x = DEFAULTS.VEHICLE_ICON_X + cfg.vehicleIconOffsetXLeft;
                vehicleLevelIcon.x = DEFAULTS.VEHICLE_LEVEL_X + cfg.vehicleIconOffsetXLeft;
                vehicleTypeIcon.x = DEFAULTS.VEHICLE_TYPE_ICON_X + cfg.vehicleIconOffsetXLeft;
            }
            vehicleLevelIcon.isCentralizeByX = true;
        }

        // extra fields

        private function _createExtraFields():void
        {
            var formats:Array = _isEnemy ? cfg.extraFieldsRight : cfg.extraFieldsLeft;
            if (formats)
            {
                if (formats.length)
                {
                    _extraFields = new ExtraFieldsGroup(this, formats);
                }
            }
        }

        private function _disposeExtraFields():void
        {
            if (_extraFields)
            {
                _extraFields.dispose();
                _extraFields = null;
            }
        }

        private function _updateExtraFields():void
        {
            if (_extraFields)
            {
                var offsetX:int = DEFAULTS.EXTRA_FIELDS_X;
                var bindToIconOffset:Number;
                if (_isEnemy)
                {
                    bindToIconOffset = vehicleIcon.x - offsetX + (Config.config.battle.mirroredVehicleIcons ? 0 : _ICONS_AREA_WIDTH);
                }
                else
                {
                    bindToIconOffset = vehicleIcon.x - offsetX;
                }
                _extraFields.visible = true;
                _extraFields.update(_currentPlayerState, bindToIconOffset, offsetX, vehicleIcon.y);
            }
        }
    }
}
