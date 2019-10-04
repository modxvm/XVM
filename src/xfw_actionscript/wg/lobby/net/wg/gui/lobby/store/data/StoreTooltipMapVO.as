package net.wg.gui.lobby.store.data
{
    public class StoreTooltipMapVO extends Object
    {

        private var _vehId:String = null;

        private var _shellId:String = null;

        private var _defaultId:String = null;

        private var _battleBoosterId:String = null;

        public function StoreTooltipMapVO(param1:String, param2:String, param3:String, param4:String = null)
        {
            super();
            this._vehId = param1;
            this._shellId = param2;
            this._defaultId = param3;
            this._battleBoosterId = param4;
        }

        public function get vehId() : String
        {
            return this._vehId;
        }

        public function get shellId() : String
        {
            return this._shellId;
        }

        public function get defaultId() : String
        {
            return this._defaultId;
        }

        public function get battleBoosterId() : String
        {
            return this._battleBoosterId;
        }
    }
}
