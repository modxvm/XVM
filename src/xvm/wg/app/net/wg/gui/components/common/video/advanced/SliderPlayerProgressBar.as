package net.wg.gui.components.common.video.advanced
{
   import scaleform.clik.events.SliderEvent;
   import flash.events.Event;


   public class SliderPlayerProgressBar extends AbstractPlayerProgressBar
   {
          
      public function SliderPlayerProgressBar() {
         super();
         this.x = 362;
         this.y = 682;
      }

      public var slider:ProgressBarSlider;

      override protected function configUI() : void {
         super.configUI();
         this.slider.addEventListener(SliderEvent.VALUE_CHANGE,this.sliderChangeHandler,false,0,true);
         this.slider.addEventListener(ProgressBarSlider.THUMB_DRUGGING_STATE,this.thumbDrugStateChangeHandler,false,0,true);
      }

      private function thumbDrugStateChangeHandler(param1:Event) : void {
         setUnderUsingState(this.slider.isSliderThumbDruggingNow());
      }

      private function sliderChangeHandler(param1:SliderEvent) : void {
         param1.stopImmediatePropagation();
         if(_position != this.slider.value)
         {
            positionUpdated(this.slider.value);
         }
      }

      override protected function draw() : void {
         super.draw();
      }

      override protected function applyTimeUpdating() : void {
         super.applyTimeUpdating();
         if(this.slider.value != _position)
         {
            this.slider.value = _position;
         }
      }

      override protected function onDispose() : void {
         this.slider.removeEventListener(SliderEvent.VALUE_CHANGE,this.sliderChangeHandler);
         this.slider.removeEventListener(ProgressBarSlider.THUMB_DRUGGING_STATE,this.thumbDrugStateChangeHandler);
         super.onDispose();
      }
   }

}