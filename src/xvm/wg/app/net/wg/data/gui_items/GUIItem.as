package net.wg.data.gui_items 
{
    public class GUIItem extends Object
    {
        public function GUIItem(arg1:uint, arg2:*)
        {
            super();
            this._itemTypeIdx = arg1;
            this._id = arg2;
            return;
        }

        protected function _getAttr(arg1:String):Object
        {
            return App.itemsMgr._getItemAttributeS(this._itemTypeIdx, this._id, arg1);
        }

        protected function _callMethod(arg1:String, ... rest):Object
        {
            return App.itemsMgr._callItemMethodS(this._itemTypeIdx, this._id, arg1, rest);
        }

        public function get itemTypeIdx():uint
        {
            return this._itemTypeIdx;
        }

        public function get id():*
        {
            return this._id;
        }

        public function toString():String
        {
            return String(this._callMethod("toString"));
        }

        protected var _itemTypeIdx:uint;

        protected var _id:*;
    }
}
