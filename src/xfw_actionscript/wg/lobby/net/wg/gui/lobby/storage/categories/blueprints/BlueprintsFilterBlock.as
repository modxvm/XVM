package net.wg.gui.lobby.storage.categories.blueprints
{
    import net.wg.gui.lobby.storage.categories.StorageVehicleFilterBlock;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.events.FiltersEvent;
    import flash.events.Event;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.Aliases;

    public class BlueprintsFilterBlock extends StorageVehicleFilterBlock
    {

        private static const CONVERT_FILTER_CHECKBOX_X_OFFSET:int = 30;

        public var convertFilterCB:CheckBox;

        public function BlueprintsFilterBlock()
        {
            super();
        }

        override protected function onDispose() : void
        {
            removeEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onResetFilters);
            this.convertFilterCB.removeEventListener(Event.SELECT,this.onConvertFilterCBChangeHandler);
            this.convertFilterCB.dispose();
            this.convertFilterCB = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onResetFilters);
            this.convertFilterCB.addEventListener(Event.SELECT,this.onConvertFilterCBChangeHandler);
            this.convertFilterCB.autoSize = TextFieldAutoSize.LEFT;
            this.convertFilterCB.label = STORAGE.BLUEPRINTS_CHECKBOX_LABEL;
            this.convertFilterCB.validateNow();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.convertFilterCB.x = searchInput.x - this.convertFilterCB.width - CONVERT_FILTER_CHECKBOX_X_OFFSET;
            }
        }

        override protected function get filterPopoverAlias() : String
        {
            return Aliases.STORAGE_BLUEPRINTS_FILTER_POPOVER;
        }

        private function onConvertFilterCBChangeHandler(param1:Event) : void
        {
            dispatchEvent(new FiltersEvent(FiltersEvent.FILTERS_CHANGED,int(this.convertFilterCB.selected)));
        }

        private function onResetFilters(param1:Event) : void
        {
            this.convertFilterCB.selected = false;
        }
    }
}
