package net.wg.gui.components.common.video.advanced
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.Slider;
   import flash.text.TextField;
   
   public class VideoPlayerControlBar extends UIComponent
   {
      
      public function VideoPlayerControlBar() {
         super();
      }
      
      private static function formatTime(param1:Number) : String {
         var _loc2_:Number = Math.floor(param1 / 60);
         var _loc3_:Number = Math.floor(param1 % 60);
         return (_loc2_ > 9?_loc2_.toString():"0" + _loc2_.toString()) + ":" + (_loc3_ > 9?_loc3_.toString():"0" + _loc3_.toString());
      }
      
      private static function htmlFormatTime(param1:Number, param2:Number) : String {
         return "<font color=\'#fffff2\'>" + formatTime(param1) + "</font> / " + formatTime(param2);
      }
      
      private static function disposeObj(param1:UIComponent) : void {
         if(param1)
         {
            param1.dispose();
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
         }
      }
      
      public var playButton:SoundButtonEx;
      
      public var repeatButton:SoundButtonEx;
      
      public var soundSlider:Slider;
      
      public var timeField:TextField;
      
      private var _volume:Number = 0;
      
      private var isVolumeInvalid:Boolean;
      
      private var isPlayButtonStateChanged:Boolean;
      
      private var _showPlayBtn:Boolean;
      
      private var _currentTime:Number = 0;
      
      private var isTimeChanged:Boolean = true;
      
      private var _totalTime:Number = 0;
      
      public function get volume() : Number {
         if(this.soundSlider)
         {
            return this.soundSlider.value;
         }
         return this._volume;
      }
      
      public function set volume(param1:Number) : void {
         var param1:Number = isNaN(param1)?0:param1;
         if(this.volume == param1)
         {
            return;
         }
         this._volume = param1;
         this.isVolumeInvalid = true;
         invalidate();
      }
      
      override protected function draw() : void {
         super.draw();
         if(this.isVolumeInvalid)
         {
            this.isVolumeInvalid = false;
            this.soundSlider.value = this._volume;
         }
         if(this.isPlayButtonStateChanged)
         {
            this.isPlayButtonStateChanged = false;
            this.playButton.selected = !this._showPlayBtn;
         }
         if(this.isTimeChanged)
         {
            this.isTimeChanged = false;
            this.timeField.htmlText = htmlFormatTime(this._currentTime,this._totalTime);
         }
      }
      
      public function set showPlayBtn(param1:Boolean) : void {
         this._showPlayBtn = param1;
         this.isPlayButtonStateChanged = true;
         invalidate();
      }
      
      public function set currentTime(param1:Number) : void {
         this._currentTime = param1;
         this.isTimeChanged = true;
         invalidate();
      }
      
      public function set totalTime(param1:Number) : void {
         this._totalTime = param1;
         this.isTimeChanged = true;
         invalidate();
      }
      
      override protected function onDispose() : void {
         super.onDispose();
         disposeObj(this.playButton);
         disposeObj(this.repeatButton);
         disposeObj(this.soundSlider);
      }
   }
}
