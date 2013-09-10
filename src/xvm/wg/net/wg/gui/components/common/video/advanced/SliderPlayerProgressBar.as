package net.wg.gui.components.common.video.advanced 
{
    import flash.events.*;
    import scaleform.clik.events.*;
    
    public class SliderPlayerProgressBar extends net.wg.gui.components.common.video.advanced.AbstractPlayerProgressBar
    {
        public function SliderPlayerProgressBar()
        {
            super();
            this.x = 362;
            this.y = 682;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.slider.addEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.sliderChangeHandler, false, 0, true);
            this.slider.addEventListener(net.wg.gui.components.common.video.advanced.ProgressBarSlider.THUMB_DRUGGING_STATE, this.thumbDrugStateChangeHandler, false, 0, true);
            return;
        }

        internal function thumbDrugStateChangeHandler(arg1:flash.events.Event):void
        {
            setUnderUsingState(this.slider.isSliderThumbDruggingNow());
            return;
        }

        internal function sliderChangeHandler(arg1:scaleform.clik.events.SliderEvent):void
        {
            arg1.stopImmediatePropagation();
            if (_position != this.slider.value) 
            {
                positionUpdated(this.slider.value);
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        protected override function applyTimeUpdating():void
        {
            super.applyTimeUpdating();
            if (this.slider.value != _position) 
            {
                this.slider.value = _position;
            }
            return;
        }

        public override function dispose():void
        {
            this.slider.removeEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.sliderChangeHandler);
            this.slider.removeEventListener(net.wg.gui.components.common.video.advanced.ProgressBarSlider.THUMB_DRUGGING_STATE, this.thumbDrugStateChangeHandler);
            super.dispose();
            return;
        }

        public var slider:net.wg.gui.components.common.video.advanced.ProgressBarSlider;
    }
}
