/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.teamBasesPanel
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    // TODO:1.10.0
    //import net.wg.gui.components.common.ticker.events.*;

    public class UI_teamBasesPanel extends teamBasesPanelUI
    {
        private var DEFAULT_RENDERER_LENGTH:Number = xfw_RENDERER_HEIGHT;
        private var DEFAULT_CAPTURE_BAR_LINKAGE:String = Linkages.CAPTURE_BAR_LINKAGE;
        private var XVM_CAPTURE_BAR_LINKAGE:String = getQualifiedClassName(UI_TeamCaptureBar);
        private var DEFAULT_Y:Number;

        public function UI_teamBasesPanel()
        {
            //Logger.add("UI_teamBasesPanel()");
            super();
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init();
        }

        private function _init():void
        {
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            Xfw.addCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, setup);
            /* TODO:1.10.0
            if (BattleXvmView.battlePageBattleTicker)
            {
                BattleXvmView.battlePageBattleTicker.addEventListener(BattleTickerEvent.SHOW, setup);
                BattleXvmView.battlePageBattleTicker.addEventListener(BattleTickerEvent.HIDE, setup);
            }
            */
        }

        override protected function configUI():void
        {
            super.configUI();
            DEFAULT_Y = y;
            setup();
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, setup);
            Xfw.removeCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, setup);
            /* TODO:1.10.0
            if (BattleXvmView.battlePageBattleTicker)
            {
                BattleXvmView.battlePageBattleTicker.removeEventListener(BattleTickerEvent.SHOW, setup);
                BattleXvmView.battlePageBattleTicker.removeEventListener(BattleTickerEvent.HIDE, setup);
            }
            */
            super.onDispose();
        }

        override public function setCompVisible(value:Boolean):void
        {
            Xvm.dispatchEvent(new BooleanEvent(BattleEvents.TEAM_BASES_PANEL_VISIBLE, value));
            super.setCompVisible(value);
        }

        // PRIVATE

        private function setup():void
        {
            //Xvm.swfProfilerBegin("UI_teamBasesPanel.update()");
            try
            {
                if (Macros.FormatBooleanGlobal(Config.config.captureBar.enabled, true))
                {
                    Linkages.CAPTURE_BAR_LINKAGE = XVM_CAPTURE_BAR_LINKAGE;
                    y = Macros.FormatNumberGlobal(Config.config.captureBar.y, DEFAULT_Y);
                    xfw_RENDERER_HEIGHT = Macros.FormatNumberGlobal(Config.config.captureBar.distanceOffset, 0) + DEFAULT_RENDERER_LENGTH;
                }
                else
                {
                    Linkages.CAPTURE_BAR_LINKAGE = DEFAULT_CAPTURE_BAR_LINKAGE;
                    y = DEFAULT_Y;
                    xfw_RENDERER_HEIGHT = DEFAULT_RENDERER_LENGTH;
                }
                // TODO: The game crashes on replay of EpicRandom when xfw_updatePositions() is called
                if (Xvm.appType != Defines.APP_TYPE_BATTLE_EPICRANDOM)
                {
                    xfw_updatePositions();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            //Xvm.swfProfilerEnd("UI_teamBasesPanel.update()");
        }
    }
}
