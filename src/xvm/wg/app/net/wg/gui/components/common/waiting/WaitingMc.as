package net.wg.gui.components.common.waiting
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.events.Event;


   public class WaitingMc extends UIComponent
   {
          
      public function WaitingMc() {
         super();
         id++;
         this.uid = id;
      }

      public static var id:int = 0;

      public static const TEXT_INVALID:String = "textInv";

      public var textField:TextField;

      public var uid:int = 0;

      private var _text:String = "";

      override public function play() : void {
         addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
      }

      override public function dispose() : void {
         this.textField = null;
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         super.dispose();
      }

      override public function stop() : void {
         super.stop();
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
      }

      override public function nextFrame() : void {
         super.nextFrame();
         if(currentFrame == totalFrames)
         {
            gotoAndStop(1);
         }
      }

      public function setMessage(param1:String) : void {
         this._text = param1;
         invalidate(TEXT_INVALID);
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(TEXT_INVALID))
         {
            this.textField.text = this._text;
         }
      }

      private function onEnterFrameHandler(param1:Event) : void {
         this.nextFrame();
      }
   }

}