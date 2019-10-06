package net.wg.gui.lobby.store
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.lobby.store.interfaces.IStoreTable;
    import net.wg.gui.components.advanced.Accordion;
    import net.wg.gui.components.controls.NationDropDownMenu;
    import flash.text.TextField;
    import scaleform.clik.events.ListEvent;

    public class StoreForm extends UIComponentEx
    {

        private static const DROPDOWN_EVENT_PRIORITY:int = 1;

        public var storeTable:IStoreTable = null;

        public var menu:Accordion = null;

        public var nationDropDown:NationDropDownMenu = null;

        public var textField:TextField = null;

        private var _isViewVisible:Boolean = true;

        private var _nationIdx:int = -1;

        public function StoreForm()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.storeTable = null;
            this.menu.dispose();
            this.menu = null;
            this.nationDropDown.removeEventListener(ListEvent.INDEX_CHANGE,this.onNationDropDownIndexChangeHandler,false);
            this.nationDropDown.dispose();
            this.nationDropDown = null;
            this.textField = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.nationDropDown.addEventListener(ListEvent.INDEX_CHANGE,this.onNationDropDownIndexChangeHandler,false,DROPDOWN_EVENT_PRIORITY);
            this.textField.text = MENU.NATIONS_TITLE;
            this.menu.setNeedPreventInnerEvents(false);
        }

        public function setNationIdx(param1:int) : void
        {
            this._nationIdx = param1;
            this.nationDropDown.selectedIndex = this._nationIdx + 1;
        }

        public function get nationIdx() : int
        {
            return this._nationIdx;
        }

        private function onNationDropDownIndexChangeHandler(param1:ListEvent) : void
        {
            this._nationIdx = param1.index - 1;
        }

        public function get isViewVisible() : Boolean
        {
            return this._isViewVisible;
        }

        public function set isViewVisible(param1:Boolean) : void
        {
            this._isViewVisible = param1;
            this.storeTable.isViewVisible = param1;
        }
    }
}
