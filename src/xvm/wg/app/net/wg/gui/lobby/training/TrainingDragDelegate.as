package net.wg.gui.lobby.training
{
   import net.wg.infrastructure.helpers.DropListDelegate;
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.entity.IDropItem;


   public class TrainingDragDelegate extends DropListDelegate
   {
          
      public function TrainingDragDelegate(param1:InteractiveObject, param2:String) {
         super(param1,param2);
      }

      override public function onStartDrop(param1:InteractiveObject, param2:InteractiveObject, param3:Number, param4:Number) : Boolean {
         var _loc5_:IUpdatable = null;
         super.onStartDrop(param1,param2,param3,param4);
         if(App.instance)
         {
            _loc5_ = App.cursor.getAttachedSprite() as IUpdatable;
            if(_loc5_)
            {
               App.utils.asserter.assertNotNull(_loc5_,"cursor.attachedSprite" + Errors.CANT_NULL);
               IUpdatable(_loc5_).update(IDropItem(param2).data);
            }
            else
            {
               DebugUtils.LOG_ERROR("attached sprite must implements IUpdatable interface.");
            }
         }
         return true;
      }
   }

}