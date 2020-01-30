package net.wg.gui.lobby.storage.categories.storage
{
    public class StorageTypeFilterBlockView extends StorageTypeFilterBlock
    {

        public function StorageTypeFilterBlockView()
        {
            super();
        }

        override protected function updatePositions() : void
        {
            typeFilters.x = width - typeFilters.width;
            typeFilterName.x = typeFilters.x - typeFilterName.width - FILTER_NAME_GAP;
        }
    }
}
