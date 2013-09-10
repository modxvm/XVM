package net.wg.gui.lobby.tankman 
{
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class PersonalCaseInputList extends scaleform.clik.core.UIComponent
    {
        public function PersonalCaseInputList()
        {
            this._selectedItem = {};
            super();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.list.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.list_listIndexChangeHandler);
            this.list.removeEventListener(scaleform.clik.events.ListEvent.ITEM_PRESS, this.list_itemPressHandler);
            this.list.disposeRenderers();
            this.searchText.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.searchText_mouseDownHandler);
            this.searchText.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.searchText_inputHandler);
            this.searchText.removeEventListener(flash.events.FocusEvent.FOCUS_IN, this.searchText_focusInHandler);
            this.searchText = null;
            this.dataProvider.cleanUp();
            this.dataProvider = null;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.list.labelField = "value";
            this.list.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.list_listIndexChangeHandler);
            this.list.addEventListener(scaleform.clik.events.ListEvent.ITEM_PRESS, this.list_itemPressHandler);
            this.list.invalidate(scaleform.clik.constants.InvalidationType.SCROLL_BAR);
            this.searchText.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.searchText_mouseDownHandler);
            this.searchText.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.searchText_inputHandler);
            this.searchText.addEventListener(flash.events.FocusEvent.FOCUS_IN, this.searchText_focusInHandler);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(this.UPDATE_DATA) && this.dataProvider && this.currentName) 
            {
                this.searchText.text = this.currentName;
                this.list.dataProvider = this.dataProvider;
                this.list.selectedIndex = this.searchIndex(this.currentName);
                this.list.validateNow();
            }
            return;
        }

        internal function searchIndex(arg1:String):int
        {
            var loc1:*=0;
            while (loc1 < this.list.dataProvider.length) 
            {
                if (arg1.toLowerCase() == String(this.list.dataProvider[loc1].value).toLowerCase().slice(0, arg1.length)) 
                {
                    this.selectedItem = this.list.dataProvider[loc1];
                    return loc1;
                }
                ++loc1;
            }
            return this.list.selectedIndex;
        }

        public function updateData(arg1:Array, arg2:String):void
        {
            this.dataProvider = new scaleform.clik.data.DataProvider(arg1);
            this.currentName = arg2;
            invalidate(this.UPDATE_DATA);
            return;
        }

        internal function searchText_inputHandler(arg1:scaleform.clik.events.InputEvent):void
        {
            this.list.selectedIndex = this.searchIndex(this.searchText.text);
            return;
        }

        internal function list_listIndexChangeHandler(arg1:scaleform.clik.events.ListEvent):void
        {
            if (arg1.itemData && !this.isTextInput) 
            {
                this.searchText.text = arg1.itemData.value;
                this.selectedItem = arg1.itemData;
            }
            return;
        }

        internal function searchText_mouseDownHandler(arg1:flash.events.MouseEvent):void
        {
            this.isTextInput = true;
            return;
        }

        internal function list_itemPressHandler(arg1:scaleform.clik.events.ListEvent):void
        {
            this.isTextInput = false;
            return;
        }

        internal function searchText_focusInHandler(arg1:flash.events.FocusEvent):void
        {
            this.searchText.textField.selectable;
            this.searchText.textField.setSelection(0, this.searchText.text.length);
            return;
        }

        public function get selectedItem():Object
        {
            return this._selectedItem;
        }

        public function set selectedItem(arg1:Object):void
        {
            this._selectedItem = arg1;
            dispatchEvent(new flash.events.Event(NAME_SELECTED, true));
            return;
        }

        internal const UPDATE_DATA:String="updateData";

        public static const NAME_SELECTED:String="nameSelected";

        public var searchText:net.wg.gui.components.controls.TextInput;

        public var list:net.wg.gui.components.controls.ScrollingListEx;

        internal var dataProvider:scaleform.clik.data.DataProvider;

        internal var currentName:String=null;

        internal var _selectedItem:Object;

        internal var isTextInput:Boolean=false;
    }
}
