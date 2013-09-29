package net.wg.gui.lobby.questsWindow.data 
{
    import net.wg.data.daapi.base.*;
    
    public class ComplexTooltipVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ComplexTooltipVO(arg1:Object)
        {
            super(arg1);
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

        public function get body():String
        {
            return this._body;
        }

        public function set body(arg1:String):void
        {
            this._body = arg1;
            return;
        }

        public function get note():String
        {
            return this._note;
        }

        public function set note(arg1:String):void
        {
            this._note = arg1;
            return;
        }

        internal var _header:String="";

        internal var _body:String="";

        internal var _note:String="";
    }
}
