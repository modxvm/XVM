package net.wg.gui.lobby.hangar 
{
    import net.wg.data.daapi.base.*;
    
    public class ParamsVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ParamsVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get param():String
        {
            return this._param;
        }

        public function set param(arg1:String):void
        {
            this._param = arg1;
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            this._text = arg1;
            return;
        }

        public function get selected():Boolean
        {
            return this._selected;
        }

        public function set selected(arg1:Boolean):void
        {
            this._selected = arg1;
            return;
        }

        internal var _param:String="";

        internal var _text:String="";

        internal var _selected:Boolean;
    }
}
