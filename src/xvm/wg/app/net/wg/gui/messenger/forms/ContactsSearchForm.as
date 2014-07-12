package net.wg.gui.messenger.forms
{
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.components.controls.ScrollingListEx;
   import flash.events.Event;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.events.ListEventEx;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.utils.Padding;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.constants.InputValue;
   import net.wg.gui.messenger.evnts.ContactsFormEvent;
   import flash.ui.Keyboard;
   import net.wg.gui.prebattle.squad.MessengerUtils;
   import scaleform.gfx.MouseEventEx;
   import net.wg.data.components.ContextItemGenerator;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.messenger.meta.IContactsWindowMeta;
   import flash.display.InteractiveObject;
   
   public class ContactsSearchForm extends UIComponentEx implements IViewStackContent
   {
      
      public function ContactsSearchForm() {
         super();
      }
      
      public var titleLabel:LabelControl;
      
      public var resultsLabel:LabelControl;
      
      public var searchButton:SoundButtonEx;
      
      public var addToFriendsButton:SoundButtonEx;
      
      public var addToIgnoredButton:SoundButtonEx;
      
      public var textInput:TextInput;
      
      public var list:ScrollingListEx;
      
      public function update(param1:Object) : void {
         if(param1)
         {
            this.list.dataProvider = param1.searchDP;
            this.list.dataProvider.addEventListener(Event.CHANGE,this.updateButtons);
            this.resultsLabel.text = param1.resultText;
            this.searchButton.enabled = !param1.freezeSearch;
         }
      }
      
      override protected function onDispose() : void {
         super.onDispose();
         this.searchButton.removeEventListener(ButtonEvent.CLICK,this.onSearchClick);
         this.addToFriendsButton.removeEventListener(ButtonEvent.CLICK,this.onAddToFriendsClick);
         this.addToIgnoredButton.removeEventListener(ButtonEvent.CLICK,this.onAddToIgnoredClick);
         this.list.removeEventListener(ListEventEx.ITEM_CLICK,this.showContextMenu);
         this.list.removeEventListener(ListEvent.INDEX_CHANGE,this.updateButtons);
         if((this.list.dataProvider) && (this.list.dataProvider.hasEventListener(Event.CHANGE)))
         {
            this.list.dataProvider.removeEventListener(Event.CHANGE,this.updateButtons);
            this.list.dataProvider.cleanUp();
            this.list.dataProvider = null;
         }
      }
      
      override protected function configUI() : void {
         super.configUI();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement("titleLabel",this.titleLabel,Constraints.LEFT | Constraints.RIGHT);
         constraints.addElement("textInput",this.textInput,Constraints.LEFT | Constraints.RIGHT);
         constraints.addElement("searchButton",this.searchButton,Constraints.RIGHT);
         constraints.addElement("resultsLabel",this.resultsLabel,Constraints.LEFT | Constraints.RIGHT);
         constraints.addElement("list",this.list,Constraints.ALL);
         constraints.addElement("addToFriendsButton",this.addToFriendsButton,Constraints.BOTTOM | Constraints.LEFT);
         constraints.addElement("addToIgnoredButton",this.addToIgnoredButton,Constraints.BOTTOM | Constraints.LEFT);
         this.searchButton.addEventListener(ButtonEvent.CLICK,this.onSearchClick);
         this.addToFriendsButton.addEventListener(ButtonEvent.CLICK,this.onAddToFriendsClick);
         this.addToIgnoredButton.addEventListener(ButtonEvent.CLICK,this.onAddToIgnoredClick);
         this.list.addEventListener(ListEventEx.ITEM_CLICK,this.showContextMenu);
         this.list.addEventListener(ListEvent.INDEX_CHANGE,this.updateButtons);
         this.list.sbPadding = new Padding(-1,-1,-1,-1);
         this.textInput.addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         this.addToFriendsButton.enabled = false;
         this.addToIgnoredButton.enabled = false;
      }
      
      override public function handleInput(param1:InputEvent) : void {
         super.handleInput(param1);
         if(param1.handled)
         {
            return;
         }
         var _loc2_:Number = param1.details.code;
         if(param1.details.value == InputValue.KEY_UP)
         {
            switch(_loc2_)
            {
               case Keyboard.ENTER:
                  param1.handled = true;
                  dispatchEvent(this.generateEvent(ContactsFormEvent.SEARCH));
                  param1.handled = true;
                  break;
            }
         }
      }
      
      public function getSelectedItem() : Object {
         return this.list.dataProvider.requestItemAt(this.list.selectedIndex);
      }
      
      private function updateButtons(param1:Event = null) : void {
         var _loc3_:* = false;
         var _loc2_:Object = this.getSelectedItem();
         if(_loc2_)
         {
            _loc3_ = this.getParent().isEnabledInRoamingS(_loc2_.uid);
            this.addToFriendsButton.enabled = _loc3_?!MessengerUtils.isFriend(_loc2_) && !_loc2_.himself:false;
            this.addToIgnoredButton.enabled = _loc3_?!MessengerUtils.isIgnored(_loc2_) && !_loc2_.himself:false;
         }
         else
         {
            this.addToFriendsButton.enabled = false;
            this.addToIgnoredButton.enabled = false;
         }
      }
      
      private function showContextMenu(param1:ListEventEx) : void {
         if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
         {
            App.contextMenuMgr.showUserContextMenu(this,param1.itemData,new ContextItemGenerator());
         }
      }
      
      override protected function draw() : void {
         super.draw();
         if((constraints) && (isInvalid(InvalidationType.SIZE)))
         {
            constraints.update(_width,_height);
         }
      }
      
      private function onSearchClick(param1:ButtonEvent) : void {
         dispatchEvent(this.generateEvent(ContactsFormEvent.SEARCH));
      }
      
      private function onAddToFriendsClick(param1:ButtonEvent) : void {
         dispatchEvent(this.generateEvent(ContactsFormEvent.ADD_TO_FRIENDS));
      }
      
      private function onAddToIgnoredClick(param1:ButtonEvent) : void {
         dispatchEvent(this.generateEvent(ContactsFormEvent.ADD_TO_IGNORED));
      }
      
      private function generateEvent(param1:String) : ContactsFormEvent {
         var _loc2_:Object = this.getSelectedItem();
         var _loc3_:ContactsFormEvent = new ContactsFormEvent(param1,true,false,this.textInput.text);
         if(_loc2_)
         {
            _loc3_.uid = _loc2_.uid;
            _loc3_.name = _loc2_.userName;
         }
         return _loc3_;
      }
      
      private function getParent() : IContactsWindowMeta {
         return IContactsWindowMeta(parent.parent.parent);
      }
      
      public function getComponentForFocus() : InteractiveObject {
         return this.textInput;
      }
      
      public function canShowAutomatically() : Boolean {
         return true;
      }
   }
}
