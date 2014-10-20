package net.wg.gui.lobby.header.mainMenuButtonBar
{
    import scaleform.clik.controls.ButtonBar;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.controls.Button;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.components.controls.MainMenuButton;
    import scaleform.clik.constants.InvalidationType;
    
    public class MainMenuButtonBar extends ButtonBar
    {
        
        public function MainMenuButtonBar()
        {
            super();
            this.visible = false;
        }
        
        private static var MAX_WIDTH:Number = 1024;
        
        public var paddingTop:Number = 0;
        
        public var paddingLeft:Number = 0;
        
        public var paddingRight:Number = 0;
        
        private var _disableNav:Boolean = false;
        
        private var _subItemSelectedIndex:Number = -1;
        
        public function setDisableNav(param1:Boolean) : void
        {
            this._disableNav = param1;
            this.enabled = !param1;
        }
        
        override public function handleInput(param1:InputEvent) : void
        {
            if(!this._disableNav)
            {
                super.handleInput(param1);
            }
        }
        
        override protected function updateRenderers() : void
        {
            var _loc4_:* = 0;
            var _loc5_:Button = null;
            var _loc6_:* = false;
            var _loc1_:Number = this.paddingLeft + this.paddingRight;
            var _loc2_:* = -1;
            if(_renderers[0] is Class(_itemRendererClass))
            {
                while(_renderers.length > _dataProvider.length)
                {
                    _loc4_ = _renderers.length - 1;
                    if(container.contains(_renderers[_loc4_]))
                    {
                        container.removeChild(_renderers[_loc4_]);
                    }
                    _renderers.splice(_loc4_--,1);
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
            var _loc3_:uint = 0;
            while(_loc3_ < _dataProvider.length && _loc2_ == -1)
            {
                _loc6_ = false;
                if(_loc3_ < _renderers.length)
                {
                    _loc5_ = _renderers[_loc3_];
                }
                else
                {
                    _loc5_ = new _itemRendererClass();
                    setupRenderer(_loc5_,_loc3_);
                    _loc6_ = true;
                }
                this.populateRendererData(_loc5_,_loc3_);
                if(_autoSize == TextFieldAutoSize.NONE && _buttonWidth > 0)
                {
                    _loc5_.width = Math.round(_buttonWidth);
                }
                else if(_autoSize != TextFieldAutoSize.NONE)
                {
                    _loc5_.autoSize = _autoSize;
                }
                
                _loc5_.validateNow();
                if(_loc1_ > MAX_WIDTH)
                {
                    _loc5_.dispose();
                    _loc5_ = null;
                    break;
                }
                if(_loc6_)
                {
                    _loc5_.x = _loc1_ ^ 0;
                    _loc1_ = _loc1_ + (_loc5_.width + spacing);
                    _loc5_.y = this.paddingTop;
                    _loc5_.group = _group;
                    container.addChild(_loc5_);
                    _renderers.push(_loc5_);
                }
                _loc3_++;
            }
            this.updateLayout(_loc1_);
            this.selectedIndex = Math.min(_dataProvider.length - 1,_selectedIndex);
        }
        
        private function updateLayout(param1:Number) : void
        {
            var _loc2_:Button = null;
            var _loc3_:Number = 0;
            var _loc4_:Number = this.paddingLeft;
            switch(_autoSize)
            {
                case TextFieldAutoSize.NONE:
                case TextFieldAutoSize.LEFT:
                    _loc3_ = 0;
                    break;
                case TextFieldAutoSize.CENTER:
                    _loc3_ = -(param1 >> 1);
                    break;
                case TextFieldAutoSize.RIGHT:
                    _loc3_ = -param1;
                    break;
            }
            _loc4_ = _loc4_ + _loc3_;
            var _loc5_:Number = 0;
            while(_loc5_ < _renderers.length)
            {
                _loc2_ = _renderers[_loc5_];
                _loc2_.x = _loc4_;
                _loc4_ = _loc4_ + (_loc2_.width + spacing);
                _loc5_++;
            }
        }
        
        override protected function populateRendererData(param1:Button, param2:uint) : void
        {
            param1.label = itemToLabel(_dataProvider.requestItemAt(param2));
            param1.data = _dataProvider.requestItemAt(param2);
            param1.selected = param2 == selectedIndex;
            if(_dataProvider[param2].textColor)
            {
                MainMenuButton(param1).textColor = _dataProvider[param2].textColor;
            }
            if(_dataProvider[param2].textColorOver)
            {
                MainMenuButton(param1).textColorOver = _dataProvider[param2].textColorOver;
            }
            if(_dataProvider[param2].tooltip)
            {
                MainMenuButton(param1).tooltip = _dataProvider[param2].tooltip;
            }
        }
        
        override protected function draw() : void
        {
            if((isInvalid(InvalidationType.RENDERERS)) || (isInvalid(InvalidationType.DATA)) || (isInvalid(InvalidationType.SETTINGS)) || (isInvalid(InvalidationType.SIZE)))
            {
                this.visible = true;
                removeChild(container);
                addChild(container);
                this.updateRenderers();
            }
        }
        
        override public function set selectedIndex(param1:int) : void
        {
            super.selectedIndex = param1;
            this.updateSubItem(this.subItemSelectedIndex,"");
        }
        
        private function updateSubItem(param1:Number, param2:String) : void
        {
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
        
        public function get subItemSelectedIndex() : int
        {
            return this._subItemSelectedIndex;
        }
        
        public function set subItemSelectedIndex(param1:int) : void
        {
            this.updateSubItem(this._subItemSelectedIndex,"");
            this._subItemSelectedIndex = param1;
            this.updateSubItem(this._subItemSelectedIndex,MainMenuButton.SUB_SELECTED);
        }
    }
}
