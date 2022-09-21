/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.stronghold.fullStats
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.vo.*;
    import com.xvm.extraFields.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.components.*;
    import net.wg.gui.battle.random.views.stats.components.fullStats.constants.*;
    import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.*;
    import net.wg.gui.battle.views.stats.constants.*;
    import net.wg.gui.components.controls.BadgeComponent;
    import net.wg.gui.components.controls.VO.BadgeVisualVO;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.gfx.*;

    public class StrongholdStatsTableItemXvm extends StatsTableItem implements IExtraFieldGroupHolder
    {
        private static const INVALIDATE_PLAYER_STATE:uint = 1 << 15;

        private static const FIELD_HEIGHT:int = 26;
        private static const ICONS_AREA_WIDTH:int = 80;
        private static const SQUAD_ITEMS_AREA_WIDTH:int = 25;
        private static const EXTRA_FIELDS_X_LEFT:int = -500;
        private static const EXTRA_FIELDS_X_RIGHT:int = 500;

        private static const MIRRORED_VEHICLE_LEVEL_ICON_OFFSET:int = 36;

        private var DEFAULT_PLAYER_NAME_X:Number;
        private var DEFAULT_PLAYER_NAME_WIDTH:Number;
        private var DEFAULT_VEHICLE_NAME_X:Number;
        private var DEFAULT_VEHICLE_NAME_WIDTH:Number;
        private var DEFAULT_FRAGS_X:Number;
        private var DEFAULT_FRAGS_WIDTH:Number;
        private var DEFAULT_VEHICLE_ICON_X:Number;
        private var DEFAULT_VEHICLE_LEVEL_X:Number;
        private var DEFAULT_VEHICLE_TYPE_ICON_X:Number;

        private var cfg:CStatisticForm;

        private var _isLeftPanel:Boolean;
        private var _playerNameTF:TextField;
        private var _vehicleNameTF:TextField;
        private var _fragsTF:TextField;
        //private var _vehicleIcon:BattleAtlasSprite;
        private var _vehicleLevelIcon:BattleAtlasSprite;
        private var _playerStatus:PlayerStatusView;
        private var _vehicleTypeIcon:BattleAtlasSprite;
        private var _icoIGR:BattleAtlasSprite;
        private var _isIGR:Boolean = false;
        private var _badge:BadgeComponent;
        private var _badgeVO:BadgeVisualVO;
        private var _hasBadge:Boolean;

        private var _vehicleID:Number = NaN;
        private var _vehicleIconName:String = null;

        private var _substrateHolder:Sprite;
        private var _bottomHolder:Sprite;
        private var _normalHolder:Sprite;
        private var _topHolder:Sprite;

        private var extraFields:ExtraFieldsGroup = null;

        private var currentPlayerState:VOPlayerState;

        public function StrongholdStatsTableItemXvm(table:MovieClip, col:int, row:int)
        {
            //Logger.add("StrongholdStatsTableItemXvm");

            super(table, col, row);

            var index:int = col * numRows + row;
            _isLeftPanel = col == 0;
            _playerNameTF = table.playerNameCollection[index];
            _vehicleNameTF = table.vehicleNameCollection[index];
            _fragsTF = table.fragsCollection[index];
            _vehicleTypeIcon = table.vehicleTypeCollection[index];
            _icoIGR = table.icoIGRCollection[index];
            _badge = table.rankBadgesCollection[index];
            //_vehicleIcon = table.vehicleIconCollection[index];
            _vehicleLevelIcon = table.vehicleLevelCollection[index];
            _playerStatus = table.playerStatusCollection[index];

            DEFAULT_PLAYER_NAME_X = _playerNameTF.x;
            DEFAULT_PLAYER_NAME_WIDTH = _playerNameTF.width;
            DEFAULT_VEHICLE_NAME_X = _vehicleNameTF.x;
            DEFAULT_VEHICLE_NAME_WIDTH = 105; // vehicleNameTF.width;
            DEFAULT_FRAGS_X = _fragsTF.x;
            DEFAULT_FRAGS_WIDTH = _fragsTF.width;
            DEFAULT_VEHICLE_ICON_X = vehicleIcon.x;
            DEFAULT_VEHICLE_LEVEL_X = _vehicleLevelIcon.x;
            DEFAULT_VEHICLE_TYPE_ICON_X = _vehicleTypeIcon.x;

            // align fields
            _fragsTF.y -= 1;
            _fragsTF.scaleX = _fragsTF.scaleY = 1;
            _fragsTF.height = FIELD_HEIGHT;
            TextFieldEx.setVerticalAlign(_fragsTF, TextFieldEx.VALIGN_CENTER);

            _playerNameTF.y = _fragsTF.y;
            _playerNameTF.scaleX = _playerNameTF.scaleY = 1;
            _playerNameTF.height = FIELD_HEIGHT;
            TextFieldEx.setVerticalAlign(_playerNameTF, TextFieldEx.VALIGN_CENTER);

            _vehicleNameTF.y = _fragsTF.y;
            _vehicleNameTF.scaleX = _vehicleNameTF.scaleY = 1;
            _vehicleNameTF.height = FIELD_HEIGHT;
            _vehicleNameTF.autoSize = TextFieldAutoSize.NONE;
            TextFieldEx.setVerticalAlign(_vehicleNameTF, TextFieldEx.VALIGN_CENTER);

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, disposeAndSetupExtraFields);
            Xvm.addEventListener(PlayerStateEvent.CHANGED, onPlayerStateChanged);
            Xvm.addEventListener(Defines.XVM_EVENT_ATLAS_LOADED, onAtlasLoaded);
            Xfw.addCommandListener(XvmCommands.AS_ON_CLAN_ICON_LOADED, onClanIconLoaded);
            Xvm.addEventListener(BattleEvents.PLAYERS_ORDER_CHANGED, onOrderChanged);
            Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, onStatLoaded, false, 0, true);

            _substrateHolder = _playerNameTF.parent.addChildAt(new Sprite(), 0) as Sprite;
            _bottomHolder = _substrateHolder;
            _normalHolder = _playerNameTF.parent.addChildAt(new Sprite(), _playerNameTF.parent.getChildIndex(_icoIGR) + 1) as Sprite;
            _topHolder = _playerNameTF.parent.addChild(new Sprite()) as Sprite;

            setupExtraFields();
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, disposeAndSetupExtraFields);
            Xvm.removeEventListener(PlayerStateEvent.CHANGED, onPlayerStateChanged);
            Xvm.removeEventListener(Defines.XVM_EVENT_ATLAS_LOADED, onAtlasLoaded);
            Xfw.removeCommandListener(XvmCommands.AS_ON_CLAN_ICON_LOADED, onClanIconLoaded);
            Xvm.removeEventListener(BattleEvents.PLAYERS_ORDER_CHANGED, onOrderChanged);
            Stat.instance.removeEventListener(Stat.COMPLETE_BATTLE, onStatLoaded)

            disposeExtraFields();

            _substrateHolder = null;
            _bottomHolder = null;
            _normalHolder = null;
            _topHolder = null;

            super.onDispose();
        }

        override public function setPlayerName(userProps:IUserProps):void
        {
            super.setPlayerName(userProps);
            var vehicleID:Number = BattleState.getVehicleIDByPlayerName(userProps.fakeName);
            if (_vehicleID != vehicleID)
            {
                _vehicleID = vehicleID;
                currentPlayerState = BattleState.get(_vehicleID);
                disposeAndSetupExtraFields();
            }
        }

        override public function setIsIGR(isIGR:Boolean):void
        {
            _isIGR = isIGR;
        }

        override public function setBadge(_badgeVO:BadgeVisualVO, _hasBadge:Boolean):void
        {
            _hasBadge = cfg.removeRankBadgeIcon ? false : _hasBadge;
            super.setBadge(_badgeVO, _hasBadge);
        }

        override public function setSuffixBadge(suffixBadgeType:String):void
        {
            super.setSuffixBadge(cfg.removeTesterIcon ? "" : suffixBadgeType);
        }

        override public function setVehicleIcon(vehicleIconName:String):void
        {
            super.setVehicleIcon(vehicleIconName);
            if (_vehicleIconName != vehicleIconName)
            {
                _vehicleIconName = vehicleIconName;
            }
        }

        override protected function draw():void
        {
            super.draw();

            if (!_vehicleID)
                return;

            var updatePlayerNameField:Boolean = false;
            var updateVehicleNameField:Boolean = false;
            var updateFragsField:Boolean = false;
            var updateVehicleIcon:Boolean = false;
            var updateVehicleLevelIcon:Boolean = false;
            var updateExtraFields:Boolean = false;
            var updateIgr:Boolean = false;

            currentPlayerState = BattleState.get(_vehicleID);

            if (isInvalid(FullStatsValidationType.USER_PROPS))
            {
                updatePlayerNameField = true;
            }
            if (isInvalid(FullStatsValidationType.BADGE))
            {
                alignPlayerNameTF();
            }
            if (isInvalid(FullStatsValidationType.COLORS))
            {
                var schemeName:String = getSchemeNameForVehicle(currentPlayerState);
                var colorScheme:IColorScheme = App.colorSchemeMgr.getScheme(schemeName);
                vehicleIcon.transform.colorTransform = colorScheme.colorTransform;
                vehicleIcon.alpha *= cfg.vehicleIconAlpha / 100.0;
            }
            if (isInvalid(FullStatsValidationType.VEHICLE_NAME))
            {
                updateVehicleNameField = true;
                updateIgr = true;
            }
            if (isInvalid(RandomFullStatsValidationType.VEHICLE_ICON))
            {
                if (this._vehicleIconName)
                {
                    updateVehicleIcon = true;
                }
            }
            if (isInvalid(RandomFullStatsValidationType.VEHICLE_LEVEL))
            {
                if (this._vehicleLevelIcon.visible)
                {
                    updateVehicleLevelIcon = true;
                }
            }
            if (isInvalid(FullStatsValidationType.FRAGS))
            {
                updateFragsField = true;
            }
            if (isInvalid(FullStatsValidationType.IS_IGR))
            {
                updateIgr = true;
            }
            if (isInvalid(INVALIDATE_PLAYER_STATE) || isInvalid(FullStatsValidationType.COLORS))
            {
                updatePlayerNameField = true;
                updateVehicleNameField = true;
                updateFragsField = true;
                updateExtraFields = true;
            }

            if (updatePlayerNameField || updateVehicleNameField || updateFragsField)
            {
                if (currentPlayerState)
                {
                    var textColor:String = XfwUtils.toHtmlColor(App.colorSchemeMgr.getScheme(getSchemeNameForPlayer(currentPlayerState)).rgb);
                    if (updatePlayerNameField)
                    {
                        _playerNameTF.visible = true;
                        _playerNameTF.htmlText = "<font color='" + textColor + "'>" +
                            Macros.FormatString(_isLeftPanel ? cfg.formatLeftNick : cfg.formatRightNick, currentPlayerState) + "</font>";
                    }
                    if (updateVehicleNameField)
                    {
                        _vehicleNameTF.visible = true;
                        _vehicleNameTF.htmlText =  "<font color='" + textColor + "'>" +
                            Macros.FormatString(_isLeftPanel ? cfg.formatLeftVehicle : cfg.formatRightVehicle, currentPlayerState) + "</font>";
                        alignVehicleNameTF();
                    }
                    if (updateFragsField)
                    {
                        _fragsTF.visible = true;
                        _fragsTF.htmlText =  "<font color='" + textColor + "'>" +
                            Macros.FormatString(_isLeftPanel ? cfg.formatLeftFrags : cfg.formatRightFrags, currentPlayerState) + "</font>";
                    }
                }
            }
            if (updateVehicleIcon)
            {
                var atlasName:String = _isLeftPanel ? UI_StrongholdFullStats.leftAtlas : UI_StrongholdFullStats.rightAtlas;
                if (!App.atlasMgr.isAtlasInitialized(atlasName))
                {
                    atlasName = ATLAS_CONSTANTS.BATTLE_ATLAS;
                }
                vehicleIcon.graphics.clear();
                App.atlasMgr.drawGraphics(atlasName, _vehicleIconName, vehicleIcon.graphics, "unknown" /*BattleLoadingHelper.VEHICLE_TYPE_UNKNOWN*/);
            }
            if (updateVehicleLevelIcon)
            {
                alignVehicleLevelIcon();
            }
            if (updateIgr)
            {
                if (_isIGR)
                {
                    if (_isLeftPanel)
                    {
                        var bounds:Rectangle = _vehicleNameTF.getCharBoundaries(0);
                        _icoIGR.x = _vehicleNameTF.x + (bounds ? bounds.x : 0) - this._icoIGR.width >> 0;
                    }
                    else
                    {
                        _icoIGR.x = this._vehicleNameTF.x - this._icoIGR.width >> 0;
                    }
                }
                else
                {
                    alignVehicleNameTF();
                }
            }
            if (updateExtraFields)
            {
                this.updateExtraFields();
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
                options.isCurrentPlayer && highlightVehicleIcon,
                options.isSquadPersonal && highlightVehicleIcon,
                options.isTeamKiller,
                options.isDead,
                options.isOffline);
        }

        public function getSchemeNameForPlayer(options:IVOMacrosOptions):String
        {
            return PlayerStatusSchemeName.getSchemeNameForPlayer(
                options.isCurrentPlayer,
                options.isSquadPersonal,
                options.isTeamKiller,
                options.isDead,
                options.isOffline);
        }

        // XVM events handlers

        private function disposeAndSetupExtraFields():void
        {
            disposeExtraFields();
            setupExtraFields();
        }

        private function setupExtraFields():void
        {
            cfg = Config.config.statisticForm;

            if (cfg.removeVehicleLevel)
            {
                _vehicleLevelIcon.alpha = 0;
            }

            if (cfg.removeVehicleTypeIcon)
            {
                _vehicleTypeIcon.alpha = 0;
            }

            if (cfg.removePlayerStatusIcon)
            {
               _playerStatus.alpha = 0;
            }

            if (cfg.nameFieldShowBorder)
            {
                _playerNameTF.border = true;
                _playerNameTF.borderColor = 0x00FF00;
            }

            if (cfg.vehicleFieldShowBorder)
            {
                _vehicleNameTF.border = true;
                _vehicleNameTF.borderColor = 0xFFFF00;
            }

            if (cfg.fragsFieldShowBorder)
            {
                _fragsTF.border = true;
                _fragsTF.borderColor = 0xFF0000;
            }

            if (!_isLeftPanel)
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

            createExtraFields();
            alignTextFields();
        }

        private function onPlayerStateChanged(e:PlayerStateEvent):void
        {
            if (e.vehicleID == _vehicleID)
            {
                invalidate(INVALIDATE_PLAYER_STATE);
            }
        }

        private function onAtlasLoaded(e:Event):void
        {
            invalidate(RandomFullStatsValidationType.VEHICLE_ICON | RandomFullStatsValidationType.VEHICLE_LEVEL);
        }

        private function onClanIconLoaded(vehicleID:Number, playerName:String):void
        {
            invalidate(INVALIDATE_PLAYER_STATE);
        }

        private function onOrderChanged(e:IntEvent):void
        {
            if (e.value == _vehicleID)
            {
                invalidate(INVALIDATE_PLAYER_STATE);
            }
        }

        private function onStatLoaded():void
        {
            // TODO if (_vehicleID in updatedPlayers)
            invalidate(INVALIDATE_PLAYER_STATE);
        }

        // PRIVATE

        private function alignTextFields():void
        {
            alignPlayerNameTF();
            alignVehicleNameTF();
            alignFragsTF();
            alignVehicleIcon();
        }

        private function alignPlayerNameTF():void
        {
            if (_isLeftPanel)
            {
                _playerNameTF.x = DEFAULT_PLAYER_NAME_X + cfg.nameFieldOffsetXLeft;
                _playerNameTF.width = cfg.nameFieldWidthLeft;
                if (_badge.visible)
                {
                    _badge.x = _playerNameTF.x;
                    _playerNameTF.x += _badge.width + 1;
                    _playerNameTF.width -= _badge.width + 1;
                }
            }
            else
            {
                _playerNameTF.x = DEFAULT_PLAYER_NAME_X - cfg.nameFieldOffsetXRight + (DEFAULT_PLAYER_NAME_WIDTH - cfg.nameFieldWidthRight);
                _playerNameTF.width = cfg.nameFieldWidthRight;
                if (_badge.visible)
                {
                    _badge.x = _playerNameTF.x + _playerNameTF.width - _badge.width;
                    _playerNameTF.width -= _badge.width + 1;
                }
            }
        }

        private function alignVehicleNameTF():void
        {
            if (_isLeftPanel)
            {
                _vehicleNameTF.x = DEFAULT_VEHICLE_NAME_X + cfg.vehicleFieldOffsetXLeft + (DEFAULT_VEHICLE_NAME_WIDTH - cfg.vehicleFieldWidthLeft);
                _vehicleNameTF.width = cfg.vehicleFieldWidthLeft;
            }
            else
            {
                _vehicleNameTF.x = DEFAULT_VEHICLE_NAME_X - cfg.vehicleFieldOffsetXRight;
                _vehicleNameTF.width = cfg.vehicleFieldWidthRight;
            }
        }

        private function alignFragsTF():void
        {
            if (_isLeftPanel)
            {
                _fragsTF.x = DEFAULT_FRAGS_X + cfg.fragsFieldOffsetXLeft + (DEFAULT_FRAGS_WIDTH - cfg.fragsFieldWidthLeft) / 2;
                _fragsTF.width = cfg.fragsFieldWidthLeft;
            }
            else
            {
                _fragsTF.x = DEFAULT_FRAGS_X - cfg.fragsFieldOffsetXRight + (DEFAULT_FRAGS_WIDTH - cfg.fragsFieldWidthRight) / 2;
                _fragsTF.width = cfg.fragsFieldWidthRight;
            }
        }

        private function alignVehicleIcon():void
        {
            if (_isLeftPanel)
            {
                vehicleIcon.x = DEFAULT_VEHICLE_ICON_X + cfg.vehicleIconOffsetXLeft;
                _vehicleTypeIcon.x = DEFAULT_VEHICLE_TYPE_ICON_X + cfg.vehicleIconOffsetXLeft;
            }
            else
            {
                if (Config.config.battle.mirroredVehicleIcons)
                {
                    vehicleIcon.x = DEFAULT_VEHICLE_ICON_X - cfg.vehicleIconOffsetXRight;
                }
                else
                {
                    vehicleIcon.x = DEFAULT_VEHICLE_ICON_X - cfg.vehicleIconOffsetXRight - ICONS_AREA_WIDTH;
                }
                _vehicleTypeIcon.x = DEFAULT_VEHICLE_TYPE_ICON_X - cfg.vehicleIconOffsetXRight;
            }
            alignVehicleLevelIcon();
        }

        private function alignVehicleLevelIcon():void
        {
            if (_isLeftPanel)
            {
                _vehicleLevelIcon.x = DEFAULT_VEHICLE_LEVEL_X + cfg.vehicleIconOffsetXLeft;
            }
            else
            {
                if (Config.config.battle.mirroredVehicleIcons)
                {
                    _vehicleLevelIcon.x = DEFAULT_VEHICLE_LEVEL_X - cfg.vehicleIconOffsetXRight;
                }
                else
                {
                    _vehicleLevelIcon.x = DEFAULT_VEHICLE_LEVEL_X - cfg.vehicleIconOffsetXRight - ICONS_AREA_WIDTH + MIRRORED_VEHICLE_LEVEL_ICON_OFFSET;
                }
            }
            _vehicleLevelIcon.isCentralizeByX = true;
            _vehicleLevelIcon.x = _vehicleLevelIcon.x - _vehicleLevelIcon.width / 2;
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
                var offsetX:Number;
                var bindToIconOffset:Number;
                if (_isLeftPanel)
                {
                    offsetX = EXTRA_FIELDS_X_LEFT;
                    bindToIconOffset = vehicleIcon.x - offsetX;
                }
                else
                {
                    offsetX = EXTRA_FIELDS_X_RIGHT;
                    bindToIconOffset = vehicleIcon.x - offsetX + (Config.config.battle.mirroredVehicleIcons ? 0 : ICONS_AREA_WIDTH);
                }
                extraFields.visible = true;
                extraFields.update(currentPlayerState, bindToIconOffset, offsetX, vehicleIcon.y);
            }
        }
    }

}