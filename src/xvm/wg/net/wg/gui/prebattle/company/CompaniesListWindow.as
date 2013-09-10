package net.wg.gui.prebattle.company 
{
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import net.wg.data.*;
    import net.wg.data.daapi.base.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.messengerBar.*;
    import net.wg.gui.messenger.*;
    import net.wg.gui.prebattle.meta.*;
    import net.wg.gui.prebattle.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class CompaniesListWindow extends net.wg.gui.prebattle.meta.impl.CompaniesWindowMeta implements net.wg.gui.prebattle.meta.ICompaniesWindowMeta
    {
        public function CompaniesListWindow()
        {
            super();
            isCentered = false;
            this.companiesDP = new net.wg.data.daapi.base.DAAPIDataProvider();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=0;
            var loc2:*=0;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                loc1 = window.width - window.contentPadding.left - window.contentPadding.right;
                loc2 = window.height - window.contentPadding.top - window.contentPadding.bottom;
                _width = loc1;
                _height = loc2;
                constraints.update(loc1, loc2);
                this.channelComponent.invalidate(scaleform.clik.constants.InvalidationType.SIZE);
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            registerComponent(this.channelComponent, net.wg.data.Aliases.CHANNEL_COMPONENT);
            this.createButton.label = PREBATTLE.BUTTONS_COMPANY_CREATE;
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            var loc1:*=this.channelComponent.messageArea;
            constraints.addElement(loc1.name, loc1, scaleform.clik.utils.Constraints.ALL);
            loc1 = this.channelComponent.messageInput;
            constraints.addElement(loc1.name, loc1, scaleform.clik.utils.Constraints.BOTTOM | scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            loc1 = this.channelComponent.sendButton;
            constraints.addElement(loc1.name, loc1, scaleform.clik.utils.Constraints.BOTTOM | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement(this.cmpList.name, this.cmpList, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.BOTTOM | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement(this.topPanel.name, this.topPanel, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement(this.refreshButton.name, this.refreshButton, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement(this.filterButton.name, this.filterButton, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement(this.filterTextField.name, this.filterTextField, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.LEFT);
            constraints.addElement(this.filterInBattleCheckbox.name, this.filterInBattleCheckbox, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement(this.groupsScrollBar.name, this.groupsScrollBar, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.BOTTOM | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement(this.division.name, this.division, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
            this.refreshButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.refreshButton_buttonClickHandler);
            this.cmpList.addEventListener(net.wg.gui.prebattle.company.CompanyEvent.SELECTED_ITEM, this.selectedItemHandler);
            this.cmpList.dataProvider = this.companiesDP;
            this.cmpList.addEventListener(net.wg.gui.prebattle.company.CompanyEvent.DROP_LIST_CLICK, this.groupsList_listClickHandler);
            this.division.dataProvider = new scaleform.clik.data.DataProvider(getDivisionsListS());
            this.division.selectedIndex = this.defaultSelectedIndex;
            this.division.enabled = false;
            this.division.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleDivisionsChange);
            this.createButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleCreateButtonClick);
            this.filterTextField.addEventListener(flash.events.FocusEvent.FOCUS_IN, this.filterTextField_focusInHandler);
            this.filterTextField.addEventListener(flash.events.Event.CHANGE, this.filterTextField_changeHandler);
            this.filterTextField.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.filterTextField_inputHandler);
            this.filterButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onFilterButtonPress);
            this.filterInBattleCheckbox.selected = this.selectedFilterInBattleCheckbox;
            this.filterTextField.text = this.defaultFilterText;
            this.setFocus();
            return;
        }

        protected override function onDispose():void
        {
            this.refreshButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.refreshButton_buttonClickHandler);
            this.refreshButton.dispose();
            this.cmpList.removeEventListener(net.wg.gui.prebattle.company.CompanyEvent.DROP_LIST_CLICK, this.groupsList_listClickHandler);
            this.cmpList.removeEventListener(net.wg.gui.prebattle.company.CompanyEvent.SELECTED_ITEM, this.selectedItemHandler);
            this.cmpList.dispose();
            this.division.dataProvider.cleanUp();
            this.division.dataProvider = null;
            this.division.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.handleDivisionsChange);
            this.createButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleCreateButtonClick);
            this.createButton.dispose();
            this.filterTextField.removeEventListener(flash.events.FocusEvent.FOCUS_IN, this.filterTextField_focusInHandler);
            this.filterTextField.removeEventListener(flash.events.Event.CHANGE, this.filterTextField_changeHandler);
            this.filterTextField.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.filterTextField_inputHandler);
            this.filterTextField.dispose();
            this.filterButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onFilterButtonPress);
            this.filterButton.dispose();
            this.groupsScrollBar.dispose();
            App.utils.scheduler.cancelTask(this.enableFilterButtons);
            super.onDispose();
            return;
        }

        public function as_setDefaultFilter(arg1:String, arg2:Boolean, arg3:uint):void
        {
            this.defaultFilterText = arg1;
            this.selectedFilterInBattleCheckbox = arg2;
            this.defaultSelectedIndex = arg3;
            return;
        }

        internal function handleDivisionsChange(arg1:scaleform.clik.events.ListEvent):void
        {
            refreshCompaniesListS(this.filterTextField.text, this.filterInBattleCheckbox.selected, this.division.selectedIndex);
            return;
        }

        internal function refreshButton_buttonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            refreshCompaniesListS(this.filterTextField.text, this.filterInBattleCheckbox.selected, this.division.selectedIndex);
            return;
        }

        internal function groupsList_listClickHandler(arg1:net.wg.gui.prebattle.company.CompanyEvent):void
        {
            joinCompanyS(arg1.prbID);
            this.cmpList.updateRenderer();
            return;
        }

        internal function coolDownProcess(arg1:Number):void
        {
            this.enableFilterButtons(false);
            App.utils.scheduler.scheduleTask(this.enableFilterButtons, arg1, true);
            return;
        }

        internal function enableFilterButtons(arg1:Boolean):void
        {
            if (arg1) 
                this.filterTextField.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.filterTextField_inputHandler);
            else if (this.filterTextField.hasEventListener(scaleform.clik.events.InputEvent.INPUT)) 
                this.filterTextField.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.filterTextField_inputHandler);
            this.refreshButton.enabled = arg1;
            this.filterButton.enabled = arg1 != false ? !(this.filterTextField.text == "") : false;
            this.division.enabled = arg1;
            return;
        }

        internal function handleCreateButtonClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            createCompanyS();
            return;
        }

        internal function filterTextField_changeHandler(arg1:flash.events.Event):void
        {
            this.filterButton.enabled = this.filterTextField.text != "" ? this.refreshButton.enabled : true;
            return;
        }

        internal function onFilterButtonPress(arg1:scaleform.clik.events.ButtonEvent):void
        {
            refreshCompaniesListS(this.filterTextField.text, this.filterInBattleCheckbox.selected, this.division.selectedIndex);
            return;
        }

        internal function selectedItemHandler(arg1:net.wg.gui.prebattle.company.CompanyEvent):void
        {
            if (arg1.prbID > -1) 
                requestPlayersListS(arg1.prbID);
            return;
        }

        internal function filterTextField_focusInHandler(arg1:flash.events.FocusEvent):void
        {
            return;
        }

        internal function filterTextField_inputHandler(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.details.code == flash.ui.Keyboard.ENTER) 
            {
                arg1.handled = true;
                this.filterButton.selected = true;
                refreshCompaniesListS(this.filterTextField.text, this.filterInBattleCheckbox.selected, this.division.selectedIndex);
                this.filterTextField.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.filterTextField_inputHandler);
            }
            return;
        }

        public function as_getCompaniesListDP():Object
        {
            return this.companiesDP;
        }

        public function as_showPlayersList(arg1:uint):void
        {
            if (this.cmpList) 
                this.cmpList.setIndexCompany = arg1;
            return;
        }

        public function as_setRefreshCoolDown(arg1:Number):void
        {
            this.coolDownProcess(arg1 * 1000);
            return;
        }

        public function as_disableCreateButton(arg1:Boolean):void
        {
            if (this.createButton != null) 
                this.createButton.enabled = !arg1;
            return;
        }

        public override function setFocus():void
        {
            super.setFocus();
            if (this.channelComponent) 
                this.channelComponent.setFocusToInput();
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.details.code == flash.ui.Keyboard.ESCAPE && arg1.details.value == scaleform.clik.constants.InputValue.KEY_DOWN) 
                if (this.cmpList.isOpenedState) 
                {
                    this.cmpList.unselectedRenderers();
                    arg1.preventDefault();
                    arg1.stopImmediatePropagation();
                    return;
                }
            super.handleInput(arg1);
            if (arg1.handled) 
                return;
            if (arg1.details.code == flash.ui.Keyboard.F1 && arg1.details.value == scaleform.clik.constants.InputValue.KEY_UP) 
            {
                showFAQWindowS();
                arg1.handled = true;
            }
            return;
        }

        protected override function onPopulate():void
        {
            canClose = true;
            enabledCloseBtn = false;
            canDrag = true;
            canResize = true;
            canMinimize = true;
            showWindowBg = false;
            var loc1:*=window.contentPadding as scaleform.clik.utils.Padding;
            loc1.top = 40;
            loc1.left = 10;
            loc1.right = 10;
            loc1.bottom = 15;
            window.setMaxWidth(1024);
            window.setMaxHeight(768);
            window.setTitleIcon("teamList");
            window.title = CHAT.CHANNELS_COMPANY;
            geometry = new net.wg.gui.lobby.messengerBar.WindowGeometryInBar(net.wg.gui.events.MessengerBarEvent.PIN_CAROUSEL_WINDOW, getClientIDS());
            return;
        }

        internal var companiesDP:net.wg.data.daapi.base.DAAPIDataProvider;

        public var channelComponent:net.wg.gui.messenger.ChannelComponent;

        public var topPanel:flash.display.MovieClip;

        public var groupsScrollBar:net.wg.gui.components.controls.ScrollBar;

        public var createButton:net.wg.gui.components.controls.SoundButtonEx;

        public var cmpList:net.wg.gui.prebattle.company.CompaniesScrollingList;

        public var refreshButton:net.wg.gui.components.controls.IconButton;

        public var filterButton:net.wg.gui.components.controls.IconButton;

        public var filterTextField:net.wg.gui.components.controls.TextInput;

        public var filterInBattleCheckbox:net.wg.gui.components.controls.CheckBox;

        public var division:net.wg.gui.components.controls.DropdownMenu;

        internal var defaultFilterText:String="";

        internal var selectedFilterInBattleCheckbox:Boolean=false;

        internal var defaultSelectedIndex:int=0;

        internal var isFirstDraw:Boolean=true;
    }
}
