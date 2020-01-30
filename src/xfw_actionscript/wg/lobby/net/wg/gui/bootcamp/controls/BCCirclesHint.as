package net.wg.gui.bootcamp.controls
{
    import flash.events.Event;
    import net.wg.gui.bootcamp.events.AppearEvent;
    import net.wg.data.constants.Values;

    public class BCCirclesHint extends BCLobbyHint
    {

        private static const CIRClES_COUNT:uint = 2;

        private static const FXMASK_SIZE_MINIMAP:uint = 277;

        private var _currentCircle:uint = 0;

        private var _isStartAnimation:Boolean = false;

        public function BCCirclesHint()
        {
            super();
            addFrameScript(totalFrames - 1,this.onAnimationComplete);
            addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
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

        private function onEnterFrameHandler(param1:Event) : void
        {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            if(fxMask.height == FXMASK_SIZE_MINIMAP)
            {
                if(!this._isStartAnimation)
                {
                    this._isStartAnimation = true;
                    dispatchEvent(new AppearEvent(AppearEvent.PREPARE_MINIMAP,Values.EMPTY_STR,Values.EMPTY_STR,true));
                }
            }
        }
    }
}
