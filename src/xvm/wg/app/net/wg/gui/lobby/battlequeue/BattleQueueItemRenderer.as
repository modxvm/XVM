package net.wg.gui.lobby.battlequeue
{
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import flash.text.TextField;
   import scaleform.clik.data.ListData;


   public class BattleQueueItemRenderer extends UIComponent implements IListItemRenderer
   {
          
      public function BattleQueueItemRenderer() {
         super();
      }

      protected var _index:uint = 0;

      protected var _owner:UIComponent = null;

      protected var _selectable:Boolean = false;

      protected var _selected:Boolean = false;

      protected var _data:Object;

      public var textField:TextField;

      public var countField:TextField;

      public function setData(param1:Object) : void {
         this.data = param1;
         invalidate();
      }

      public function getData() : Object {
         return this.data;
      }

      override protected function draw() : void {
         if(this.data)
         {
            if((this.textField) && !(this.data.type == null))
            {
               this.textField.text = typeof this.data.type == "number"?String(this.data.type):this.data.type;
            }
            if((this.countField) && !(this.data.count == null))
            {
               this.countField.text = typeof this.data.count == "number"?App.utils.locale.integer(this.data.count):this.data.count;
            }
         }
         super.draw();
      }

      public function setListData(param1:ListData) : void {
          
      }

      public function get index() : uint {
         return this._index;
      }

      public function set index(param1:uint) : void {
         this._index = param1;
      }

      public function get owner() : UIComponent {
         return this._owner;
      }

      public function set owner(param1:UIComponent) : void {
         this._owner = param1;
      }

      public function get selectable() : Boolean {
         return this._selectable;
      }

      public function set selectable(param1:Boolean) : void {
         this._selectable = param1;
      }

      public function get selected() : Boolean {
         return this._selected;
      }

      public function set selected(param1:Boolean) : void {
         if(this._selected == param1)
         {
            return;
         }
         this._selected = param1;
      }

      public function get data() : Object {
         return this._data;
      }

      public function set data(param1:Object) : void {
         this._data = param1;
      }

      override public function toString() : String {
         return "[WG BattleQueueItemRenderer " + name + "]";
      }
   }

}