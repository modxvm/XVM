/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.fullStats
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.vo.*;
    import com.xvm.types.cfg.*;
    import flash.text.*;
    import flash.geom.*;
    import net.wg.data.constants.*;
    import net.wg.gui.battle.components.*;
    import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.*;
    import net.wg.gui.battle.views.stats.*;
    import net.wg.gui.battle.views.stats.constants.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.gfx.*;

    public class StatsTableItemXvm extends StatsTableItem
    {
        private static const FIELD_HEIGHT:int = 26;

        private static const INVALIDATE_PLAYER_STATE:uint = 1 << 15;

        private var DEFAULT_PLAYER_NAME_X:Number;
        private var DEFAULT_PLAYER_NAME_WIDTH:Number;
        private var DEFAULT_VEHICLE_NAME_X:Number;
        private var DEFAULT_VEHICLE_NAME_WIDTH:Number;
        private var DEFAULT_FRAGS_X:Number;
        private var DEFAULT_FRAGS_WIDTH:Number;
        private var DEFAULT_VEHICLE_ICON_X:Number;
        private var DEFAULT_VEHICLE_TYPE_ICON_X:Number;

        private var cfg:CStatisticForm;

        private var _isLeftPanel:Boolean;
        private var _playerNameTF:TextField;
        private var _vehicleNameTF:TextField;
        private var _fragsTF:TextField;
        private var _vehicleIcon:BattleAtlasSprite;
        private var _vehicleTypeIcon:BattleAtlasSprite;
        private var _icoIGR:BattleAtlasSprite;
        private var _isIGR:Boolean = false;

        private var _vehicleID:Number = NaN;

        public function StatsTableItemXvm(isLeftPanel:Boolean, playerNameTF:TextField, vehicleNameTF:TextField, fragsTF:TextField, deadBg:BattleAtlasSprite,
            vehicleTypeIcon:BattleAtlasSprite, icoIGR:BattleAtlasSprite, vehicleIcon:BattleAtlasSprite, vehicleLevelIcon:BattleAtlasSprite,
            muteIcon:BattleAtlasSprite, speakAnimation:SpeakAnimation, vehicleActionIcon:BattleAtlasSprite, playerStatus:PlayerStatusView)
        {
            //Logger.add("StatsTableItemXvm");
            super(playerNameTF, vehicleNameTF, fragsTF, deadBg, vehicleTypeIcon, icoIGR, vehicleIcon, vehicleLevelIcon, muteIcon, speakAnimation, vehicleActionIcon, playerStatus);

            _isLeftPanel = isLeftPanel;
            _playerNameTF = playerNameTF;
            _vehicleNameTF = vehicleNameTF;
            _icoIGR = icoIGR;
            _fragsTF = fragsTF;
            _vehicleIcon = vehicleIcon;
            _vehicleTypeIcon = vehicleTypeIcon;

            DEFAULT_PLAYER_NAME_X = playerNameTF.x;
            DEFAULT_PLAYER_NAME_WIDTH = playerNameTF.width;
            DEFAULT_VEHICLE_NAME_X = vehicleNameTF.x;
            DEFAULT_VEHICLE_NAME_WIDTH = vehicleNameTF.width;
            DEFAULT_FRAGS_X = fragsTF.x;
            DEFAULT_FRAGS_WIDTH = fragsTF.width;
            DEFAULT_VEHICLE_ICON_X = vehicleIcon.x;
            DEFAULT_VEHICLE_TYPE_ICON_X = vehicleTypeIcon.x;

            cfg = Config.config.statisticForm;

            // align fields
            fragsTF.y -= 1;
            fragsTF.scaleX = fragsTF.scaleY = 1;
            fragsTF.height = FIELD_HEIGHT;
            TextFieldEx.setVerticalAlign(fragsTF, TextFieldEx.VALIGN_CENTER);

            playerNameTF.y = fragsTF.y;
            playerNameTF.scaleX = playerNameTF.scaleY = 1;
            playerNameTF.height = FIELD_HEIGHT;
            TextFieldEx.setVerticalAlign(playerNameTF, TextFieldEx.VALIGN_CENTER);

            vehicleNameTF.y = fragsTF.y;
            vehicleNameTF.scaleX = vehicleNameTF.scaleY = 1;
            vehicleNameTF.height = FIELD_HEIGHT;
            TextFieldEx.setVerticalAlign(vehicleNameTF, TextFieldEx.VALIGN_CENTER);

            if (cfg.removeVehicleLevel)
            {
                vehicleLevelIcon.alpha = 0;
            }

            if (cfg.removeVehicleTypeIcon)
            {
                vehicleTypeIcon.alpha = 0;
            }

            if (cfg.nameFieldShowBorder)
            {
                playerNameTF.border = true;
                playerNameTF.borderColor = 0x00FF00;
            }

            if (cfg.vehicleFieldShowBorder)
            {
                vehicleNameTF.border = true;
                vehicleNameTF.borderColor = 0xFFFF00;
            }

            if (cfg.fragsFieldShowBorder)
            {
                fragsTF.border = true;
                fragsTF.borderColor = 0xFF0000;
            }

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xvm.addEventListener(PlayerStateEvent.CHANGED, onPlayerStateChanged);
            Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, onStatLoaded)
            alignTextFields();

            /*
    "formatLeftNick": "<img src='xvm://res/icons/flags/{{flag|default}}.png' width='16' height='13'> <img src='xvm://res/icons/xvm/xvm-user-{{xvm-user}}.png'> {{name%.15s~..}} <font alpha='#A0'>{{clan}}</font>",
    "formatRightNick": "<font alpha='#A0'>{{clan}}</font> {{name%.15s~..}} <img src='xvm://res/icons/xvm/xvm-user-{{xvm-user}}.png'> <img src='xvm://res/icons/flags/{{flag|default}}.png' width='16' height='13'>",
    "formatLeftVehicle": "{{vehicle}}<font face='mono' size='{{xvm-stat?13|0}}'> <font color='{{c:kb}}'>{{kb%2d~k|--k}}</font> <font color='{{c:r}}'>{{r}}</font> <font color='{{c:winrate}}'>{{winrate%2d~%|--%}}</font></font>",
    "formatRightVehicle": "<font face='mono' size='{{xvm-stat?13|0}}'><font color='{{c:winrate}}'>{{winrate%2d~%|--%}}</font> <font color='{{c:r}}'>{{r}}</font> <font color='{{c:kb}}'>{{kb%2d~k|--k}}</font> </font>{{vehicle}}"
    */
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xvm.removeEventListener(PlayerStateEvent.CHANGED, onPlayerStateChanged);
            Stat.instance.removeEventListener(Stat.COMPLETE_BATTLE, onStatLoaded)
            super.onDispose();
        }

        override public function setPlayerName(userProps:IUserProps):void
        {
            super.setPlayerName(userProps);
            _vehicleID = BattleState.getVehicleID(userProps.userName);
        }

        override public function setIsIGR(isIGR:Boolean):void
        {
            _isIGR = isIGR;
        }

        override protected function draw():void
        {
            super.draw();

            var updatePlayerNameField:Boolean = false;
            var updateVehicleNameField:Boolean = false;
            var updateFragsField:Boolean = false;
            var updateIgr:Boolean = false;
            var needAlign:Boolean = false;

            if (isInvalid(FullStatsValidationType.USER_PROPS))
            {
                updatePlayerNameField = true;
            }
            if (isInvalid(FullStatsValidationType.VEHICLE_NAME))
            {
                updateVehicleNameField = true;
                updateIgr = true;
            }
            if (isInvalid(FullStatsValidationType.FRAGS))
            {
                updateFragsField = true;
            }
            if (isInvalid(FullStatsValidationType.IS_IGR))
            {
                updateIgr = true;
                needAlign = true;
            }
            if (isInvalid(INVALIDATE_PLAYER_STATE) || isInvalid(FullStatsValidationType.COLORS))
            {
                updatePlayerNameField = true;
                updateVehicleNameField = true;
                updateFragsField = true;
            }

            if (updatePlayerNameField || updateVehicleNameField || updateFragsField)
            {
                var playerState:VOPlayerState = BattleState.get(_vehicleID);
                if (playerState)
                {
                    if (updatePlayerNameField)
                    {
                        _playerNameTF.visible = true;
                        _playerNameTF.htmlText = Macros.FormatString(_isLeftPanel ? cfg.formatLeftNick : cfg.formatRightNick, playerState);
                    }
                    if (updateVehicleNameField)
                    {
                        _vehicleNameTF.visible = true;
                        _vehicleNameTF.htmlText = Macros.FormatString(_isLeftPanel ? cfg.formatLeftVehicle : cfg.formatRightVehicle, playerState);
                    }
                    if (updateFragsField)
                    {
                        _fragsTF.visible = true;
                        _fragsTF.htmlText = Macros.FormatString(_isLeftPanel ? cfg.formatLeftFrags : cfg.formatRightFrags, playerState);
                    }
                }
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
            }
        }

        // XVM events handlers

        private function onConfigLoaded():void
        {
            cfg = Config.config.statisticForm;
            alignTextFields();
        }

        private function onPlayerStateChanged(e:PlayerStateEvent):void
        {
            invalidate(INVALIDATE_PLAYER_STATE);
        }

        private function onStatLoaded():void
        {
            // TODO if (_vehicleID in updatedPlayers)
            invalidate(INVALIDATE_PLAYER_STATE);
        }

        // PRIVATE

        private function alignTextFields():void
        {
            if (_isLeftPanel)
            {
                _playerNameTF.x = DEFAULT_PLAYER_NAME_X + cfg.nameFieldOffsetXLeft;
                _playerNameTF.width = cfg.nameFieldWidthLeft;
                _vehicleNameTF.x = DEFAULT_VEHICLE_NAME_X + cfg.vehicleFieldOffsetXLeft + (DEFAULT_VEHICLE_NAME_WIDTH - cfg.vehicleFieldWidthLeft);
                _vehicleNameTF.width = cfg.vehicleFieldWidthLeft;
                _fragsTF.x = DEFAULT_FRAGS_X + cfg.fragsFieldOffsetXLeft + (DEFAULT_FRAGS_WIDTH - cfg.fragsFieldWidthLeft) / 2;
                _fragsTF.width = cfg.fragsFieldWidthLeft;
                _vehicleIcon.x = DEFAULT_VEHICLE_ICON_X + cfg.vehicleIconOffsetXLeft;
                _vehicleTypeIcon.x = DEFAULT_VEHICLE_TYPE_ICON_X + cfg.vehicleIconOffsetXLeft;
            }
            else
            {
                _playerNameTF.x = DEFAULT_PLAYER_NAME_X - cfg.nameFieldOffsetXRight + (DEFAULT_PLAYER_NAME_WIDTH - cfg.nameFieldWidthRight);
                _playerNameTF.width = cfg.nameFieldWidthRight;
                _vehicleNameTF.x = DEFAULT_VEHICLE_NAME_X - cfg.vehicleFieldOffsetXRight;
                _vehicleNameTF.width = cfg.vehicleFieldWidthRight;
                _fragsTF.x = DEFAULT_FRAGS_X - cfg.fragsFieldOffsetXRight + (DEFAULT_FRAGS_WIDTH - cfg.fragsFieldWidthRight) / 2;
                _fragsTF.width = cfg.fragsFieldWidthRight;
                _vehicleIcon.x = DEFAULT_VEHICLE_ICON_X - cfg.vehicleIconOffsetXRight;
                _vehicleTypeIcon.x = DEFAULT_VEHICLE_TYPE_ICON_X - cfg.vehicleIconOffsetXRight;
            }
        }
    }
}
