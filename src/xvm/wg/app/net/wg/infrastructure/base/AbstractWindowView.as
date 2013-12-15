package net.wg.infrastructure.base
{
   import net.wg.infrastructure.base.meta.impl.WindowViewMeta;
   import net.wg.infrastructure.interfaces.IAbstractWindowView;
   import net.wg.gui.components.common.waiting.Waiting;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.infrastructure.interfaces.IWindowGeometry;
   import flash.display.DisplayObject;
   import net.wg.infrastructure.constants.WindowViewInvalidationType;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.windows.Window;
   import scaleform.clik.ui.InputDetails;
   import flash.ui.Keyboard;
   import scaleform.clik.constants.InputValue;
   import flash.display.MovieClip;


   public class AbstractWindowView extends WindowViewMeta implements IAbstractWindowView
   {
          
      public function AbstractWindowView() {
         super();
         this._geometry = new DefaultWindowGeometry();
      }

      private static const BG_ENABLED:String = "enable";

      private static const BG_DISABLED:String = "disable";

      private var _waiting:Waiting;

      private var waitingMessage:String;

      private var _showWaiting:Boolean;

      private var _window:IWindow;

      private var _canMinimize:Boolean = false;

      private var _enabledCloseBtn:Boolean = true;

      private var _canDrag:Boolean = true;

      private var _canClose:Boolean = true;

      private var _canResize:Boolean = false;

      private var _isCentered:Boolean = true;

      private var _showWindowBg:Boolean = true;

      private var _isModal:Boolean = false;

      private var _geometry:IWindowGeometry;

      private var _isSourceTracked:Boolean = false;

      override public function setViewSize(param1:Number, param2:Number) : void {
          
      }

      override public function playShowTween(param1:DisplayObject, param2:Function=null) : Boolean {
         return false;
      }

      override public function setFocus() : void {
         super.setFocus();
         App.utils.scheduler.envokeInNextFrame(this.changeBackgroundLabel,BG_ENABLED);
      }

      override public function removeFocus() : void {
         super.removeFocus();
         App.utils.scheduler.envokeInNextFrame(this.changeBackgroundLabel,BG_DISABLED);
      }

      override public function playHideTween(param1:DisplayObject, param2:Function=null) : Boolean {
         return false;
      }

      override public function updateStage(param1:Number, param2:Number) : void {
         super.updateStage(param1,param2);
         invalidate(WindowViewInvalidationType.POSITION_INVALID);
      }

      public function handleWindowMinimize() : void {
         onWindowMinimizeS();
      }

      public function as_showWaiting(param1:String, param2:Object) : void {
         this.waitingMessage = param1;
         this.showWaiting = true;
      }

      public function as_hideWaiting() : void {
         this.showWaiting = false;
      }

      public function as_getGeometry() : Array {
         if(this.window)
         {
            return [this.window.x,this.window.y,this.window.width,this.window.height];
         }
         return null;
      }

      public function as_setGeometry(param1:Number, param2:Number, param3:Number, param4:Number) : void {
         this._geometry = new StoredWindowGeometry(param1,param2,param3,param4);
         invalidate(WindowViewInvalidationType.POSITION_INVALID);
      }

      public function as_isModal() : Boolean {
         return this._isModal;
      }

      public function get window() : IWindow {
         return this._window;
      }

      public function set window(param1:IWindow) : void {
         this._window = param1;
      }

      public function get canMinimize() : Boolean {
         return this._canMinimize;
      }

      public function set canMinimize(param1:Boolean) : void {
         if(param1 != this._canMinimize)
         {
            this._canMinimize = param1;
            this.validateView();
         }
      }

      public function get enabledCloseBtn() : Boolean {
         return this._enabledCloseBtn;
      }

      public function set enabledCloseBtn(param1:Boolean) : void {
         if(param1 != this._enabledCloseBtn)
         {
            this._enabledCloseBtn = param1;
            this.validateView();
         }
      }

      public function get canDrag() : Boolean {
         return this._canDrag;
      }

      public function set canDrag(param1:Boolean) : void {
         if(param1 != this._canDrag)
         {
            this._canDrag = param1;
            this.validateView();
         }
      }

      public function get canClose() : Boolean {
         return this._canClose;
      }

      public function set canClose(param1:Boolean) : void {
         if(param1 != this._canClose)
         {
            this._canClose = param1;
            this.validateView();
         }
      }

      public function get canResize() : Boolean {
         return this._canResize;
      }

      public function set canResize(param1:Boolean) : void {
         if(param1 != this._canResize)
         {
            this._canResize = param1;
            this.validateView();
         }
      }

      public function get isCentered() : Boolean {
         return this._isCentered;
      }

      public function set isCentered(param1:Boolean) : void {
         this._isCentered = param1;
      }

      public function get showWindowBg() : Boolean {
         return this._showWindowBg;
      }

      public function set showWindowBg(param1:Boolean) : void {
         this._showWindowBg = param1;
      }

      public function get isModal() : Boolean {
         return this._isModal;
      }

      public function set isModal(param1:Boolean) : void {
         this._isModal = param1;
      }

      public function get showWaiting() : Boolean {
         return this._showWaiting;
      }

      public function get geometry() : IWindowGeometry {
         return this._geometry;
      }

      public function set geometry(param1:IWindowGeometry) : void {
         if(!this._geometry.canOverwrite())
         {
            return;
         }
         this._geometry = param1;
      }

      public function get isSourceTracked() : Boolean {
         return this._isSourceTracked;
      }

      public function set isSourceTracked(param1:Boolean) : void {
         this._isSourceTracked = param1;
      }

      public function set showWaiting(param1:Boolean) : void {
         if(this._showWaiting != param1)
         {
            this._showWaiting = param1;
            invalidate(WindowViewInvalidationType.WAITING_INVALID);
         }
      }

      override protected function configUI() : void {
         if(this.window)
         {
            this.window.addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         }
         initSize();
      }

      override protected function onDispose() : void {
         if(this._waiting)
         {
            this._waiting.dispose();
            if(this._waiting.parent)
            {
               this._waiting.parent.removeChild(this._waiting);
            }
            this._waiting = null;
         }
         if(this._window)
         {
            this._window.removeEventListener(InputEvent.INPUT,this.handleInput);
            this._window.dispose();
            this._window.sourceView = null;
            this._window = null;
         }
         App.utils.scheduler.cancelTask(this.changeBackgroundLabel);
         super.onDispose();
      }

      override protected function draw() : void {
         if(isInvalid(WindowViewInvalidationType.WAITING_INVALID))
         {
            this.applyWaitingChanges();
         }
         super.draw();
         if((this.geometry) && (this.window) && (isInvalid(WindowViewInvalidationType.POSITION_INVALID)))
         {
            this.geometry.setPosition(this.window);
            this.checkAppBounds();
         }
      }

      protected function applyWaitingChanges() : void {
         if(this._showWaiting)
         {
            if(!this._waiting)
            {
               this._waiting = new Waiting();
               addChild(this._waiting);
               this._waiting.setSize(width,height);
               this._waiting.validateNow();
            }
            this._waiting.setMessage(this.waitingMessage);
         }
         if(this._waiting)
         {
            if(this._showWaiting)
            {
               this._waiting.show();
            }
            else
            {
               this._waiting.hide();
            }
         }
      }

      private function checkAppBounds() : void {
         if(this.window.width > App.appWidth)
         {
            this.window.x = Math.round((App.appWidth - this.window.width) / 2);
         }
         else
         {
            if(this.window.x < 0)
            {
               this.window.x = 0;
            }
            if(this.window.x + this.window.width > App.appWidth)
            {
               this.window.x = Math.round(App.appWidth - this.window.width);
            }
         }
         if(this.window.height > App.appHeight)
         {
            this.window.y = Math.round((App.appHeight - this.window.height) / 2);
         }
         else
         {
            if(this.window.y < 0)
            {
               this.window.y = 0;
            }
            if(this.window.y + this.window.height > App.appHeight)
            {
               this.window.y = Math.round(App.appHeight - this.window.height);
            }
         }
      }

      private function validateView() : void {
         if(this.window != null)
         {
            UIComponent(this.window).invalidate(Window.INVALID_SRC_VIEW);
         }
      }

      override public function handleInput(param1:InputEvent) : void {
         super.handleInput(param1);
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(this.canCloseFromInputDetails(_loc2_))
         {
            param1.handled = true;
            onWindowCloseS();
         }
      }

      protected final function canCloseFromInputDetails(param1:InputDetails) : Boolean {
         return param1.code == Keyboard.ESCAPE && param1.value == InputValue.KEY_DOWN && this.window.getBackground().currentLabel == BG_ENABLED;
      }

      public function get waiting() : Waiting {
         return this._waiting;
      }

      private function changeBackgroundLabel(param1:String) : void {
         var _loc2_:MovieClip = null;
         if(this.window)
         {
            _loc2_ = this.window.getBackground();
            if((_loc2_) && !(_loc2_.currentLabel == param1))
            {
               _loc2_.gotoAndPlay(param1);
            }
         }
      }
   }

}