package net.wg.gui.utils
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.utils.Dictionary;
   import scaleform.clik.motion.Tween;


   public class ExcludeTweenManager extends Object implements IDisposable
   {
          
      public function ExcludeTweenManager() {
         super();
         this.currentTweens = new Dictionary(true);
      }

      private var currentTweens:Dictionary;

      public function registerAndLaunch(param1:Number, param2:Object, param3:Object, param4:Object) : Tween {
         var _loc5_:Tween = null;
         if(this.currentTweens[param2])
         {
            _loc5_ = Tween(this.currentTweens[param2]);
            _loc5_.paused = true;
            this.unregister(_loc5_);
         }
         _loc5_ = new Tween(param1,param2,param3,param4);
         this.currentTweens[param2] = _loc5_;
         return _loc5_;
      }

      public function unregister(param1:Tween) : void {
         if((this.currentTweens) && (this.currentTweens[param1.target]))
         {
            delete this.currentTweens[[param1.target]];
         }
      }

      public function unregisterAll() : void {
         var _loc1_:Object = null;
         var _loc2_:Tween = null;
         for (_loc1_ in this.currentTweens)
         {
            _loc2_ = Tween(this.currentTweens[_loc1_]);
            _loc2_.onComplete = null;
            _loc2_.onChange = null;
            _loc2_.paused = true;
            delete this.currentTweens[[_loc1_]];
         }
      }

      public function dispose() : void {
         this.unregisterAll();
         this.currentTweens = null;
      }
   }

}