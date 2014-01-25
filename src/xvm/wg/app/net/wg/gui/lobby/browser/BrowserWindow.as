package net.wg.gui.lobby.browser
{
   import net.wg.infrastructure.base.meta.impl.BrowserMeta;
   import net.wg.infrastructure.base.meta.IBrowserMeta;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.utils.Padding;


   public class BrowserWindow extends BrowserMeta implements IBrowserMeta
   {
          
      public function BrowserWindow() {
         super();
         showWindowBg = false;
      }

      public var actionBtn:BrowserActionBtn;

      public var browserHitArea:BrowserHitArea;

      public function as_loadingStart() : void {
         this.actionBtn.action = BrowserActionBtn.ACTION_LOADING;
         this.updateFocus();
      }

      public function as_loadingStop() : void {
         this.actionBtn.action = BrowserActionBtn.ACTION_RELOAD;
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         var _loc1_:IWindow = IWindow(window);
         window.title = MENU.BROWSER_WINDOW_TITLE;
         var _loc2_:Padding = window.contentPadding as Padding;
         _loc2_.bottom = -8;
         window.contentPadding = _loc2_;
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.actionBtn.dispose();
         this.actionBtn.removeEventListener(BrowserEvent.ACTION_LOADING,this.onBtnAction);
         this.actionBtn.removeEventListener(BrowserEvent.ACTION_RELOAD,this.onBtnAction);
         this.browserHitArea.dispose();
         this.browserHitArea.removeEventListener(BrowserEvent.BROWSER_DOWN,this.onBrowserDown);
         this.browserHitArea.removeEventListener(BrowserEvent.BROWSER_UP,this.onBrowserUp);
         this.browserHitArea.removeEventListener(BrowserEvent.BROWSER_MOVE,this.onBrowserMove);
         this.browserHitArea.removeEventListener(BrowserEvent.BROWSER_FOCUS_IN,this.onBrowserFocusIn);
         this.browserHitArea.removeEventListener(BrowserEvent.BROWSER_FOCUS_OUT,this.onBrowserFocusOut);
      }

      override protected function configUI() : void {
         super.configUI();
         this.actionBtn.addEventListener(BrowserEvent.ACTION_LOADING,this.onBtnAction);
         this.actionBtn.addEventListener(BrowserEvent.ACTION_RELOAD,this.onBtnAction);
         this.browserHitArea.addEventListener(BrowserEvent.BROWSER_DOWN,this.onBrowserDown);
         this.browserHitArea.addEventListener(BrowserEvent.BROWSER_UP,this.onBrowserUp);
         this.browserHitArea.addEventListener(BrowserEvent.BROWSER_MOVE,this.onBrowserMove);
         this.browserHitArea.addEventListener(BrowserEvent.BROWSER_FOCUS_IN,this.onBrowserFocusIn);
         this.browserHitArea.addEventListener(BrowserEvent.BROWSER_FOCUS_OUT,this.onBrowserFocusOut);
      }

      private function onBtnAction(param1:BrowserEvent) : void {
         browserActionS(param1.type);
      }

      private function onBrowserDown(param1:BrowserEvent) : void {
         browserDownS(param1.mouseX,param1.mouseY,param1.delta);
      }

      private function onBrowserUp(param1:BrowserEvent) : void {
         browserUpS(param1.mouseX,param1.mouseY,param1.delta);
      }

      private function onBrowserMove(param1:BrowserEvent) : void {
         browserMoveS(param1.mouseX,param1.mouseY,param1.delta);
      }

      private function onBrowserFocusIn(param1:BrowserEvent) : void {
         onBrowserShowS(false);
      }

      private function onBrowserFocusOut(param1:BrowserEvent) : void {
         browserFocusOut();
      }

      private function updateFocus() : void {
         if(!this.actionBtn.isMouseOver)
         {
            setFocus(this);
         }
      }
   }

}