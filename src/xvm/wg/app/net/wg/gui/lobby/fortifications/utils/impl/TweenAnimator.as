package net.wg.gui.lobby.fortifications.utils.impl
{
   import net.wg.utils.ITweenAnimator;
   import flash.display.DisplayObject;
   import net.wg.utils.IAssertable;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.NullPointerException;
   import net.wg.data.constants.TweenTypes;
   import net.wg.infrastructure.interfaces.ITweenAnimatorHandler;
   import net.wg.data.constants.TweenConstraints;
   import net.wg.infrastructure.interfaces.ITween;
   import flash.geom.Point;
   import net.wg.data.VO.TweenPropertiesVO;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   import net.wg.utils.ITweenManager;
   import __AS3__.vec.*;


   public class TweenAnimator extends Object implements ITweenAnimator
   {
          
      public function TweenAnimator() {
         this.tweensData = new Vector.<TweenAnimator>(0);
         super();
      }

      private static var ms_instance:ITweenAnimator = null;

      public static function get instance() : ITweenAnimator {
         if(ms_instance == null)
         {
            ms_instance = new TweenAnimator();
         }
         return ms_instance;
      }

      private var tweensData:Vector.<TweenLinkedObjects>;

      public function blinkInfinity(param1:DisplayObject) : void {
         var _loc2_:IAssertable = this.getAsserter();
         var _loc3_:String = "element for blinking" + Errors.CANT_NULL;
         var _loc4_:* = "The element already blinks";
         _loc2_.assertNotNull(param1,_loc3_,NullPointerException);
         _loc2_.assert(this.checkTweenTypeInStack(TweenTypes.BLINK_IN,param1),_loc4_);
         this.createDirectAnim(param1);
         this.createReverseAnim(param1);
      }

      public function addFadeInAnim(param1:DisplayObject, param2:ITweenAnimatorHandler) : void {
         param1.visible = true;
         var _loc3_:ITween = this.addAlphaAnim(param1,TweenConstraints.FADE_DURATION,TweenConstraints.FADE_ALPHA_MIN,TweenConstraints.FADE_ALPHA_MAX,true);
         _loc3_.memberData = {"type":TweenTypes.FADE_IN};
         var _loc4_:* = "Fading for \'" + param1.name + "\' already exists!";
         this.getAsserter().assert(this.checkTweenTypeInStack(TweenTypes.FADE_IN,param1),_loc4_);
         this.tweensData.push(new TweenLinkedObjects(_loc3_,param1,param2));
      }

      public function addFadeInAnimEx(param1:DisplayObject) : ITween {
         var _loc2_:ITween = this.addAlphaAnim(param1,TweenConstraints.FADE_DURATION,TweenConstraints.FADE_ALPHA_MIN,TweenConstraints.FADE_ALPHA_MAX);
         _loc2_.memberData = {"type":TweenTypes.FADE_IN};
         return _loc2_;
      }

      public function addFadeOutAnim(param1:DisplayObject, param2:ITweenAnimatorHandler) : void {
         var _loc3_:ITween = this.addAlphaAnim(param1,TweenConstraints.FADE_DURATION,TweenConstraints.FADE_ALPHA_MAX,TweenConstraints.FADE_ALPHA_MIN,true);
         _loc3_.memberData = {"type":TweenTypes.FADE_OUT};
         var _loc4_:* = "Fading for \'" + param1.name + "\' already exists!";
         this.getAsserter().assert(this.checkTweenTypeInStack(TweenTypes.FADE_OUT,param1),_loc4_);
         this.tweensData.push(new TweenLinkedObjects(_loc3_,param1,param2));
      }

      public function addFadeOutAnimEx(param1:DisplayObject) : ITween {
         var _loc2_:ITween = this.addAlphaAnim(param1,TweenConstraints.FADE_DURATION,TweenConstraints.FADE_ALPHA_MAX,TweenConstraints.FADE_ALPHA_MIN);
         _loc2_.memberData = {"type":TweenTypes.FADE_OUT};
         return _loc2_;
      }

      public function removeAnims(param1:DisplayObject) : void {
         var _loc3_:TweenLinkedObjects = null;
         var _loc2_:int = this.tweensData.length-1;
         while(_loc2_ >= 0)
         {
            _loc3_ = this.tweensData[_loc2_];
            if(_loc3_.target == param1)
            {
               this.getTweenManager().disposeTweenS(_loc3_.tween);
               _loc3_.dispose();
               delete this.tweensData[[_loc2_]];
            }
            _loc2_--;
         }
      }

      public function addMoveUpAnim(param1:DisplayObject, param2:Number, param3:ITweenAnimatorHandler) : void {
         var _loc4_:* = "Moving for \'" + param1.name + "\' already exists!";
         var _loc5_:Point = new Point(param1.x,param2 + TweenConstraints.TRANSLATION_LENGTH);
         var _loc6_:Point = new Point(param1.x,param2);
         var _loc7_:ITween = this.addMoveAnim(param1,TweenConstraints.MOVE_DURATION,_loc5_,_loc6_,true);
         _loc7_.memberData = {"type":TweenTypes.MOVE_UP};
         this.getAsserter().assert(this.checkTweenTypeInStack(TweenTypes.MOVE_UP,param1),_loc4_);
         this.tweensData.push(new TweenLinkedObjects(_loc7_,param1,param3));
      }

      public function addMoveUpAnimEx(param1:DisplayObject, param2:Number) : ITween {
         var _loc3_:Point = new Point(param1.x,param2 + TweenConstraints.TRANSLATION_LENGTH);
         var _loc4_:Point = new Point(param1.x,param2);
         var _loc5_:ITween = this.addMoveAnim(param1,TweenConstraints.MOVE_DURATION,_loc3_,_loc4_);
         _loc5_.memberData = {"type":TweenTypes.MOVE_UP};
         return _loc5_;
      }

      public function addMoveDownAnim(param1:DisplayObject, param2:Number, param3:ITweenAnimatorHandler) : void {
         var _loc4_:* = "Moving for \'" + param1.name + "\' already exists!";
         var _loc5_:Point = new Point(param1.x,param2);
         var _loc6_:Point = new Point(param1.x,param2 + TweenConstraints.TRANSLATION_LENGTH);
         var _loc7_:ITween = this.addMoveAnim(param1,TweenConstraints.MOVE_DURATION,_loc5_,_loc6_,true);
         _loc7_.memberData = {"type":TweenTypes.MOVE_DOWN};
         this.getAsserter().assert(this.checkTweenTypeInStack(TweenTypes.MOVE_DOWN,param1),_loc4_);
         this.tweensData.push(new TweenLinkedObjects(_loc7_,param1,param3));
      }

      public function addMoveDownAnimEx(param1:DisplayObject, param2:Number) : ITween {
         var _loc3_:Point = new Point(param1.x,param2);
         var _loc4_:Point = new Point(param1.x,param2 + TweenConstraints.TRANSLATION_LENGTH);
         var _loc5_:ITween = this.addMoveAnim(param1,TweenConstraints.MOVE_DURATION,_loc3_,_loc4_);
         _loc5_.memberData = {"type":TweenTypes.MOVE_DOWN};
         return _loc5_;
      }

      public function addHalfTurnAnim(param1:DisplayObject) : void {
         var _loc2_:* = "Tween for \'" + param1.name + "\' already exists!";
         var _loc3_:ITween = this.addHalfTurnAnimEx(param1);
         _loc3_.setHandler(this);
         this.getAsserter().assert(this.checkTweenTypeInStack(TweenTypes.TURN_HALF,param1),_loc2_);
         this.tweensData.push(new TweenLinkedObjects(_loc3_,param1,null));
      }

      public function addHalfTurnAnimEx(param1:DisplayObject) : ITween {
         var _loc2_:ITweenPropertiesVO = new TweenPropertiesVO(
            {
               "target":param1,
               "duration":TweenConstraints.HALF_TURN_DURATION,
               "loop":false,
               "paused":false,
               "rotation":param1.rotation + 180,
               "position":0
            }
         );
         var _loc3_:ITween = this.getTweenManager().createNewTween(_loc2_);
         _loc3_.memberData = {"type":TweenTypes.TURN_HALF};
         return _loc3_;
      }

      public function onComplete(param1:ITween) : void {
         var _loc4_:TweenLinkedObjects = null;
         var _loc2_:Object = param1.memberData;
         var _loc3_:ITweenAnimatorHandler = this.tweensData[this.getIdxOfTweenDataByTween(param1)].handler;
         if(TweenTypes.SIMPLE_ANIM_TYPES.indexOf(_loc2_.type) >= 0)
         {
            if(_loc2_.type == TweenTypes.FADE_OUT)
            {
               _loc4_ = this.tweensData[this.getIdxOfTweenDataByTween(param1)];
               _loc4_.target.visible = false;
            }
            this.removeTween(param1);
         }
         if(_loc3_ != null)
         {
            _loc3_.onComplete();
         }
      }

      public function onStart(param1:ITween) : void {
          
      }

      public function dispose() : void {
         var _loc1_:TweenLinkedObjects = null;
         while(this.tweensData.length > 0)
         {
            _loc1_ = this.tweensData.pop();
            this.getTweenManager().disposeTweenS(_loc1_.tween);
            _loc1_.dispose();
         }
         ms_instance = null;
         this.tweensData = null;
      }

      public function createPropsForAlpha(param1:DisplayObject, param2:uint, param3:Number, param4:uint=0) : ITweenPropertiesVO {
         var _loc5_:ITweenPropertiesVO = new TweenPropertiesVO(
            {
               "target":param1,
               "duration":param2,
               "globalDelay":param4,
               "alpha":param3,
               "loop":false,
               "paused":true
            }
         );
         return _loc5_;
      }

      public function createPropsForFrameBasedAnim(param1:DisplayObject, param2:int, param3:int) : ITweenPropertiesVO {
         var _loc4_:ITweenPropertiesVO = new TweenPropertiesVO(
            {
               "target":param1,
               "duration":param2,
               "globalDelay":param3,
               "loop":false,
               "paused":true,
               "isOnCodeBased":false
            }
         );
         return _loc4_;
      }

      private function getAsserter() : IAssertable {
         return App.utils.asserter;
      }

      private function getTweenManager() : ITweenManager {
         return App.tweenMgr;
      }

      private function removeTween(param1:ITween) : void {
         var _loc3_:TweenLinkedObjects = null;
         var _loc2_:* = 0;
         while(_loc2_ < this.tweensData.length)
         {
            _loc3_ = this.tweensData[_loc2_];
            if(_loc3_.tween == param1)
            {
               this.getTweenManager().disposeTweenS(param1);
               _loc3_.dispose();
               delete this.tweensData[[_loc2_]];
            }
            _loc2_++;
         }
      }

      private function addAlphaAnim(param1:DisplayObject, param2:int, param3:Number, param4:Number, param5:Boolean=false) : ITween {
         var _loc6_:Number = param1.alpha;
         param1.alpha = param3;
         var _loc7_:ITweenManager = this.getTweenManager();
         var _loc8_:ITweenPropertiesVO = this.createPropsForAlpha(param1,param2,param4);
         if(param5)
         {
            _loc8_.setPaused(false);
            _loc8_.setHandler(this);
         }
         var _loc9_:ITween = _loc7_.createNewTween(_loc8_);
         param1.alpha = _loc6_;
         return _loc9_;
      }

      private function addMoveAnim(param1:DisplayObject, param2:int, param3:Point, param4:Point, param5:Boolean=false) : ITween {
         var _loc6_:Point = new Point(param1.x,param1.y);
         param1.x = param3.x;
         param1.y = param3.y;
         var _loc7_:ITweenPropertiesVO = new TweenPropertiesVO(
            {
               "target":param1,
               "duration":param2,
               "x":param4.x,
               "y":param4.y,
               "loop":false
            }
         );
         if(param5)
         {
            _loc7_.setHandler(this);
            _loc7_.setPaused(false);
         }
         var _loc8_:ITween = this.getTweenManager().createNewTween(_loc7_);
         param1.x = _loc6_.x;
         param1.y = _loc6_.y;
         return _loc8_;
      }

      private function checkTweenTypeInStack(param1:String, param2:DisplayObject) : Boolean {
         var _loc6_:Vector.<String> = null;
         var _loc7_:TweenLinkedObjects = null;
         var _loc8_:String = null;
         var _loc3_:String = "Not such type = " + param1;
         var _loc4_:Vector.<String> = null;
         if(_loc4_ == TweenTypes.FADE_TYPES)
         {
            _loc4_ = TweenTypes.BLINKING_TYPES;
            _loc4_.concat(TweenTypes.FADE_TYPES);
         }
         var _loc5_:* = 0;
         while(_loc5_ < TweenTypes.DURATIONS_BY_TYPES.length)
         {
            _loc6_ = TweenTypes.DURATIONS_BY_TYPES[_loc5_].types;
            if(_loc6_.indexOf(param1) >= 0)
            {
               _loc4_ = _loc6_;
               break;
            }
            _loc5_++;
         }
         this.getAsserter().assertNotNull(_loc4_,_loc3_);
         _loc5_ = 0;
         while(_loc5_ < this.tweensData.length)
         {
            _loc7_ = this.tweensData[_loc5_];
            _loc8_ = _loc7_.tween.memberData.type;
            if(this.tweensData[_loc5_].target != param2)
            {
               if(_loc7_.target == param2 && _loc4_.indexOf(_loc8_) >= 0)
               {
                  return false;
               }
            }
            _loc5_++;
         }
         return true;
      }

      private function createDirectAnim(param1:DisplayObject) : ITween {
         var _loc2_:ITween = this.createBlinkingAlpha(param1,TweenConstraints.FADE_ALPHA_MIN,TweenConstraints.FADE_ALPHA_MAX);
         if(param1.alpha == 0)
         {
            _loc2_.setPositionS(0);
         }
         _loc2_.memberData = {"type":TweenTypes.BLINK_IN};
         return _loc2_;
      }

      private function createReverseAnim(param1:DisplayObject) : ITween {
         var _loc2_:ITween = this.createBlinkingAlpha(param1,TweenConstraints.FADE_ALPHA_MAX,TweenConstraints.FADE_ALPHA_MIN);
         if(param1.alpha > 0)
         {
            _loc2_.setPositionS(0);
         }
         _loc2_.memberData = {"type":TweenTypes.BLINK_OUT};
         return _loc2_;
      }

      private function createBlinkingAlpha(param1:DisplayObject, param2:Number, param3:Number) : ITween {
         var _loc4_:ITween = this.addAlphaAnim(param1,TweenConstraints.BLINKING_DURATION,param2,param3);
         _loc4_.setDelayS(TweenConstraints.BLINKING_DURATION);
         _loc4_.setLoopS(true);
         _loc4_.setPausedS(false);
         this.tweensData.push(new TweenLinkedObjects(_loc4_,param1,null));
         return _loc4_;
      }

      private function getIdxOfTweenDataByTween(param1:ITween) : int {
         var _loc2_:uint = param1.getTweenIdxS();
         var _loc3_:* = 0;
         while(_loc3_ < this.tweensData.length)
         {
            if(this.tweensData[_loc3_].getTweenId() == _loc2_)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
   }

}   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.ITween;
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.ITweenAnimatorHandler;


   class TweenLinkedObjects extends Object implements IDisposable
   {
          
      function TweenLinkedObjects(param1:ITween, param2:DisplayObject, param3:ITweenAnimatorHandler) {
         super();
         this._tween = param1;
         this._target = param2;
         this._handler = param3;
      }

      private var _tween:ITween;

      private var _target:DisplayObject;

      private var _handler:ITweenAnimatorHandler;

      public function get tween() : ITween {
         return this._tween;
      }

      public function set tween(param1:ITween) : void {
         this._tween = param1;
      }

      public function get target() : DisplayObject {
         return this._target;
      }

      public function set target(param1:DisplayObject) : void {
         this._target = param1;
      }

      public function get handler() : ITweenAnimatorHandler {
         return this._handler;
      }

      public function set handler(param1:ITweenAnimatorHandler) : void {
         this._handler = param1;
      }

      public function getTweenId() : int {
         return this._tween.getTweenIdxS();
      }

      public function dispose() : void {
         this._tween = null;
         this._target = null;
         this._handler = null;
      }
   }
