package net.wg.gui.lobby.questsWindow.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class QuestDashlineItemVO extends DAAPIDataClass
    {
        
        public function QuestDashlineItemVO(param1:Object) {
            super(param1);
        }
        
        private var _label:String = "";
        
        private var _linkID:String = "";
        
        private var _isNotAvailable:Boolean = false;
        
        private var _value:String = "";
        
        private var _linkage:String = "";
        
        public function get label() : String {
            return this._label;
        }
        
        public function set label(param1:String) : void {
            this._label = param1;
        }
        
        public function get linkID() : String {
            return this._linkID;
        }
        
        public function set linkID(param1:String) : void {
            this._linkID = param1;
        }
        
        public function get isNotAvailable() : Boolean {
            return this._isNotAvailable;
        }
        
        public function set isNotAvailable(param1:Boolean) : void {
            this._isNotAvailable = param1;
        }
        
        public function get value() : String {
            return this._value;
        }
        
        public function set value(param1:String) : void {
            this._value = param1;
        }
        
        public function get linkage() : String {
            return this._linkage;
        }
        
        public function set linkage(param1:String) : void {
            this._linkage = param1;
        }
    }
}
