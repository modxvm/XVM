package net.wg.gui.lobby.browser
{
   import scaleform.clik.core.UIComponent;
   import net.wg.utils.IEventCollector;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;


   public class BrowserHitArea extends UIComponent
   {
          
      public function BrowserHitArea() {
         this.events = App.utils.events;
         super();
      }

      private var events:IEventCollector;

      private var bgImg:Bitmap;

      override protected function onDispose() : void {
         super.onDispose();
         removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.events.removeEvent(App.stage,MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         this.events.removeEvent(App.stage,MouseEvent.MOUSE_UP,this.onMouseUpHandler);
         removeChild(this.bgImg);
         this.events = null;
      }

      override protected function configUI() : void {
         super.configUI();
         var _loc1_:Class = App.browserBgClass;
         this.bgImg = new _loc1_();
         addChild(this.bgImg);
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler,false,0,true);
         this.events.addEvent(App.stage,MouseEvent.MOUSE_DOWN,this.onMouseDownHandler,false,0,true);
         this.events.addEvent(App.stage,MouseEvent.MOUSE_UP,this.onMouseUpHandler,false,0,true);
      }

      private function onMouseRollOverHandler(param1:MouseEvent) : void {
         addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler,false,0,true);
         dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_FOCUS_IN));
      }

      private function onMouseRollOutHandler(param1:MouseEvent) : void {
         removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_FOCUS_OUT));
      }

      private function onMouseWheelHandler(param1:MouseEvent) : void {
         dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_MOVE,0,0,param1.delta));
      }

      private function onMouseDownHandler(param1:MouseEvent) : void {
         if(param1.target == this)
         {
            dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_DOWN,this.mouseX,this.mouseY));
         }
         else
         {
            dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_FOCUS_OUT));
         }
      }

      private function onMouseUpHandler(param1:MouseEvent) : void {
         dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_UP,this.mouseX,this.mouseY));
      }

      private function onMouseMoveHandler(param1:MouseEvent) : void {
         dispatchEvent(new BrowserEvent(BrowserEvent.BROWSER_MOVE,this.mouseX,this.mouseY));
      }
   }

}