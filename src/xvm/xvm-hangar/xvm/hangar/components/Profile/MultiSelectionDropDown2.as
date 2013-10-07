/**
* ...
* @author STL1te
*/
package xvm.hangar.components.Profile
{
    import com.xvm.*;
    import flash.events.*;
    import scaleform.clik.events.*;
    import net.wg.gui.components.controls.*;

    public class MultiSelectionDropDown2 extends DropDownImageText
    {
        public var selectedItems:Array = new Array();

        public function MultiSelectionDropDown2()
        {
            super();
            if (this.icon == null)
                this.icon = App.utils.classFactory.getComponent("UILoaderAlt", UILoaderAlt);
            this.icon.autoSize = false;
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
