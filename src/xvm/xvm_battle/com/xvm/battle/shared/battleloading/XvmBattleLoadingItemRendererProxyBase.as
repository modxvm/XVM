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
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import flash.text.TextFieldAutoSize;
    import net.wg.data.constants.UserTags;
    import net.wg.data.constants.generated.ATLAS_CONSTANTS;
    import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
    import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
    import net.wg.infrastructure.interfaces.IColorScheme;
    import scaleform.gfx.TextFieldEx;

    public class XvmBattleLoadingItemRendererProxyBase implements IExtraFieldGroupHolder
    {
        // PUBLIC CONSTS

        public static const UI_TYPE_TABLE:String = "table";
        public static const UI_TYPE_TIPS:String = "tips";

        // PRIVATE CONSTS

        private static const _INVALIDATE_PLAYER_STATE:uint = 1 << 15;

        private static const _FIELD_HEIGHT:int = 26;
        private static const _ICONS_AREA_WIDTH:int = 80;
        private static const _BADGE_ICON_WIDTH:int = 24;

        private static const _MIRRORED_VEHICLE_LEVEL_ICON_OFFSET:int = 36;

        // PROTECTED VARS

        protected var cfg:CBattleLoading;

        // PRIVATE VARS

        private var _ui:IXvmBattleLoadingItemRendererBase;
        private var _uiType:String;
        private var _isLeftPanel:Boolean;

        private var _model:DAAPIVehicleInfoVO;

        private var _vehicleIconLoaded:Boolean = false;

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

        public function XvmBattleLoadingItemRendererProxyBase(ui:IXvmBattleLoadingItemRendererBase, uiType:String, isLeftPanel:Boolean)
        {
            this._ui = ui;
            this._uiType = uiType;
            this._isLeftPanel = isLeftPanel;

            // align fields

            ui.nameField.y -= 3;
            ui.nameField.scaleX = ui.nameField.scaleY = 1;
            ui.nameField.height = _FIELD_HEIGHT;
            TextFieldEx.setVerticalAlign(ui.nameField, TextFieldEx.VALIGN_CENTER);

            ui.vehicleField.y = ui.nameField.y;
            ui.vehicleField.scaleX = ui.vehicleField.scaleY = 1;
            ui.vehicleField.height = _FIELD_HEIGHT;
            ui.vehicleField.autoSize = TextFieldAutoSize.NONE;
            TextFieldEx.setVerticalAlign(ui.vehicleField, TextFieldEx.VALIGN_CENTER);

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, _setup);
            Xvm.addEventListener(PlayerStateEvent.CHANGED, _onPlayerStateChanged);
            Xvm.addEventListener(Defines.XVM_EVENT_ATLAS_LOADED, _onAtlasLoaded);
            Xfw.addCommandListener(XvmCommands.AS_ON_CLAN_ICON_LOADED, _onClanIconLoaded);
            Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, _onStatLoaded, false, 0, true);

            _substrateHolder = ui.addChildAt(new Sprite(), 0) as Sprite;
            _bottomHolder = ui.addChildAt(new Sprite(), ui.selfBg_pub ? ui.getChildIndex(ui.selfBg_pub) + 1 : 0) as Sprite;
            _normalHolder = ui.addChildAt(new Sprite(), ui.getChildIndex(ui.playerActionMarker) + 1) as Sprite;
            _topHolder = ui.addChild(new Sprite()) as Sprite;

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

                _currentPlayerState = BattleState.get(_model.vehicleID);

                var textColor:String = XfwUtils.toHtmlColor(App.colorSchemeMgr.getScheme(getSchemeNameForPlayer(_currentPlayerState)).rgb);
                _ui.nameField.visible = true;
                _ui.nameField.htmlText = "<font color='" + textColor + "'>" + Macros.FormatString(_isLeftPanel ? cfg.formatLeftNick : cfg.formatRightNick, _currentPlayerState) + "</font>";
                _alignNameField();

                _ui.vehicleField.visible = true;
                _ui.vehicleField.htmlText = "<font color='" + textColor + "'>" + Macros.FormatString(_isLeftPanel ? cfg.formatLeftVehicle : cfg.formatRightVehicle, _currentPlayerState) + "</font>";
                _alignVehicleField();

                var atlasName:String = isLeftPanel ? leftAtlas : rightAtlas;
                if (!App.atlasMgr.isAtlasInitialized(atlasName))
                {
                    atlasName = ATLAS_CONSTANTS.BATTLE_ATLAS;
                }

                _ui.vehicleIcon.graphics.clear();
                App.atlasMgr.drawGraphics(atlasName, _model.vehicleIconName, _ui.vehicleIcon.graphics, "unknown" /*BattleLoadingHelper.VEHICLE_TYPE_UNKNOWN*/);

                var schemeName:String = getSchemeNameForVehicle(_currentPlayerState);
                var scheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
                if (scheme)
                {
                    _ui.vehicleIcon.transform.colorTransform = scheme.colorTransform;
                }
                schemeName = PlayerStatusSchemeName.getSchemeForVehicleLevel(!_model.isAlive());
                scheme = App.colorSchemeMgr.getScheme(schemeName);
                if (scheme)
                {
                    _ui.vehicleLevelIcon.transform.colorTransform = scheme.colorTransform;
                }
                _ui.vehicleIcon.alpha = cfg.vehicleIconAlpha / 100.0;
                _ui.vehicleLevelIcon.alpha = cfg.removeVehicleLevel ? 0 : cfg.vehicleIconAlpha / 100.0;

                _updateExtraFields();
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
                _ui.vehicleTypeIcon.alpha = 0;
            }

            if (cfg.nameFieldShowBorder)
            {
                _ui.nameField.border = true;
                _ui.nameField.borderColor = 0x00FF00;
            }

            if (cfg.vehicleFieldShowBorder)
            {
                _ui.vehicleField.border = true;
                _ui.vehicleField.borderColor = 0xFFFF00;
            }

            if (!_isLeftPanel)
            {
                if (Config.config.battle.mirroredVehicleIcons)
                {
                    _ui.vehicleIcon.scaleX = 1;
                }
                else
                {
                    _ui.vehicleIcon.scaleX = -1;
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
                    _ui.invalidate2(_INVALIDATE_PLAYER_STATE);
                }
            }
        }

        private function _onAtlasLoaded(e:Event):void
        {
            _ui.invalidate2(_INVALIDATE_PLAYER_STATE);
        }

        private function _onClanIconLoaded(vehicleID:Number, playerName:String):void
        {
            if (_model)
            {
                if (_model.vehicleID == vehicleID)
                {
                    _ui.invalidate2(_INVALIDATE_PLAYER_STATE);
                }
            }
        }

        private function _onStatLoaded():void
        {
            //Logger.add("onStatLoaded: " + _model.playerName);
            _ui.invalidate2(_INVALIDATE_PLAYER_STATE);
        }

        private function _getNameFieldWidth():int
        {
            var w:Number = _ui.DEFAULTS.NAME_FIELD_WIDTH;
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

        private function _getVehicleFieldWidth():int
        {
            var w:Number = _ui.DEFAULTS.VEHICLE_FIELD_WIDTH;
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

        private function _alignTextFields():void
        {
            alignTextFields();

            _alignNameField();
            _alignVehicleField();
            _alignVehicleIcon();
        }

        private function _alignNameField():void
        {
            _ui.nameField.width = _getNameFieldWidth();
            if (_isLeftPanel)
            {
                _ui.nameField.x = _ui.DEFAULTS.NAME_FIELD_X + cfg.nameFieldOffsetXLeft;
                if (!cfg.removeRankBadgeIcon)
                {
                    _ui.badgeIcon.x = _ui.nameField.x;
                    _ui.nameField.x += _BADGE_ICON_WIDTH + 1;
                    _ui.nameField.width -= _BADGE_ICON_WIDTH + 1;
                }
            }
            else
            {
                _ui.nameField.x = _ui.DEFAULTS.NAME_FIELD_X - cfg.nameFieldOffsetXRight + (_ui.DEFAULTS.NAME_FIELD_WIDTH - _ui.nameField.width);
                if (!cfg.removeRankBadgeIcon)
                {
                    _ui.badgeIcon.x = _ui.nameField.x + _ui.nameField.width - _BADGE_ICON_WIDTH;
                    _ui.nameField.width -= _BADGE_ICON_WIDTH + 1;
                }
            }
        }

        private function _alignVehicleField():void
        {
            _ui.vehicleField.width = _getVehicleFieldWidth();
            if (_isLeftPanel)
            {
                _ui.vehicleField.x = _ui.DEFAULTS.VEHICLE_FIELD_X + cfg.vehicleFieldOffsetXLeft + (_ui.DEFAULTS.VEHICLE_FIELD_WIDTH - _ui.vehicleField.width);
                if (_model)
                {
                    if (_model.isIGR)
                    {
                        var bounds:Rectangle = _ui.vehicleField.getCharBoundaries(0);
                        _ui.icoIGR.x = _ui.vehicleField.x + (bounds ? bounds.x : 0) - _ui.icoIGR.width >> 0;
                    }
                }
            }
            else
            {
                _ui.vehicleField.x = _ui.DEFAULTS.VEHICLE_FIELD_X - cfg.vehicleFieldOffsetXRight;
                if (_model)
                {
                    if (_model.isIGR)
                    {
                        _ui.icoIGR.x = _ui.vehicleField.x - _ui.icoIGR.width >> 0;
                    }
                }
            }
        }

        private function _alignVehicleIcon():void
        {
            if (_isLeftPanel)
            {
                _ui.vehicleIcon.x = _ui.DEFAULTS.VEHICLE_ICON_X + cfg.vehicleIconOffsetXLeft;
                _ui.vehicleLevelIcon.x = _ui.DEFAULTS.VEHICLE_LEVEL_X + cfg.vehicleIconOffsetXLeft;
                _ui.vehicleTypeIcon.x = _ui.DEFAULTS.VEHICLE_TYPE_ICON_X + cfg.vehicleIconOffsetXLeft;
            }
            else
            {
                if (Config.config.battle.mirroredVehicleIcons)
                {
                    _ui.vehicleIcon.x = _ui.DEFAULTS.VEHICLE_ICON_X - cfg.vehicleIconOffsetXRight;
                    _ui.vehicleLevelIcon.x = _ui.DEFAULTS.VEHICLE_LEVEL_X - cfg.vehicleIconOffsetXRight;
                }
                else
                {
                    _ui.vehicleIcon.x = _ui.DEFAULTS.VEHICLE_ICON_X - cfg.vehicleIconOffsetXRight - _ICONS_AREA_WIDTH;
                    _ui.vehicleLevelIcon.x = _ui.DEFAULTS.VEHICLE_LEVEL_X - cfg.vehicleIconOffsetXRight - _ICONS_AREA_WIDTH + _MIRRORED_VEHICLE_LEVEL_ICON_OFFSET;
                }
                _ui.vehicleTypeIcon.x = _ui.DEFAULTS.VEHICLE_TYPE_ICON_X - cfg.vehicleIconOffsetXRight;
            }
            _ui.vehicleLevelIcon.isCentralizeByX = true;
        }

        // extra fields

        private function _createExtraFields():void
        {
            var formats:Array = _isLeftPanel ? cfg.extraFieldsLeft : cfg.extraFieldsRight;
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
                var offsetX:int = _ui.DEFAULTS.EXTRA_FIELDS_X;
                var bindToIconOffset:Number;
                if (_isLeftPanel)
                {
                    bindToIconOffset = _ui.vehicleIcon.x - offsetX;
                }
                else
                {
                    bindToIconOffset = _ui.vehicleIcon.x - offsetX + (Config.config.battle.mirroredVehicleIcons ? 0 : _ICONS_AREA_WIDTH);
                }
                _extraFields.visible = true;
                _extraFields.update(_currentPlayerState, bindToIconOffset, offsetX, _ui.vehicleIcon.y);
            }
        }
    }
}
