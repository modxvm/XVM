package net.wg.gui.components.common.waiting
{
   import net.wg.infrastructure.base.meta.impl.WaitingViewMeta;
   import net.wg.infrastructure.managers.IWaitingView;
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.IView;
   import scaleform.gfx.FocusManager;
   import flash.events.MouseEvent;


   public class WaitingView extends WaitingViewMeta implements IWaitingView
   {
          
      public function WaitingView() {
         super();
      }

      public static const WAITING_STATE_CHANGED:String = "waitingStateChanged";

      private static const VISIBLE_INVALID:String = "visibleInv";

      public var waitingComponent:WaitingComponent;

      private var _isVisible:Boolean;

      override public function updateStage(param1:Number, param2:Number) : void {
         super.updateStage(param1,param2);
         this.waitingComponent.setSize(param1,param2);
      }

      public function show(param1:Object) : void {
         this.waitingComponent.setMessage(param1.toString());
         this.setVisibility(true);
      }

      public function hide(param1:Object) : void {
         this.setVisibility(false);
      }

      override public function set visible(param1:Boolean) : void {
         super.visible = this._isVisible;
      }

      public function get isVisible() : Boolean {
         return this._isVisible;
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(VISIBLE_INVALID))
         {
            this.visible = this._isVisible;
            this.waitingComponent.setAnimationStatus(!this._isVisible);
            dispatchEvent(new Event(WAITING_STATE_CHANGED));
         }
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         addEventListener(WaitingView.WAITING_STATE_CHANGED,this.waitingStateChangedHandler);
      }

      override protected function onDispose() : void {
         removeEventListener(WaitingView.WAITING_STATE_CHANGED,this.waitingStateChangedHandler);
         if(this.waitingComponent)
         {
            this.waitingComponent.parent.removeChild(this.waitingComponent);
            this.waitingComponent.dispose();
            this.waitingComponent = null;
         }
         super.onDispose();
      }

      private function setVisibility(param1:Boolean) : void {
         if(this._isVisible != param1)
         {
            this._isVisible = param1;
            invalidate(VISIBLE_INVALID);
         }
      }

      private function waitingStateChangedHandler(param1:Event) : void {
         var _loc2_:IView = null;
         if(this.isVisible)
         {
            FocusManager.setFocus(this);
            FocusManager.setModalClip(this);
         }
         else
         {
            FocusManager.setModalClip(null);
            if(App.containerMgr.lastFocusedView)
            {
               _loc2_ = App.containerMgr.lastFocusedView;
               App.containerMgr.lastFocusedView = null;
               _loc2_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
            }
         }
      }
   }

}