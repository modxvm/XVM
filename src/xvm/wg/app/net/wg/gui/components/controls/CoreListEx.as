package net.wg.gui.components.controls
{
   import scaleform.clik.controls.CoreList;
   import net.wg.gui.events.ListEventEx;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import scaleform.gfx.MouseEventEx;
   
   public class CoreListEx extends CoreList
   {
      
      public function CoreListEx() {
         super();
      }
      
      private var _useRightButton:Boolean = false;
      
      private var _useRightButtonForSelect:Boolean = false;
      
      protected function onItemStartDrag(param1:ListEventEx) : void {
      }
      
      protected function onItemStopDrag(param1:ListEventEx) : void {
      }
      
      override protected function setupRenderer(param1:IListItemRenderer) : void {
         param1.owner = this;
         param1.focusTarget = this;
         param1.tabEnabled = false;
         param1.doubleClickEnabled = true;
         param1.enabled = this.enabled;
         if(param1 is SoundListItemRenderer)
         {
            (param1 as SoundListItemRenderer).useRightButton = this._useRightButton;
         }
         param1.addEventListener(ButtonEvent.PRESS,this.dispatchItemEvent,false,0,true);
         param1.addEventListener(ButtonEvent.CLICK,this.handleItemClick,false,0,true);
         param1.addEventListener(ButtonEvent.DRAG_OVER,this.dispatchItemEvent,false,0,true);
         param1.addEventListener(ButtonEvent.DRAG_OUT,this.dispatchItemEvent,false,0,true);
         param1.addEventListener(ButtonEvent.RELEASE_OUTSIDE,this.dispatchItemEvent,false,0,true);
         param1.addEventListener(MouseEvent.DOUBLE_CLICK,this.dispatchItemEvent,false,0,true);
         param1.addEventListener(MouseEvent.ROLL_OVER,this.dispatchItemEvent,false,0,true);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.dispatchItemEvent,false,0,true);
         param1.addEventListener(ListEventEx.ITEM_DRAG_START,this.onItemStartDrag,false,0,true);
         param1.addEventListener(ListEventEx.ITEM_DRAG_STOP,this.onItemStopDrag,false,0,true);
         if(_usingExternalRenderers)
         {
            param1.addEventListener(MouseEvent.MOUSE_WHEEL,handleMouseWheel,false,0,true);
         }
      }
      
      override protected function cleanUpRenderer(param1:IListItemRenderer) : void {
         param1.doubleClickEnabled = false;
         param1.removeEventListener(ButtonEvent.DRAG_OVER,this.dispatchItemEvent,false);
         param1.removeEventListener(ButtonEvent.DRAG_OUT,this.dispatchItemEvent,false);
         param1.removeEventListener(ButtonEvent.RELEASE_OUTSIDE,this.dispatchItemEvent,false);
         param1.removeEventListener(ListEventEx.ITEM_DRAG_START,this.onItemStartDrag,false);
         param1.removeEventListener(ListEventEx.ITEM_DRAG_STOP,this.onItemStopDrag,false);
         super.cleanUpRenderer(param1);
      }
      
      override protected function dispatchItemEvent(param1:Event) : Boolean {
         var _loc2_:String = null;
         switch(param1.type)
         {
            case ButtonEvent.PRESS:
               _loc2_ = ListEventEx.ITEM_PRESS;
               break;
            case ButtonEvent.CLICK:
               _loc2_ = ListEventEx.ITEM_CLICK;
               break;
            case ButtonEvent.DRAG_OVER:
               _loc2_ = ListEventEx.ITEM_DRAG_OVER;
               break;
            case ButtonEvent.DRAG_OUT:
               _loc2_ = ListEventEx.ITEM_DRAG_OUT;
               break;
            case ButtonEvent.RELEASE_OUTSIDE:
               _loc2_ = ListEventEx.ITEM_RELEASE_OUTSIDE;
               break;
            case MouseEvent.ROLL_OVER:
               _loc2_ = ListEventEx.ITEM_ROLL_OVER;
               break;
            case MouseEvent.ROLL_OUT:
               _loc2_ = ListEventEx.ITEM_ROLL_OUT;
               break;
            case MouseEvent.DOUBLE_CLICK:
               _loc2_ = ListEventEx.ITEM_DOUBLE_CLICK;
               break;
            default:
               return true;
         }
         var _loc3_:IListItemRenderer = param1.currentTarget as IListItemRenderer;
         var _loc4_:uint = 0;
         if(param1 is ButtonEvent)
         {
            _loc4_ = (param1 as ButtonEvent).controllerIdx;
         }
         else if(param1 is MouseEventEx)
         {
            _loc4_ = (param1 as MouseEventEx).mouseIdx;
         }
         
         var _loc5_:uint = 0;
         if(param1 is ButtonEvent)
         {
            _loc5_ = (param1 as ButtonEvent).buttonIdx;
         }
         else if(param1 is MouseEventEx)
         {
            _loc5_ = (param1 as MouseEventEx).buttonIdx;
         }
         
         var _loc6_:* = false;
         if(param1 is ButtonEvent)
         {
            _loc6_ = (param1 as ButtonEvent).isKeyboard;
         }
         var _loc7_:ListEventEx = new ListEventEx(_loc2_,false,true,_loc3_.index,0,_loc3_.index,_loc3_,dataProvider.requestItemAt(_loc3_.index),_loc4_,_loc5_,_loc6_);
         return dispatchEvent(_loc7_);
      }
      
      public function set useRightButton(param1:Boolean) : void {
         var _loc2_:uint = 0;
         var _loc3_:SoundListItemRenderer = null;
         if(this._useRightButton == param1)
         {
            return;
         }
         this._useRightButton = param1;
         if(_renderers)
         {
            _loc2_ = 0;
            while(_loc2_ < _renderers.length)
            {
               _loc3_ = getRendererAt(_loc2_) as SoundListItemRenderer;
               if(_loc3_)
               {
                  _loc3_.useRightButton = this._useRightButton;
               }
               _loc2_++;
            }
         }
      }
      
      public function get useRightButton() : Boolean {
         return this._useRightButton;
      }
      
      public function set useRightButtonForSelect(param1:Boolean) : void {
         if(this._useRightButtonForSelect == param1)
         {
            return;
         }
         this._useRightButtonForSelect = param1;
      }
      
      public function get useRightButtonForSelect() : Boolean {
         return this._useRightButtonForSelect;
      }
      
      override protected function handleItemClick(param1:ButtonEvent) : void {
         var _loc2_:Number = (param1.currentTarget as IListItemRenderer).index;
         if(isNaN(_loc2_))
         {
            return;
         }
         if(this.dispatchItemEvent(param1))
         {
            if(_baseDisposed)
            {
               return;
            }
            if((this.useRightButton) && (this.useRightButtonForSelect) || param1.buttonIdx == 0)
            {
               selectedIndex = _loc2_;
            }
         }
      }
   }
}
