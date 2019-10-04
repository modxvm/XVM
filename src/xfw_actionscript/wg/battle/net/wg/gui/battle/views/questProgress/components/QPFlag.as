package net.wg.gui.battle.views.questProgress.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.questProgress.events.QuestProgressComponentEvent;
    import flash.display.BlendMode;

    public class QPFlag extends Sprite implements IDisposable
    {

        private static const SHARP_CHAR:String = "#";

        public var taskIndexTF:TextField = null;

        public var taskIco:UILoaderAlt = null;

        public var flag:Sprite = null;

        public function QPFlag()
        {
            super();
            this.blendMode = BlendMode.SCREEN;
        }

        public final function dispose() : void
        {
            this.taskIndexTF = null;
            this.taskIco.dispose();
            this.taskIco = null;
            this.flag = null;
        }

        public function getFlagWidth() : int
        {
            return visible?this.flag.width:0;
        }

        public function setData(param1:String, param2:String) : void
        {
            this.taskIndexTF.text = SHARP_CHAR + param1;
            this.taskIco.source = param2;
        }

        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
            var _loc2_:String = param1?QuestProgressComponentEvent.SHOW:QuestProgressComponentEvent.HIDE;
            dispatchEvent(new QuestProgressComponentEvent(_loc2_));
        }
    }
}
