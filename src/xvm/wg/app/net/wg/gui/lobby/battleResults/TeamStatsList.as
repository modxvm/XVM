package net.wg.gui.lobby.battleResults
{
   import net.wg.gui.components.controls.ScrollingListEx;
   import scaleform.clik.constants.WrappingMode;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   
   public class TeamStatsList extends ScrollingListEx
   {
      
      public function TeamStatsList() {
         super();
      }
      
      override protected function configUI() : void {
         super.configUI();
         wrapping = WrappingMode.NORMAL;
      }
      
      override protected function drawLayout() : void {
         var _loc8_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:Number = rowHeight;
         var _loc3_:Number = availableWidth - padding.horizontal;
         var _loc4_:Number = margin + padding.left;
         var _loc5_:Number = margin + padding.top;
         var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            _loc8_ = getRendererAt(_loc7_);
            _loc8_.x = Math.round(_loc4_);
            _loc8_.y = Math.round(_loc5_ + _loc7_ * _loc2_);
            _loc8_.width = _loc3_;
            if(!_loc6_)
            {
               _loc8_.validateNow();
            }
            _loc7_++;
         }
         drawScrollBar();
      }
      
      override protected function handleItemClick(param1:ButtonEvent) : void {
         var _loc2_:Number = (param1.currentTarget as IListItemRenderer).index;
         if(isNaN(_loc2_))
         {
            return;
         }
         if(dispatchItemEvent(param1))
         {
            if((useRightButton) && (useRightButtonForSelect) || param1.buttonIdx == 0)
            {
               selectedIndex = _loc2_;
            }
         }
      }
      
      override public function handleInput(param1:InputEvent) : void {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:IListItemRenderer = getRendererAt(_selectedIndex,_scrollPosition);
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
         switch(_loc3_.navEquivalent)
         {
            case NavigationCode.UP:
               if(selectedIndex == -1)
               {
                  if(_loc4_)
                  {
                     return;
                  }
               }
               else if(_selectedIndex > 0)
               {
                  if(_loc4_)
                  {
                     selectedIndex--;
                  }
               }
               else if(wrapping != WrappingMode.STICK)
               {
                  if(wrapping == WrappingMode.WRAP)
                  {
                     if(_loc4_)
                     {
                        selectedIndex = _dataProvider.length - 1;
                     }
                  }
                  else
                  {
                     return;
                  }
               }
               
               
               break;
            case NavigationCode.DOWN:
               if(_selectedIndex == -1)
               {
                  if(_loc4_)
                  {
                     selectedIndex = _scrollPosition;
                  }
               }
               else if(_selectedIndex < _dataProvider.length - 1)
               {
                  if(_loc4_)
                  {
                     selectedIndex++;
                  }
               }
               else if(wrapping != WrappingMode.STICK)
               {
                  if(wrapping == WrappingMode.WRAP)
                  {
                     if(_loc4_)
                     {
                        selectedIndex = 0;
                     }
                  }
                  else
                  {
                     return;
                  }
               }
               
               
               break;
            case NavigationCode.END:
               if(!_loc4_)
               {
                  selectedIndex = _dataProvider.length - 1;
               }
               break;
            case NavigationCode.HOME:
               if(!_loc4_)
               {
                  selectedIndex = 0;
               }
               break;
            case NavigationCode.PAGE_UP:
               if(_loc4_)
               {
                  selectedIndex = Math.max(0,_selectedIndex - _totalRenderers);
               }
               break;
            case NavigationCode.PAGE_DOWN:
               if(_loc4_)
               {
                  selectedIndex = Math.min(_dataProvider.length - 1,_selectedIndex + _totalRenderers);
               }
               break;
            default:
               return;
         }
         param1.handled = true;
      }
   }
}
