package net.wg.data.managers.impl
{
   import net.wg.infrastructure.base.meta.impl.TweenMeta;
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.utils.IAssertable;
   import net.wg.data.constants.Errors;
   import org.idmedia.as3commons.lang.IllegalStateException;
   import net.wg.data.constants.TweenActionsOnRemove;


   public class Tween extends TweenMeta implements ITween
   {
          
      public function Tween(param1:ITweenPropertiesVO) {
         super();
         var _loc2_:IAssertable = App.utils.asserter;
         _loc2_.assertNotNull(param1,"props in Tween " + Errors.CANT_NULL);
         _loc2_.assertNotNull(param1.target,"_props.target in Tween " + Errors.CANT_NULL);
         _loc2_.assertNotNull(param1.target.stage,"target.stage in Tween " + Errors.CANT_NULL);
         _loc2_.assertNotNull(param1.duration,"_props.duration " + Errors.CANT_NULL);
         if(param1.onComplete != null)
         {
            this.setOnAnimComplete(param1.onComplete,param1.argsForOnComplete);
         }
         this._props = param1;
      }

      private var _props:ITweenPropertiesVO = null;

      private var _onAnimComplete:Function = null;

      private var _argsForAnimComplete:Object = null;

      public function getTargetDisplayObject() : DisplayObject {
         return this._props.target;
      }

      public function getOnAnimComplete() : Function {
         return this._onAnimComplete;
      }

      public function setOnAnimComplete(param1:Function, param2:Object=null) : void {
         this._onAnimComplete = param1;
         this._argsForAnimComplete = param2;
      }

      public function onAnimComplete() : void {
         if(this._onAnimComplete != null)
         {
            if(this._argsForAnimComplete != null)
            {
               this._onAnimComplete(this._argsForAnimComplete);
            }
            else
            {
               this._onAnimComplete();
            }
         }
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         initialiazeS(this._props);
         this._props.target.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }

      override protected function onDispose() : void {
         var _loc1_:IAssertable = App.utils.asserter;
         _loc1_.assertNotNull(this._props,"props in Tween " + Errors.CANT_NULL);
         _loc1_.assertNotNull(this._props.target,"_props.target in Tween " + Errors.CANT_NULL);
         this._props.target.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this._props.dispose();
         this._props = null;
         super.onDispose();
      }

      private function onRemovedFromStage(param1:Event) : void {
         var _loc2_:String = null;
         switch(this._props.actionAfterRemoveFromStage)
         {
            case TweenActionsOnRemove.STOP:
               setPausedS(true);
               break;
            case TweenActionsOnRemove.NOT_TO_PROCESS:
               break;
            default:
               _loc2_ = "unknown actionAfterRemoveFromStage value: " + this._props.actionAfterRemoveFromStage;
               throw new IllegalStateException(_loc2_);
         }
      }
   }

}