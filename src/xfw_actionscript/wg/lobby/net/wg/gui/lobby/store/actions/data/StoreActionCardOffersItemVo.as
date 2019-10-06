package net.wg.gui.lobby.store.actions.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class StoreActionCardOffersItemVo extends DAAPIDataClass
    {

        public var icon:String = "";

        public var additionalIcon:String = "";

        public var title:String = "";

        public var discount:String = "";

        public var price:String = "";

        public function StoreActionCardOffersItemVo(param1:Object = null)
        {
            super(param1);
        }
    }
}
