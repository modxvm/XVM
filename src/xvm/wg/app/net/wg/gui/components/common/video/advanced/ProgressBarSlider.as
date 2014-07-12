package net.wg.gui.components.common.video.advanced
{
    import net.wg.gui.components.controls.Slider;
    import flash.events.MouseEvent;
    import flash.events.Event;
    
    public class ProgressBarSlider extends Slider
    {
        
        public function ProgressBarSlider() {
            super();
        }
        
        public static var THUMB_DRUGGING_STATE:String = "thumbDraggingStateChanged";
        
        public function isSliderThumbDruggingNow() : Boolean {
            return _thumbPressed;
        }
        
        override protected function beginDrag(param1:MouseEvent) : void {
            super.beginDrag(param1);
            dispatchEvent(new Event(THUMB_DRUGGING_STATE));
        }
        
        override protected function endDrag(param1:MouseEvent) : void {
            super.endDrag(param1);
            dispatchEvent(new Event(THUMB_DRUGGING_STATE));
        }
        
        override protected function onScrollWheel(param1:MouseEvent) : void {
        }
        
        override protected function updateThumb() : void {
            super.updateThumb();
        }
    }
}
