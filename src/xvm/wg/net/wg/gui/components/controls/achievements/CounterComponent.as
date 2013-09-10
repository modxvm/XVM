package net.wg.gui.components.controls.achievements 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    
    public class CounterComponent extends net.wg.gui.components.controls.SoundButtonEx
    {
        public function CounterComponent()
        {
            super();
            this.originalBgWidth = this.background.width;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            super.draw();
            if (isInvalid(COUNT_INV)) 
            {
                textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
                textField.text = this._text.toString();
                invalidate(LAYOUT_INV);
            }
            if (isInvalid(LAYOUT_INV)) 
            {
                loc1 = textField.width - this._minBgWindowWidth;
                if (loc1 > 0) 
                {
                    loc2 = this.originalBgWidth + loc1;
                }
                else 
                {
                    loc2 = this.originalBgWidth;
                }
                this.background.width = loc2;
                textField.x = loc2 - textField.width >> 1;
            }
            return;
        }

        protected override function handleStageChange(arg1:flash.events.Event):void
        {
            if (arg1.type == flash.events.Event.ADDED_TO_STAGE) 
            {
                removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.handleStageChange, false);
                addEventListener(flash.events.Event.RENDER, validateNow, false, 0, true);
                addEventListener(flash.events.Event.ENTER_FRAME, validateNow, false, 0, true);
                if (stage != null) 
                {
                    stage.invalidate();
                }
            }
            return;
        }

        public function get minBgWindowWidth():uint
        {
            return this._minBgWindowWidth;
        }

        public function set minBgWindowWidth(arg1:uint):void
        {
            this._minBgWindowWidth = arg1;
            invalidate(LAYOUT_INV);
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            this._text = arg1;
            invalidate(COUNT_INV);
            return;
        }

        public function receiveBottomPadding():Number
        {
            return 0;
        }

        internal static const LAYOUT_INV:String="layoutInvalid";

        internal static const COUNT_INV:String="countInvalid";

        public var background:flash.display.MovieClip;

        internal var _minBgWindowWidth:uint=20;

        internal var _text:String="0";

        internal var originalBgWidth:uint=0;
    }
}
