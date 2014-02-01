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

      override public function updateStage(param1:Number, param2:Number) : void {
         super.updateStage(param1,param2);
         this.waitingComponent.setSize(param1,param2);
      }

      public function show(param1:Object) : void {
         App.utils.scheduler.cancelTask(this.performHide);
         addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         assertNotNull(this.waitingComponent,"waitingComponent");
         this.waitingComponent.setMessage(param1.toString());
         this.visible = true;
      }

      public function hide(param1:Object) : void {
         removeEventListener(InputEvent.INPUT,this.handleInput);
         App.utils.scheduler.envokeInNextFrame(this.performHide);
      }

      override public function set visible(param1:Boolean) : void {
         if(!(param1 == visible) && (initialized))
         {
            super.visible = param1;
            this.onWaitingStateChanged();
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
         super.visible = false;
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

      private function onWaitingStateChanged() : void {
         var _loc1_:String = visible?WaitingChangeVisibilityEvent.WAITING_SHOWN:WaitingChangeVisibilityEvent.WAITING_HIDDEN;
         dispatchEvent(new WaitingChangeVisibilityEvent(_loc1_));
         App.containerMgr.updateFocus();
      }

      override public function handleInput(param1:InputEvent) : void {
         param1.handled = true;
         super.handleInput(param1);
      }

      private function performHide() : void {
         this.visible = false;
      }
   }

}