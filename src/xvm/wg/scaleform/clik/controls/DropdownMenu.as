package scaleform.clik.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.managers.*;
    import scaleform.clik.ui.*;
    import scaleform.clik.utils.*;
    
    public class DropdownMenu extends scaleform.clik.controls.Button
    {
        public function DropdownMenu()
        {
            super();
            return;
        }

        public function get labelFunction():Function
        {
            return this._labelFunction;
        }

        public function set labelFunction(arg1:Function):void
        {
            this._labelFunction = arg1;
            invalidateData();
            return;
        }

        public function itemToLabel(arg1:Object):String
        {
            if (arg1 == null) 
                return "";
            if (this._labelFunction != null) 
                return this._labelFunction(arg1);
            if (arg1 is String) 
                return arg1.toString();
            if (!(this._labelField == null) && !(arg1[this._labelField] == null)) 
                return arg1[this._labelField];
            return arg1.toString();
        }

        public function open():void
        {
            this.selected = true;
            stage.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleStageClick, false, 0, true);
            this.showDropdown();
            return;
        }

        public function close():void
        {
            this.selected = false;
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleStageClick, false);
            this.hideDropdown();
            return;
        }

        public function isOpen():Boolean
        {
            return !(this._dropdownRef == null);
        }

        public override function set toggle(arg1:Boolean):void
        {
            super.toggle = arg1;
            return;
        }

        public function invalidateSelectedIndex():void
        {
            invalidate(scaleform.clik.constants.InvalidationType.SELECTED_INDEX);
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.handled) 
                return;
            if (!(this._dropdownRef == null) && this.selected) 
            {
                this._dropdownRef.handleInput(arg1);
                if (arg1.handled) 
                    return;
            }
            super.handleInput(arg1);
            var loc1:*=arg1.details;
            var loc2:*=loc1.value == scaleform.clik.constants.InputValue.KEY_DOWN;
            var loc3:*=loc1.navEquivalent;
            switch (loc3) 
            {
                case scaleform.clik.constants.NavigationCode.ESCAPE:
                    if (this.selected) 
                    {
                        if (loc2) 
                            this.close();
                        arg1.handled = true;
                    }
                default:
                    break;
            }
            return;
        }

        public override function toString():String
        {
            return "[CLIK DropdownMenu " + name + "]";
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.SELECTED_INDEX) || isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this._dataProvider.requestItemAt(this._selectedIndex, this.populateText);
                invalidateData();
            }
            super.draw();
            return;
        }

        protected override function changeFocus():void
        {
            super.changeFocus();
            if (_selected && this._dropdownRef) 
                this.close();
            return;
        }

        protected function handleDataChange(arg1:flash.events.Event):void
        {
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        protected function populateText(arg1:Object):void
        {
            this.updateLabel(arg1);
            dispatchEvent(new flash.events.Event(flash.events.Event.CHANGE));
            return;
        }

        protected function updateLabel(arg1:Object):void
        {
            _label = this.itemToLabel(arg1);
            return;
        }

        protected function handleStageClick(arg1:flash.events.MouseEvent):void
        {
            if (this.contains(arg1.target as flash.display.DisplayObject)) 
                return;
            if (this._dropdownRef.contains(arg1.target as flash.display.DisplayObject)) 
                return;
            this.close();
            return;
        }

        protected function showDropdown():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.dropdown == null) 
                return;
            if (this.dropdown is String && !(this.dropdown == "")) 
            {
                loc2 = flash.utils.getDefinitionByName(this.dropdown.toString()) as Class;
                if (loc2 != null) 
                    loc1 = new loc2() as scaleform.clik.controls.CoreList;
            }
            if (loc1) 
            {
                if (this.itemRenderer is String && !(this.itemRenderer == "")) 
                    loc1.itemRenderer = flash.utils.getDefinitionByName(this.itemRenderer.toString()) as Class;
                else if (this.itemRenderer is Class) 
                    loc1.itemRenderer = this.itemRenderer as Class;
                if (this.scrollBar is String && !(this.scrollBar == "")) 
                    loc1.scrollBar = flash.utils.getDefinitionByName(this.scrollBar.toString()) as Class;
                else if (this.scrollBar is Class) 
                    loc1.scrollBar = this.scrollBar as Class;
                loc1.selectedIndex = this._selectedIndex;
                loc1.width = this.menuWidth != -1 ? this.menuWidth : width + this.menuOffset.left + this.menuOffset.right;
                loc1.dataProvider = this._dataProvider;
                loc1.padding = this.menuPadding;
                loc1.wrapping = this.menuWrapping;
                loc1.margin = this.menuMargin;
                loc1.thumbOffset = {"top":this.thumbOffsetTop, "bottom":this.thumbOffsetBottom};
                loc1.focusTarget = this;
                loc1.rowCount = this.menuRowCount < 1 ? 5 : this.menuRowCount;
                loc1.labelField = this._labelField;
                loc1.labelFunction = this._labelFunction;
                loc1.addEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, this.handleMenuItemClick, false, 0, true);
                this._dropdownRef = loc1;
                scaleform.clik.managers.PopUpManager.show(loc1, x + this.menuOffset.left, this.menuDirection != "down" ? y - this._dropdownRef.height + this.menuOffset.bottom : y + height + this.menuOffset.top, parent);
            }
            return;
        }

        protected function hideDropdown():void
        {
            if (this._dropdownRef) 
            {
                this._dropdownRef.parent.removeChild(this._dropdownRef);
                this._dropdownRef = null;
            }
            return;
        }

        protected function handleMenuItemClick(arg1:scaleform.clik.events.ListEvent):void
        {
            this.selectedIndex = arg1.index;
            this.close();
            return;
        }

        protected override function initialize():void
        {
            this.dataProvider = new scaleform.clik.data.DataProvider();
            this.menuOffset = new scaleform.clik.utils.Padding(0, 0, 0, 0);
            this.menuPadding = new scaleform.clik.utils.Padding(0, 0, 0, 0);
            super.initialize();
            return;
        }

        public override function get autoRepeat():Boolean
        {
            return false;
        }

        public override function set autoRepeat(arg1:Boolean):void
        {
            return;
        }

        public override function get data():Object
        {
            return null;
        }

        public override function set data(arg1:Object):void
        {
            return;
        }

        public override function get label():String
        {
            return "";
        }

        public override function set label(arg1:String):void
        {
            return;
        }

        public override function get selected():Boolean
        {
            return super.selected;
        }

        public override function set selected(arg1:Boolean):void
        {
            super.selected = arg1;
            return;
        }

        public override function get toggle():Boolean
        {
            return super.toggle;
        }

        protected override function handleClick(arg1:uint=0):void
        {
            if (_selected) 
                this.close();
            else 
                this.open();
            super.handleClick();
            return;
        }

        public function set inspectableMenuPadding(arg1:Object):void
        {
            if (!componentInspectorSetting) 
                return;
            this.menuPadding = new scaleform.clik.utils.Padding(arg1.top, arg1.right, arg1.bottom, arg1.left);
            return;
        }

        public function set inspectableMenuOffset(arg1:Object):void
        {
            if (!componentInspectorSetting) 
                return;
            this.menuOffset = new scaleform.clik.utils.Padding(arg1.top, arg1.right, arg1.bottom, arg1.left);
            return;
        }

        public function set inspectableThumbOffset(arg1:Object):void
        {
            if (!componentInspectorSetting) 
                return;
            this.thumbOffsetTop = Number(arg1.top);
            this.thumbOffsetBottom = Number(arg1.bottom);
            return;
        }

        public override function get focusable():Boolean
        {
            return _focusable;
        }

        public override function set focusable(arg1:Boolean):void
        {
            super.focusable = arg1;
            return;
        }

        public function get selectedIndex():int
        {
            return this._selectedIndex;
        }

        public function set selectedIndex(arg1:int):void
        {
            var loc1:*=null;
            var loc2:*=0;
            if (this._selectedIndex == arg1) 
                return;
            this._selectedIndex = arg1;
            this.invalidateSelectedIndex();
            if (this._dropdownRef != null) 
            {
                loc1 = this._dropdownRef as scaleform.clik.controls.CoreList;
                loc2 = loc1 is scaleform.clik.controls.ScrollingList ? (loc1 as scaleform.clik.controls.ScrollingList).scrollPosition : 0;
                dispatchEvent(new scaleform.clik.events.ListEvent(scaleform.clik.events.ListEvent.INDEX_CHANGE, true, false, this._selectedIndex, -1, -1, loc1.getRendererAt(this._selectedIndex, loc2), this._dataProvider[this._selectedIndex]));
            }
            return;
        }

        public function get dataProvider():scaleform.clik.interfaces.IDataProvider
        {
            return this._dataProvider;
        }

        public function set dataProvider(arg1:scaleform.clik.interfaces.IDataProvider):void
        {
            if (this._dataProvider == arg1) 
                return;
            if (this._dataProvider != null) 
                this._dataProvider.removeEventListener(flash.events.Event.CHANGE, this.handleDataChange, false);
            this._dataProvider = arg1;
            var loc1:*=this._dataProvider.length;
            if (!this.menuRowsFixed && loc1 > 0 && loc1 < this.menuRowCount) 
                this.menuRowCount = loc1;
            if (this._dataProvider == null) 
                return;
            this._dataProvider.addEventListener(flash.events.Event.CHANGE, this.handleDataChange, false, 0, true);
            invalidateData();
            return;
        }

        public function get labelField():String
        {
            return this._labelField;
        }

        public function set labelField(arg1:String):void
        {
            this._labelField = arg1;
            invalidateData();
            return;
        }

        public var dropdown:Object="CLIKScrollingList";

        public var itemRenderer:Object="CLIKListItemRenderer";

        public var scrollBar:Object;

        public var menuWrapping:String="normal";

        public var menuDirection:String="down";

        public var menuWidth:Number=-1;

        public var menuRowCount:Number=5;

        public var menuRowsFixed:Boolean=true;

        public var menuPadding:scaleform.clik.utils.Padding;

        public var menuOffset:scaleform.clik.utils.Padding;

        public var thumbOffsetTop:Number;

        public var thumbOffsetBottom:Number;

        protected var _selectedIndex:int=-1;

        protected var _dataProvider:scaleform.clik.interfaces.IDataProvider;

        protected var _labelField:String="label";

        protected var _labelFunction:Function;

        protected var _popup:flash.display.MovieClip;

        protected var _dropdownRef:flash.display.MovieClip=null;

        public var menuMargin:Number=1;
    }
}
