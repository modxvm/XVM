package net.wg.gui.prebattle.company
{
    import net.wg.infrastructure.base.meta.impl.CompanyListMeta;
    import net.wg.infrastructure.base.meta.ICompanyListMeta;
    import net.wg.gui.cyberSport.interfaces.IChannelComponentHolder;
    import net.wg.gui.messenger.ChannelComponent;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.ScrollBar;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.IconButton;
    import net.wg.gui.components.controls.TextInput;
    import net.wg.gui.components.controls.CheckBox;
    import net.wg.gui.components.controls.DropdownMenu;
    import net.wg.data.daapi.base.DAAPIDataProvider;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    import flash.display.DisplayObject;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.FocusEvent;
    import flash.events.Event;
    import scaleform.clik.events.InputEvent;
    import flash.events.MouseEvent;
    import net.wg.data.Aliases;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.events.ListEvent;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import net.wg.data.constants.generated.PREBATTLE_ALIASES;
    import flash.ui.Keyboard;
    import flash.geom.Point;
    import net.wg.utils.IEventCollector;
    import scaleform.clik.constants.InputValue;
    
    public class CompanyListView extends CompanyListMeta implements ICompanyListMeta, IChannelComponentHolder
    {
        
        public function CompanyListView()
        {
            super();
            this.companiesDP = new DAAPIDataProvider();
        }
        
        public var channelComponent:ChannelComponent;
        
        public var topPanel:MovieClip;
        
        public var groupsScrollBar:ScrollBar;
        
        public var createButton:SoundButtonEx;
        
        public var cmpList:CompaniesScrollingList;
        
        public var refreshButton:IconButton;
        
        public var filterButton:IconButton;
        
        public var filterTextField:TextInput;
        
        public var filterInBattleCheckbox:CheckBox;
        
        public var division:DropdownMenu;
        
        private var companiesDP:DAAPIDataProvider;
        
        private var defaultFilterText:String = "";
        
        private var selectedFilterInBattleCheckbox:Boolean = false;
        
        private var defaultSelectedIndex:int = 0;
        
        override public function as_getSearchDP() : Object
        {
            return this.companiesDP;
        }
        
        public function as_showPlayersList(param1:uint) : void
        {
            if(this.cmpList)
            {
                this.cmpList.setIndexCompany = param1;
            }
        }
        
        public function as_setRefreshCoolDown(param1:Number) : void
        {
            this.coolDownProcess(param1 * 1000);
        }
        
        public function as_disableCreateButton(param1:Boolean) : void
        {
            if(this.createButton != null)
            {
                this.createButton.enabled = !param1;
            }
        }
        
        public function as_setDefaultFilter(param1:String, param2:Boolean, param3:uint) : void
        {
            this.defaultFilterText = param1;
            this.selectedFilterInBattleCheckbox = param2;
            this.defaultSelectedIndex = param3;
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
        
        override public function canShowAutomatically() : Boolean
        {
            return super.canShowAutomatically();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.createButton.label = PREBATTLE.BUTTONS_COMPANY_CREATE;
            constraints = new Constraints(this,ConstrainMode.REFLOW);
            var _loc1_:DisplayObject = this.channelComponent.messageArea;
            constraints.addElement(_loc1_.name,_loc1_,Constraints.ALL);
            _loc1_ = this.channelComponent.messageInput;
            constraints.addElement(_loc1_.name,_loc1_,Constraints.BOTTOM | Constraints.LEFT | Constraints.RIGHT);
            _loc1_ = this.channelComponent.sendButton;
            constraints.addElement(_loc1_.name,_loc1_,Constraints.BOTTOM | Constraints.RIGHT);
            constraints.addElement(this.cmpList.name,this.cmpList,Constraints.TOP | Constraints.BOTTOM | Constraints.RIGHT);
            constraints.addElement(this.topPanel.name,this.topPanel,Constraints.TOP | Constraints.LEFT | Constraints.RIGHT);
            constraints.addElement(this.refreshButton.name,this.refreshButton,Constraints.TOP | Constraints.RIGHT);
            constraints.addElement(this.filterButton.name,this.filterButton,Constraints.TOP | Constraints.RIGHT);
            constraints.addElement(this.filterTextField.name,this.filterTextField,Constraints.TOP | Constraints.RIGHT | Constraints.LEFT);
            constraints.addElement(this.filterInBattleCheckbox.name,this.filterInBattleCheckbox,Constraints.TOP | Constraints.RIGHT);
            constraints.addElement(this.groupsScrollBar.name,this.groupsScrollBar,Constraints.TOP | Constraints.BOTTOM | Constraints.RIGHT);
            constraints.addElement(this.division.name,this.division,Constraints.TOP | Constraints.RIGHT);
            this.refreshButton.addEventListener(ButtonEvent.CLICK,this.refreshButton_buttonClickHandler);
            this.cmpList.addEventListener(CompanyEvent.SELECTED_ITEM,this.selectedItemHandler);
            this.cmpList.dataProvider = this.companiesDP;
            this.cmpList.addEventListener(CompanyEvent.DROP_LIST_CLICK,this.groupsList_listClickHandler);
            this.createButton.addEventListener(ButtonEvent.CLICK,this.handleCreateButtonClick);
            this.filterTextField.addEventListener(FocusEvent.FOCUS_IN,this.filterTextField_focusInHandler);
            this.filterTextField.addEventListener(Event.CHANGE,this.filterTextField_changeHandler);
            this.filterTextField.addEventListener(InputEvent.INPUT,this.filterTextField_inputHandler);
            this.filterButton.addEventListener(ButtonEvent.CLICK,this.onFilterButtonPress);
            this.filterButton.addEventListener(MouseEvent.MOUSE_OVER,this.onFilterButtonOver);
            this.filterButton.addEventListener(MouseEvent.MOUSE_OUT,this.onFilterButtonOut);
            this.filterInBattleCheckbox.selected = this.selectedFilterInBattleCheckbox;
            this.filterTextField.text = this.defaultFilterText;
            addEventListener(CompanyDropDownEvent.SHOW_DROP_DOWN,this.onShowDropwDownHandler);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerFlashComponent(this.channelComponent,Aliases.CHANNEL_COMPONENT);
            this.division.dataProvider = new DataProvider(getDivisionsListS());
            this.division.selectedIndex = this.defaultSelectedIndex;
            this.division.enabled = false;
            this.division.addEventListener(ListEvent.INDEX_CHANGE,this.handleDivisionsChange);
        }
        
        private function onFilterButtonOut(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function onFilterButtonOver(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(TOOLTIPS.PREBATTLE_NAMEFILTERBUTTON);
        }
        
        override protected function onDispose() : void
        {
            if(isFlashComponentRegisteredS(Aliases.CHANNEL_COMPONENT))
            {
                unregisterFlashComponentS(Aliases.CHANNEL_COMPONENT);
            }
            this.refreshButton.removeEventListener(ButtonEvent.CLICK,this.refreshButton_buttonClickHandler);
            this.refreshButton.dispose();
            this.cmpList.removeEventListener(CompanyEvent.DROP_LIST_CLICK,this.groupsList_listClickHandler);
            this.cmpList.removeEventListener(CompanyEvent.SELECTED_ITEM,this.selectedItemHandler);
            this.cmpList.dispose();
            this.division.dataProvider.cleanUp();
            this.division.dataProvider = null;
            this.division.removeEventListener(ListEvent.INDEX_CHANGE,this.handleDivisionsChange);
            this.createButton.removeEventListener(ButtonEvent.CLICK,this.handleCreateButtonClick);
            this.createButton.dispose();
            this.filterTextField.removeEventListener(FocusEvent.FOCUS_IN,this.filterTextField_focusInHandler);
            this.filterTextField.removeEventListener(Event.CHANGE,this.filterTextField_changeHandler);
            this.filterTextField.removeEventListener(InputEvent.INPUT,this.filterTextField_inputHandler);
            this.filterTextField.dispose();
            this.filterButton.removeEventListener(ButtonEvent.CLICK,this.onFilterButtonPress);
            this.filterButton.removeEventListener(MouseEvent.MOUSE_OVER,this.onFilterButtonOver);
            this.filterButton.removeEventListener(MouseEvent.MOUSE_OUT,this.onFilterButtonOut);
            this.filterButton.dispose();
            this.groupsScrollBar.dispose();
            App.utils.scheduler.cancelTask(this.enableFilterButtons);
            removeEventListener(CompanyDropDownEvent.SHOW_DROP_DOWN,this.onShowDropwDownHandler);
            super.onDispose();
        }
        
        private function coolDownProcess(param1:Number) : void
        {
            this.enableFilterButtons(false);
            App.utils.scheduler.scheduleTask(this.enableFilterButtons,param1,true);
        }
        
        private function enableFilterButtons(param1:Boolean) : void
        {
            var _loc2_:* = NaN;
            if(!param1)
            {
                if(this.filterTextField.hasEventListener(InputEvent.INPUT))
                {
                    this.filterTextField.removeEventListener(InputEvent.INPUT,this.filterTextField_inputHandler);
                }
            }
            else
            {
                this.filterTextField.addEventListener(InputEvent.INPUT,this.filterTextField_inputHandler);
            }
            _loc2_ = this.getSelectedDivisionData();
            this.refreshButton.enabled = param1;
            this.filterButton.enabled = (param1) && _loc2_ == 0?!(this.filterTextField.text == ""):false;
            this.division.enabled = param1;
        }
        
        private function getSelectedDivisionData() : Number
        {
            var _loc2_:Object = null;
            var _loc1_:Number = -1;
            if((this.division.dataProvider) && this.division.selectedIndex >= 0)
            {
                _loc2_ = this.division.dataProvider.requestItemAt(this.division.selectedIndex);
                _loc1_ = _loc2_.hasOwnProperty("data")?_loc2_["data"]:-1;
            }
            return _loc1_;
        }
        
        private function handleDivisionsChange(param1:ListEvent) : void
        {
            refreshCompaniesListS(this.filterTextField.text,this.filterInBattleCheckbox.selected,this.division.selectedIndex);
            var _loc2_:Number = this.getSelectedDivisionData();
            this.filterButton.enabled = (this.refreshButton.enabled) && _loc2_ == 0?!(this.filterTextField.text == ""):false;
        }
        
        private function refreshButton_buttonClickHandler(param1:ButtonEvent) : void
        {
            refreshCompaniesListS(this.filterTextField.text,this.filterInBattleCheckbox.selected,this.division.selectedIndex);
        }
        
        private function groupsList_listClickHandler(param1:CompanyEvent) : void
        {
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST,{"alias":PREBATTLE_ALIASES.COMPANY_ROOM_VIEW_UI,
            "itemId":param1.prbID
        }));
    }
    
    private function handleCreateButtonClick(param1:ButtonEvent) : void
    {
        dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST,{"alias":PREBATTLE_ALIASES.COMPANY_ROOM_VIEW_UI}));
    }
    
    private function filterTextField_changeHandler(param1:Event) : void
    {
        var _loc2_:Number = this.getSelectedDivisionData();
        this.filterButton.enabled = (this.refreshButton.enabled) && _loc2_ == 0?!(this.filterTextField.text == ""):false;
    }
    
    private function onFilterButtonPress(param1:ButtonEvent) : void
    {
        refreshCompaniesListS(this.filterTextField.text,this.filterInBattleCheckbox.selected,this.division.selectedIndex);
    }
    
    private function selectedItemHandler(param1:CompanyEvent) : void
    {
        if(param1.prbID > -1)
        {
            requestPlayersListS(param1.prbID);
        }
    }
    
    private function filterTextField_focusInHandler(param1:FocusEvent) : void
    {
    }
    
    private function filterTextField_inputHandler(param1:InputEvent) : void
    {
        if(param1.details.code == Keyboard.ENTER)
        {
            param1.handled = true;
            this.filterButton.selected = true;
            refreshCompaniesListS(this.filterTextField.text,this.filterInBattleCheckbox.selected,this.division.selectedIndex);
            this.filterTextField.removeEventListener(InputEvent.INPUT,this.filterTextField_inputHandler);
        }
    }
    
    private function onShowDropwDownHandler(param1:CompanyDropDownEvent) : void
    {
        var _loc2_:Point = globalToLocal(new Point(param1.dropDownref.x,param1.dropDownref.y));
        var _loc3_:IEventCollector = App.utils.events;
        _loc3_.disableDisposingForObj(param1.dropDownref);
        addChild(param1.dropDownref);
        _loc3_.enableDisposingForObj(param1.dropDownref);
        param1.dropDownref.x = _loc2_.x;
        param1.dropDownref.y = _loc2_.y;
    }
    
    override public function handleInput(param1:InputEvent) : void
    {
        if(param1.details.code == Keyboard.ESCAPE && param1.details.value == InputValue.KEY_DOWN)
        {
            if(this.cmpList.isOpenedState)
            {
                this.cmpList.unselectedRenderers();
                param1.preventDefault();
                param1.stopImmediatePropagation();
                return;
            }
        }
        super.handleInput(param1);
        if(param1.handled)
        {
            return;
        }
        if(param1.details.code == Keyboard.F1 && param1.details.value == InputValue.KEY_UP)
        {
            showFAQWindowS();
            param1.handled = true;
        }
    }
    
    public function getChannelComponent() : ChannelComponent
    {
        return this.channelComponent;
    }
}
}
