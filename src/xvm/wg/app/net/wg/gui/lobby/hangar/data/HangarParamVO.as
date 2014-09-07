package net.wg.gui.lobby.hangar.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class HangarParamVO extends DAAPIDataClass
    {
        
        public function HangarParamVO(param1:Object)
        {
            super(param1);
        }
        
        private var _param:String = "";
        
        private var _text:String = "";
        
        private var _selected:Boolean;
        
        public function get param() : String
        {
            return this._param;
        }
        
        public function set param(param1:String) : void
        {
            this._param = param1;
        }
        
        public function get text() : String
        {
            return this._text;
        }
        
        public function set text(param1:String) : void
        {
            this._text = param1;
        }
        
        public function get selected() : Boolean
        {
            return this._selected;
        }
        
        public function set selected(param1:Boolean) : void
        {
            this._selected = param1;
        }
    }
}
