package net.wg.gui.lobby.header
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ServerVO extends DAAPIDataClass
    {
        
        public function ServerVO(param1:Object) {
            super(param1);
        }
        
        private var _label:String = "";
        
        private var _id:int = 0;
        
        private var _selected:Boolean = false;
        
        public function get label() : String {
            return this._label;
        }
        
        public function set label(param1:String) : void {
            this._label = param1;
        }
        
        public function get id() : int {
            return this._id;
        }
        
        public function set id(param1:int) : void {
            this._id = param1;
        }
        
        public function get selected() : Boolean {
            return this._selected;
        }
        
        public function set selected(param1:Boolean) : void {
            this._selected = param1;
        }
    }
}
