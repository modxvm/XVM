package net.wg.data.utilData
{
   import net.wg.data.gui_items.Tankman;


   public class TankmanSlot extends Object
   {
          
      public function TankmanSlot(param1:uint, param2:uint=undefined) {
         super();
         this._roleName = param1;
         this._tankmanInvID = param2;
      }

      private var _roleName:uint;

      private var _tankmanInvID:uint;

      public function get roleName() : uint {
         return this._roleName;
      }

      public function get tankman() : Tankman {
         if(this._tankmanInvID != -1)
         {
            return new Tankman(this._tankmanInvID);
         }
         return null;
      }
   }

}