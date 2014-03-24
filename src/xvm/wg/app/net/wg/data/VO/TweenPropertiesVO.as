package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   import flash.display.DisplayObject;
   import net.wg.utils.IAssertable;
   import net.wg.data.constants.Errors;


   public class TweenPropertiesVO extends DAAPIDataClass implements ITweenPropertiesVO
   {
          
      public function TweenPropertiesVO(param1:Object) {
         super(param1);
      }

      private var _duration:int = 0;

      private var _delay:int = 0;

      private var _position:int = 0;

      private var _target:DisplayObject = null;

      private var _actionAfterRemoveFromStage:String = "notToProcess";

      private var _loop:Boolean = false;

      private var _paused:Boolean = true;

      private var _ease:String = null;

      private var _x:Number = NaN;

      private var _y:Number = NaN;

      private var _scaleX:Number = NaN;

      private var _scaleY:Number = NaN;

      private var _alpha:Number = NaN;

      private var _rotation:Number = NaN;

      private var _onComplete:Function = null;

      private var _argsForOnComplete:Object = null;

      public function get position() : int {
         return this._position;
      }

      public function set position(param1:int) : void {
         this._position = param1;
      }

      public function get duration() : int {
         return this._duration;
      }

      public function set duration(param1:int) : void {
         var _loc2_:IAssertable = App.utils.asserter;
         _loc2_.assert(param1 > 0,"Duration in Tween will be more than 0.");
         this._duration = param1;
      }

      public function get delay() : int {
         return this._delay;
      }

      public function set delay(param1:int) : void {
         this._delay = param1;
      }

      public function get target() : DisplayObject {
         return this._target;
      }

      public function set target(param1:DisplayObject) : void {
         App.utils.asserter.assertNotNull(param1,"target " + Errors.CANT_NULL);
         this._target = param1;
      }

      public function get actionAfterRemoveFromStage() : String {
         return this._actionAfterRemoveFromStage;
      }

      public function set actionAfterRemoveFromStage(param1:String) : void {
         this._actionAfterRemoveFromStage = param1;
      }

      public function get loop() : Boolean {
         return this._loop;
      }

      public function set loop(param1:Boolean) : void {
         this._loop = param1;
      }

      public function get paused() : Boolean {
         return this._paused;
      }

      public function set paused(param1:Boolean) : void {
         this._paused = param1;
      }

      public function get ease() : String {
         return this._ease;
      }

      public function set ease(param1:String) : void {
         this._ease = param1;
      }

      public function get onComplete() : Function {
         return this._onComplete;
      }

      public function set onComplete(param1:Function) : void {
         this._onComplete = param1;
      }

      public function get x() : Number {
         return this._x;
      }

      public function set x(param1:Number) : void {
         this._x = param1;
      }

      public function get y() : Number {
         return this._y;
      }

      public function set y(param1:Number) : void {
         this._y = param1;
      }

      public function get scaleX() : Number {
         return this._scaleX;
      }

      public function set scaleX(param1:Number) : void {
         this._scaleX = param1;
      }

      public function get scaleY() : Number {
         return this._scaleY;
      }

      public function set scaleY(param1:Number) : void {
         this._scaleY = param1;
      }

      public function get alpha() : Number {
         return this._alpha;
      }

      public function set alpha(param1:Number) : void {
         this._alpha = param1 * 100;
      }

      public function get rotation() : Number {
         return this._rotation;
      }

      public function set rotation(param1:Number) : void {
         this._rotation = param1;
      }

      public function get argsForOnComplete() : Object {
         return this._argsForOnComplete;
      }

      public function set argsForOnComplete(param1:Object) : void {
         this._argsForOnComplete = param1;
      }

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         if(typeof param2 == "function")
         {
            this[param1] = param2;
            return false;
         }
         return true;
      }

      override protected function onDispose() : void {
         this._target = null;
         super.onDispose();
      }
   }

}