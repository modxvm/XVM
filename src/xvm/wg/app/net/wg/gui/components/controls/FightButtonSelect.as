package net.wg.gui.components.controls
{
   import flash.events.MouseEvent;
   import flash.display.MovieClip;
   import net.wg.gui.events.FightButtonEvent;
   import flash.events.Event;
   import scaleform.clik.controls.CoreList;
   import scaleform.clik.controls.ScrollingList;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.interfaces.IDataProvider;
   import flash.utils.getDefinitionByName;
   import flash.geom.Point;
   import flash.display.DisplayObject;


   public class FightButtonSelect extends DropdownMenu
   {
          
      public function FightButtonSelect() {
         super();
         handleScroll = false;
      }

      public static function showTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.showComplex(TOOLTIPS.HEADER_FIGHT_BUTTON_DROPDOWN);
      }

      public static function hideTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      public var iconText:IconText;

      public var hit_mc:MovieClip;

      protected var _fightBtnlabel:String;

      override public function open() : void {
         if(selected)
         {
            return;
         }
         this.selected = true;
         stage.addEventListener(MouseEvent.MOUSE_DOWN,this.handleStageClick,false,0,true);
         this.showDropdown();
         if(_dropdownRef)
         {
            this.iconText.textColor = 14008503;
            this.iconText.icon = "arrowUp";
            this.iconText.validateNow();
         }
      }

      public function get fightBtnlabel() : String {
         return _label;
      }

      public function set fightBtnlabel(param1:String) : void {
         if(this._fightBtnlabel == param1)
         {
            return;
         }
         this._fightBtnlabel = param1;
         invalidateData();
      }

      override public function close() : void {
         if(!selected)
         {
            return;
         }
         this.selected = false;
         stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.handleStageClick,false);
         if(_dropdownRef)
         {
            this.iconText.icon = "arrowDown";
            this.iconText.textColor = 14008503;
            this.iconText.validateNow();
         }
         this.hideDropdown();
      }

      override public function set selected(param1:Boolean) : void {
         super.selected = param1;
         dispatchEvent(new FightButtonEvent(FightButtonEvent.SELECT_TOGGLE));
      }

      override protected function updateText() : void {
         if(!(this._fightBtnlabel == null) && !(this.iconText == null))
         {
            this.iconText.text = this._fightBtnlabel;
            this.iconText.validateNow();
         }
      }

      override protected function configUI() : void {
         super.configUI();
         this.hitArea = this.hit_mc;
         this.iconText.icon = "arrowDown";
         this.iconText.textColor = 14008503;
         this.iconText.validateNow();
         addEventListener(MouseEvent.ROLL_OVER,showTooltip,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,hideTooltip,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,hideTooltip,false,0,true);
      }

      override public function dispose() : void {
         removeEventListener(MouseEvent.ROLL_OVER,showTooltip,false);
         removeEventListener(MouseEvent.ROLL_OUT,hideTooltip,false);
         removeEventListener(MouseEvent.MOUSE_DOWN,hideTooltip,false);
         App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.handleStageClick,false);
         App.stage.removeEventListener(Event.RESIZE,this.updateDDPosition);
         this.iconText.dispose();
         super.dispose();
      }

      override public function get selectedIndex() : int {
         return _selectedIndex;
      }

      override public function set selectedIndex(param1:int) : void {
         var _loc2_:CoreList = null;
         var _loc3_:uint = 0;
         if(_selectedIndex == param1)
         {
            return;
         }
         _selectedIndex = param1;
         invalidateSelectedIndex();
         if(_dropdownRef != null)
         {
            _loc2_ = _dropdownRef.list as CoreList;
            _loc3_ = _loc2_  is  ScrollingList?(_loc2_ as ScrollingList).scrollPosition:0;
            dispatchEvent(new ListEvent(ListEvent.INDEX_CHANGE,true,false,_selectedIndex,-1,-1,_loc2_.getRendererAt(_selectedIndex,_loc3_),_dataProvider[_selectedIndex]));
         }
      }

      override public function handleInput(param1:InputEvent) : void {
         if(param1.handled)
         {
            return;
         }
         if(!(_dropdownRef == null) && (selected))
         {
            _dropdownRef.handleInput(param1);
            if(param1.handled)
            {
               return;
            }
         }
         super.handleInput(param1);
         var _loc2_:InputDetails = param1.details;
         var _loc3_:* = _loc2_.value == InputValue.KEY_DOWN;
         switch(_loc2_.navEquivalent)
         {
            case NavigationCode.ESCAPE:
               if(selected)
               {
                  if(_loc3_)
                  {
                     this.close();
                  }
                  param1.handled = true;
                  break;
               }
               break;
         }
      }

      override public function set dataProvider(param1:IDataProvider) : void {
         super.dataProvider = param1;
         if(_dropdownRef)
         {
            CoreList(_dropdownRef).dataProvider = _dataProvider;
         }
      }

      override protected function changeFocus() : void {
         super.changeFocus();
         if((_selected) && (_dropdownRef))
         {
            this.close();
         }
      }

      override protected function showDropdown() : void {
         var _loc1_:MovieClip = null;
         var _loc2_:Class = null;
         if(dropdown == null)
         {
            return;
         }
         if(dropdown  is  String && !(dropdown == ""))
         {
            _loc2_ = getDefinitionByName(dropdown.toString()) as Class;
            if(_loc2_ != null)
            {
               _loc1_ = new _loc2_();
            }
         }
         if(_loc1_)
         {
            if(itemRenderer  is  String && !(itemRenderer == ""))
            {
               _loc1_.itemRenderer = getDefinitionByName(itemRenderer.toString()) as Class;
            }
            else
            {
               if(itemRenderer  is  Class)
               {
                  _loc1_.itemRenderer = itemRenderer as Class;
               }
            }
            if(scrollBar  is  String && !(scrollBar == ""))
            {
               _loc1_.scrollBar = getDefinitionByName(scrollBar.toString()) as Class;
            }
            else
            {
               if(scrollBar  is  Class)
               {
                  _loc1_.scrollBar = scrollBar as Class;
               }
            }
            _loc1_.selectedIndex = _selectedIndex;
            _loc1_.width = menuWidth == -1?width + menuOffset.left + menuOffset.right:menuWidth;
            _loc1_.dataProvider = _dataProvider;
            _loc1_.padding = menuPadding;
            _loc1_.wrapping = menuWrapping;
            _loc1_.margin = menuMargin;
            _loc1_.thumbOffset =
               {
                  "top":thumbOffsetTop,
                  "bottom":thumbOffsetBottom
               }
            ;
            _loc1_.focusTarget = this;
            _loc1_.rowCount = _dataProvider.length;
            _loc1_.labelField = _labelField;
            _loc1_.labelFunction = _labelFunction;
            _loc1_.list.addEventListener(ListEvent.ITEM_CLICK,handleMenuItemClick,false,0,true);
            _dropdownRef = _loc1_;
            _dropdownRef.x = x + menuOffset.left;
            _dropdownRef.y = menuDirection == "down"?y + height + menuOffset.top:y - _dropdownRef.height + menuOffset.bottom;
            App.utils.popupMgr.show(_loc1_,x + menuOffset.left,menuDirection == "down"?y + height + menuOffset.top:y - _loc1_.height + menuOffset.bottom,parent);
            stage.addEventListener(Event.RESIZE,this.updateDDPosition);
         }
      }

      override protected function updateDDPosition(param1:Event) : void {
         if(_dropdownRef)
         {
            super.updateDDPosition(param1);
         }
      }

      override protected function hideDropdown() : void {
         if(_dropdownRef)
         {
            this.hideToolTips();
            _dropdownRef.parent.removeChild(_dropdownRef);
            _dropdownRef = null;
         }
         stage.removeEventListener(Event.RESIZE,this.updateDDPosition);
      }

      private function hideToolTips() : void {
         var _loc1_:Point = new Point(_dropdownRef.mouseX,_dropdownRef.mouseY);
         _loc1_ = localToGlobal(_loc1_);
         if(_dropdownRef.hitTestPoint(_loc1_.x,_loc1_.y,true))
         {
            App.toolTipMgr.hide();
         }
      }

      override protected function handleStageClick(param1:MouseEvent) : void {
         if(this.contains(param1.target as DisplayObject))
         {
            return;
         }
         if(this._dropdownRef.contains(param1.target as DisplayObject))
         {
            return;
         }
         this.close();
      }
   }

}