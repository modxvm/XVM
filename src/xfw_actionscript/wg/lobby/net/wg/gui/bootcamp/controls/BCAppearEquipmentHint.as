package net.wg.gui.bootcamp.controls
{
    import net.wg.gui.bootcamp.containers.TipHintAnimation;
    import flash.events.Event;

    public class BCAppearEquipmentHint extends BCHighlightRendererBase
    {

        public var hint:TipHintAnimation = null;

        public function BCAppearEquipmentHint()
        {
            super();
            this.hint.setLabel(BOOTCAMP.PREBATTLE_HINT_CONSUMABLES);
            this.hint.addFrameScript(this.hint.totalFrames - 1,this.onAnimationComplete);
        }

        override public function setProperties(param1:Number, param2:Number, param3:Boolean) : void
        {
            this.hint.x = param1 >> 1;
        }

        override protected function onDispose() : void
        {
            this.hint.addFrameScript(this.hint.totalFrames - 1,null);
            this.hint.dispose();
            this.hint = null;
            super.onDispose();
        }

        private function onAnimationComplete() : void
        {
            this.hint.stop();
            this.hint.addFrameScript(this.hint.totalFrames - 1,null);
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }
}
