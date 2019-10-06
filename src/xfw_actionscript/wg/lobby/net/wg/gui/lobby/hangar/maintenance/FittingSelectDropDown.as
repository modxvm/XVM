package net.wg.gui.lobby.hangar.maintenance
{
    import net.wg.gui.components.controls.DropdownMenu;
    import flash.geom.Point;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.components.controls.ScrollingListEx;
    import scaleform.clik.utils.Padding;
    import scaleform.clik.interfaces.IListItemRenderer;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.controls.CoreList;
    import flash.events.Event;
    import scaleform.clik.events.ListEvent;
    import net.wg.data.constants.SoundTypes;

    public class FittingSelectDropDown extends DropdownMenu
    {

        private static const SIZE_INVALID:String = "sizeInv";

        private static const SB_PADDING_TOP:int = 4;

        private static const SB_PADDING_BOTTOM:int = 4;

        private static const SB_PADDING_LEFT:int = 2;

        private static const SB_PADDING_RIGHT:int = 4;

        private static const STATE_UP:String = "up";

        private static const SOUND_CLOSE:String = "close";

        private static const STANDARD_RENDERER_HEIGHT:int = 58;

        private static const MENU_PADDING:int = 40;

        public var closeOnlyClickItem:Boolean = false;

        private var _itemClicked:Boolean = false;

        private var _availableSize:Point;

        public function FittingSelectDropDown()
        {
            this._availableSize = new Point();
            super();
            soundType = SoundTypes.FITTING_BUTTON;
            handleScroll = false;
        }

        override public function close() : void
        {
            if(!selected || this.closeOnlyClickItem && !this._itemClicked)
            {
                return;
            }
            super.close();
            App.soundMgr.playControlsSnd(SOUND_CLOSE,soundType,soundId);
            setState(STATE_UP);
        }

        override protected function onDispose() : void
        {
            this._availableSize = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            scrollBar = Linkages.SCROLL_BAR;
        }

        override protected function showDropdown() : void
        {
            var _loc1_:ScrollingListEx = null;
            super.showDropdown();
            if(_dropdownRef)
            {
                _loc1_ = ScrollingListEx(_dropdownRef);
                _loc1_.sbPadding = new Padding(SB_PADDING_TOP,SB_PADDING_LEFT,SB_PADDING_BOTTOM,SB_PADDING_RIGHT);
                parent.parent.parent.addChild(_dropdownRef);
                this.updateDDPosition(null);
                invalidate(SIZE_INVALID);
            }
        }

        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            var _loc3_:IListItemRenderer = null;
            if(_baseDisposed)
            {
                return;
            }
            super.draw();
            if(isInvalid(SIZE_INVALID,InvalidationType.DATA))
            {
                _loc1_ = STANDARD_RENDERER_HEIGHT;
                if(_dropdownRef && _dropdownRef is CoreList)
                {
                    _loc3_ = CoreList(_dropdownRef).getRendererAt(0);
                    if(_loc3_)
                    {
                        _loc1_ = _loc3_.height;
                    }
                }
                _loc2_ = menuPadding?menuPadding.top + menuPadding.bottom:0;
                rowCount = (this._availableSize.y - _loc2_ - MENU_PADDING) / _loc1_ | 0;
            }
        }

        override protected function hideDropdown() : void
        {
            App.toolTipMgr.hide();
            super.hideDropdown();
        }

        public function updateAvailableSize(param1:Number, param2:Number) : void
        {
            this._availableSize.x = param1;
            this._availableSize.y = param2;
            invalidate(SIZE_INVALID);
        }

        override protected function updateDDPosition(param1:Event) : void
        {
            var _loc2_:Point = null;
            if(_dropdownRef)
            {
                super.updateDDPosition(param1);
                _dropdownRef.x = _dropdownRef.x * App.appScale;
                _dropdownRef.y = _dropdownRef.y * App.appScale;
                _loc2_ = parent.parent.parent.globalToLocal(new Point(_dropdownRef.x,_dropdownRef.y));
                _dropdownRef.x = _loc2_.x;
                _dropdownRef.y = _loc2_.y;
            }
        }

        override protected function handleMenuItemClick(param1:ListEvent) : void
        {
            selectedIndex = param1.index;
            this._itemClicked = true;
            this.close();
            this._itemClicked = false;
        }
    }
}
