/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.fullStats
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.text.*;
    import net.wg.gui.battle.components.*;
    import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.*;
    import net.wg.gui.battle.views.stats.*;
    import scaleform.gfx.*;

    public class StatsTableItemXvm extends StatsTableItem
    {
        private static const FIELD_HEIGHT:int = 26;

        private var DEFAULT_PLAYER_NAME_X:Number;
        private var DEFAULT_PLAYER_NAME_WIDTH:Number;
        private var DEFAULT_VEHICLE_NAME_X:Number;
        private var DEFAULT_VEHICLE_NAME_WIDTH:Number;
        private var DEFAULT_FRAGS_X:Number;
        private var DEFAULT_FRAGS_WIDTH:Number;

        private var cfg:CStatisticForm;

        private var _isLeftPanel:Boolean;
        private var _playerNameTF:TextField;
        private var _vehicleNameTF:TextField;
        private var _fragsTF:TextField;

        public function StatsTableItemXvm(isLeftPanel:Boolean, playerNameTF:TextField, vehicleNameTF:TextField, fragsTF:TextField, deadBg:BattleAtlasSprite,
            vehicleTypeIcon:BattleAtlasSprite, icoIGR:BattleAtlasSprite, vehicleIcon:BattleAtlasSprite, vehicleLevelIcon:BattleAtlasSprite,
            muteIcon:BattleAtlasSprite, speakAnimation:SpeakAnimation, vehicleActionIcon:BattleAtlasSprite, playerStatus:PlayerStatusView)
        {
            //Logger.add("StatsTableItemXvm");
            super(playerNameTF, vehicleNameTF, fragsTF, deadBg, vehicleTypeIcon, icoIGR, vehicleIcon, vehicleLevelIcon, muteIcon, speakAnimation, vehicleActionIcon, playerStatus);

            _isLeftPanel = isLeftPanel;
            _playerNameTF = playerNameTF;
            _vehicleNameTF = vehicleNameTF;
            _fragsTF = fragsTF;

            DEFAULT_PLAYER_NAME_X = playerNameTF.x;
            DEFAULT_PLAYER_NAME_WIDTH = playerNameTF.width;
            DEFAULT_VEHICLE_NAME_X = vehicleNameTF.x;
            DEFAULT_VEHICLE_NAME_WIDTH = vehicleNameTF.width;
            DEFAULT_FRAGS_X = fragsTF.x;
            DEFAULT_FRAGS_WIDTH = fragsTF.width;

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

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            alignTextFields();

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
                fragsTF.visible = true;
                fragsTF.border = true;
                fragsTF.borderColor = 0xFF0000;
            }

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
            super.onDispose();
        }

        // PRIVATE

        private function alignTextFields():void
        {
            _playerNameTF.x = DEFAULT_PLAYER_NAME_X + (_isLeftPanel ? cfg.nameFieldOffsetXLeft : -cfg.nameFieldOffsetXRight + (DEFAULT_PLAYER_NAME_WIDTH - cfg.nameFieldWidthRight));
            _playerNameTF.width = _isLeftPanel ? cfg.nameFieldWidthLeft : cfg.nameFieldWidthRight;
            _vehicleNameTF.x = DEFAULT_VEHICLE_NAME_X + (_isLeftPanel ? cfg.vehicleFieldOffsetXLeft + (DEFAULT_VEHICLE_NAME_WIDTH - cfg.vehicleFieldWidthLeft) : -cfg.vehicleFieldOffsetXRight);
            _vehicleNameTF.width = _isLeftPanel ? cfg.vehicleFieldWidthLeft : cfg.vehicleFieldWidthRight;
            _fragsTF.x = DEFAULT_FRAGS_X + (_isLeftPanel
                ? cfg.fragsFieldOffsetXLeft + (DEFAULT_FRAGS_WIDTH - cfg.fragsFieldWidthLeft) / 2
                : -cfg.fragsFieldOffsetXRight + (DEFAULT_FRAGS_WIDTH - cfg.fragsFieldWidthRight) / 2);
            _fragsTF.width = _isLeftPanel ? cfg.fragsFieldWidthLeft : cfg.fragsFieldWidthRight;
        }

        private function onConfigLoaded():void
        {
            cfg = Config.config.statisticForm;
            alignTextFields();
        }
    }
}
