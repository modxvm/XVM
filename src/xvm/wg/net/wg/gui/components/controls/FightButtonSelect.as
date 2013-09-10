package net.wg.gui.components.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.ui.*;
    
    public class FightButtonSelect extends net.wg.gui.components.controls.DropdownMenu
    {
        public function FightButtonSelect()
        {
            super();
            handleScroll = false;
            return;
        }

        public override function open():void
        {
            if (selected) 
                return;
            selected = true;
            stage.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleStageClick, false, 0, true);
            this.showDropdown();
            if (_dropdownRef) 
            {
                this.y = this.y + _dropdownRef.height;
                this.iconText.textColor = 14008503;
                this.iconText.icon = "arrowUp";
                this.iconText.validateNow();
            }
            return;
        }

        public function get fightBtnlabel():String
        {
            return _label;
        }

        public function set fightBtnlabel(arg1:String):void
        {
            if (this._fightBtnlabel == arg1) 
                return;
            this._fightBtnlabel = arg1;
            invalidateData();
            return;
        }

        public override function close():void
        {
            if (!selected) 
                return;
            selected = false;
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleStageClick, false);
            if (_dropdownRef) 
            {
                this.iconText.icon = "arrowDown";
                this.iconText.textColor = 14008503;
                this.iconText.validateNow();
                this.y = this.y - _dropdownRef.height;
            }
            this.hideDropdown();
            return;
        }

        protected override function updateText():void
        {
            if (!(this._fightBtnlabel == null) && !(this.iconText == null)) 
            {
                this.iconText.text = this._fightBtnlabel;
                this.iconText.validateNow();
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.hitArea = this.hit_mc;
            this.iconText.icon = "arrowDown";
            this.iconText.textColor = 14008503;
            this.iconText.validateNow();
            addEventListener(flash.events.MouseEvent.ROLL_OVER, showTooltip, false, 0, true);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, hideTooltip, false, 0, true);
            addEventListener(flash.events.MouseEvent.MOUSE_DOWN, hideTooltip, false, 0, true);
            return;
        }

        public override function get selectedIndex():int
        {
            return _selectedIndex;
        }

        public override function set selectedIndex(arg1:int):void
        {
            var loc1:*=null;
            var loc2:*=0;
            if (_selectedIndex == arg1) 
                return;
            _selectedIndex = arg1;
            invalidateSelectedIndex();
            if (_dropdownRef != null) 
            {
                loc1 = _dropdownRef as scaleform.clik.controls.CoreList;
                loc2 = loc1 is scaleform.clik.controls.ScrollingList ? (loc1 as scaleform.clik.controls.ScrollingList).scrollPosition : 0;
                dispatchEvent(new scaleform.clik.events.ListEvent(scaleform.clik.events.ListEvent.INDEX_CHANGE, true, false, _selectedIndex, -1, -1, loc1.getRendererAt(_selectedIndex, loc2), _dataProvider[_selectedIndex]));
            }
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.handled) 
                return;
            if (!(_dropdownRef == null) && selected) 
            {
                _dropdownRef.handleInput(arg1);
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
                    if (selected) 
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

        public override function set dataProvider(arg1:scaleform.clik.interfaces.IDataProvider):void
        {
            super.dataProvider = arg1;
            if (_dropdownRef) 
                scaleform.clik.controls.CoreList(_dropdownRef).dataProvider = _dataProvider;
            return;
        }

        protected override function changeFocus():void
        {
            super.changeFocus();
            if (_selected && _dropdownRef) 
                this.close();
            return;
        }

        protected override function showDropdown():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (dropdown == null) 
                return;
            if (dropdown is String && !(dropdown == "")) 
            {
                loc2 = flash.utils.getDefinitionByName(dropdown.toString()) as Class;
                if (loc2 != null) 
                    loc1 = new loc2();
            }
            if (loc1) 
            {
                if (itemRenderer is String && !(itemRenderer == "")) 
                    loc1.itemRenderer = flash.utils.getDefinitionByName(itemRenderer.toString()) as Class;
                else if (itemRenderer is Class) 
                    loc1.itemRenderer = itemRenderer as Class;
                if (scrollBar is String && !(scrollBar == "")) 
                    loc1.scrollBar = flash.utils.getDefinitionByName(scrollBar.toString()) as Class;
                else if (scrollBar is Class) 
                    loc1.scrollBar = scrollBar as Class;
                loc1.selectedIndex = _selectedIndex;
                loc1.width = menuWidth != -1 ? menuWidth : width + menuOffset.left + menuOffset.right;
                loc1.dataProvider = _dataProvider;
                loc1.padding = menuPadding;
                loc1.wrapping = menuWrapping;
                loc1.margin = menuMargin;
                loc1.thumbOffset = {"top":thumbOffsetTop, "bottom":thumbOffsetBottom};
                loc1.focusTarget = this;
                loc1.rowCount = menuRowCount < 1 ? 5 : menuRowCount;
                loc1.labelField = _labelField;
                loc1.labelFunction = _labelFunction;
                loc1.addEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, handleMenuItemClick, false, 0, true);
                _dropdownRef = loc1;
                _dropdownRef.x = x + menuOffset.left;
                _dropdownRef.y = menuDirection != "down" ? y - _dropdownRef.height + menuOffset.bottom : y + height + menuOffset.top;
                parent.addChild(_dropdownRef);
            }
            return;
        }

        protected override function hideDropdown():void
        {
            if (_dropdownRef) 
            {
                _dropdownRef.parent.removeChild(_dropdownRef);
                _dropdownRef = null;
            }
            return;
        }

        protected override function handleStageClick(arg1:flash.events.MouseEvent):void
        {
            if (this.contains(arg1.target as flash.display.DisplayObject)) 
                return;
            if (this._dropdownRef.contains(arg1.target as flash.display.DisplayObject)) 
                return;
            this.close();
            return;
        }

        public static function showTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.showComplex(TOOLTIPS.HEADER_FIGHT_BUTTON_DROPDOWN);
            return;
        }

        public static function hideTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        public var iconText:net.wg.gui.components.controls.IconText;

        public var hit_mc:flash.display.MovieClip;

        protected var _fightBtnlabel:String;
    }
}
