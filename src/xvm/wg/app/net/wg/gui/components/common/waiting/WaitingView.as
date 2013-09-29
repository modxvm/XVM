package net.wg.gui.components.common.waiting 
{
    import flash.events.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.managers.*;
    import scaleform.gfx.*;
    
    public class WaitingView extends net.wg.infrastructure.base.meta.impl.WaitingViewMeta implements net.wg.infrastructure.managers.IWaitingView
    {
        public function WaitingView()
        {
            super();
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            super.updateStage(arg1, arg2);
            this.waitingComponent.setSize(arg1, arg2);
            return;
        }

        public function show(arg1:Object):void
        {
            this.waitingComponent.setMessage(arg1.toString());
            this.setVisibility(true);
            return;
        }

        public function hide(arg1:Object):void
        {
            this.setVisibility(false);
            return;
        }

        public override function set visible(arg1:Boolean):void
        {
            super.visible = this._isVisible;
            return;
        }

        public function get isVisible():Boolean
        {
            return this._isVisible;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(VISIBLE_INVALID)) 
            {
                this.visible = this._isVisible;
                this.waitingComponent.setAnimationStatus(!this._isVisible);
                dispatchEvent(new flash.events.Event(WAITING_STATE_CHANGED));
            }
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            addEventListener(net.wg.gui.components.common.waiting.WaitingView.WAITING_STATE_CHANGED, this.waitingStateChangedHandler);
            return;
        }

        protected override function onDispose():void
        {
            removeEventListener(net.wg.gui.components.common.waiting.WaitingView.WAITING_STATE_CHANGED, this.waitingStateChangedHandler);
            if (this.waitingComponent) 
            {
                this.waitingComponent.parent.removeChild(this.waitingComponent);
                this.waitingComponent.dispose();
                this.waitingComponent = null;
            }
            super.onDispose();
            return;
        }

        internal function setVisibility(arg1:Boolean):void
        {
            if (this._isVisible != arg1) 
            {
                this._isVisible = arg1;
                invalidate(VISIBLE_INVALID);
            }
            return;
        }

        internal function waitingStateChangedHandler(arg1:flash.events.Event):void
        {
            var loc1:*=null;
            if (this.isVisible) 
            {
                scaleform.gfx.FocusManager.setFocus(this);
                scaleform.gfx.FocusManager.setModalClip(this);
            }
            else 
            {
                scaleform.gfx.FocusManager.setModalClip(null);
                if (App.containerMgr.lastFocusedView) 
                {
                    loc1 = App.containerMgr.lastFocusedView;
                    App.containerMgr.lastFocusedView = null;
                    loc1.dispatchEvent(new flash.events.MouseEvent(flash.events.MouseEvent.MOUSE_DOWN));
                }
            }
            return;
        }

        public static const WAITING_STATE_CHANGED:String="waitingStateChanged";

        internal static const VISIBLE_INVALID:String="visibleInv";

        public var waitingComponent:net.wg.gui.components.common.waiting.WaitingComponent;

        internal var _isVisible:Boolean;
    }
}
