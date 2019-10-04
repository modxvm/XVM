package net.wg.gui.battle.tutorial.views.tutorial.components.doneAnim
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;

    public class BattleTutorialDoneAnimContainer extends Sprite implements IDisposable
    {

        public var textField:TextField = null;

        public function BattleTutorialDoneAnimContainer()
        {
            super();
            this.textField.text = BATTLE_TUTORIAL.TASKS_ANIM_DONE;
        }

        public function dispose() : void
        {
            this.textField = null;
        }
    }
}
