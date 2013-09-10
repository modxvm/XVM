package net.wg.infrastructure.base 
{
    import flash.display.*;
    import flash.ui.*;
    import net.wg.gui.components.common.waiting.*;
    import net.wg.gui.components.windows.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.constants.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    
    public class AbstractWindowView extends net.wg.infrastructure.base.meta.impl.WindowViewMeta implements net.wg.infrastructure.interfaces.IAbstractWindowView
    {
        public function AbstractWindowView()
        {
            super();
            this._geometry = new net.wg.infrastructure.base.DefaultWindowGeometry();
            return;
        }

        public function get isModal():Boolean
        {
            return this._isModal;
        }

        public function set isModal(arg1:Boolean):void
        {
            this._isModal = arg1;
            return;
        }

        public function get showWaiting():Boolean
        {
            return this._showWaiting;
        }

        public function get geometry():net.wg.infrastructure.interfaces.IWindowGeometry
        {
            return this._geometry;
        }

        public function set geometry(arg1:net.wg.infrastructure.interfaces.IWindowGeometry):void
        {
            if (!this._geometry.canOverwrite()) 
                return;
            this._geometry = arg1;
            return;
        }

        public function get canMinimize():Boolean
        {
            return this._canMinimize;
        }

        public function set showWaiting(arg1:Boolean):void
        {
            if (this._showWaiting != arg1) 
            {
                this._showWaiting = arg1;
                invalidate(net.wg.infrastructure.constants.WindowViewInvalidationType.WAITING_INVALID);
            }
            return;
        }

        protected override function onDispose():void
        {
            if (this.waiting) 
            {
                this.waiting.dispose();
                if (this.waiting.parent) 
                    this.waiting.parent.removeChild(this.waiting);
                this.waiting = null;
            }
            if (this._window) 
            {
                this._window.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput);
                this._window.dispose();
                this._window.sourceView = null;
                this._window = null;
            }
            super.onDispose();
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(net.wg.infrastructure.constants.WindowViewInvalidationType.WAITING_INVALID)) 
                this.applyWaitingChanges();
            super.draw();
            if (this.geometry && this.window && isInvalid(net.wg.infrastructure.constants.WindowViewInvalidationType.POSITION_INVALID)) 
            {
                this.geometry.setPosition(this.window);
                this.checkAppBounds();
            }
            return;
        }

        protected function applyWaitingChanges():void
        {
            if (this._showWaiting) 
            {
                if (!this.waiting) 
                {
                    this.waiting = new net.wg.gui.components.common.waiting.Waiting();
                    addChild(this.waiting);
                    this.waiting.setSize(width, height);
                    this.waiting.validateNow();
                }
                this.waiting.setMessage(this.waitingMessage);
            }
            if (this.waiting) 
                if (this._showWaiting) 
                    this.waiting.show();
                else 
                    this.waiting.hide();
            return;
        }

        internal function checkAppBounds():void
        {
            var loc1:*=this.window.width + this.window.x;
            var loc2:*=this.window.height + this.window.y;
            if (loc1 > App.appWidth) 
                this.window.x = this.window.x - (loc1 - App.appWidth);
            if (loc2 > App.appHeight) 
                this.window.y = this.window.y - (loc2 - App.appHeight);
            return;
        }

        internal function validateView():void
        {
            if (this.window != null) 
                scaleform.clik.core.UIComponent(this.window).invalidate(net.wg.gui.components.windows.Window.INVALID_SRC_VIEW);
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            super.handleInput(arg1);
            if (arg1.handled) 
                return;
            var loc1:*=arg1.details;
            if (loc1.code == flash.ui.Keyboard.ESCAPE && loc1.value == scaleform.clik.constants.InputValue.KEY_DOWN) 
            {
                arg1.handled = true;
                onWindowCloseS();
            }
            return;
        }

        public override function setViewSize(arg1:Number, arg2:Number):void
        {
            return;
        }

        public override function playShowTween(arg1:flash.display.DisplayObject, arg2:Function=null):Boolean
        {
            return false;
        }

        public override function setFocus():void
        {
            if (this.window && this.window.getBackground()) 
                this.window.getBackground().gotoAndPlay("enable");
            return;
        }

        public override function removeFocus():void
        {
            if (this.window && this.window.getBackground()) 
                this.window.getBackground().gotoAndPlay("disable");
            return;
        }

        public override function playHideTween(arg1:flash.display.DisplayObject, arg2:Function=null):Boolean
        {
            return false;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            super.updateStage(arg1, arg2);
            invalidate(net.wg.infrastructure.constants.WindowViewInvalidationType.POSITION_INVALID);
            return;
        }

        public function handleWindowMinimize():void
        {
            onWindowMinimizeS();
            return;
        }

        public function as_showWaiting(arg1:String, arg2:Object):void
        {
            this.waitingMessage = arg1;
            this.showWaiting = true;
            return;
        }

        public function as_hideWaiting():void
        {
            this.showWaiting = false;
            return;
        }

        public function as_getGeometry():Array
        {
            if (this.window) 
                return [this.window.x, this.window.y, this.window.width, this.window.height];
            return null;
        }

        public function as_setGeometry(arg1:Number, arg2:Number, arg3:Number, arg4:Number):void
        {
            this._geometry = new net.wg.infrastructure.base.StoredWindowGeometry(arg1, arg2, arg3, arg4);
            invalidate(net.wg.infrastructure.constants.WindowViewInvalidationType.POSITION_INVALID);
            return;
        }

        public function get window():net.wg.infrastructure.interfaces.IWindow
        {
            return this._window;
        }

        public function set window(arg1:net.wg.infrastructure.interfaces.IWindow):void
        {
            this._window = arg1;
            return;
        }

        protected override function configUI():void
        {
            if (this.window) 
                this.window.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false, 0, true);
            initSize();
            return;
        }

        public function set canMinimize(arg1:Boolean):void
        {
            if (arg1 != this._canMinimize) 
            {
                this._canMinimize = arg1;
                this.validateView();
            }
            return;
        }

        public function get enabledCloseBtn():Boolean
        {
            return this._enabledCloseBtn;
        }

        public function set enabledCloseBtn(arg1:Boolean):void
        {
            if (arg1 != this._enabledCloseBtn) 
            {
                this._enabledCloseBtn = arg1;
                this.validateView();
            }
            return;
        }

        public function get canDrag():Boolean
        {
            return this._canDrag;
        }

        public function set canDrag(arg1:Boolean):void
        {
            if (arg1 != this._canDrag) 
            {
                this._canDrag = arg1;
                this.validateView();
            }
            return;
        }

        public function get canClose():Boolean
        {
            return this._canClose;
        }

        public function set canClose(arg1:Boolean):void
        {
            if (arg1 != this._canClose) 
            {
                this._canClose = arg1;
                this.validateView();
            }
            return;
        }

        public function get canResize():Boolean
        {
            return this._canResize;
        }

        public function set canResize(arg1:Boolean):void
        {
            if (arg1 != this._canResize) 
            {
                this._canResize = arg1;
                this.validateView();
            }
            return;
        }

        public function get isCentered():Boolean
        {
            return this._isCentered;
        }

        public function set isCentered(arg1:Boolean):void
        {
            this._isCentered = arg1;
            return;
        }

        public function get showWindowBg():Boolean
        {
            return this._showWindowBg;
        }

        public function set showWindowBg(arg1:Boolean):void
        {
            this._showWindowBg = arg1;
            return;
        }

        protected var waiting:net.wg.gui.components.common.waiting.Waiting;

        internal var waitingMessage:String;

        internal var _showWaiting:Boolean;

        internal var _window:net.wg.infrastructure.interfaces.IWindow;

        internal var _canMinimize:Boolean=false;

        internal var _canDrag:Boolean=true;

        internal var _canClose:Boolean=true;

        internal var _canResize:Boolean=false;

        internal var _isCentered:Boolean=true;

        internal var _showWindowBg:Boolean=true;

        internal var _isModal:Boolean=false;

        internal var _geometry:net.wg.infrastructure.interfaces.IWindowGeometry;

        internal var _enabledCloseBtn:Boolean=true;
    }
}
