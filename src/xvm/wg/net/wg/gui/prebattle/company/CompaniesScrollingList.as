package net.wg.gui.prebattle.company 
{
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.ui.*;
    
    public class CompaniesScrollingList extends net.wg.gui.components.controls.ScrollingListEx
    {
        public function CompaniesScrollingList()
        {
            super();
            tabEnabled = true;
            focusable = true;
            this.addEventListener(flash.events.FocusEvent.FOCUS_OUT, this.focusOutHandler);
            this.addEventListener(net.wg.gui.prebattle.company.CompanyEvent.SELECTED_ITEM, this.selectedItemHandler);
            this.addEventListener(flash.events.MouseEvent.CLICK, this.buttonClickHandler);
            App.stage.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.clickHandler);
            return;
        }

        public function get isOpenedState():Boolean
        {
            var loc3:*=null;
            var loc1:*=_renderers.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = getRendererAt(loc2) as net.wg.gui.prebattle.company.CompanyListItemRenderer;
                if (loc3.selected) 
                    return true;
                ++loc2;
            }
            return false;
        }

        public function updateRenderer():void
        {
            refreshData();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            App.utils.scheduler.cancelTask(this.updateRenderer);
            this.removeEventListener(flash.events.FocusEvent.FOCUS_OUT, this.focusOutHandler);
            this.removeEventListener(net.wg.gui.prebattle.company.CompanyEvent.SELECTED_ITEM, this.selectedItemHandler);
            this.removeEventListener(flash.events.MouseEvent.CLICK, this.buttonClickHandler);
            App.stage.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.clickHandler);
            return;
        }

        internal function clickHandler(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=null;
            if (scrollBar && scrollBar.hitTestPoint(arg1.stageX, arg1.stageY)) 
            {
                loc1 = net.wg.gui.components.controls.ScrollBar(scrollBar);
                if (loc1.upArrowWg.hitTestPoint(arg1.stageX, arg1.stageY) && !loc1.upArrowWg.enabled) 
                    this.unselectedRenderers();
                if (loc1.downArrowWg.hitTestPoint(arg1.stageX, arg1.stageY) && !loc1.downArrowWg.enabled) 
                    this.unselectedRenderers();
            }
            return;
        }

        public function unselectedRenderers():void
        {
            var loc3:*=null;
            this.isItemSelected = false;
            var loc1:*=_renderers.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = getRendererAt(loc2) as net.wg.gui.prebattle.company.CompanyListItemRenderer;
                loc3.selected = false;
                ++loc2;
            }
            return;
        }

        internal function buttonClickHandler(arg1:flash.events.MouseEvent):void
        {
            if (arg1.target is CompaniesScrollingList) 
            {
                this.isItemSelected = false;
                App.utils.scheduler.scheduleTask(this.updateRenderer, 110);
            }
            return;
        }

        internal function selectedItemHandler(arg1:net.wg.gui.prebattle.company.CompanyEvent):void
        {
            this.isItemSelected = arg1.isSelected;
            return;
        }

        public function set setIndexCompany(arg1:uint):void
        {
            this._setIndexCompany = int(arg1);
            return;
        }

        internal function isShowPlayersList():Boolean
        {
            return !(this._setIndexCompany == -1) && this._setIndexCompany >= _scrollPosition && this._setIndexCompany <= _scrollPosition + _totalRenderers;
        }

        internal function focusOutHandler(arg1:flash.events.FocusEvent):void
        {
            this.isItemSelected = false;
            App.utils.scheduler.scheduleTask(this.updateRenderer, 110);
            return;
        }

        protected override function populateData(arg1:Array):void
        {
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=false;
            var loc7:*=null;
            var loc8:*=false;
            this.showPlayersList = this.isShowPlayersList();
            var loc1:*=arg1.length;
            var loc2:*=_renderers.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                if (loc4 = getRendererAt(loc3) as net.wg.gui.prebattle.company.CompanyListItemRenderer) 
                {
                    loc5 = _scrollPosition + loc3;
                    if (!(loc6 = this.isItemSelected ? _selectedIndex == loc5 : false) && loc4.dd.isOpen()) 
                        loc4.dd.close();
                    loc7 = new scaleform.clik.data.ListData(loc5, itemToLabel(arg1[loc3]), loc6);
                    loc4.enabled = loc3 >= loc1 ? false : true;
                    loc4.setListData(loc7);
                    loc8 = this.showPlayersList && loc5 == this._setIndexCompany && this.isItemSelected;
                    net.wg.gui.prebattle.company.CompanyListItemRenderer(loc4).showPlayersList(loc8);
                    loc4.setData(arg1[loc3]);
                    loc4.refreshPopulateData(this.updateRenderer);
                    loc4.validateNow();
                }
                ++loc3;
            }
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.handled) 
                return;
            var loc1:*=getRendererAt(_selectedIndex, _scrollPosition);
            if (loc1 != null) 
            {
                loc1.handleInput(arg1);
                if (arg1.handled) 
                    return;
            }
            var loc2:*=arg1.details;
            var loc3:*=loc2.value == scaleform.clik.constants.InputValue.KEY_DOWN || loc2.value == scaleform.clik.constants.InputValue.KEY_HOLD;
            var loc4:*=loc2.navEquivalent;
            switch (loc4) 
            {
                case scaleform.clik.constants.NavigationCode.UP:
                    if (selectedIndex != -1) 
                        if (_selectedIndex > 0) 
                            if (loc3) 
                                scrollPosition--;
                        else if (wrapping != scaleform.clik.constants.WrappingMode.STICK) 
                            if (wrapping != scaleform.clik.constants.WrappingMode.WRAP) 
                                return;
                            else if (loc3) 
                                scrollPosition = (_dataProvider.length - 1);
                    else if (loc3) 
                        scrollPosition = (scrollPosition + _totalRenderers - 1);
                    break;
                case scaleform.clik.constants.NavigationCode.DOWN:
                    if (_selectedIndex != -1) 
                        if (_selectedIndex < (_dataProvider.length - 1)) 
                            if (loc3) 
                                scrollPosition++;
                        else if (wrapping != scaleform.clik.constants.WrappingMode.STICK) 
                            if (wrapping != scaleform.clik.constants.WrappingMode.WRAP) 
                                return;
                            else if (loc3) 
                                scrollPosition = 0;
                    else if (loc3) 
                        scrollPosition = _scrollPosition;
                    break;
                case scaleform.clik.constants.NavigationCode.END:
                    if (!loc3) 
                        scrollPosition = (_dataProvider.length - 1);
                    break;
                case scaleform.clik.constants.NavigationCode.HOME:
                    if (!loc3) 
                        scrollPosition = 0;
                    break;
                case scaleform.clik.constants.NavigationCode.PAGE_UP:
                    if (loc3) 
                        scrollList(_totalRenderers);
                    break;
                case scaleform.clik.constants.NavigationCode.PAGE_DOWN:
                    if (loc3) 
                        scrollList(-_totalRenderers);
                    break;
                default:
                    return;
            }
            arg1.handled = true;
            return;
        }

        internal var _setIndexCompany:int=-1;

        internal var showPlayersList:Boolean=false;

        internal var isItemSelected:Boolean=false;
    }
}
