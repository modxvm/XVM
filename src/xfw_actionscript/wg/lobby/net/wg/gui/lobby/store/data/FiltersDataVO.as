package net.wg.gui.lobby.store.data
{
    import net.wg.gui.data.DataClassItemVO;
    import net.wg.gui.lobby.store.views.data.FiltersVO;

    public class FiltersDataVO extends DataClassItemVO
    {

        public var showExtra:Boolean = false;

        private var _filtersData:FiltersVO = null;

        public function FiltersDataVO(param1:Object)
        {
            super(param1);
        }

        override public function fromHash(param1:Object) : void
        {
            super.fromHash(param1);
            this._filtersData = FiltersVO(voData);
        }

        override protected function onDispose() : void
        {
            this._filtersData = null;
            super.onDispose();
        }

        public function get filtersData() : FiltersVO
        {
            return this._filtersData;
        }
    }
}
