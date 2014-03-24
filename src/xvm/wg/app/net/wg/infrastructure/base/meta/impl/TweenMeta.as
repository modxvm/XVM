package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   import net.wg.data.constants.Errors;
   import flash.display.DisplayObject;


   public class TweenMeta extends BaseDAAPIComponent
   {
          
      public function TweenMeta() {
         super();
      }

      public var initialiaze:Function = null;

      public var creatTweenPY:Function = null;

      public var getPaused:Function = null;

      public var setPaused:Function = null;

      public var getLoop:Function = null;

      public var setLoop:Function = null;

      public var getDuration:Function = null;

      public var setDuration:Function = null;

      public var getPosition:Function = null;

      public var setPosition:Function = null;

      public var getDelay:Function = null;

      public var setDelay:Function = null;

      public var setEasy:Function = null;

      public var getEasy:Function = null;

      public var getFinishScaleX:Function = null;

      public var setFinishScaleX:Function = null;

      public var getFinishScaleY:Function = null;

      public var setFinishScaleY:Function = null;

      public var getFinishX:Function = null;

      public var setFinishX:Function = null;

      public var getFinishY:Function = null;

      public var setFinishY:Function = null;

      public var getFinishAlpha:Function = null;

      public var setFinishAlpha:Function = null;

      public var getFinishRotation:Function = null;

      public var setFinishRotation:Function = null;

      public var resetAnim:Function = null;

      public var getTweenIdx:Function = null;

      public var getIsComplete:Function = null;

      public function initialiazeS(param1:ITweenPropertiesVO) : void {
         App.utils.asserter.assertNotNull(this.initialiaze,"initialiaze" + Errors.CANT_NULL);
         this.initialiaze(param1);
      }

      public function creatTweenPYS(param1:DisplayObject) : void {
         App.utils.asserter.assertNotNull(this.creatTweenPY,"creatTweenPY" + Errors.CANT_NULL);
         this.creatTweenPY(param1);
      }

      public function getPausedS() : Boolean {
         App.utils.asserter.assertNotNull(this.getPaused,"getPaused" + Errors.CANT_NULL);
         return this.getPaused();
      }

      public function setPausedS(param1:Boolean) : void {
         App.utils.asserter.assertNotNull(this.setPaused,"setPaused" + Errors.CANT_NULL);
         this.setPaused(param1);
      }

      public function getLoopS() : Boolean {
         App.utils.asserter.assertNotNull(this.getLoop,"getLoop" + Errors.CANT_NULL);
         return this.getLoop();
      }

      public function setLoopS(param1:Boolean) : void {
         App.utils.asserter.assertNotNull(this.setLoop,"setLoop" + Errors.CANT_NULL);
         this.setLoop(param1);
      }

      public function getDurationS() : uint {
         App.utils.asserter.assertNotNull(this.getDuration,"getDuration" + Errors.CANT_NULL);
         return this.getDuration();
      }

      public function setDurationS(param1:uint) : void {
         App.utils.asserter.assertNotNull(this.setDuration,"setDuration" + Errors.CANT_NULL);
         this.setDuration(param1);
      }

      public function getPositionS() : uint {
         App.utils.asserter.assertNotNull(this.getPosition,"getPosition" + Errors.CANT_NULL);
         return this.getPosition();
      }

      public function setPositionS(param1:uint) : void {
         App.utils.asserter.assertNotNull(this.setPosition,"setPosition" + Errors.CANT_NULL);
         this.setPosition(param1);
      }

      public function getDelayS() : uint {
         App.utils.asserter.assertNotNull(this.getDelay,"getDelay" + Errors.CANT_NULL);
         return this.getDelay();
      }

      public function setDelayS(param1:uint) : void {
         App.utils.asserter.assertNotNull(this.setDelay,"setDelay" + Errors.CANT_NULL);
         this.setDelay(param1);
      }

      public function setEasyS(param1:Function) : void {
         App.utils.asserter.assertNotNull(this.setEasy,"setEasy" + Errors.CANT_NULL);
         this.setEasy(param1);
      }

      public function getEasyS() : Function {
         App.utils.asserter.assertNotNull(this.getEasy,"getEasy" + Errors.CANT_NULL);
         return this.getEasy();
      }

      public function getFinishScaleXS() : Number {
         App.utils.asserter.assertNotNull(this.getFinishScaleX,"getFinishScaleX" + Errors.CANT_NULL);
         return this.getFinishScaleX();
      }

      public function setFinishScaleXS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.setFinishScaleX,"setFinishScaleX" + Errors.CANT_NULL);
         this.setFinishScaleX(param1);
      }

      public function getFinishScaleYS() : Number {
         App.utils.asserter.assertNotNull(this.getFinishScaleY,"getFinishScaleY" + Errors.CANT_NULL);
         return this.getFinishScaleY();
      }

      public function setFinishScaleYS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.setFinishScaleY,"setFinishScaleY" + Errors.CANT_NULL);
         this.setFinishScaleY(param1);
      }

      public function getFinishXS() : uint {
         App.utils.asserter.assertNotNull(this.getFinishX,"getFinishX" + Errors.CANT_NULL);
         return this.getFinishX();
      }

      public function setFinishXS(param1:uint) : void {
         App.utils.asserter.assertNotNull(this.setFinishX,"setFinishX" + Errors.CANT_NULL);
         this.setFinishX(param1);
      }

      public function getFinishYS() : uint {
         App.utils.asserter.assertNotNull(this.getFinishY,"getFinishY" + Errors.CANT_NULL);
         return this.getFinishY();
      }

      public function setFinishYS(param1:uint) : void {
         App.utils.asserter.assertNotNull(this.setFinishY,"setFinishY" + Errors.CANT_NULL);
         this.setFinishY(param1);
      }

      public function getFinishAlphaS() : uint {
         App.utils.asserter.assertNotNull(this.getFinishAlpha,"getFinishAlpha" + Errors.CANT_NULL);
         return this.getFinishAlpha();
      }

      public function setFinishAlphaS(param1:uint) : void {
         App.utils.asserter.assertNotNull(this.setFinishAlpha,"setFinishAlpha" + Errors.CANT_NULL);
         this.setFinishAlpha(param1);
      }

      public function getFinishRotationS() : Number {
         App.utils.asserter.assertNotNull(this.getFinishRotation,"getFinishRotation" + Errors.CANT_NULL);
         return this.getFinishRotation();
      }

      public function setFinishRotationS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.setFinishRotation,"setFinishRotation" + Errors.CANT_NULL);
         this.setFinishRotation(param1);
      }

      public function resetAnimS() : void {
         App.utils.asserter.assertNotNull(this.resetAnim,"resetAnim" + Errors.CANT_NULL);
         this.resetAnim();
      }

      public function getTweenIdxS() : uint {
         App.utils.asserter.assertNotNull(this.getTweenIdx,"getTweenIdx" + Errors.CANT_NULL);
         return this.getTweenIdx();
      }

      public function getIsCompleteS() : Boolean {
         App.utils.asserter.assertNotNull(this.getIsComplete,"getIsComplete" + Errors.CANT_NULL);
         return this.getIsComplete();
      }
   }

}