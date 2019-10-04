package net.wg.gui.lobby.boosters.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class BoostersWindowStaticVO extends DAAPIDataClass
    {

        private static const FILTERS_DATA_FIELD_NAME:String = "filtersData";

        public var windowTitle:String = "";

        public var closeBtnLabel:String = "";

        public var noInfoBgSource:String = "";

        public var filtersData:BoostersWindowFiltersVO;

        public function BoostersWindowStaticVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == FILTERS_DATA_FIELD_NAME)
            {
                this.filtersData = new BoostersWindowFiltersVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            this.filtersData.dispose();
            this.filtersData = null;
            super.onDispose();
        }
    }
}
