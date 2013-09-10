package net.wg.gui.components.common.video.advanced 
{
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    
    public class ProgressBarSlider extends net.wg.gui.components.controls.Slider
    {
        public function ProgressBarSlider()
        {
            super();
            return;
        }

        public function isSliderThumbDruggingNow():Boolean
        {
            return _thumbPressed;
        }

        protected override function beginDrag(arg1:flash.events.MouseEvent):void
        {
            super.beginDrag(arg1);
            dispatchEvent(new flash.events.Event(THUMB_DRUGGING_STATE));
            return;
        }

        protected override function endDrag(arg1:flash.events.MouseEvent):void
        {
            super.endDrag(arg1);
            dispatchEvent(new flash.events.Event(THUMB_DRUGGING_STATE));
            return;
        }

        protected override function onScrollWheel(arg1:flash.events.MouseEvent):void
        {
            return;
        }

        protected override function updateThumb():void
        {
            super.updateThumb();
            return;
        }

        public static const THUMB_DRUGGING_STATE:String="thumbDraggingStateChanged";
    }
}
