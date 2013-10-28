package net.wg.gui.login.impl
{
   import net.wg.gui.login.ISparksManager;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.entity.IDisposable;


   public final class SparksManager extends Object implements ISparksManager
   {
          
      public function SparksManager() {
         super();
      }

      private var _sparkQuantity:Number = 0;

      private var _scope:MovieClip = null;

      private var _zone:Rectangle = null;

      public function set scope(param1:MovieClip) : void {
         this._scope = param1;
      }

      public function get scope() : MovieClip {
         return this._scope;
      }

      public function set sparkQuantity(param1:Number) : void {
         this._sparkQuantity = param1;
      }

      public function get sparkQuantity() : Number {
         return this._sparkQuantity;
      }

      public function set zone(param1:Rectangle) : void {
         this._zone = param1;
      }

      public function get zone() : Rectangle {
         return this._zone;
      }

      public function resetZone(param1:Rectangle) : void {
         var _loc3_:Spark = null;
         this._zone = param1;
         var _loc2_:Number = 0;
         while(_loc2_ < this._scope.numChildren)
         {
            _loc3_ = this._scope.getChildAt(_loc2_) as Spark;
            _loc3_.zone = this._zone;
            _loc2_++;
         }
      }

      public function dispose() : void {
         var _loc1_:IDisposable = null;
         while(this._scope.numChildren)
         {
            _loc1_ = IDisposable(this._scope.getChildAt(0));
            _loc1_.dispose();
            this._scope.removeChildAt(0);
         }
         this._scope = null;
      }

      public function createSparks() : void {
         var _loc2_:Spark = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._sparkQuantity)
         {
            _loc2_ = new Spark(this._zone,"spark_" + _loc1_);
            this._scope.addChild(_loc2_);
            _loc2_.startAnimation();
            _loc1_++;
         }
      }
   }

}