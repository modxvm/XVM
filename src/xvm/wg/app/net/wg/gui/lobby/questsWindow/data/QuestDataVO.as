package net.wg.gui.lobby.questsWindow.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class QuestDataVO extends DAAPIDataClass
    {
        
        public function QuestDataVO(param1:Object) {
            this._award = [];
            super(param1);
        }
        
        private var _header:HeaderDataVO = null;
        
        private var _award:Array;
        
        private var _requirements:Object = null;
        
        private var _conditions:Object = null;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean {
            switch(param1)
            {
                case "header":
                    this._header = param2?new HeaderDataVO(param2):null;
                    return false;
                default:
                    return true;
            }
        }
        
        public function get header() : HeaderDataVO {
            return this._header;
        }
        
        public function set header(param1:HeaderDataVO) : void {
            this._header = param1;
        }
        
        override protected function onDispose() : void {
            if(this._header)
            {
                this._header.dispose();
                this._header = null;
            }
            if(this._award)
            {
                this._award.splice(0,this._award.length);
                this._award = null;
            }
            super.onDispose();
        }
        
        public function get requirements() : Object {
            return this._requirements;
        }
        
        public function set requirements(param1:Object) : void {
            this._requirements = param1;
        }
        
        public function get conditions() : Object {
            return this._conditions;
        }
        
        public function set conditions(param1:Object) : void {
            this._conditions = param1;
        }
        
        public function get award() : Array {
            return this._award;
        }
        
        public function set award(param1:Array) : void {
            this._award = param1;
        }
    }
}
