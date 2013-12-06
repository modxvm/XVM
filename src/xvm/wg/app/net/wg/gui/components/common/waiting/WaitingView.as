package net.wg.gui.components.common.waiting
{
   import net.wg.infrastructure.base.meta.impl.WaitingViewMeta;
   import net.wg.infrastructure.managers.IWaitingView;
   import scaleform.clik.events.InputEvent;
   import net.wg.infrastructure.interfaces.IView;
   import scaleform.gfx.FocusManager;
   import flash.events.MouseEvent;


   public class WaitingView extends WaitingViewMeta implements IWaitingView
   {
          
      public function WaitingView() {
         super();
      }

      private static const VISIBLE_INVALID:String = "visibleInv";

      public var waitingComponent:WaitingComponent;

      override public function updateStage(param1:Number, param2:Number) : void {
         super.updateStage(param1,param2);
         this.waitingComponent.setSize(param1,param2);
      }

      public function show(param1:Object) : void {
         addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         this.waitingComponent.setMessage(param1.toString());
         this.visible = true;
      }

      public function hide(param1:Object) : void {
         removeEventListener(InputEvent.INPUT,this.handleInput);
         this.visible = false;
      }

      override public function set visible(param1:Boolean) : void {
         if(param1 != visible)
         {
            super.visible = param1;
            this.onWaitingStateChanged();
            if(this.waitingComponent)
            {
               this.waitingComponent.setAnimationStatus(!param1);
            }
         }
      }

      override protected function configUI() : void {
         super.configUI();
         if(this.waitingComponent)
         {
            this.waitingComponent.setAnimationStatus(!visible);
         }
      }

      override protected function nextFrameAfterPopulateHandler() : void {
         super.visible = false;
      }

      override protected function onDispose() : void {
         if(this.waitingComponent)
         {
            this.waitingComponent.parent.removeChild(this.waitingComponent);
            this.waitingComponent.dispose();
            this.waitingComponent = null;
         }
         super.onDispose();
      }

      private function onWaitingStateChanged() : void {
         var _loc1_:IView = null;
         if(visible)
         {
            FocusManager.setFocus(this);
            FocusManager.setModalClip(this);
         }
         else
         {
            FocusManager.setModalClip(null);
            if(App.containerMgr.lastFocusedView)
            {
               _loc1_ = App.containerMgr.lastFocusedView;
               App.containerMgr.lastFocusedView = null;
               _loc1_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
            }
         }
      }

      override public function handleInput(param1:InputEvent) : void {
         param1.handled = true;
         super.handleInput(param1);
      }
   }

}