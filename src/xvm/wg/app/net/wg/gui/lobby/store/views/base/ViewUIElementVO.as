package net.wg.gui.lobby.store.views.base
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.controls.Button;
   import net.wg.utils.IAssertable;
   import net.wg.data.constants.Errors;


   public class ViewUIElementVO extends Object implements IDisposable
   {
          
      public function ViewUIElementVO(param1:String, param2:Button) {
         var _loc3_:IAssertable = null;
         super();
         if(App.instance)
         {
            _loc3_ = App.utils.asserter;
            _loc3_.assertNotNull(param1,"name" + Errors.CANT_NULL);
            _loc3_.assertNotNull(param2,"instance" + Errors.CANT_NULL);
         }
         this._name = param1;
         this._instance = param2;
      }

      private var _name:String = null;

      private var _instance:Button = null;

      public function dispose() : void {
         this._instance = null;
         this._name = null;
      }

      public function get name() : String {
         return this._name;
      }

      public function get instance() : Button {
         return this._instance;
      }
   }

}