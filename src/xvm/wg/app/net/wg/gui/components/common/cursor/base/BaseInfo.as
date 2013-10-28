package net.wg.gui.components.common.cursor.base
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.interfaces.entity.IDragDropHitArea;
   import net.wg.utils.IAssertable;
   import net.wg.data.constants.Errors;


   public class BaseInfo extends Object implements IDisposable
   {
          
      public function BaseInfo(param1:IDragDropHitArea, param2:String, param3:String) {
         super();
         var _loc4_:* = "drag or drop object must be InteractiveObject";
         var _loc5_:IAssertable = App.utils.asserter;
         _loc5_.assertNotNull(param1,"dragDropObject" + Errors.CANT_NULL);
         _loc5_.assert(param1  is  InteractiveObject,_loc4_);
         this._container = param1;
         this._cursor = param2?param2:param3;
      }

      public static const STATE_NONE:String = "none";

      public static const STATE_INITIALIZED:String = "initialized";

      public static const STATE_STARTED:String = "started";

      public static function getHitFromContainer(param1:IDragDropHitArea) : InteractiveObject {
         var _loc2_:InteractiveObject = param1.getHitArea();
         return _loc2_?_loc2_:InteractiveObject(param1);
      }

      private var _cursor:String = null;

      private var _container:IDragDropHitArea = null;

      private var _processState:String = "none";

      public function dispose() : void {
         this._cursor = null;
         this._container = null;
         this._processState = null;
      }

      public function get hit() : InteractiveObject {
         return BaseInfo.getHitFromContainer(this._container);
      }

      public function get cursor() : String {
         return this._cursor;
      }

      public function set state(param1:String) : void {
         App.utils.asserter.assert(!([STATE_NONE,STATE_INITIALIZED,STATE_STARTED].indexOf(param1) == -1),"unknown drag state:" + param1);
         this._processState = param1;
      }

      public function get state() : String {
         return this._processState;
      }

      protected final function getContainer() : IDragDropHitArea {
         return this._container;
      }

      protected final function getCursor() : String {
         return this._cursor;
      }
   }

}