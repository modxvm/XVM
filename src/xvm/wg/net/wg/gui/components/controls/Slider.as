package net.wg.gui.components.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    
    public class Slider extends scaleform.clik.controls.Slider
    {
        public function Slider()
        {
            super();
            offsetLeft = 1;
            offsetRight = 5;
            buttonMode = true;
            return;
        }

        protected override function scrollWheel(arg1:Number):void
        {
            if (!this.enabled) 
                return;
            value = value + arg1 * _snapInterval;
            dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE));
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            track["progress_mask"].gotoAndStop(0);
            addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.onScrollWheel, false, 0, true);
            return;
        }

        protected override function beginDrag(arg1:flash.events.MouseEvent):void
        {
            if (App.utils.commons.isLeftButton(arg1)) 
                super.beginDrag(arg1);
            return;
        }

        protected override function trackPress(arg1:flash.events.MouseEvent):void
        {
            if (App.utils.commons.isLeftButton(arg1)) 
                super.trackPress(arg1);
            return;
        }

        protected function onScrollWheel(arg1:flash.events.MouseEvent):void
        {
            this.scrollWheel(arg1.delta);
            return;
        }

        public function get undefinedDisabled():Boolean
        {
            return this._undefined;
        }

        public function set undefinedDisabled(arg1:Boolean):void
        {
            if (this._undefined == arg1) 
                return;
            this._undefined = arg1;
            super.enabled = !arg1;
            var loc1:*;
            track.enabled = loc1 = !arg1;
            thumb.enabled = loc1;
            thumb.visible = !this._undefined;
            track["progress_mask"].gotoAndStop(0);
            invalidate(scaleform.clik.constants.InvalidationType.STATE);
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            if (arg1 == super.enabled) 
                return;
            super.enabled = arg1;
            thumb.visible = arg1;
            if (!initialized) 
                return;
            invalidate(scaleform.clik.constants.InvalidationType.STATE);
            return;
        }

        protected override function doDrag(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=globalToLocal(new flash.geom.Point(arg1.stageX, arg1.stageY));
            var loc2:*=loc1.x - _dragOffset.x;
            var loc3:*=track.width - offsetLeft - offsetRight;
            var loc4:*=lockValue((loc2 - offsetLeft) / loc3 * (_maximum - _minimum) + _minimum);
            if (value == loc4) 
                return;
            _value = loc4;
            this.updateThumb();
            if (liveDragging) 
                dispatchEvent(new scaleform.clik.events.SliderEvent(scaleform.clik.events.SliderEvent.VALUE_CHANGE, false, true, _value));
            return;
        }

        protected override function updateThumb():void
        {
            var loc2:*=NaN;
            var loc1:*=track.width - offsetLeft - offsetRight;
            thumb.x = (_value - _minimum) / (_maximum - _minimum) * loc1 - thumb.width / 2 + offsetLeft ^ 0;
            if (!this.enabled) 
            {
                track["progress_mask"].gotoAndStop(0);
                return;
            }
            if (this._undefined) 
                track["progress_mask"].gotoAndStop(0);
            else 
            {
                loc2 = (position - _minimum) / (_maximum - _minimum);
                track["progress_mask"].gotoAndStop(Math.round(loc2 * track["progress_mask"].totalFrames));
            }
            return;
        }

        internal var progress_mask:flash.display.MovieClip;

        internal var _undefined:Boolean=false;
    }
}
