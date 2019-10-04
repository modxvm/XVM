package net.wg.gui.lobby.storage.categories.inhangar
{
    import net.wg.gui.lobby.storage.categories.StorageVehicleFilterBlock;
    import net.wg.data.Aliases;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.AlignType;

    public class InHangarFilterBlock extends StorageVehicleFilterBlock
    {

        public function InHangarFilterBlock()
        {
            super();
            filterCounter.contentAlign = AlignType.LEFT;
        }

        override protected function get filterPopoverAlias() : String
        {
            return Aliases.STORAGE_VEHICLES_FILTER_POPOVER;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                filterCounter.x = filterTitle.x + filterTitle.width + filterNameGap;
            }
        }
    }
}
