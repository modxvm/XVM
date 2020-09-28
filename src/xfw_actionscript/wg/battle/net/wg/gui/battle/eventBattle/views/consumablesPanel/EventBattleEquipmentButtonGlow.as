package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
    import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButtonGlow;
    import net.wg.data.constants.generated.CONSUMABLES_PANEL_SETTINGS;

    public class EventBattleEquipmentButtonGlow extends BattleEquipmentButtonGlow
    {

        private static const SHOW_GLOW_BLUE_STATE:String = "blue";

        private static const SHOW_GLOW_HIDETEXT_STATE:String = "hideText";

        private static const SHOW_GLOW_HIDEBACK_STATE:String = "hideBack";

        private static const HIDE_STATE:String = "hide";

        private static const READY_TEXT_COLOR:uint = 7977983;

        public function EventBattleEquipmentButtonGlow()
        {
            super();
        }

        override public function hideGlow(param1:Boolean = true) : void
        {
            if(currentLabel == SHOW_GLOW_HIDETEXT_STATE)
            {
                gotoAndPlay(SHOW_GLOW_HIDEBACK_STATE);
            }
            else
            {
                gotoAndPlay(HIDE_STATE);
            }
            bindKeyField.textColor = NORMAL_TEXT_COLOR;
        }

        override public function showGlow(param1:int) : void
        {
            if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_ORANGE || param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_GREEN)
            {
                this.showBlueGlow();
            }
        }

        public function abilityReady() : void
        {
            this.showBlueGlow();
        }

        public function hideText() : void
        {
            if(currentLabel == SHOW_GLOW_BLUE_STATE)
            {
                gotoAndPlay(SHOW_GLOW_HIDETEXT_STATE);
            }
            bindKeyField.textColor = NORMAL_TEXT_COLOR;
        }

        private function showBlueGlow() : void
        {
            if(currentLabel != SHOW_GLOW_BLUE_STATE)
            {
                gotoAndPlay(SHOW_GLOW_BLUE_STATE);
                bindKeyField.textColor = READY_TEXT_COLOR;
            }
        }
    }
}
