package net.wg.gui.lobby.fortifications.data.base
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class BaseFortificationVO extends DAAPIDataClass
    {
        
        public function BaseFortificationVO(param1:Object) {
            super(param1);
        }
        
        private var _isCommander:Boolean = false;
        
        private var _level:uint = 0;
        
        private var _clanSize:uint = 0;
        
        private var _minClanSize:uint = 0;
        
        private var _clanCommanderName:String = "";
        
        public function get clanSize() : uint {
            return this._clanSize;
        }
        
        public function set clanSize(param1:uint) : void {
            this._clanSize = param1;
        }
        
        public function get minClanSize() : uint {
            return this._minClanSize;
        }
        
        public function set minClanSize(param1:uint) : void {
            this._minClanSize = param1;
        }
        
        public function get clanCommanderName() : String {
            return this._clanCommanderName;
        }
        
        public function set clanCommanderName(param1:String) : void {
            this._clanCommanderName = param1;
        }
        
        public function get isCommander() : Boolean {
            return this._isCommander;
        }
        
        public function set isCommander(param1:Boolean) : void {
            this._isCommander = param1;
        }
        
        public function get level() : uint {
            return this._level;
        }
        
        public function set level(param1:uint) : void {
            this._level = param1;
        }
    }
}
