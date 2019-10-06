package net.wg.gui.lobby.store.actions.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class StoreActionTimeVo extends DAAPIDataClass
    {

        public var id:String = "";

        public var isTimeOver:Boolean = false;

        public var timeLeft:String = "";

        public var isShowTimeIco:Boolean = false;

        public function StoreActionTimeVo(param1:Object = null)
        {
            super(param1);
        }
    }
}
