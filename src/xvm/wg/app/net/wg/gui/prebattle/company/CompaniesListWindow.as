package net.wg.gui.prebattle.company
{
   import net.wg.gui.prebattle.meta.impl.CompaniesWindowMeta;
   import net.wg.gui.prebattle.meta.ICompaniesWindowMeta;
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import net.wg.gui.messenger.ChannelComponent;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.IconButton;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import scaleform.clik.events.InputEvent;
   import flash.ui.Keyboard;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.utils.Padding;
   import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
   import net.wg.gui.events.MessengerBarEvent;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.Aliases;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import flash.display.DisplayObject;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   import flash.events.FocusEvent;
   import flash.events.Event;


   public class CompaniesListWindow extends CompaniesWindowMeta implements ICompaniesWindowMeta
   {
          
      public function CompaniesListWindow() {
         super();
         isCentered = false;
         this.companiesDP = new DAAPIDataProvider();
      }

      private var companiesDP:DAAPIDataProvider;

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

      private var defaultFilterText:String = "";

      private var selectedFilterInBattleCheckbox:Boolean = false;

      private var defaultSelectedIndex:int = 0;

      private var isFirstDraw:Boolean = true;

      public function as_getCompaniesListDP() : Object {
         return this.companiesDP;
      }

      public function as_showPlayersList(param1:uint) : void {
         if(this.cmpList)
         {
            this.cmpList.setIndexCompany = param1;
         }
      }

      public function as_setRefreshCoolDown(param1:Number) : void {
         this.coolDownProcess(param1 * 1000);
      }

      public function as_disableCreateButton(param1:Boolean) : void {
         if(this.createButton != null)
         {
            this.createButton.enabled = !param1;
         }
      }

      override public function setFocus() : void {
         super.setFocus();
         if(this.channelComponent)
         {
            this.channelComponent.setFocusToInput();
         }
      }

      override public function handleInput(param1:InputEvent) : void {
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

      override protected function onPopulate() : void {
         canClose = true;
         enabledCloseBtn = false;
         canDrag = true;
         canResize = true;
         canMinimize = true;
         showWindowBg = false;
         var _loc1_:Padding = window.contentPadding as Padding;
         _loc1_.top = 40;
         _loc1_.left = 10;
         _loc1_.right = 10;
         _loc1_.bottom = 15;
         window.setMaxWidth(1024);
         window.setMaxHeight(768);
         window.setTitleIcon("teamList");
         window.title = CHAT.CHANNELS_COMPANY;
         geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CAROUSEL_WINDOW,getClientIDS());
      }

      override protected function draw() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = window.width - window.contentPadding.left - window.contentPadding.right;
            _loc2_ = window.height - window.contentPadding.top - window.contentPadding.bottom;
            _width = _loc1_;
            _height = _loc2_;
            constraints.update(_loc1_,_loc2_);
            this.channelComponent.invalidate(InvalidationType.SIZE);
         }
      }

      override protected function configUI() : void {
         super.configUI();
         registerComponent(this.channelComponent,Aliases.CHANNEL_COMPONENT);
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
         this.division.dataProvider = new DataProvider(getDivisionsListS());
         this.division.selectedIndex = this.defaultSelectedIndex;
         this.division.enabled = false;
         this.division.addEventListener(ListEvent.INDEX_CHANGE,this.handleDivisionsChange);
         this.createButton.addEventListener(ButtonEvent.CLICK,this.handleCreateButtonClick);
         this.filterTextField.addEventListener(FocusEvent.FOCUS_IN,this.filterTextField_focusInHandler);
         this.filterTextField.addEventListener(Event.CHANGE,this.filterTextField_changeHandler);
         this.filterTextField.addEventListener(InputEvent.INPUT,this.filterTextField_inputHandler);
         this.filterButton.addEventListener(ButtonEvent.CLICK,this.onFilterButtonPress);
         this.filterInBattleCheckbox.selected = this.selectedFilterInBattleCheckbox;
         this.filterTextField.text = this.defaultFilterText;
         this.setFocus();
      }

      override protected function onDispose() : void {
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
         this.filterButton.dispose();
         this.groupsScrollBar.dispose();
         App.utils.scheduler.cancelTask(this.enableFilterButtons);
         super.onDispose();
      }

      public function as_setDefaultFilter(param1:String, param2:Boolean, param3:uint) : void {
         this.defaultFilterText = param1;
         this.selectedFilterInBattleCheckbox = param2;
         this.defaultSelectedIndex = param3;
      }

      private function handleDivisionsChange(param1:ListEvent) : void {
         refreshCompaniesListS(this.filterTextField.text,this.filterInBattleCheckbox.selected,this.division.selectedIndex);
      }

      private function refreshButton_buttonClickHandler(param1:ButtonEvent) : void {
         refreshCompaniesListS(this.filterTextField.text,this.filterInBattleCheckbox.selected,this.division.selectedIndex);
      }

      private function groupsList_listClickHandler(param1:CompanyEvent) : void {
         joinCompanyS(param1.prbID);
         this.cmpList.updateRenderer();
      }

      private function coolDownProcess(param1:Number) : void {
         this.enableFilterButtons(false);
         App.utils.scheduler.scheduleTask(this.enableFilterButtons,param1,true);
      }

      private function enableFilterButtons(param1:Boolean) : void {
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
         this.refreshButton.enabled = param1;
         this.filterButton.enabled = param1 == false?false:!(this.filterTextField.text == "");
         this.division.enabled = param1;
      }

      private function handleCreateButtonClick(param1:ButtonEvent) : void {
         createCompanyS();
      }

      private function filterTextField_changeHandler(param1:Event) : void {
         this.filterButton.enabled = this.filterTextField.text == ""?true:this.refreshButton.enabled;
      }

      private function onFilterButtonPress(param1:ButtonEvent) : void {
         refreshCompaniesListS(this.filterTextField.text,this.filterInBattleCheckbox.selected,this.division.selectedIndex);
      }

      private function selectedItemHandler(param1:CompanyEvent) : void {
         if(param1.prbID > -1)
         {
            requestPlayersListS(param1.prbID);
         }
      }

      private function filterTextField_focusInHandler(param1:FocusEvent) : void {
          
      }

      private function filterTextField_inputHandler(param1:InputEvent) : void {
         if(param1.details.code == Keyboard.ENTER)
         {
            param1.handled = true;
            this.filterButton.selected = true;
            refreshCompaniesListS(this.filterTextField.text,this.filterInBattleCheckbox.selected,this.division.selectedIndex);
            this.filterTextField.removeEventListener(InputEvent.INPUT,this.filterTextField_inputHandler);
         }
      }
   }

}