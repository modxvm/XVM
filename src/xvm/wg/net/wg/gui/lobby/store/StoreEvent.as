package net.wg.gui.lobby.store 
{
    import flash.events.*;
    import net.wg.data.VO.*;
    
    public class StoreEvent extends flash.events.Event
    {
        public function StoreEvent(arg1:String, arg2:net.wg.data.VO.StoreTableData)
        {
            super(arg1, true, true);
            this._data = arg2;
            return;
        }

        public function get data():net.wg.data.VO.StoreTableData
        {
            return this._data;
        }

        public static const BUY:String="storeBuy";

        public static const SELL:String="storeSell";

        public static const INFO:String="storeInfo";

        internal var _data:net.wg.data.VO.StoreTableData=null;
    }
}
