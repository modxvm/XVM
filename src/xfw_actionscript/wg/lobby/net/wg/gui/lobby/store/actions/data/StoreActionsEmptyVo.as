package net.wg.gui.lobby.store.actions.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class StoreActionsEmptyVo extends DAAPIDataClass
    {

        public var info:String = "";

        public var btnLabel:String = "";

        public function StoreActionsEmptyVo(param1:Object = null)
        {
            super(param1);
        }
    }
}
