package net.wg.data.VO 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class SellDialogItem extends Object implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function SellDialogItem()
        {
            super();
            this._elements = new Vector.<net.wg.data.VO.SellDialogElement>();
            return;
        }

        public function get header():String
        {
            return this._header;
        }

        public function set header(arg1:String):void
        {
            this._header = arg1;
            return;
        }

        public function get elements():__AS3__.vec.Vector.<net.wg.data.VO.SellDialogElement>
        {
            return this._elements;
        }

        public function set elements(arg1:__AS3__.vec.Vector.<net.wg.data.VO.SellDialogElement>):void
        {
            this._elements = arg1;
            return;
        }

        public function dispose():void
        {
            this._elements.splice(0, this._elements.length);
            return;
        }

        internal var _elements:__AS3__.vec.Vector.<net.wg.data.VO.SellDialogElement>;

        internal var _header:String;
    }
}
