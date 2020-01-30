package net.wg.gui.bootcamp.controls
{
    import flash.display.MovieClip;
    import flash.events.Event;
    import net.wg.gui.bootcamp.events.AppearEvent;
    import net.wg.data.constants.Values;

    public class BCAppearHint extends BCHighlightRendererBase
    {

        private static const ORIGINAL_SIZE:int = 130;

        public var animationMC:MovieClip;

        private var _isStartAnimation:Boolean = false;

        public function BCAppearHint()
        {
            super();
            this.animationMC.addFrameScript(this.animationMC.totalFrames - 1,this.onAnimationComplete);
            addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
        }

        override public function setProperties(param1:Number, param2:Number, param3:Boolean) : void
        {
            this.animationMC.scaleX = param1 / ORIGINAL_SIZE;
            this.animationMC.scaleY = param2 / ORIGINAL_SIZE;
            this.animationMC.x = param1 >> 1;
            this.animationMC.y = param2 >> 1;
        }

        override protected function onDispose() : void
        {
            this.animationMC.addFrameScript(this.animationMC.totalFrames - 1,null);
            this.animationMC.stop();
            this.animationMC = null;
            super.onDispose();
        }

        private function onAnimationComplete() : void
        {
            this.animationMC.addFrameScript(this.animationMC.totalFrames - 1,null);
            stop();
            dispatchEvent(new Event(Event.COMPLETE));
        }

        private function onEnterFrameHandler(param1:Event) : void
        {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            if(!this._isStartAnimation)
            {
                this._isStartAnimation = true;
                dispatchEvent(new AppearEvent(AppearEvent.PREPARE,Values.EMPTY_STR,Values.EMPTY_STR,true));
            }
        }
    }
}
