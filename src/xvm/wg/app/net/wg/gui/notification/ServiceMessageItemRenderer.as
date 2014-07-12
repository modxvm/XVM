package net.wg.gui.notification
{
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import net.wg.gui.notification.events.NotificationListEvent;
   import flash.display.InteractiveObject;
   
   public class ServiceMessageItemRenderer extends ServiceMessage implements IListItemRenderer
   {
      
      public function ServiceMessageItemRenderer() {
         super();
      }
      
      private static const SINGLE_RENDERER_LABEL:String = "single";
      
      private static const FIRST_RENDERER_LABEL:String = "first";
      
      private static const DEFAULT_RENDERER_LABEL:String = "normal";
      
      private static const LAST_RENDERER_LABEL:String = "last";
      
      private var _index:uint;
      
      private var _selectable:Boolean;
      
      private var _selected:Boolean;
      
      private var _owner:UIComponent;
      
      private var _backgroundLabel:String = "";
      
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
      
      public function get owner() : UIComponent {
         return this._owner;
      }
      
      public function set owner(param1:UIComponent) : void {
         if(this._owner)
         {
            this._owner.removeEventListener(NotificationListEvent.UPDATE_INDEXES,this.handleUpdateIndexes,false);
         }
         this._owner = param1;
         if(this._owner)
         {
            this._owner.addEventListener(NotificationListEvent.UPDATE_INDEXES,this.handleUpdateIndexes,false,0,true);
         }
         this.focusTarget = this._owner;
      }
      
      public function get selected() : Boolean {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void {
         this._selected = param1;
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
            if((_loc2_) && (!(_loc2_ == textField)) && !(_loc2_ == btnsGroup))
            {
               _loc2_.mouseEnabled = false;
            }
            _loc1_++;
         }
      }
      
      override protected function onDispose() : void {
         this.owner = null;
         super.onDispose();
      }
      
      private function handleUpdateIndexes(param1:NotificationListEvent) : void {
         var _loc2_:int = param1.length;
         if(!background)
         {
            return;
         }
         var _loc3_:String = DEFAULT_RENDERER_LABEL;
         if(this.index == 0)
         {
            _loc3_ = _loc2_ > 0?FIRST_RENDERER_LABEL:SINGLE_RENDERER_LABEL;
         }
         else if(this.index + 1 == _loc2_)
         {
            _loc3_ = LAST_RENDERER_LABEL;
         }
         
         if(_loc3_ != this._backgroundLabel)
         {
            this._backgroundLabel = _loc3_;
            background.gotoAndStop(this._backgroundLabel);
         }
      }
   }
}
