package net.wg.gui.components.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.managers.*;

    public class DropdownMenu extends scaleform.clik.controls.DropdownMenu implements net.wg.infrastructure.interfaces.entity.ISoundable
    {
        public function DropdownMenu()
        {
            super();
            return;
        }

        protected override function handleStageClick(arg1:flash.events.MouseEvent):void
        {
            if (this.contains(arg1.target as flash.display.DisplayObject))
                return;
            if (this._dropdownRef && this._dropdownRef.contains(arg1.target as flash.display.DisplayObject))
                return;
            close();
            return;
        }

        public override function set dataProvider(arg1:scaleform.clik.interfaces.IDataProvider):void
        {
            if (_dataProvider == arg1)
                return;
            if (_dataProvider != null)
                _dataProvider.removeEventListener(flash.events.Event.CHANGE, handleDataChange, false);
            _dataProvider = arg1;
            if (_dataProvider == null)
                return;
            this.calcMenuAvailableRowCount();
            _dataProvider.addEventListener(flash.events.Event.CHANGE, handleDataChange, false, 0, true);
            invalidateData();
            return;
        }

        internal function calcMenuAvailableRowCount():void
        {
            var loc1:*=_dataProvider ? _dataProvider.length : 0;
            if (menuRowsFixed)
            {
                menuRowCount = this._maxRowCount;
                this.allowScrolling = true;
            }
            else if (this._maxRowCount < 0)
            {
                menuRowCount = loc1;
                this.allowScrolling = false;
            }
            else if (this._maxRowCount < loc1)
            {
                menuRowCount = this._maxRowCount;
                this.allowScrolling = true;
            }
            else
            {
                menuRowCount = loc1;
                this.allowScrolling = false;
            }
            return;
        }

        public function get rowCount():int
        {
            return this._maxRowCount;
        }

        public function set rowCount(arg1:int):void
        {
            this._maxRowCount = arg1;
            this.calcMenuAvailableRowCount();
            invalidateData();
            return;
        }

        public function get handleScroll():Boolean
        {
            return this._handleScroll;
        }

        public function set handleScroll(arg1:Boolean):void
        {
            if (this._handleScroll != arg1)
            {
                this._handleScroll = arg1;
                invalidate(HANDLE_SCROLL_INV);
            }
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.Event.ADDED, addToAutoGroup, false);
            removeEventListener(flash.events.Event.REMOVED, addToAutoGroup, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, handleMouseRollOver, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, handleMouseRollOut, false);
            removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, handleMousePress, false);
            removeEventListener(flash.events.MouseEvent.CLICK, handleMouseRelease, false);
            removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, handleMouseRelease, false);
            removeEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput, false);
            removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.mouseWheelHandler, false);
            if (_repeatTimer)
            {
                _repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, beginRepeat, false);
                _repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER, handleRepeat, false);
            }
            if (_dropdownRef)
            {
                _dropdownRef.removeEventListener(scaleform.clik.events.ListEvent.ITEM_CLICK, handleMenuItemClick, false);
                if (_dropdownRef is net.wg.infrastructure.interfaces.entity.IDisposable)
                    net.wg.infrastructure.interfaces.entity.IDisposable(_dropdownRef).dispose();
                _dropdownRef.parent.removeChild(_dropdownRef);
                _dropdownRef = null;
            }
            if (_dataProvider)
            {
                _dataProvider.removeEventListener(flash.events.Event.CHANGE, handleDataChange, false);
                _dataProvider.cleanUp();
                _dataProvider = null;
            }
            if (scrollBar && scrollBar is net.wg.infrastructure.interfaces.entity.IDisposable)
                net.wg.infrastructure.interfaces.entity.IDisposable(scrollBar).dispose();
            scrollBar = null;
            super.dispose();
            return;
        }

        public final function getSoundType():String
        {
            return this.soundType;
        }

        public final function getSoundId():String
        {
            return this.soundId;
        }

        public final function getStateOverSnd():String
        {
            return net.wg.data.constants.SoundManagerStates.SND_OVER;
        }

        public final function getStateOutSnd():String
        {
            return net.wg.data.constants.SoundManagerStates.SND_OUT;
        }

        public final function getStatePressSnd():String
        {
            return net.wg.data.constants.SoundManagerStates.SND_PRESS;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.hitArea = this.hitMc;
            buttonMode = true;
            if (App.soundMgr)
                App.soundMgr.addSoundsHdlrs(this);
            this.calcMenuAvailableRowCount();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(HANDLE_SCROLL_INV))
            {
                removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.mouseWheelHandler);
                if (this._handleScroll)
                    addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.mouseWheelHandler, false, 0, true);
            }
            return;
        }

        protected override function showDropdown():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (dropdown == null)
                return;
            if (menuWidth == -1)
                menuWidth = width - this.SHADOW_WIDTH;
            if (dropdown is String && !(dropdown == ""))
            {
                loc2 = flash.utils.getDefinitionByName(dropdown.toString()) as Class;
                if (loc2 != null)
                    loc1 = new loc2() as scaleform.clik.controls.CoreList;
            }
            if (loc1)
            {
                if (itemRenderer is String && !(itemRenderer == ""))
                    loc1.itemRenderer = flash.utils.getDefinitionByName(itemRenderer.toString()) as Class;
                else if (itemRenderer is Class)
                    loc1.itemRenderer = itemRenderer as Class;
                if (this.allowScrolling)
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
                scaleform.clik.managers.PopUpManager.show(loc1, x + menuOffset.left, menuDirection != "down" ? y - _dropdownRef.height + menuOffset.bottom : y + height + menuOffset.top, parent);
            }
            stage.addEventListener(flash.events.Event.RESIZE, this.updateDDPosition);
            return;
        }

        internal function mouseWheelHandler(arg1:flash.events.MouseEvent):void
        {
            var loc3:*=null;
            var loc1:*=arg1.delta > 0 ? -1 : 1;
            var loc2:*=_selectedIndex + loc1;
            if (loc2 < 0)
                loc2 = 0;
            else if (loc2 >= _dataProvider.length)
                loc2 = (_dataProvider.length - 1);
            if (_dropdownRef && !(loc2 == _selectedIndex))
                loc3 = _dropdownRef as scaleform.clik.controls.ScrollingList;
                if (loc3)
                    _dropdownRef.selectedIndex = loc2;
            this.selectedIndex = loc2;
            return;
        }

        public override function set selectedIndex(arg1:int):void
        {
            var loc1:*=null;
            var loc2:*=0;
            if (_selectedIndex == arg1)
                return;
            _selectedIndex = arg1;
            invalidateSelectedIndex();
            if (_dropdownRef == null)
                dispatchEvent(new scaleform.clik.events.ListEvent(scaleform.clik.events.ListEvent.INDEX_CHANGE, true, false, _selectedIndex, -1, -1, null, _dataProvider[_selectedIndex]));
            else
            {
                loc1 = _dropdownRef as scaleform.clik.controls.CoreList;
                loc2 = loc1 is scaleform.clik.controls.ScrollingList ? (loc1 as scaleform.clik.controls.ScrollingList).scrollPosition : 0;
                dispatchEvent(new scaleform.clik.events.ListEvent(scaleform.clik.events.ListEvent.INDEX_CHANGE, true, false, _selectedIndex, -1, -1, loc1.getRendererAt(_selectedIndex, loc2), _dataProvider[_selectedIndex]));
            }
            return;
        }

        protected override function hideDropdown():void
        {
            super.hideDropdown();
            stage.removeEventListener(flash.events.Event.RESIZE, this.updateDDPosition);
            return;
        }

        protected function updateDDPosition(arg1:flash.events.Event):void
        {
            var loc1:*=x + menuOffset.left;
            var loc2:*=menuDirection != "down" ? y - _dropdownRef.height + menuOffset.bottom : y + height + menuOffset.top;
            var loc3:*=parent.localToGlobal(new flash.geom.Point(loc1, loc2));
            _dropdownRef.x = loc3.x;
            _dropdownRef.y = loc3.y;
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            if (super.enabled == arg1)
                return;
            super.enabled = arg1;
            if (stage)
                this.close();
            return;
        }

        protected override function updateText():void
        {
            if (!(_label == null) && !(textField == null))
                textField.htmlText = _label;
            return;
        }

        internal const SHADOW_WIDTH:Number=6;

        internal static const HANDLE_SCROLL_INV:String="handleScrolInv";

        public var showEmptyItems:Boolean;

        public var soundType:String="dropDownMenu";

        public var soundId:String="";

        internal var _handleScroll:Boolean=true;

        public var hitMc:flash.display.MovieClip;

        internal var _maxRowCount:int=-1;

        internal var allowScrolling:Boolean=true;
    }
}
