package net.wg.gui.lobby.header
{
   import scaleform.clik.controls.ButtonBar;
   import net.wg.infrastructure.interfaces.IHelpLayoutComponent;
   import flash.display.MovieClip;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.controls.Button;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.events.HeaderButtonBarEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.MainMenuButton;
   import scaleform.clik.constants.InvalidationType;
   
   public class HeaderButtonBar extends ButtonBar implements IHelpLayoutComponent
   {
      
      public function HeaderButtonBar() {
         super();
         this.visible = false;
      }
      
      private static const MAX_WIDTH:Number = 1024;
      
      public var bg:MovieClip;
      
      public var paddingTop:Number = 0;
      
      public var paddingBottom:Number = 0;
      
      public var paddingLeft:Number = 0;
      
      public var paddingRight:Number = 0;
      
      private var _disableNav:Boolean = false;
      
      private var _subItemSelectedIndex:Number = -1;
      
      public function showHelpLayout() : void {
         var _loc1_:Number = _renderers.length;
         var _loc2_:Number = 1;
         while(_loc2_ < _loc1_ - 1)
         {
            (_renderers[_loc2_] as IHelpLayoutComponent).showHelpLayout();
            _loc2_++;
         }
      }
      
      public function closeHelpLayout() : void {
         var _loc1_:Number = _renderers.length;
         var _loc2_:Number = 1;
         while(_loc2_ < _loc1_ - 1)
         {
            (_renderers[_loc2_] as IHelpLayoutComponent).closeHelpLayout();
            _loc2_++;
         }
      }
      
      public function setDisableNav(param1:Boolean) : void {
         this._disableNav = param1;
         this.enabled = !param1;
      }
      
      override public function handleInput(param1:InputEvent) : void {
         if(!this._disableNav)
         {
            super.handleInput(param1);
         }
      }
      
      override protected function updateRenderers() : void {
         var _loc5_:* = 0;
         var _loc6_:Button = null;
         var _loc7_:* = false;
         var _loc8_:* = 0;
         var _loc9_:Button = null;
         var _loc1_:Number = this.paddingLeft;
         var _loc2_:Number = this.paddingTop;
         var _loc3_:* = -1;
         if(_renderers[0] is Class(_itemRendererClass))
         {
            while(_renderers.length > _dataProvider.length)
            {
               _loc5_ = _renderers.length - 1;
               if(container.contains(_renderers[_loc5_]))
               {
                  container.removeChild(_renderers[_loc5_]);
               }
               _renderers.splice(_loc5_--,1);
            }
         }
         else
         {
            while(container.numChildren > 0)
            {
               container.removeChildAt(0);
            }
            _renderers.length = 0;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < _dataProvider.length && _loc3_ == -1)
         {
            _loc7_ = false;
            if(_loc4_ < _renderers.length)
            {
               _loc6_ = _renderers[_loc4_];
            }
            else
            {
               _loc6_ = new _itemRendererClass();
               setupRenderer(_loc6_,_loc4_);
               _loc7_ = true;
            }
            this.populateRendererData(_loc6_,_loc4_);
            if(_autoSize == TextFieldAutoSize.NONE && _buttonWidth > 0)
            {
               _loc6_.width = Math.round(_buttonWidth);
            }
            else if(_autoSize != TextFieldAutoSize.NONE)
            {
               _loc6_.autoSize = _autoSize;
            }
            
            _loc6_.validateNow();
            if(_loc6_.width + _spacing + _loc1_ < MAX_WIDTH)
            {
               _loc6_.y = this.paddingTop;
               _loc6_.x = Math.round(_loc1_);
               _loc1_ = _loc1_ + (_loc6_.width + _spacing);
               _loc2_ = Math.round(_loc6_.height + this.paddingTop);
            }
            else
            {
               _loc3_ = _loc4_;
               _loc6_ = null;
            }
            if((_loc7_) && !(_loc6_ == null))
            {
               _loc6_.group = _group;
               container.addChild(_loc6_);
               _renderers.push(_loc6_);
            }
            _loc4_++;
         }
         if(_loc3_ > -1)
         {
            _loc8_ = _renderers.length - 1;
            while(_loc8_ >= _loc3_)
            {
               _loc9_ = _renderers[_loc8_];
               if(_loc9_)
               {
                  if(container.contains(_loc9_))
                  {
                     container.removeChild(_loc9_);
                  }
                  _renderers.splice(_loc8_,1);
               }
               _loc8_--;
            }
         }
         this.bg.width = Math.round(_loc1_ - _spacing + this.paddingRight);
         this.bg.height = Math.round(_loc2_ + this.paddingBottom);
         dispatchEvent(new HeaderButtonBarEvent(HeaderButtonBarEvent.RESIZE,this.bg.width));
         this.selectedIndex = Math.min(_dataProvider.length - 1,_selectedIndex);
      }
      
      override protected function populateRendererData(param1:Button, param2:uint) : void {
         param1.label = itemToLabel(_dataProvider.requestItemAt(param2));
         param1.data = _dataProvider.requestItemAt(param2);
         param1.selected = param2 == selectedIndex;
         if(_dataProvider[param2].textColor)
         {
            SoundButtonEx(param1).textColor = _dataProvider[param2].textColor;
         }
         if(_dataProvider[param2].textColorOver)
         {
            MainMenuButton(param1).textColorOver = _dataProvider[param2].textColorOver;
         }
         if(_dataProvider[param2].tooltip)
         {
            SoundButtonEx(param1).tooltip = _dataProvider[param2].tooltip;
         }
      }
      
      override protected function draw() : void {
         if((isInvalid(InvalidationType.RENDERERS)) || (isInvalid(InvalidationType.DATA)) || (isInvalid(InvalidationType.SETTINGS)) || (isInvalid(InvalidationType.SIZE)))
         {
            this.visible = true;
            removeChild(container);
            addChild(container);
            this.updateRenderers();
         }
      }
      
      override public function set selectedIndex(param1:int) : void {
         super.selectedIndex = param1;
         this.updateSubItem(this.subItemSelectedIndex,"");
      }
      
      private function updateSubItem(param1:Number, param2:String) : void {
         var _loc3_:MainMenuButton = null;
         if(param1 >= 0)
         {
            _loc3_ = _renderers[this.subItemSelectedIndex] as MainMenuButton;
            if(_loc3_)
            {
               _loc3_.setExternalState(param2);
            }
            if(param2 == "")
            {
               this._subItemSelectedIndex = -1;
            }
         }
      }
      
      public function get subItemSelectedIndex() : int {
         return this._subItemSelectedIndex;
      }
      
      public function set subItemSelectedIndex(param1:int) : void {
         this.updateSubItem(this._subItemSelectedIndex,"");
         this._subItemSelectedIndex = param1;
         this.updateSubItem(this._subItemSelectedIndex,MainMenuButton.SUB_SELECTED);
      }
   }
}
