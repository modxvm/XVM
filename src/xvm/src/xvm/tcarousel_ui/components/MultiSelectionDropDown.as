/**
 * XFW
 * @author STL1te
 */
package xvm.tcarousel_ui.components
{
    import com.xfw.*;
    import scaleform.clik.events.*;

    public class MultiSelectionDropDown extends DropDown
    {
        public function MultiSelectionDropDown()
        {
            super();
            icon.autoSize = false;
            itemRenderer = ImageCheckBoxItemRenderer;
        }

        private var _selectedItems:Array = new Array();
        public function get selectedItems():Array
        {
            return _selectedItems;
        }

        public function set selectedItems(value:Array):void
        {
            _selectedItems = value;
            for each (var key:* in dataProvider)
                key.selected = _selectedItems.indexOf(key.data) >= 0;
            dispatchEvent(new ListEvent(ListEvent.INDEX_CHANGE));
        }

        override protected function configUI():void
        {
            super.configUI();
            updateSelected();
        }

        override protected function handleMenuItemClick(event:ListEvent):void
        {
            if (event.buttonIdx == 1)
                selectAll(false);
            else if (event.buttonIdx == 2)
                selectAll(true);
            else
            {
                dataProvider[event.index].selected = !dataProvider[event.index].selected;
                if (_selectedItems.indexOf(event.itemData.data) < 0)
                    _selectedItems.push(event.itemData.data);
                else
                    _selectedItems.splice(selectedItems.indexOf(event.itemData.data), 1);
                dispatchEvent(new ListEvent(ListEvent.INDEX_CHANGE));
            }
        }

        // PRIVATE

        private function updateSelected() : void
        {
            _selectedItems.splice();
            for each (var key:* in dataProvider)
            {
                if (key.selected == true)
                    _selectedItems.push(key.data);
            }
        }

        private function selectAll(enabled:Boolean) : void
        {
            for each (var key:* in dataProvider)
                key.selected = enabled;
            updateSelected();
            dispatchEvent(new ListEvent(ListEvent.INDEX_CHANGE));
            close();
        }
    }
}
