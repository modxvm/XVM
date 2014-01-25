package net.wg.gui.components.common.containers
{
   import net.wg.infrastructure.interfaces.IBaseLayout;


   public class GroupLayout extends Object implements IBaseLayout
   {
          
      public function GroupLayout() {
         super();
      }

      protected var _target:Group;

      public function set target(param1:Object) : void {
         this._target = Group(param1);
      }

      public function invokeLayout() : Object {
         return null;
      }

      public function dispose() : void {
         this._target = null;
      }

      public function get target() : Object {
         return this._target;
      }
   }

}