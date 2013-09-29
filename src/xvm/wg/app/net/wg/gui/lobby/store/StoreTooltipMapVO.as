package net.wg.gui.lobby.store 
{
    public class StoreTooltipMapVO extends Object
    {
        public function StoreTooltipMapVO(arg1:String, arg2:String, arg3:String)
        {
            super();
            this._vehId = arg1;
            this._shellId = arg2;
            this._defaultId = arg3;
            return;
        }

        public function get vehId():String
        {
            return this._vehId;
        }

        public function get shellId():String
        {
            return this._shellId;
        }

        public function get defaultId():String
        {
            return this._defaultId;
        }

        internal var _vehId:String=null;

        internal var _shellId:String=null;

        internal var _defaultId:String=null;
    }
}
