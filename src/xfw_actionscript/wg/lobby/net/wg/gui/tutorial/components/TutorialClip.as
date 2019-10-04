package net.wg.gui.tutorial.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.events.TutorialEvent;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import scaleform.clik.events.ComponentEvent;
    import flash.events.Event;

    public class TutorialClip extends MovieClip implements IDisposable
    {

        private static var _onReadyForTutorialPointer:Function = checkTutorialFunctionType;

        public function TutorialClip()
        {
            super();
            if(!stage)
            {
                addEventListener(Event.ADDED_TO_STAGE,this.onTutorialClipAddedToStageHandler,false,0,true);
            }
            else
            {
                _onReadyForTutorialPointer(this);
            }
        }

        private static function onReadyForTutorialFake(param1:DisplayObject) : void
        {
        }

        private static function checkTutorialFunctionType(param1:DisplayObject) : void
        {
            if(!App.instance)
            {
                return;
            }
            if(App.tutorialMgr.isSystemEnabled)
            {
                _onReadyForTutorialPointer = onReadyForTutorial;
                onReadyForTutorial(param1);
            }
            else if(App.tutorialMgr.isSystemEnabled != null)
            {
                _onReadyForTutorialPointer = onReadyForTutorialFake;
            }
        }

        private static function onReadyForTutorial(param1:DisplayObject) : void
        {
            var _loc2_:TutorialEvent = new TutorialEvent(TutorialEvent.VIEW_READY_FOR_TUTORIAL);
            _loc2_.addPathPoint(param1,param1.name);
            param1.dispatchEvent(_loc2_);
        }

        public final function dispose() : void
        {
            this.onDispose();
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_DISPOSE));
        }

        protected function onDispose() : void
        {
        }

        override public function set visible(param1:Boolean) : void
        {
            if(visible == param1)
            {
                return;
            }
            super.visible = param1;
            dispatchEvent(new ComponentEvent(param1?ComponentEvent.SHOW:ComponentEvent.HIDE));
        }

        private function onTutorialClipAddedToStageHandler(param1:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE,this.onTutorialClipAddedToStageHandler);
            _onReadyForTutorialPointer(this);
        }
    }
}
