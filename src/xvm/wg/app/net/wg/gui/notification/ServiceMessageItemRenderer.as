package net.wg.gui.notification
{
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import flash.display.InteractiveObject;


   public class ServiceMessageItemRenderer extends ServiceMessage implements IListItemRenderer
   {
          
      public function ServiceMessageItemRenderer() {
         super();
      }

      private var _index:uint;

      private var _selectable:Boolean;

      private var _selected:Boolean;

      private var _owner:UIComponent;

      public function get index() : uint {
         return this._index;
      }

      public function set index(param1:uint) : void {
         this._index = param1;
      }

      public function get selectable() : Boolean {
         return this._selectable;
      }

      public function set selectable(param1:Boolean) : void {
         this._selectable = param1;
      }

      public function setListData(param1:ListData) : void {
         this.index = param1.index;
      }

      public function setData(param1:Object) : void {
         this.data = param1;
      }

      public function getData() : Object {
         return this.data;
      }

      override public function toString() : String {
         return "[Service message ListItemRenderer " + this.index + ", " + name + "]";
      }

      override protected function configUI() : void {
         var _loc2_:InteractiveObject = null;
         super.configUI();
         focusTarget = this._owner;
         _focusable = tabEnabled = tabChildren = false;
         var _loc1_:* = 0;
         while(_loc1_ < numChildren)
         {
            _loc2_ = getChildAt(_loc1_) as InteractiveObject;
            if((_loc2_) && (!(_loc2_ == textField)) && !(_loc2_ == btnMoreInfo))
            {
               _loc2_.mouseEnabled = false;
            }
            _loc1_++;
         }
      }

      public function get owner() : UIComponent {
         return this._owner;
      }

      public function set owner(param1:UIComponent) : void {
         this._owner = param1;
         this.focusTarget = this._owner;
      }

      public function get selected() : Boolean {
         return this._selected;
      }

      public function set selected(param1:Boolean) : void {
         this._selected = param1;
      }
   }

}