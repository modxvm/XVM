package net.wg.gui.components.common.video.advanced 
{
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class VideoPlayerControlBar extends scaleform.clik.core.UIComponent
    {
        public function VideoPlayerControlBar()
        {
            super();
            return;
        }

        public function get volume():Number
        {
            if (this.soundSlider) 
            {
                return this.soundSlider.value;
            }
            return this._volume;
        }

        public function set volume(arg1:Number):void
        {
            arg1 = isNaN(arg1) ? 0 : arg1;
            if (this.volume == arg1) 
            {
                return;
            }
            this._volume = arg1;
            this.isVolumeInvalid = true;
            invalidate();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (this.isVolumeInvalid) 
            {
                this.isVolumeInvalid = false;
                this.soundSlider.value = this._volume;
            }
            if (this.isPlayButtonStateChanged) 
            {
                this.isPlayButtonStateChanged = false;
                this.playButton.selected = !this._showPlayBtn;
            }
            if (this.isTimeChanged) 
            {
                this.isTimeChanged = false;
                this.timeField.htmlText = htmlFormatTime(this._currentTime, this._totalTime);
            }
            return;
        }

        public function set showPlayBtn(arg1:Boolean):void
        {
            this._showPlayBtn = arg1;
            this.isPlayButtonStateChanged = true;
            invalidate();
            return;
        }

        public function set currentTime(arg1:Number):void
        {
            this._currentTime = arg1;
            this.isTimeChanged = true;
            invalidate();
            return;
        }

        public function set totalTime(arg1:Number):void
        {
            this._totalTime = arg1;
            this.isTimeChanged = true;
            invalidate();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            disposeObj(this.playButton);
            disposeObj(this.repeatButton);
            disposeObj(this.soundSlider);
            return;
        }

        internal static function formatTime(arg1:Number):String
        {
            var loc1:*=Math.floor(arg1 / 60);
            var loc2:*=Math.floor(arg1 % 60);
            return (loc1 > 9 ? loc1.toString() : "0" + loc1.toString()) + ":" + (loc2 > 9 ? loc2.toString() : "0" + loc2.toString());
        }

        internal static function htmlFormatTime(arg1:Number, arg2:Number):String
        {
            return "<font color=\'#fffff2\'>" + formatTime(arg1) + "</font> / " + formatTime(arg2);
        }

        internal static function disposeObj(arg1:scaleform.clik.core.UIComponent):void
        {
            if (arg1) 
            {
                arg1.dispose();
                if (arg1.parent) 
                {
                    arg1.parent.removeChild(arg1);
                }
            }
            return;
        }

        public var playButton:net.wg.gui.components.controls.SoundButtonEx;

        public var repeatButton:net.wg.gui.components.controls.SoundButtonEx;

        public var soundSlider:net.wg.gui.components.controls.Slider;

        public var timeField:flash.text.TextField;

        internal var _volume:Number=0;

        internal var isVolumeInvalid:Boolean;

        internal var isPlayButtonStateChanged:Boolean;

        internal var _showPlayBtn:Boolean;

        internal var _currentTime:Number=0;

        internal var isTimeChanged:Boolean=true;

        internal var _totalTime:Number=0;
    }
}
