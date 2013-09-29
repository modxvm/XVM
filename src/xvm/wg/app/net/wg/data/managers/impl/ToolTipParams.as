package net.wg.data.managers.impl 
{
    import net.wg.data.managers.*;
    
    public class ToolTipParams extends Object implements net.wg.data.managers.IToolTipParams
    {
        public function ToolTipParams(arg1:Object=null, arg2:Object=null, arg3:Object=null)
        {
            super();
            this._header = arg1;
            this._body = arg2;
            this._note = arg3;
            return;
        }

        public function get header():Object
        {
            return this._header;
        }

        public function set header(arg1:Object):void
        {
            this._header = arg1;
            return;
        }

        public function get body():Object
        {
            return this._body;
        }

        public function set body(arg1:Object):void
        {
            this._body = arg1;
            return;
        }

        public function get note():Object
        {
            return this._note;
        }

        public function set note(arg1:Object):void
        {
            this._note = this.note;
            return;
        }

        internal var _header:Object;

        internal var _body:Object;

        internal var _note:Object;
    }
}
