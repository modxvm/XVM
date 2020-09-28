package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
    import net.wg.gui.battle.views.consumablesPanel.BattleShellButton;
    import net.wg.gui.battle.views.consumablesPanel.constants.COLOR_STATES;

    public class EventBattleShellButton extends BattleShellButton
    {

        public function EventBattleShellButton()
        {
            super();
        }

        override public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int = 1) : void
        {
            super.setCoolDownTime(param1,param2,param3,param4);
            if(reloading)
            {
                iconLoader.transform.colorTransform = COLOR_STATES.DARK_COLOR_TRANSFORM;
            }
            else
            {
                iconLoader.transform.colorTransform = null;
            }
        }

        override public function set buttonMode(param1:Boolean) : void
        {
        }
    }
}
