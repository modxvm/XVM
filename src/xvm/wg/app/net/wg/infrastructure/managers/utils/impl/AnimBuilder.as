package net.wg.infrastructure.managers.utils.impl
{
   import net.wg.utils.IAnimBuilder;
   import net.wg.utils.animation.ITweenConstruction;
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.ITweenConstructionHandler;
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.managers.utils.animation.impl.TweenConstruction;
   
   public class AnimBuilder extends Object implements IAnimBuilder
   {
      
      public function AnimBuilder() {
         super();
      }
      
      public function addFadeIn(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = "global") : ITweenConstruction {
         return this.createTweenConstruction(param1,param2).addFadeIn(param3,param4);
      }
      
      public function addFadeOut(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = "global") : ITweenConstruction {
         return this.createTweenConstruction(param1,param2).addFadeOut(param3,param4);
      }
      
      public function addMoveUp(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = "global") : ITweenConstruction {
         return this.createTweenConstruction(param1,param2).addMoveUp(param3,param4);
      }
      
      public function addMoveDown(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = "global") : ITweenConstruction {
         return this.createTweenConstruction(param1,param2).addMoveDown(param3,param4);
      }
      
      public function addGlowIn(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = "global") : ITweenConstruction {
         return this.createTweenConstruction(param1,param2).addGlowIn(param3,param4);
      }
      
      public function addGlowOut(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = "global") : ITweenConstruction {
         return this.createTweenConstruction(param1,param2).addGlowOut(param3,param4);
      }
      
      public function addShadowIn(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = "global") : ITweenConstruction {
         return this.createTweenConstruction(param1,param2).addShadowIn(param3,param4);
      }
      
      public function addShadowOut(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = "global") : ITweenConstruction {
         return this.createTweenConstruction(param1,param2).addShadowOut(param3,param4);
      }
      
      public function addTween(param1:String, param2:int, param3:ITween, param4:DisplayObject, param5:ITweenConstructionHandler) : ITweenConstruction {
         return this.createTweenConstruction(param4,param5).addTween(param3,param2,param1);
      }
      
      public function addHalfTurn(param1:DisplayObject, param2:ITweenConstructionHandler, param3:int, param4:String = "global") : ITweenConstruction {
         return this.createTweenConstruction(param1,param2).addHalfTurn(param3,param4);
      }
      
      private function createTweenConstruction(param1:DisplayObject, param2:ITweenConstructionHandler) : ITweenConstruction {
         return new TweenConstruction(param1,param2);
      }
   }
}
