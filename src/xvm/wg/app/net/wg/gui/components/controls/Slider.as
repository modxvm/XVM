package net.wg.gui.components.controls
{
   import scaleform.clik.controls.Slider;
   import flash.display.MovieClip;
   import scaleform.clik.utils.Padding;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import scaleform.clik.constants.InvalidationType;
   import flash.geom.Point;
   import scaleform.clik.events.SliderEvent;


   public class Slider extends scaleform.clik.controls.Slider
   {
          
      public function Slider() {
         this._fillPadding = new Padding(3,6,3,2);
         super();
         offsetLeft = 3;
         offsetRight = 4;
         if((track) && (track["bg"]) && (track["bg"]["patternMc"]))
         {
            this.patternMc = track["bg"]["patternMc"];
         }
         if((track) && (track["hitMc"]))
         {
            this.hitMc = track["hitMc"];
         }
         buttonMode = true;
      }

      private var progress_mask:MovieClip;

      protected var _undefined:Boolean = false;

      public var hitMc:MovieClip = null;

      public var patternMc:BitmapFill = null;

      private var _fillPaddingX:Number = 11;

      private var _fillPaddingY:Number = 4;

      private var _fillPadding:Padding;

      override public function dispose() : void {
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.onScrollWheel,false);
         this.progress_mask = null;
         if(this.patternMc)
         {
            this.patternMc.dispose();
            this.patternMc = null;
         }
         super.dispose();
      }

      override protected function scrollWheel(param1:Number) : void {
         if(!this.enabled)
         {
            return;
         }
         value = value + _snapInterval * (param1 > 0?1:-1);
         dispatchEvent(new Event(Event.CHANGE));
      }

      override protected function configUI() : void {
         super.configUI();
         track["progress_mask"].gotoAndStop(0);
         addEventListener(MouseEvent.MOUSE_WHEEL,this.onScrollWheel,false,0,true);
      }

      override protected function beginDrag(param1:MouseEvent) : void {
         if(App.utils.commons.isLeftButton(param1))
         {
            super.beginDrag(param1);
         }
      }

      override protected function trackPress(param1:MouseEvent) : void {
         if(App.utils.commons.isLeftButton(param1))
         {
            super.trackPress(param1);
         }
      }

      protected function onScrollWheel(param1:MouseEvent) : void {
         this.scrollWheel(param1.delta);
      }

      override protected function draw() : void {
         super.draw();
         this.updatePattern();
      }

      public function get undefinedDisabled() : Boolean {
         return this._undefined;
      }

      public function set undefinedDisabled(param1:Boolean) : void {
         if(this._undefined == param1)
         {
            return;
         }
         this._undefined = param1;
         super.enabled = !param1;
         thumb.enabled = track.enabled = !param1;
         thumb.visible = !this._undefined;
         track["progress_mask"].gotoAndStop(0);
         invalidate(InvalidationType.STATE);
      }

      override public function get enabled() : Boolean {
         return super.enabled;
      }

      override public function set enabled(param1:Boolean) : void {
         if(param1 == super.enabled)
         {
            return;
         }
         super.enabled = param1;
         thumb.visible = param1;
         if(!initialized)
         {
            return;
         }
         invalidate(InvalidationType.STATE);
      }

      override protected function doDrag(param1:MouseEvent) : void {
         var _loc2_:Point = globalToLocal(new Point(param1.stageX,param1.stageY));
         var _loc3_:Number = _loc2_.x - _dragOffset.x;
         var _loc4_:Number = track.width - offsetLeft - offsetRight;
         var _loc5_:Number = lockValue((_loc3_ - offsetLeft) / _loc4_ * (_maximum - _minimum) + _minimum);
         if(value == _loc5_)
         {
            return;
         }
         _value = _loc5_;
         this.updateThumb();
         if(liveDragging)
         {
            dispatchEvent(new SliderEvent(SliderEvent.VALUE_CHANGE,false,true,_value));
         }
      }

      override protected function updateThumb() : void {
         var _loc2_:* = NaN;
         var _loc1_:Number = track.width - offsetLeft - offsetRight;
         thumb.x = (_value - _minimum) / (_maximum - _minimum) * _loc1_ - thumb.width / 2 + offsetLeft ^ 0;
         if(!this.enabled)
         {
            track["progress_mask"].gotoAndStop(0);
            return;
         }
         if(!this._undefined)
         {
            _loc2_ = (position - _minimum) / (_maximum - _minimum);
            track["progress_mask"].gotoAndStop(Math.round(_loc2_ * track["progress_mask"].totalFrames));
         }
         else
         {
            track["progress_mask"].gotoAndStop(0);
         }
      }

      private function updatePattern() : void {
         if(this.patternMc)
         {
            this.patternMc.x = this._fillPadding.left;
            this.patternMc.y = this._fillPadding.top;
            this.patternMc.setActualScale(1 / this.track.actualScaleX,1 / this.track.actualScaleY);
            this.patternMc.widthFill = Math.round(this.hitMc.width * this.track.actualScaleX);
            this.patternMc.heightFill = Math.round(this.hitMc.height * this.track.actualScaleY);
         }
      }
   }

}