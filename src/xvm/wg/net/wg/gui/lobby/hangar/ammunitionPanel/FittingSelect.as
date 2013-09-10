package net.wg.gui.lobby.hangar.ammunitionPanel
{
    import flash.events.*;
    import flash.geom.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;

    public class FittingSelect extends net.wg.gui.components.controls.DropdownMenu
    {
        public function FittingSelect()
        {
            this._availableSize = new flash.geom.Point();
            super();
            soundType = net.wg.data.constants.SoundTypes.FITTING_BUTTON;
            handleScroll = false;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            scrollBar = net.wg.data.constants.Linkages.SCROLL_BAR;
            return;
        }

        public override function close():void
        {
            if (!selected || this.closeOnlyClickItem && !this.itemClicked)
            {
                return;
            }
            super.close();
            focused = 0;
            App.soundMgr.playControlsSnd("close", soundType, soundId);
            return;
        }

        protected override function showDropdown():void
        {
            var loc1:*=null;
            super.showDropdown();
            if (_dropdownRef)
            {
                loc1 = App.utils.events;
                loc1.disableDisposingForObj(_dropdownRef);
                parent.parent.parent.addChild(_dropdownRef);
                loc1.enableDisposingForObj(_dropdownRef);
                this.updateDDPosition(null);
                invalidate(SIZE_INVALID);
            }
            return;
        }

        protected override function updateDDPosition(arg1:flash.events.Event):void
        {
            super.updateDDPosition(arg1);
            var loc1:*=parent.parent.parent.globalToLocal(new flash.geom.Point(_dropdownRef.x, _dropdownRef.y));
            _dropdownRef.x = loc1.x;
            _dropdownRef.y = loc1.y;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=null;
            super.draw();
            if (isInvalid(SIZE_INVALID, scaleform.clik.constants.InvalidationType.DATA))
            {
                loc1 = 58;
                if (_dropdownRef && _dropdownRef as scaleform.clik.controls.CoreList)
                {
                    loc4 = (_dropdownRef as scaleform.clik.controls.CoreList).getRendererAt(0);
                    if (loc4)
                    {
                        loc1 = loc4.height;
                    }
                }
                loc2 = menuPadding ? menuPadding.top + menuPadding.bottom : 0;
                loc3 = 15;
                rowCount = Math.floor((this._availableSize.y - loc2 - loc3) / loc1);
            }
            return;
        }

        protected override function handleMenuItemClick(arg1:scaleform.clik.events.ListEvent):void
        {
            selectedIndex = arg1.index;
            this.itemClicked = true;
            this.close();
            this.itemClicked = false;
            return;
        }

        protected override function hideDropdown():void
        {
            var loc1:*=null;
            if (_dropdownRef)
            {
                loc1 = _dropdownRef as scaleform.clik.controls.CoreList;
                loc1.dataProvider = null;
                App.utils.commons.releaseReferences(loc1);
            }
            super.hideDropdown();
            return;
        }

        public function updateAvailableSize(arg1:Number, arg2:Number):void
        {
            this._availableSize.x = arg1;
            this._availableSize.y = arg2;
            invalidate(SIZE_INVALID);
            return;
        }

        internal static const SIZE_INVALID:String="sizeInv";

        public var closeOnlyClickItem:Boolean=false;

        internal var itemClicked:Boolean=false;

        internal var _availableSize:flash.geom.Point;
    }
}
