package net.wg.gui.login.impl
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.geom.Rectangle;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class Spark extends Sprite implements IDisposable
   {
      
      public function Spark(param1:Rectangle, param2:String) {
         this.zone = param1;
         this.name = param2;
         super();
      }
      
      private static function randRange(param1:Number, param2:Number) : Number {
         var _loc3_:Number = Math.random() * (param2 - param1) + param1;
         return _loc3_;
      }
      
      private var _zone:Rectangle = null;
      
      public var sparkAnimation:MovieClip = null;
      
      public function set zone(param1:Rectangle) : void {
         this._zone = param1;
      }
      
      public function get zone() : Rectangle {
         return this._zone;
      }
      
      public function startAnimation(param1:Event = null) : void {
         var _loc2_:* = NaN;
         removeEventListener(Event.ADDED_TO_STAGE,this.startAnimation,false);
         if(stage)
         {
            this.reposition();
            _loc2_ = this.sparkAnimation.totalFrames - 1;
            this.sparkAnimation.gotoAndPlay(1 + Math.floor(Math.random() * _loc2_));
            this.sparkAnimation.addFrameScript(_loc2_,this.sparkAnimationDispatch);
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.startAnimation,false);
         }
      }
      
      private function sparkAnimationDispatch() : void {
         this.reposition();
      }
      
      private function reposition() : void {
         var _loc1_:Number = 1;
         if(Math.random() > 0.75)
         {
            _loc1_ = randRange(0.7,1);
         }
         else
         {
            _loc1_ = randRange(0.2,0.4);
         }
         x = Math.floor(randRange(this._zone.x,this._zone.width));
         y = Math.floor(randRange(this._zone.y,this._zone.height));
         scaleX = this.scaleY = _loc1_;
         alpha = randRange(0.05,0.5);
         rotation = randRange(-120,-100);
      }
      
      public function dispose() : void {
         removeEventListener(Event.ADDED_TO_STAGE,this.startAnimation);
         this.zone = null;
         this.sparkAnimation.stop();
         this.sparkAnimation = null;
      }
   }
}
