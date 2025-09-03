/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.classic.fullStats
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import net.wg.gui.battle.components.*;
    import net.wg.gui.battle.components.buttons.*;
    import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.*;
    import net.wg.gui.battle.views.stats.fullStats.*;

    public class DynamicSquadCtrlXvm extends DynamicSquadCtrl
    {
        private var DEFAULT_SQUAD_STATUS_X:Number;
        private var DEFAULT_SQUAD_ICON_X:Number;

        private var cfg:CStatisticForm;

        private var _isLeftPanel:Boolean;
        private var _squadStatus:SquadInviteStatusView;
        private var _squadIcon:BattleAtlasSprite;

        public function DynamicSquadCtrlXvm(isLeftPanel:Boolean, squadStatus:SquadInviteStatusView, squadIcon:BattleAtlasSprite,
            squadAcceptBt:BattleButton, squadAddBt:BattleButton, hit:Sprite, noSound:BattleAtlasSprite = null)
        {
            //Logger.add("DynamicSquadCtrl");
            super(squadStatus, squadIcon, squadAcceptBt, squadAddBt, hit, noSound);
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init(isLeftPanel, squadStatus, squadIcon, squadAcceptBt, squadAddBt, hit, noSound);
        }

        private function _init(isLeftPanel:Boolean, squadStatus:SquadInviteStatusView, squadIcon:BattleAtlasSprite,
            squadAcceptBt:BattleButton, squadAddBt:BattleButton, hit:Sprite, noSound:BattleAtlasSprite):void
        {
            _isLeftPanel = isLeftPanel;
            _squadStatus = squadStatus;
            _squadIcon = squadIcon;

            DEFAULT_SQUAD_STATUS_X = squadStatus.x;
            DEFAULT_SQUAD_ICON_X = squadIcon.x;

            cfg = Config.config.statisticForm;

            if (cfg.removeSquadIcon)
            {
                squadStatus.alpha = 0;
                squadIcon.alpha = 0;
            }

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            alignTextFields();
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            super.onDispose();
        }

        // PRIVATE

        private function alignTextFields():void
        {
            if (_isLeftPanel)
            {
                _squadStatus.x = DEFAULT_SQUAD_STATUS_X + cfg.squadIconOffsetXLeft;
                _squadIcon.x = DEFAULT_SQUAD_ICON_X + cfg.squadIconOffsetXLeft;
            }
            else
            {
                _squadStatus.x = DEFAULT_SQUAD_STATUS_X - cfg.squadIconOffsetXRight;
                _squadIcon.x = DEFAULT_SQUAD_ICON_X - cfg.squadIconOffsetXRight;
            }
        }

        private function onConfigLoaded():void
        {
            cfg = Config.config.statisticForm;
            alignTextFields();
        }
    }
}
