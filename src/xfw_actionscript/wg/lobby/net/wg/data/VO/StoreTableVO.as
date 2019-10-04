package net.wg.data.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.lobby.components.data.InfoMessageVO;

    public class StoreTableVO extends DAAPIDataClass
    {

        private static const NO_ITEMS_INFO_FIELD_NAME:String = "noItemsInfo";

        public var type:String = "";

        public var showNoItemsInfo:Boolean = false;

        public var noItemsInfo:InfoMessageVO = null;

        public function StoreTableVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == NO_ITEMS_INFO_FIELD_NAME && param2 != null)
            {
                this.noItemsInfo = new InfoMessageVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.noItemsInfo != null)
            {
                this.noItemsInfo.dispose();
                this.noItemsInfo = null;
            }
            super.onDispose();
        }
    }
}
