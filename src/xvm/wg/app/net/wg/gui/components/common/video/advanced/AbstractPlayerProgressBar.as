package net.wg.gui.components.common.video.advanced
{
   import scaleform.clik.core.UIComponent;
   import flash.events.Event;
   
   public class AbstractPlayerProgressBar extends UIComponent
   {
      
      public function AbstractPlayerProgressBar() {
         super();
      }
      
      public static const UNDER_USING_STATE:String = "controlUnderUsing";
      
      private static const POSITION_INVALID:String = "timeInvalid";
      
      protected var _position:Number = 0;
      
      protected var _underUsing:Boolean;
      
      override protected function draw() : void {
         super.draw();
         if(isInvalid(POSITION_INVALID))
         {
            this.applyTimeUpdating();
         }
      }
      
      protected function setUnderUsingState(param1:Boolean) : void {
         this._underUsing = param1;
         dispatchEvent(new Event(UNDER_USING_STATE));
      }
      
      protected function positionUpdated(param1:Number) : void {
         dispatchEvent(new ProgressBarEvent(ProgressBarEvent.POSITION_UPDATED,param1));
      }
      
      protected function applyTimeUpdating() : void {
      }
      
      public function get position() : Number {
         return this._position;
      }
      
      public function set position(param1:Number) : void {
         this._position = param1;
         invalidate(POSITION_INVALID);
      }
      
      public function get underUsing() : Boolean {
         return this._underUsing;
      }
      
      override protected function onDispose() : void {
         super.onDispose();
      }
   }
}
