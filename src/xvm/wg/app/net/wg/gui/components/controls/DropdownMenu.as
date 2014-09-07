package net.wg.gui.components.controls
{
    import scaleform.clik.controls.DropdownMenu;
    import net.wg.infrastructure.interfaces.entity.ISoundable;
    import flash.display.MovieClip;
    import net.wg.data.constants.SoundManagerStates;
    import scaleform.clik.controls.ScrollingList;
    import flash.events.MouseEvent;
    import net.wg.gui.components.controls.events.ScrollBarEvent;
    import net.wg.gui.components.controls.events.DropdownMenuEvent;
    import flash.utils.getDefinitionByName;
    import scaleform.clik.controls.CoreList;
    import scaleform.clik.events.ListEvent;
    import flash.events.Event;
    import flash.geom.Point;
    import net.wg.gui.components.controls.helpers.ListUtils;
    import flash.display.DisplayObject;
    import scaleform.clik.interfaces.IDataProvider;
    import scaleform.clik.events.InputEvent;
    import flash.events.TimerEvent;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    
    public class DropdownMenu extends scaleform.clik.controls.DropdownMenu implements ISoundable
    {
        
        public function DropdownMenu()
        {
            super();
        }
        
        private static var HANDLE_SCROLL_INV:String = "handleScrolInv";
        
        private static var INV_LIST_DATA:String = "InvListData";
        
        public var showEmptyItems:Boolean;
        
        private var _soundType:String = "dropDownMenu";
        
        public var soundId:String = "";
        
        private var _handleScroll:Boolean = true;
        
        private var SHADOW_WIDTH:Number = 6;
        
        public var hitMc:MovieClip;
        
        private var _maxRowCount:int = -1;
        
        private var allowScrolling:Boolean = true;
        
        public var checkItemDisabledFunction:Function;
        
        public function get soundType() : String
        {
            return this._soundType;
        }
        
        public function set soundType(param1:String) : void
        {
            if((param1) && !(param1 == this._soundType))
            {
                this._soundType = param1;
            }
        }
        
        public final function getSoundType() : String
        {
            return this.soundType;
        }
        
        public final function getSoundId() : String
        {
            return this.soundId;
        }
        
        public final function getStateOverSnd() : String
        {
            return SoundManagerStates.SND_OVER;
        }
        
        public final function getStateOutSnd() : String
        {
            return SoundManagerStates.SND_OUT;
        }
        
        public final function getStatePressSnd() : String
        {
            return SoundManagerStates.SND_PRESS;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.hitArea = this.hitMc;
            buttonMode = true;
            if(App.soundMgr)
            {
                App.soundMgr.addSoundsHdlrs(this);
            }
            this.calcMenuAvailableRowCount();
        }
        
        override protected function draw() : void
        {
            var _loc1_:ScrollingList = null;
            var _loc2_:* = 0;
            var _loc3_:ScrollingList = null;
            super.draw();
            if((isInvalid(INV_LIST_DATA)) && (_dataProvider))
            {
                if(isOpen())
                {
                    _loc1_ = _dropdownRef as ScrollingList;
                    _loc2_ = menuRowCount < 1?5:menuRowCount;
                    if(_loc1_.rowCount != _loc2_)
                    {
                        this.close();
                        this.open();
                        _loc3_ = _dropdownRef as ScrollingList;
                        _loc3_.validateNow();
                    }
                    else
                    {
                        _loc1_.dataProvider = _dataProvider;
                        _loc1_.validateNow();
                    }
                }
            }
            if(isInvalid(HANDLE_SCROLL_INV))
            {
                removeEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelHandler);
                if(this._handleScroll)
                {
                    addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelHandler,false,0,true);
                }
            }
        }
        
        override public function open() : void
        {
            super.open();
            App.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelHandlerGlobal,false,0,true);
            App.stage.addEventListener(ScrollBarEvent.ON_MOUSE_WHEEL_INSIDE,this.onMouseWheelInside,false);
        }
        
        override public function close() : void
        {
            selected = false;
            App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.handleStageClick,false);
            App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelHandlerGlobal,false);
            App.stage.removeEventListener(ScrollBarEvent.ON_MOUSE_WHEEL_INSIDE,this.onMouseWheelInside,false);
            this.hideDropdown();
            if(!_dropdownRef)
            {
                dispatchEvent(new DropdownMenuEvent(DropdownMenuEvent.CLOSE_DROP_DOWN,null));
            }
        }
        
        override protected function showDropdown() : void
        {
            var _loc1_:MovieClip = null;
            var _loc2_:Class = null;
            if(dropdown == null)
            {
                return;
            }
            if(menuWidth == -1)
            {
                menuWidth = width - this.SHADOW_WIDTH;
            }
            if(dropdown is String && !(dropdown == ""))
            {
                _loc2_ = getDefinitionByName(dropdown.toString()) as Class;
                if(_loc2_ != null)
                {
                    _loc1_ = new _loc2_() as CoreList;
                }
            }
            if(_loc1_)
            {
                if(itemRenderer is String && !(itemRenderer == ""))
                {
                    _loc1_.itemRenderer = getDefinitionByName(itemRenderer.toString()) as Class;
                }
                else if(itemRenderer is Class)
                {
                    _loc1_.itemRenderer = itemRenderer as Class;
                }
                
                if(this.allowScrolling)
                {
                    if(scrollBar is String && !(scrollBar == ""))
                    {
                        _loc1_.scrollBar = getDefinitionByName(scrollBar.toString()) as Class;
                    }
                    else if(scrollBar is Class)
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
                _loc1_.thumbOffset = {"top":thumbOffsetTop,
                "bottom":thumbOffsetBottom
            };
            _loc1_.focusTarget = this;
            _loc1_.rowCount = menuRowCount < 1?5:menuRowCount;
            _loc1_.labelField = _labelField;
            _loc1_.labelFunction = _labelFunction;
            _loc1_.addEventListener(ListEvent.ITEM_CLICK,handleMenuItemClick,false,0,true);
            _dropdownRef = _loc1_;
            App.utils.popupMgr.show(_loc1_,x + menuOffset.left,menuDirection == "down"?y + height + menuOffset.top:y - _dropdownRef.height + menuOffset.bottom,parent);
        }
        stage.addEventListener(Event.RESIZE,this.updateDDPosition);
        if(_dropdownRef)
        {
            dispatchEvent(new DropdownMenuEvent(DropdownMenuEvent.SHOW_DROP_DOWN,_dropdownRef));
        }
    }
    
    private function mouseWheelHandlerGlobal(param1:MouseEvent) : void
    {
        this.tryClosedDropDown();
    }
    
    private function onMouseWheelInside(param1:ScrollBarEvent) : void
    {
        this.tryClosedDropDown();
    }
    
    private function tryClosedDropDown() : void
    {
        var _loc1_:Point = null;
        var _loc2_:* = false;
        if(isOpen())
        {
            _loc1_ = new Point(_dropdownRef.mouseX,_dropdownRef.mouseY);
            _loc1_ = _dropdownRef.localToGlobal(_loc1_);
            _loc2_ = _dropdownRef.hitTestPoint(_loc1_.x,_loc1_.y);
            if(!_loc2_)
            {
                this.close();
            }
        }
    }
    
    private function mouseWheelHandler(param1:MouseEvent) : void
    {
        var _loc3_:* = 0;
        var _loc4_:ScrollingList = null;
        param1.stopPropagation();
        if(App.stage)
        {
            App.stage.dispatchEvent(new ScrollBarEvent(ScrollBarEvent.ON_MOUSE_WHEEL_INSIDE));
        }
        var _loc2_:int = param1.delta > 0?-1:1;
        if(_loc2_ == -1)
        {
            if(selectedIndex < 0)
            {
                _loc3_ = this.getFirstSelectablePosition(0,true);
            }
            else if(selectedIndex > this.getFirstSelectablePosition(0,true))
            {
                _loc3_ = this.getFirstSelectablePosition(selectedIndex - 1,false);
            }
            else
            {
                _loc3_ = this.getFirstSelectablePosition(selectedIndex + _loc2_,true);
            }
            
        }
        else if(selectedIndex == -1)
        {
            _loc3_ = this.getFirstSelectablePosition(0,true);
        }
        else if(selectedIndex < this.getFirstSelectablePosition(_dataProvider.length - 1,false))
        {
            _loc3_ = this.getFirstSelectablePosition(selectedIndex + 1,true);
        }
        else
        {
            _loc3_ = this.getFirstSelectablePosition(selectedIndex + _loc2_,true);
        }
        
        
        if((_dropdownRef) && !(_loc3_ == _selectedIndex))
        {
            _loc4_ = _dropdownRef as ScrollingList;
            if(_loc4_)
            {
                _dropdownRef.selectedIndex = _loc3_;
            }
        }
        this.selectedIndex = _loc3_;
    }
    
    public function getFirstSelectablePosition(param1:int, param2:Boolean = true) : int
    {
        return ListUtils.getFirstSelectablePosition(param1,selectedIndex,_dataProvider,param2,this.checkItemDisabledFunction);
    }
    
    override public function set selectedIndex(param1:int) : void
    {
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
            _loc2_ = _dropdownRef as CoreList;
            _loc3_ = _loc2_ is ScrollingList?(_loc2_ as ScrollingList).scrollPosition:0;
            dispatchEvent(new ListEvent(ListEvent.INDEX_CHANGE,true,false,_selectedIndex,-1,-1,_loc2_.getRendererAt(_selectedIndex,_loc3_),_dataProvider[_selectedIndex]));
        }
        else
        {
            dispatchEvent(new ListEvent(ListEvent.INDEX_CHANGE,true,false,_selectedIndex,-1,-1,null,_dataProvider[_selectedIndex]));
        }
    }
    
    override protected function hideDropdown() : void
    {
        super.hideDropdown();
        App.stage.removeEventListener(Event.RESIZE,this.updateDDPosition);
    }
    
    protected function updateDDPosition(param1:Event) : void
    {
        var _loc2_:Number = x + menuOffset.left;
        var _loc3_:Number = menuDirection == "down"?y + height + menuOffset.top:y - _dropdownRef.height + menuOffset.bottom;
        var _loc4_:Point = parent.localToGlobal(new Point(_loc2_,_loc3_));
        _dropdownRef.x = _loc4_.x;
        _dropdownRef.y = _loc4_.y;
    }
    
    override public function get enabled() : Boolean
    {
        return super.enabled;
    }
    
    override public function set enabled(param1:Boolean) : void
    {
        if(super.enabled == param1)
        {
            return;
        }
        super.enabled = param1;
        if(stage)
        {
            this.close();
        }
    }
    
    override protected function updateText() : void
    {
        if(!(_label == null) && !(textField == null))
        {
            textField.htmlText = _label;
        }
    }
    
    override protected function handleStageClick(param1:MouseEvent) : void
    {
        if(this.contains(param1.target as DisplayObject))
        {
            return;
        }
        if((this._dropdownRef) && (this._dropdownRef.contains(param1.target as DisplayObject)))
        {
            return;
        }
        this.close();
    }
    
    override public function set dataProvider(param1:IDataProvider) : void
    {
        if(_dataProvider == param1)
        {
            return;
        }
        if(_dataProvider != null)
        {
            _dataProvider.removeEventListener(Event.CHANGE,handleDataChange,false);
        }
        _dataProvider = param1;
        if(_dataProvider == null)
        {
            return;
        }
        this.calcMenuAvailableRowCount();
        _dataProvider.addEventListener(Event.CHANGE,handleDataChange,false,0,true);
        invalidateData();
        invalidate(INV_LIST_DATA);
    }
    
    private function calcMenuAvailableRowCount() : void
    {
        var _loc1_:uint = _dataProvider?_dataProvider.length:0;
        if(!menuRowsFixed)
        {
            if(this._maxRowCount < 0)
            {
                menuRowCount = _loc1_;
                this.allowScrolling = false;
            }
            else if(this._maxRowCount < _loc1_)
            {
                menuRowCount = this._maxRowCount;
                this.allowScrolling = true;
            }
            else
            {
                menuRowCount = _loc1_;
                this.allowScrolling = false;
            }
            
        }
        else
        {
            menuRowCount = this._maxRowCount;
            this.allowScrolling = true;
        }
    }
    
    public function get rowCount() : int
    {
        return this._maxRowCount;
    }
    
    public function set rowCount(param1:int) : void
    {
        this._maxRowCount = param1;
        this.calcMenuAvailableRowCount();
        invalidateData();
    }
    
    public function get handleScroll() : Boolean
    {
        return this._handleScroll;
    }
    
    public function set handleScroll(param1:Boolean) : void
    {
        if(this._handleScroll != param1)
        {
            this._handleScroll = param1;
            invalidate(HANDLE_SCROLL_INV);
        }
    }
    
    override protected function onDispose() : void
    {
        this.checkItemDisabledFunction = null;
        removeEventListener(Event.ADDED,addToAutoGroup,false);
        removeEventListener(Event.REMOVED,addToAutoGroup,false);
        removeEventListener(MouseEvent.ROLL_OVER,handleMouseRollOver,false);
        removeEventListener(MouseEvent.ROLL_OUT,handleMouseRollOut,false);
        removeEventListener(MouseEvent.MOUSE_DOWN,handleMousePress,false);
        removeEventListener(MouseEvent.CLICK,handleMouseRelease,false);
        removeEventListener(MouseEvent.DOUBLE_CLICK,handleMouseRelease,false);
        removeEventListener(InputEvent.INPUT,handleInput,false);
        removeEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelHandler,false);
        App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelHandlerGlobal,false);
        App.stage.removeEventListener(ScrollBarEvent.ON_MOUSE_WHEEL_INSIDE,this.onMouseWheelInside,false);
        if(_repeatTimer)
        {
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat,false);
            _repeatTimer.removeEventListener(TimerEvent.TIMER,handleRepeat,false);
        }
        if(_dropdownRef)
        {
            _dropdownRef.removeEventListener(ListEvent.ITEM_CLICK,handleMenuItemClick,false);
            if(_dropdownRef is IDisposable)
            {
                IDisposable(_dropdownRef).dispose();
            }
            _dropdownRef.parent.removeChild(_dropdownRef);
            _dropdownRef = null;
        }
        if(_dataProvider)
        {
            _dataProvider.removeEventListener(Event.CHANGE,handleDataChange,false);
            _dataProvider.cleanUp();
            _dataProvider = null;
        }
        if((scrollBar) && scrollBar is IDisposable)
        {
            IDisposable(scrollBar).dispose();
        }
        if(App.soundMgr)
        {
            App.soundMgr.removeSoundHdlrs(this);
        }
        scrollBar = null;
        this.hitMc = null;
        super.onDispose();
    }
}
}
