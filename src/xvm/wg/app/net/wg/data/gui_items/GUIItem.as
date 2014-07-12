package net.wg.data.gui_items
{
   public class GUIItem extends Object
   {
      
      public function GUIItem(param1:uint, param2:*) {
         super();
         this._itemTypeIdx = param1;
         this._id = param2;
      }
      
      protected var _itemTypeIdx:uint;
      
      protected var _id;
      
      public function toString() : String {
         return String(this._callMethod("toString"));
      }
      
      public function get itemTypeIdx() : uint {
         return this._itemTypeIdx;
      }
      
      public function get id() : * {
         return this._id;
      }
      
      protected function _getAttr(param1:String) : Object {
         return App.itemsMgr._getItemAttributeS(this._itemTypeIdx,this._id,param1);
      }
      
      protected function _callMethod(param1:String, ... rest) : Object {
         return App.itemsMgr._callItemMethodS(this._itemTypeIdx,this._id,param1,rest);
      }
   }
}
