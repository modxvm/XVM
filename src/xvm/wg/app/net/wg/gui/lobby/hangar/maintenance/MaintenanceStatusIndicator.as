package net.wg.gui.lobby.hangar.maintenance
{
   import scaleform.clik.controls.StatusIndicator;
   import flash.display.MovieClip;
   import flash.text.TextField;


   public class MaintenanceStatusIndicator extends StatusIndicator
   {
          
      public function MaintenanceStatusIndicator() {
         super();
      }

      private var _flashing:Boolean = true;

      private var _divisor:Number = -1;

      private var _label:String = "";

      private var _divisorValueLoaded:Number = 0;

      private var _divisorValueTotal:Number = 0;

      private var _divisorEnabled:Boolean = true;

      public var alert_mc:MovieClip;

      public var divisor_mc:MovieClip;

      public var textField:TextField;

      public function setDivisor(param1:Number, param2:Number) : void {
         this._divisorValueLoaded = param1;
         this._divisorValueTotal = param2;
         this.updateDivisorVisibility();
         var _loc3_:Number = (width - 8) * param1 / param2;
         this.divisor_mc.x = Math.round(_loc3_ / scaleX);
      }

      public function get flashing() : Boolean {
         return this._flashing;
      }

      public function set flashing(param1:Boolean) : void {
         this._flashing = param1;
         this.alert_mc.visible = this._flashing;
      }

      public function get label() : String {
         return this._label;
      }

      public function set label(param1:String) : void {
         this._label = param1;
         this.textField.text = this._label;
      }

      public function get divisorEnabled() : Boolean {
         return this._divisorEnabled;
      }

      public function set divisorEnabled(param1:Boolean) : void {
         this._divisorEnabled = param1;
         this.updateDivisorVisibility();
      }

      private function updateDivisorVisibility() : void {
         this.divisor_mc.visible = (this._divisorEnabled) && (this._divisorValueLoaded) && (this._divisorValueTotal);
      }

      override public function toString() : String {
         return "[Wargaming ProgressBar " + name + "]";
      }
   }

}