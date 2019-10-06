package net.wg.gui.lobby.boosters.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.lobby.components.data.ButtonFiltersVO;

    public class BoostersWindowFiltersVO extends DAAPIDataClass
    {

        private static const QUALITY_FILTERS_FIELD_NAME:String = "qualityFilters";

        private static const TYPE_FILTERS_FIELD_NAME:String = "typeFilters";

        public var qualityFiltersLabel:String = "";

        public var typeFiltersLabel:String = "";

        public var qualityFilters:ButtonFiltersVO;

        public var typeFilters:ButtonFiltersVO;

        public function BoostersWindowFiltersVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == QUALITY_FILTERS_FIELD_NAME)
            {
                this.qualityFilters = new ButtonFiltersVO(param2);
                return false;
            }
            if(param1 == TYPE_FILTERS_FIELD_NAME)
            {
                this.typeFilters = new ButtonFiltersVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            this.qualityFilters.dispose();
            this.qualityFilters = null;
            this.typeFilters.dispose();
            this.typeFilters = null;
            super.onDispose();
        }
    }
}
