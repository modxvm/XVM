/**
* ...
* @author STL1te
*/
package com.xvm.components
{
    import com.xvm.*;
    import scaleform.clik.events.*;

    public class MultiSelectionDropDown extends DropDown // from controls.swf
    {
        public var selectedItems:Array = new Array();

        public function MultiSelectionDropDown()
        {
            super();
        }

        override protected function configUI():void
        {
            super.configUI();
            for each(var key:* in this._dataProvider)
                this.selectedItems.push(key.data);
        }

        private function _isInArray(element:*, array:Array):Boolean
        {
            return (array.indexOf(element) >= 0);
        }

        protected override function handleMenuItemClick(event:ListEvent):void
        {
            this.dataProvider[event.index].selected = !this.dataProvider[event.index].selected;
            if (!_isInArray(event.itemData.data, this.selectedItems))
                this.selectedItems.push(event.itemData.data);
            else
                this.selectedItems.splice(selectedItems.indexOf(event.itemData.data), 1);
            dispatchEvent(new ListEvent(ListEvent.INDEX_CHANGE));
            return;
        }

    }

}
