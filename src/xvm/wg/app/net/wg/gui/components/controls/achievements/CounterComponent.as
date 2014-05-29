package net.wg.gui.components.controls.achievements
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.interfaces.ICounterComponent;
   import flash.display.MovieClip;
   import flash.text.TextFieldAutoSize;
   import flash.events.Event;


   public class CounterComponent extends SoundButtonEx implements ICounterComponent
   {
          
      public function CounterComponent() {
         super();
         this.originalBgWidth = this.background.width;
      }

      private static const LAYOUT_INV:String = "layoutInvalid";

      private static const COUNT_INV:String = "countInvalid";

      public var background:MovieClip;

      private var _minBgWindowWidth:uint = 20;

      private var _text:String = "0";

      private var originalBgWidth:uint = 0;

      override protected function onDispose() : void {
         this.background = null;
         super.onDispose();
      }

      override protected function draw() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         super.draw();
         if(isInvalid(COUNT_INV))
         {
            textField.autoSize = TextFieldAutoSize.LEFT;
            textField.text = this._text.toString();
            invalidate(LAYOUT_INV);
         }
         if(isInvalid(LAYOUT_INV))
         {
            _loc1_ = textField.width - this._minBgWindowWidth;
            if(_loc1_ > 0)
            {
               _loc2_ = this.originalBgWidth + _loc1_;
            }
            else
            {
               _loc2_ = this.originalBgWidth;
            }
            this.background.width = _loc2_;
            textField.x = _loc2_ - textField.width >> 1;
         }
      }

      override public function get width() : Number {
         return actualWidth;
      }

      override protected function handleStageChange(param1:Event) : void {
         if(param1.type == Event.ADDED_TO_STAGE)
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.handleStageChange,false);
            addEventListener(Event.RENDER,validateNow,false,0,true);
            addEventListener(Event.ENTER_FRAME,validateNow,false,0,true);
            if(stage != null)
            {
               stage.invalidate();
            }
         }
      }

      public function get minBgWindowWidth() : uint {
         return this._minBgWindowWidth;
      }

      public function set minBgWindowWidth(param1:uint) : void {
         this._minBgWindowWidth = param1;
         invalidate(LAYOUT_INV);
      }

      public function get text() : String {
         return this._text;
      }

      public function set text(param1:String) : void {
         this._text = param1;
         invalidate(COUNT_INV);
      }

      public function receiveBottomPadding() : Number {
         return 0;
      }
   }

}