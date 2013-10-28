package net.wg.gui.lobby.techtree.data.state
{


   public class StateProperties extends Object
   {
          
      public function StateProperties(param1:uint, param2:uint, param3:String=null, param4:uint=undefined, param5:Boolean=false, param6:AnimationProperties=null, param7:Number=undefined) {
         super();
         this.id = param1;
         this.index = param2;
         this.label = param3;
         this.enough = param4;
         this.visible = param5;
         this.animation = param6;
         this.icoAlpha = param7;
      }

      public var id:uint;

      public var index:uint;

      public var label:String;

      public var enough:uint;

      public var visible:Boolean;

      public var animation:AnimationProperties;

      public var icoAlpha:Number;

      public function toString() : String {
         var _loc1_:* = "StateProperties(";
         _loc1_ = _loc1_ + ("id = " + this.id);
         _loc1_ = _loc1_ + (", index = " + this.index);
         _loc1_ = _loc1_ + (", label = " + this.label);
         _loc1_ = _loc1_ + (", enough = " + this.enough);
         _loc1_ = _loc1_ + (", visible = " + this.visible);
         _loc1_ = _loc1_ + (" animation = " + this.animation);
         _loc1_ = _loc1_ + (", icoAlpha = " + this.icoAlpha);
         return _loc1_ + ")";
      }
   }

}