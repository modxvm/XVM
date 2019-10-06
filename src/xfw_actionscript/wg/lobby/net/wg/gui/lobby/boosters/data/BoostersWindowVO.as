package net.wg.gui.lobby.boosters.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.components.data.InfoMessageVO;

    public class BoostersWindowVO extends DAAPIDataClass
    {

        private static const NO_INFO_DATA_FIELD_NAME:String = "noInfoData";

        private static const TABS_LABELS_FIELD_NAME:String = "tabsLabels";

        public var tabsLabels:DataProvider = null;

        public var activeText:String = "";

        public var isHaveNotInfo:Boolean = true;

        public var noInfoData:InfoMessageVO;

        public var tabIndex:int = -1;

        public var filterState:int = -1;

        public function BoostersWindowVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == NO_INFO_DATA_FIELD_NAME && param2 != null)
            {
                this.noInfoData = new InfoMessageVO(param2);
                return false;
            }
            if(param1 == TABS_LABELS_FIELD_NAME && param2)
            {
                this.tabsLabels = new DataProvider(param2 as Array);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.noInfoData != null)
            {
                this.noInfoData.dispose();
                this.noInfoData = null;
            }
            this.tabsLabels.cleanUp();
            this.tabsLabels = null;
            super.onDispose();
        }
    }
}
