package net.wg.gui.lobby.tankman
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.components.controls.ScrollingListEx;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   import flash.events.MouseEvent;
   import scaleform.clik.events.InputEvent;
   import flash.events.FocusEvent;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.Event;


   public class PersonalCaseInputList extends UIComponent
   {
          
      public function PersonalCaseInputList() {
         this._selectedItem = {};
         super();
      }

      public static const NAME_SELECTED:String = "nameSelected";

      public var searchText:TextInput;

      public var list:ScrollingListEx;

      private var dataProvider:DataProvider;

      private var currentName:String = null;

      private var _selectedItem:Object;

      private var isTextInput:Boolean = false;

      private const UPDATE_DATA:String = "updateData";

      override public function dispose() : void {
         super.dispose();
         this.list.removeEventListener(ListEvent.INDEX_CHANGE,this.list_listIndexChangeHandler);
         this.list.removeEventListener(ListEvent.ITEM_PRESS,this.list_itemPressHandler);
         this.list.disposeRenderers();
         this.searchText.removeEventListener(MouseEvent.MOUSE_DOWN,this.searchText_mouseDownHandler);
         this.searchText.removeEventListener(InputEvent.INPUT,this.searchText_inputHandler);
         this.searchText.removeEventListener(FocusEvent.FOCUS_IN,this.searchText_focusInHandler);
         this.searchText = null;
         this.dataProvider.cleanUp();
         this.dataProvider = null;
      }

      override protected function configUI() : void {
         super.configUI();
         this.list.labelField = "value";
         this.list.addEventListener(ListEvent.INDEX_CHANGE,this.list_listIndexChangeHandler);
         this.list.addEventListener(ListEvent.ITEM_PRESS,this.list_itemPressHandler);
         this.list.invalidate(InvalidationType.SCROLL_BAR);
         this.searchText.addEventListener(MouseEvent.MOUSE_DOWN,this.searchText_mouseDownHandler);
         this.searchText.addEventListener(InputEvent.INPUT,this.searchText_inputHandler);
         this.searchText.addEventListener(FocusEvent.FOCUS_IN,this.searchText_focusInHandler);
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(this.UPDATE_DATA)) && (this.dataProvider) && (this.currentName))
         {
            this.searchText.text = this.currentName;
            this.list.dataProvider = this.dataProvider;
            this.list.selectedIndex = this.searchIndex(this.currentName);
            this.list.validateNow();
         }
      }

      private function searchIndex(param1:String) : int {
         var _loc2_:* = 0;
         while(_loc2_ < this.list.dataProvider.length)
         {
            if(param1.toLowerCase() == String(this.list.dataProvider[_loc2_].value).toLowerCase().slice(0,param1.length))
            {
               this.selectedItem = this.list.dataProvider[_loc2_];
               return _loc2_;
            }
            _loc2_++;
         }
         return this.list.selectedIndex;
      }

      public function updateData(param1:Array, param2:String) : void {
         this.dataProvider = new DataProvider(param1);
         this.currentName = param2;
         invalidate(this.UPDATE_DATA);
      }

      private function searchText_inputHandler(param1:InputEvent) : void {
         this.list.selectedIndex = this.searchIndex(this.searchText.text);
      }

      private function list_listIndexChangeHandler(param1:ListEvent) : void {
         if((param1.itemData) && !this.isTextInput)
         {
            this.searchText.text = param1.itemData.value;
            this.selectedItem = param1.itemData;
         }
      }

      private function searchText_mouseDownHandler(param1:MouseEvent) : void {
         this.isTextInput = true;
      }

      private function list_itemPressHandler(param1:ListEvent) : void {
         this.isTextInput = false;
      }

      private function searchText_focusInHandler(param1:FocusEvent) : void {
         this.searchText.textField.setSelection(0,this.searchText.text.length);
      }

      public function get selectedItem() : Object {
         return this._selectedItem;
      }

      public function set selectedItem(param1:Object) : void {
         this._selectedItem = param1;
         dispatchEvent(new Event(NAME_SELECTED,true));
      }
   }

}