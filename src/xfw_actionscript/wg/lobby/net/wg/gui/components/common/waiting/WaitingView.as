package net.wg.gui.components.common.waiting
{
    import net.wg.infrastructure.base.meta.impl.WaitingViewMeta;
    import net.wg.infrastructure.managers.IWaitingView;
    import scaleform.clik.events.InputEvent;
    import net.wg.infrastructure.events.ChildVisibilityEvent;

    public class WaitingView extends WaitingViewMeta implements IWaitingView
    {

        private static const WAITING_COMPONENT_NAME:String = "waitingComponent";

        public var waitingComponent:WaitingComponent;

        private var _frameOnShow:uint = 0;

        public function WaitingView()
        {
            super();
            focusRect = false;
            focusable = true;
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            this.waitingComponent.setSize(param1,param2);
        }

        override protected function configUI() : void
        {
            super.configUI();
            assertNotNull(this.waitingComponent,WAITING_COMPONENT_NAME);
            this.waitingComponent.setAnimationStatus(true);
        }

        override protected function nextFrameAfterPopulateHandler() : void
        {
            super.nextFrameAfterPopulateHandler();
            this.setAnimationStatus(false);
        }

        override protected function onDispose() : void
        {
            App.utils.scheduler.cancelTask(this.performHide);
            if(this.waitingComponent)
            {
                this.waitingComponent.parent.removeChild(this.waitingComponent);
                this.waitingComponent.dispose();
                this.waitingComponent = null;
            }
            super.onDispose();
        }

        public function as_hideWaiting() : void
        {
            removeEventListener(InputEvent.INPUT,this.handleInput);
            if(this._frameOnShow == this.waitingComponent.waitingMc.currentFrame)
            {
                this.performHide();
            }
            else
            {
                App.utils.scheduler.scheduleOnNextFrame(this.performHide);
            }
        }

        public function as_showWaiting(param1:String) : void
        {
            this._frameOnShow = this.waitingComponent.waitingMc.currentFrame;
            App.utils.scheduler.cancelTask(this.performHide);
            addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
            assertNotNull(this.waitingComponent,WAITING_COMPONENT_NAME);
            this.waitingComponent.setMessage(param1);
            this.setAnimationStatus(true);
        }

        public function setAnimationStatus(param1:Boolean) : void
        {
            var _loc2_:String = null;
            if(param1 != this.isOnStage && initialized)
            {
                _loc2_ = param1?ChildVisibilityEvent.CHILD_SHOWN:ChildVisibilityEvent.CHILD_HIDDEN;
                dispatchEvent(new ChildVisibilityEvent(_loc2_));
                assertNotNull(this.waitingComponent,WAITING_COMPONENT_NAME);
                this.waitingComponent.setAnimationStatus(!param1);
                this.waitingComponent.validateNow();
            }
            App.containerMgr.updateFocus();
        }

        private function performHide() : void
        {
            this.setAnimationStatus(false);
        }

        public function get isFocusable() : Boolean
        {
            return focusable;
        }

        public function get isOnStage() : Boolean
        {
            return stage != null;
        }

        override public function handleInput(param1:InputEvent) : void
        {
            param1.handled = true;
            super.handleInput(param1);
        }
    }
}
