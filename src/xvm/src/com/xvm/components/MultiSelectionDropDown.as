/**
* ...
* @author STL1te
*/
package com.xvm.components
{
    import com.xvm.*;
    import scaleform.clik.events.*;

    public class MultiSelectionDropDown extends DropDown
    {
        public var selectedItems:Array = new Array();

        public function MultiSelectionDropDown()
        {
            super();
            //icon.autoSize = false;
            itemRenderer = ImageCheckBoxItemRenderer;
        }

        override protected function configUI():void
        {
            super.configUI();
            updateSelected();
        }

        override protected function handleMenuItemClick(event:ListEvent) : void
        {
            if (event.buttonIdx == 1)
                selectAll(false);
            else if (event.buttonIdx == 2)
                selectAll(true);
            else
            {
                dataProvider[event.index].selected = !dataProvider[event.index].selected;
                if (selectedItems.indexOf(event.itemData.data) < 0)
                    selectedItems.push(event.itemData.data);
                else
                    selectedItems.splice(selectedItems.indexOf(event.itemData.data), 1);
                dispatchEvent(new ListEvent(ListEvent.INDEX_CHANGE));
            }
        }

        // PRIVATE

        private function updateSelected() : void
        {
            selectedItems.splice();
            for each (var key:* in dataProvider)
            {
                if (key.selected == true)
                    selectedItems.push(key.data);
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
