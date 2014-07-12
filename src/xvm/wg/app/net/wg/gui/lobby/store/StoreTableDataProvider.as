package net.wg.gui.lobby.store
{
    import net.wg.data.daapi.base.DAAPIDataProvider;
    import net.wg.data.VO.StoreTableVO;
    import net.wg.data.VO.StoreTableData;
    
    public class StoreTableDataProvider extends DAAPIDataProvider
    {
        
        public function StoreTableDataProvider() {
            super();
        }
        
        private var _tableVO:StoreTableVO = null;
        
        private var _type:String = "";
        
        override public function requestItemAt(param1:uint, param2:Function = null) : Object {
            var _loc4_:StoreTableData = null;
            var _loc3_:Object = requestItemAtHandler(param1);
            if(_loc3_ != null)
            {
                _loc4_ = new StoreTableData(_loc3_);
                _loc4_.requestType = this._type;
                _loc4_.tableVO = this._tableVO;
            }
            else
            {
                _loc4_ = null;
            }
            if(param2 != null)
            {
                param2(_loc4_);
            }
            return _loc4_;
        }
        
        override public function requestItemRange(param1:int, param2:int, param3:Function = null) : Array {
            var _loc6_:StoreTableData = null;
            var _loc7_:Object = null;
            if(!Boolean(requestItemRangeHandler))
            {
                return [];
            }
            var _loc4_:Array = requestItemRangeHandler(param1,param2);
            var _loc5_:Array = [];
            for each(_loc7_ in _loc4_)
            {
                _loc6_ = new StoreTableData(_loc7_);
                _loc6_.requestType = this._type;
                _loc6_.tableVO = this._tableVO;
                _loc5_.push(_loc6_);
            }
            if(param3 != null)
            {
                param3(_loc5_);
            }
            return _loc5_;
        }
        
        public function get tableVO() : StoreTableVO {
            return this._tableVO;
        }
        
        public function set tableVO(param1:StoreTableVO) : void {
            this._tableVO = param1;
        }
        
        public function get type() : String {
            return this._type;
        }
        
        public function set type(param1:String) : void {
            this._type = param1;
        }
    }
}
