package net.wg.gui.components.common.waiting
{
    import net.wg.infrastructure.base.meta.impl.WaitingViewMeta;
    import net.wg.infrastructure.managers.IWaitingView;
    import scaleform.clik.events.InputEvent;
    import net.wg.gui.components.common.waiting.events.WaitingChangeVisibilityEvent;
    
    public class WaitingView extends WaitingViewMeta implements IWaitingView
    {
        
        public function WaitingView() {
            super();
            focusRect = false;
        }
        
        public var waitingComponent:WaitingComponent;
        
        private var frameOnShow:uint = 0;
        
        override public function updateStage(param1:Number, param2:Number) : void {
            super.updateStage(param1,param2);
            this.waitingComponent.setSize(param1,param2);
        }
        
        public function get isOnStage() : Boolean {
            return !(stage == null);
        }
        
        public function show(param1:Object) : void {
            this.frameOnShow = this.waitingComponent.waitingMc.currentFrame;
            App.utils.scheduler.cancelTask(this.performHide);
            addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
            assertNotNull(this.waitingComponent,"waitingComponent");
            this.waitingComponent.setMessage(param1.toString());
            this.setAnimationStatus(true);
        }
        
        public function hide(param1:Object) : void {
            removeEventListener(InputEvent.INPUT,this.handleInput);
            if(this.frameOnShow == this.waitingComponent.waitingMc.currentFrame)
            {
                this.performHide();
            }
            else
            {
                App.utils.scheduler.envokeInNextFrame(this.performHide);
            }
        }
        
        public function setAnimationStatus(param1:Boolean) : void {
            var _loc2_:String = null;
            if(!(param1 == this.isOnStage) && (initialized))
            {
                _loc2_ = param1?WaitingChangeVisibilityEvent.WAITING_SHOWN:WaitingChangeVisibilityEvent.WAITING_HIDDEN;
                dispatchEvent(new WaitingChangeVisibilityEvent(_loc2_));
                App.containerMgr.updateFocus();
                assertNotNull(this.waitingComponent,"waitingComponent");
                this.waitingComponent.setAnimationStatus(!param1);
                this.waitingComponent.validateNow();
            }
        }
        
        override protected function configUI() : void {
            super.configUI();
            assertNotNull(this.waitingComponent,"waitingComponent");
            this.waitingComponent.setAnimationStatus(true);
        }
        
        override protected function nextFrameAfterPopulateHandler() : void {
            super.nextFrameAfterPopulateHandler();
            this.setAnimationStatus(false);
        }
        
        override protected function onDispose() : void {
            App.utils.scheduler.cancelTask(this.performHide);
            if(this.waitingComponent)
            {
                this.waitingComponent.parent.removeChild(this.waitingComponent);
                this.waitingComponent.dispose();
                this.waitingComponent = null;
            }
            super.onDispose();
        }
        
        override public function handleInput(param1:InputEvent) : void {
            param1.handled = true;
            super.handleInput(param1);
        }
        
        private function performHide() : void {
            this.setAnimationStatus(false);
        }
    }
}
