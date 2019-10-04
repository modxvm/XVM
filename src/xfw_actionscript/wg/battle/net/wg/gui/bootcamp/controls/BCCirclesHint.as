package net.wg.gui.bootcamp.controls
{
    import flash.events.Event;

    public class BCCirclesHint extends BCLobbyHint
    {

        private static const CIRClES_COUNT:uint = 2;

        private var _currentCircle:uint = 0;

        public function BCCirclesHint()
        {
            super();
            addFrameScript(totalFrames - 1,this.onAnimationComplete);
        }

        override protected function onDispose() : void
        {
            this.removeFrameListener();
            super.onDispose();
        }

        private function removeFrameListener() : void
        {
            addFrameScript(totalFrames - 1,null);
            stop();
        }

        private function onAnimationComplete() : void
        {
            this._currentCircle++;
            if(this._currentCircle == CIRClES_COUNT)
            {
                this.removeFrameListener();
                dispatchEvent(new Event(Event.COMPLETE));
            }
        }
    }
}
