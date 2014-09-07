package net.wg.gui.lobby.header.headerButtonBar
{
    import scaleform.clik.controls.ButtonBar;
    import net.wg.gui.interfaces.IHelpLayoutComponent;
    import flash.geom.Rectangle;
    import flash.display.DisplayObject;
    import scaleform.clik.interfaces.IDataProvider;
    import scaleform.clik.controls.Button;
    import net.wg.data.constants.Values;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.lobby.header.events.HeaderEvents;
    import net.wg.gui.lobby.header.vo.HeaderButtonVo;
    import flash.text.TextFieldAutoSize;
    import net.wg.utils.IHelpLayout;
    import net.wg.data.constants.Directions;
    
    public class HeaderButtonBar extends ButtonBar implements IHelpLayoutComponent
    {
        
        public function HeaderButtonBar()
        {
            super();
        }
        
        private var _currentScreen:String = "";
        
        private var _screenWidth:Number;
        
        private var _wideScreenPrc:Number = 0;
        
        private var _maxScreenPrc:Number = 0;
        
        private var _centerItemNum:Number;
        
        private var _centerItemRect:Rectangle = null;
        
        private var _itemsUpdated:Number = 0;
        
        private var _firstLeftRightAlignItemIsSet:Boolean = true;
        
        private var _lastRightLeftAlignItem:HeaderButton = null;
        
        private var _financeHelpLayout:DisplayObject;
        
        override protected function configUI() : void
        {
            this.visible = false;
            super.configUI();
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
        
        override public function set dataProvider(param1:IDataProvider) : void
        {
            this._itemsUpdated = 0;
            this._centerItemNum = -1;
            super.dataProvider = param1;
        }
        
        override protected function updateRenderers() : void
        {
            var _loc3_:* = 0;
            var _loc4_:Button = null;
            var _loc5_:* = false;
            var _loc1_:DisplayObject = null;
            if(_renderers[0] is Class(_itemRendererClass))
            {
                while(_renderers.length > _dataProvider.length)
                {
                    _loc3_ = _renderers.length - 1;
                    if(container.contains(_renderers[_loc3_]))
                    {
                        _loc1_ = _renderers[_loc3_];
                        container.removeChild(_loc1_);
                        this.removeRenderer(_loc1_);
                    }
                    _renderers.splice(_loc3_--,1);
                }
            }
            else
            {
                while(container.numChildren > 0)
                {
                    _loc1_ = container.removeChildAt(0);
                    this.removeRenderer(_loc1_);
                }
                _renderers.length = 0;
            }
            this._firstLeftRightAlignItemIsSet = true;
            this._lastRightLeftAlignItem = null;
            var _loc2_:uint = 0;
            while(_loc2_ < _dataProvider.length)
            {
                _loc5_ = false;
                if(_loc2_ < _renderers.length)
                {
                    _loc4_ = _renderers[_loc2_];
                }
                else
                {
                    _loc4_ = new _itemRendererClass();
                    this.setupRenderer(_loc4_,_loc2_);
                    _loc5_ = true;
                }
                this.populateRendererData(_loc4_,_loc2_);
                _loc4_.validateNow();
                if((_loc5_) && !(_loc4_ == null))
                {
                    _loc4_.group = _group;
                    container.addChild(_loc4_);
                    _renderers.push(_loc4_);
                    if(this._currentScreen != Values.EMPTY_STR)
                    {
                        this.updateRendererScreen(_loc4_);
                    }
                }
                _loc2_++;
            }
        }
        
        private function removeRenderer(param1:DisplayObject) : void
        {
            if(param1 is IDisposable)
            {
                IDisposable(param1).dispose();
            }
            param1.removeEventListener(HeaderEvents.HBC_SIZE_UPDATED,this.onContentUpdated);
            var param1:DisplayObject = null;
        }
        
        private function onContentUpdated(param1:HeaderEvents) : void
        {
            if(this._itemsUpdated < _renderers.length)
            {
                this._itemsUpdated++;
            }
            if(this._itemsUpdated >= _renderers.length && !this.visible)
            {
                this.visible = true;
            }
            this.repositionItems();
        }
        
        private function repositionItems() : void
        {
            var _loc1_:HeaderButton = null;
            var _loc2_:HeaderButtonVo = null;
            var _loc3_:* = NaN;
            var _loc4_:* = NaN;
            if((_renderers) && _renderers.length > 0)
            {
                if(this._itemsUpdated < _renderers.length)
                {
                    return;
                }
                _loc3_ = 0;
                _loc4_ = 0;
                _loc3_ = 0;
                while(_loc3_ < _renderers.length && _loc3_ < this._centerItemNum)
                {
                    _loc1_ = _renderers[_loc3_];
                    if(_loc1_.isReadyToShow)
                    {
                        _loc2_ = _loc1_.headerButtonData;
                        if(_loc2_.direction == TextFieldAutoSize.LEFT && _loc2_.align == TextFieldAutoSize.LEFT)
                        {
                            _loc1_.x = _loc4_ ^ 0;
                            _loc4_ = _loc4_ + _loc1_.bounds.width;
                        }
                        else
                        {
                            break;
                        }
                    }
                    _loc3_++;
                }
                _loc4_ = this._centerItemRect.x;
                _loc3_ = this._centerItemNum - 1;
                while(_loc3_ >= 0)
                {
                    _loc1_ = _renderers[_loc3_];
                    if(_loc1_.isReadyToShow)
                    {
                        _loc2_ = _loc1_.headerButtonData;
                        if(_loc2_.direction == TextFieldAutoSize.LEFT && _loc2_.align == TextFieldAutoSize.RIGHT)
                        {
                            _loc4_ = _loc4_ - _loc1_.bounds.width;
                            _loc1_.x = _loc4_ ^ 0;
                        }
                        else
                        {
                            break;
                        }
                    }
                    _loc3_--;
                }
                _loc4_ = this._screenWidth;
                _loc3_ = _renderers.length - 1;
                while(_loc3_ >= this._centerItemNum)
                {
                    _loc1_ = _renderers[_loc3_];
                    if(_loc1_.isReadyToShow)
                    {
                        _loc2_ = _loc1_.headerButtonData;
                        if(_loc2_.direction == TextFieldAutoSize.RIGHT && _loc2_.align == TextFieldAutoSize.RIGHT)
                        {
                            _loc4_ = _loc4_ + -_loc1_.bounds.width;
                            _loc1_.x = _loc4_ ^ 0;
                        }
                        else
                        {
                            break;
                        }
                    }
                    _loc3_--;
                }
                _loc4_ = this._centerItemRect.x + this._centerItemRect.width;
                _loc3_ = this._centerItemNum;
                while(_loc3_ < _renderers.length)
                {
                    _loc1_ = _renderers[_loc3_];
                    if(_loc1_.isReadyToShow)
                    {
                        _loc2_ = _loc1_.headerButtonData;
                        if(_loc2_.direction == TextFieldAutoSize.RIGHT && _loc2_.align == TextFieldAutoSize.LEFT)
                        {
                            _loc1_.x = _loc4_ ^ 0;
                            _loc4_ = _loc4_ + _loc1_.bounds.width;
                        }
                        else
                        {
                            break;
                        }
                    }
                    _loc3_++;
                }
            }
            this.updateFreeSizeButtons();
            dispatchEvent(new HeaderEvents(HeaderEvents.HEADER_ITEMS_REPOSITION,this._screenWidth));
        }
        
        private function updateFreeSizeButtons() : void
        {
            var _loc4_:HeaderButtonVo = null;
            if(!_renderers || _renderers.length == 0)
            {
                return;
            }
            var _loc1_:HeaderButton = null;
            var _loc2_:HeaderButton = null;
            var _loc3_:HeaderButton = null;
            var _loc5_:Number = 0;
            var _loc6_:Number = 0;
            var _loc7_:Number = 0;
            while(_loc7_ < _renderers.length)
            {
                _loc1_ = _renderers[_loc7_];
                _loc4_ = _loc1_.headerButtonData;
                if((_loc4_) && (_loc4_.isUseFreeSize))
                {
                    if(!_loc2_ && _loc4_.direction == TextFieldAutoSize.LEFT)
                    {
                        _loc2_ = _loc1_;
                    }
                    if(!_loc3_ && _loc4_.direction == TextFieldAutoSize.RIGHT)
                    {
                        _loc3_ = _loc1_;
                    }
                }
                else if(_loc4_.direction == TextFieldAutoSize.LEFT)
                {
                    _loc5_ = _loc5_ + _loc1_.bounds.width;
                }
                else
                {
                    _loc6_ = _loc6_ + _loc1_.bounds.width;
                }
                
                _loc7_++;
            }
            if(_loc2_)
            {
                _loc5_ = this._centerItemRect.x - _loc5_;
                _loc2_.content.setAvailableWidth(_loc5_);
            }
            if(_loc3_)
            {
                _loc6_ = this._screenWidth - (this._centerItemRect.x + this._centerItemRect.width + _loc6_);
                _loc3_.content.setAvailableWidth(_loc6_);
            }
        }
        
        override protected function setupRenderer(param1:Button, param2:uint) : void
        {
            param1.owner = this;
            param1.focusable = false;
            param1.focusTarget = this;
            param1.toggle = false;
            param1.allowDeselect = false;
            param1.addEventListener(HeaderEvents.HBC_SIZE_UPDATED,this.onContentUpdated);
        }
        
        override protected function populateRendererData(param1:Button, param2:uint) : void
        {
            var _loc3_:HeaderButton = HeaderButton(param1);
            var _loc4_:HeaderButtonVo = HeaderButtonVo(dataProvider.requestItemAt(param2));
            if(_loc4_.direction == TextFieldAutoSize.RIGHT && this._centerItemNum == -1)
            {
                this._centerItemNum = param2;
            }
            var _loc5_:* = true;
            if(_loc4_.direction == TextFieldAutoSize.LEFT && _loc4_.align == TextFieldAutoSize.LEFT)
            {
                _loc5_ = true;
            }
            else if(_loc4_.direction == TextFieldAutoSize.LEFT && _loc4_.align == TextFieldAutoSize.RIGHT && (this._firstLeftRightAlignItemIsSet))
            {
                this._firstLeftRightAlignItemIsSet = false;
                _loc5_ = false;
            }
            else if(_loc4_.direction == TextFieldAutoSize.RIGHT && _loc4_.align == TextFieldAutoSize.LEFT)
            {
                this._lastRightLeftAlignItem = _loc3_;
            }
            else if(_loc4_.direction == TextFieldAutoSize.RIGHT && _loc4_.align == TextFieldAutoSize.RIGHT)
            {
                _loc5_ = true;
                if(this._lastRightLeftAlignItem)
                {
                    this._lastRightLeftAlignItem.isShowSeparator = false;
                }
            }
            
            
            
            _loc3_.isShowSeparator = _loc5_;
            _loc3_.data = _loc4_;
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:DisplayObject = null;
            while(container.numChildren > 0)
            {
                _loc1_ = container.removeChildAt(0);
                this.removeRenderer(_loc1_);
            }
            _renderers = null;
            this._lastRightLeftAlignItem = null;
            super.onDispose();
        }
        
        public function updateScreen(param1:String, param2:Number, param3:Number, param4:Number) : void
        {
            var _loc5_:* = NaN;
            this._screenWidth = param2;
            if(!(this._currentScreen == param1) || !(this._wideScreenPrc == param3) || !(this._maxScreenPrc == param4))
            {
                this._wideScreenPrc = param3;
                this._maxScreenPrc = param4;
                this._currentScreen = param1;
                this._itemsUpdated = 0;
                if((_renderers) && _renderers.length > 0)
                {
                    _loc5_ = 0;
                    while(_loc5_ < _renderers.length)
                    {
                        this.updateRendererScreen(_renderers[_loc5_]);
                        _loc5_++;
                    }
                }
            }
            this.repositionItems();
        }
        
        private function updateRendererScreen(param1:Button) : void
        {
            HeaderButton(param1).updateScreen(this._currentScreen,this._wideScreenPrc,this._maxScreenPrc);
        }
        
        public function updateCenterItem(param1:Rectangle) : void
        {
            this._centerItemRect = param1;
        }
        
        public function showHelpLayoutById(param1:Array) : void
        {
            var _loc2_:* = NaN;
            var _loc3_:HeaderButtonVo = null;
            var _loc4_:HeaderButton = null;
            if((_renderers) && _renderers.length > 0)
            {
                _loc2_ = 0;
                while(_loc2_ < _renderers.length)
                {
                    _loc3_ = HeaderButtonVo(dataProvider.requestItemAt(_loc2_));
                    if(param1.indexOf(_loc3_.id) > -1)
                    {
                        _loc4_ = this.getRendererAt(_loc2_);
                        _loc4_.showHelpLayout();
                    }
                    _loc2_++;
                }
            }
        }
        
        public function showFinanceHelpLayout() : void
        {
            var _loc10_:* = NaN;
            var _loc11_:HeaderButtonVo = null;
            var _loc12_:HeaderButton = null;
            var _loc1_:IHelpLayout = App.utils.helpLayout;
            var _loc2_:Number = 0;
            var _loc3_:Number = 0;
            var _loc4_:Array = [HeaderButtonsHelper.ITEM_ID_GOLD,HeaderButtonsHelper.ITEM_ID_SILVER,HeaderButtonsHelper.ITEM_ID_FREEXP];
            var _loc5_:HeaderButton = null;
            var _loc6_:HeaderButton = null;
            var _loc7_:HeaderButton = null;
            var _loc8_:HeaderButton = null;
            if((_renderers) && _renderers.length > 0)
            {
                _loc10_ = 0;
                while(_loc10_ < _renderers.length)
                {
                    _loc11_ = HeaderButtonVo(dataProvider.requestItemAt(_loc10_));
                    if(_loc4_.indexOf(_loc11_.id) > -1)
                    {
                        _loc12_ = this.getRendererAt(_loc10_);
                        if(_loc5_)
                        {
                            if(_loc12_.x < _loc5_.x)
                            {
                                _loc5_ = _loc12_;
                            }
                        }
                        else
                        {
                            _loc5_ = _loc12_;
                        }
                        if(_loc6_)
                        {
                            if(_loc12_.x > _loc6_.x)
                            {
                                _loc6_ = _loc12_;
                            }
                        }
                        else
                        {
                            _loc6_ = _loc12_;
                        }
                        if(_loc7_)
                        {
                            if(_loc12_.y < _loc7_.y)
                            {
                                _loc7_ = _loc12_;
                            }
                        }
                        else
                        {
                            _loc7_ = _loc12_;
                        }
                        if(_loc8_)
                        {
                            if(_loc12_.y > _loc8_.y)
                            {
                                _loc8_ = _loc12_;
                            }
                        }
                        else
                        {
                            _loc8_ = _loc12_;
                        }
                    }
                    _loc10_++;
                }
                _loc2_ = _loc6_.x + _loc6_.bounds.width - _loc5_.x;
                _loc3_ = _loc8_.y + _loc8_.bounds.height - _loc7_.y;
            }
            var _loc9_:Object = _loc1_.getProps(_loc2_ - 1,_loc3_ - 2,Directions.BOTTOM,LOBBY_HELP.HEADER_FINANCE_BLOCK,1,1,39);
            this._financeHelpLayout = _loc1_.create(root,_loc9_,_loc5_);
        }
        
        public function closeFinanceHelpLayout() : void
        {
            var _loc1_:IHelpLayout = null;
            if(this._financeHelpLayout)
            {
                _loc1_ = App.utils.helpLayout;
                _loc1_.destroy(this._financeHelpLayout);
            }
            this._financeHelpLayout = null;
        }
        
        public function getRendererAt(param1:uint, param2:int = 0) : HeaderButton
        {
            if(_renderers == null)
            {
                return null;
            }
            var _loc3_:uint = param1 - param2;
            if(_loc3_ >= _renderers.length)
            {
                return null;
            }
            return _renderers[_loc3_] as HeaderButton;
        }
        
        public function showHelpLayout() : void
        {
            var _loc1_:Array = [HeaderButtonsHelper.ITEM_ID_SETTINGS,HeaderButtonsHelper.ITEM_ID_ACCOUNT,HeaderButtonsHelper.ITEM_ID_PREM,HeaderButtonsHelper.ITEM_ID_SQUAD,HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR];
            this.showHelpLayoutById(_loc1_);
            this.showFinanceHelpLayout();
        }
        
        public function closeHelpLayout() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:HeaderButton = null;
            if((_renderers) && _renderers.length > 0)
            {
                _loc1_ = 0;
                while(_loc1_ < _renderers.length)
                {
                    _loc2_ = HeaderButton(this.getRendererAt(_loc1_));
                    _loc2_.closeHelpLayout();
                    _loc1_++;
                }
            }
            this.closeFinanceHelpLayout();
        }
    }
}
