package net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.containers
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import scaleform.gfx.TextFieldEx;

    public class TaskAnimation extends Sprite implements IDisposable
    {

        private static const TEXT_FIELD_PADDING:int = 5;

        public var taskTF:TextField = null;

        public function TaskAnimation()
        {
            super();
            TextFieldEx.setNoTranslate(this.taskTF,true);
        }

        public function dispose() : void
        {
            this.taskTF = null;
        }

        public function setTaskText(param1:String) : void
        {
            this.taskTF.htmlText = param1;
            this.taskTF.height = this.taskTF.textHeight + TEXT_FIELD_PADDING;
        }

        public function getTaskTextHeight() : int
        {
            return this.taskTF.textHeight;
        }
    }
}
