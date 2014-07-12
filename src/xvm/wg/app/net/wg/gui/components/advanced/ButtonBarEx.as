package net.wg.gui.components.advanced
{
   import scaleform.clik.controls.ButtonBar;
   import net.wg.infrastructure.interfaces.IGroupedControl;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import net.wg.gui.components.controls.SoundButtonEx;
   import scaleform.clik.interfaces.IListItemRenderer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.display.DisplayObject;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   
   public class ButtonBarEx extends ButtonBar implements IGroupedControl
   {
      
      public function ButtonBarEx() {
         super();
      }
      
      public static const FORWARD_STEP_INDEX:int = 1;
      
      public static const BACKWARD_STEP_INDEX:int = -1;
      
      private var _paddingHorizontal:Number = 10;
      
      public function get paddingHorizontal() : Number {
         return this._paddingHorizontal;
      }
      
      public function set paddingHorizontal(param1:Number) : void {
         this._paddingHorizontal = param1;
         invalidate(InvalidationType.SETTINGS);
      }
      
      override protected function setupRenderer(param1:Button, param2:uint) : void {
         var _loc3_:SoundButtonEx = null;
         super.setupRenderer(param1,param2);
         param1.autoSize = this.autoSize;
         if(param1 is SoundButtonEx)
         {
            _loc3_ = param1 as SoundButtonEx;
            _loc3_.paddingHorizontal = this.paddingHorizontal;
         }
      }
      
      public function get selectedRenderer() : IListItemRenderer {
         if(_selectedIndex >= 0)
         {
            return _renderers[_selectedIndex];
         }
         return null;
      }
      
      override public function get data() : Object {
         return selectedItem;
      }
      
      public function disposeRenderers() : void {
         var _loc2_:* = NaN;
         var _loc3_:Button = null;
         var _loc4_:IDisposable = null;
         var _loc5_:DisplayObject = null;
         var _loc1_:Number = _renderers.length;
         _loc2_ = _loc1_ - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = getButtonAt(_loc2_);
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_ as IDisposable;
               if(_loc4_)
               {
                  _loc4_.dispose();
               }
               _loc5_ = _loc3_ as DisplayObject;
               if(container)
               {
                  if(container.contains(_loc5_))
                  {
                     container.removeChild(_loc5_);
                  }
               }
            }
            _renderers.splice(_loc2_,1);
            _loc2_--;
         }
         this.removeChild(container);
         if(_dataProvider)
         {
            _dataProvider.cleanUp();
         }
      }
      
      override public function handleInput(param1:InputEvent) : void {
         var _loc6_:* = NaN;
         if(param1.handled)
         {
            return;
         }
         var _loc2_:Button = _renderers[_selectedIndex] as Button;
         if(_loc2_ != null)
         {
            _loc2_.handleInput(param1);
            if(param1.handled)
            {
               return;
            }
         }
         var _loc3_:InputDetails = param1.details;
         var _loc4_:Boolean = _loc3_.value == InputValue.KEY_DOWN || _loc3_.value == InputValue.KEY_HOLD;
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:* = false;
         switch(_loc3_.navEquivalent)
         {
            case NavigationCode.LEFT:
               if(_direction == DIRECTION_HORIZONTAL)
               {
                  _loc6_ = this.getNextEnabledBtnIndex(_selectedIndex,BACKWARD_STEP_INDEX);
                  _loc5_ = true;
               }
               break;
            case NavigationCode.RIGHT:
               if(_direction == DIRECTION_HORIZONTAL)
               {
                  _loc6_ = this.getNextEnabledBtnIndex(_selectedIndex,FORWARD_STEP_INDEX);
                  _loc5_ = true;
               }
               break;
            case NavigationCode.UP:
               if(_direction == DIRECTION_VERTICAL)
               {
                  _loc6_ = this.getNextEnabledBtnIndex(_selectedIndex,BACKWARD_STEP_INDEX);
                  _loc5_ = true;
               }
               break;
            case NavigationCode.DOWN:
               if(_direction == DIRECTION_VERTICAL)
               {
                  _loc6_ = this.getNextEnabledBtnIndex(_selectedIndex,FORWARD_STEP_INDEX);
                  _loc5_ = true;
               }
               break;
         }
         if(_loc5_)
         {
            _loc6_ = Math.max(0,Math.min(_dataProvider.length - 1,_loc6_));
            if(_loc6_ != _selectedIndex)
            {
               selectedIndex = _loc6_;
               param1.handled = true;
            }
         }
      }
      
      protected function getNextEnabledBtnIndex(param1:int, param2:int) : int {
         var _loc5_:Button = null;
         var _loc6_:* = 0;
         var _loc7_:* = false;
         var _loc3_:int = _renderers?_renderers.length:0;
         var _loc4_:int = Math.max(0,Math.min(_loc3_ - 1,param1 + param2));
         if(param2 == FORWARD_STEP_INDEX)
         {
            _loc6_ = _loc4_;
            while(_loc6_ < _loc3_)
            {
               _loc5_ = getButtonAt(_loc6_);
               if(_loc7_)
               {
                  if(_loc5_.enabled)
                  {
                     _loc4_ = _loc6_;
                     break;
                  }
               }
               else
               {
                  if(_loc5_.enabled)
                  {
                     _loc4_ = _loc6_;
                     break;
                  }
                  _loc7_ = true;
                  _loc4_ = _loc6_ - 1;
               }
               _loc6_++;
            }
         }
         else if(param2 == BACKWARD_STEP_INDEX)
         {
            _loc6_ = _loc4_;
            while(_loc6_ >= 0)
            {
               _loc5_ = getButtonAt(_loc6_);
               if(_loc7_)
               {
                  if(_loc5_.enabled)
                  {
                     _loc4_ = _loc6_;
                     break;
                  }
               }
               else
               {
                  if(_loc5_.enabled)
                  {
                     _loc4_ = _loc6_;
                     break;
                  }
                  _loc7_ = true;
                  _loc4_ = _loc6_ + 1;
               }
               _loc6_--;
            }
         }
         else
         {
            throw new Error(this + ". Invalid step value: " + param2);
         }
         
         return _loc4_;
      }
      
      override protected function onDispose() : void {
         this.disposeRenderers();
         super.onDispose();
      }
      
      override protected function populateRendererData(param1:Button, param2:uint) : void {
         var _loc3_:Object = _dataProvider.requestItemAt(param2);
         if((param1.hasOwnProperty("tooltip")) && (_loc3_) && (_loc3_.hasOwnProperty("tooltip")))
         {
            param1["tooltip"] = _loc3_.tooltip;
         }
         super.populateRendererData(param1,param2);
      }
      
      override public function toString() : String {
         return "[WG ButtonBarEx " + name + "]";
      }
   }
}
