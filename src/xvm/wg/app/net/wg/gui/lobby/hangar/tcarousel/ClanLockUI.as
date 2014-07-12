package net.wg.gui.lobby.hangar.tcarousel
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   
   public class ClanLockUI extends UIComponent
   {
      
      public function ClanLockUI() {
         super();
      }
      
      public var textField:TextField;
      
      private var _timer:Number;
      
      override protected function onDispose() : void {
         this.textField = null;
         super.onDispose();
      }
      
      override protected function draw() : void {
         super.draw();
         this.textField.text = this.updateClanLock();
      }
      
      public function set timer(param1:Number) : void {
         this._timer = param1;
         invalidate();
      }
      
      public function get timer() : Number {
         return this._timer;
      }
      
      private function updateClanLock() : String {
         var _loc1_:* = "";
         var _loc2_:Date = new Date();
         var _loc3_:Number = Math.round(this._timer - _loc2_.valueOf() / 1000);
         if(_loc3_ > 0)
         {
            _loc1_ = this.calcLockTime(_loc3_);
            this.visible = true;
         }
         else
         {
            this.visible = false;
         }
         return _loc1_;
      }
      
      private function calcLockTime(param1:Number) : String {
         var _loc2_:* = "";
         var param1:Number = Math.ceil(param1 / 60);
         var _loc3_:Number = Math.floor(param1 / 60);
         var _loc4_:Number = Math.floor(param1 - _loc3_ * 60);
         var _loc5_:String = _loc3_ < 10?"0" + _loc3_:_loc3_.toString();
         var _loc6_:String = _loc4_ < 10?"0" + _loc4_:_loc4_.toString();
         _loc2_ = _loc5_ + ":" + _loc6_;
         return _loc2_;
      }
      
      override public function toString() : String {
         return "[WG ClanLockUi " + name + "]";
      }
   }
}
