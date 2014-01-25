package net.wg.gui.messenger.forms
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.ScrollingListEx;
   import flash.display.Sprite;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.events.ListEventEx;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import net.wg.data.constants.Errors;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.messenger.evnts.ChannelsFormEvent;
   import scaleform.clik.ui.InputDetails;
   import flash.ui.Keyboard;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   import flash.display.InteractiveObject;


   public class ChannelsSearchForm extends UIComponent implements IViewStackContent
   {
          
      public function ChannelsSearchForm() {
         super();
      }

      public var searchLabel:LabelControl = null;

      public var searchResultLabel:LabelControl = null;

      public var searchNameInput:TextInput = null;

      public var searchButton:SoundButtonEx = null;

      public var searchResultList:ScrollingListEx = null;

      public var joinButton:SoundButtonEx = null;

      public var bg:Sprite = null;

      private var _data:Object = null;

      override protected function configUI() : void {
         super.configUI();
         this.joinButton.enabled = false;
         this.searchButton.addEventListener(ButtonEvent.CLICK,this.onSearchClick);
         this.joinButton.addEventListener(ButtonEvent.CLICK,this.onJoinButtonClick);
         this.searchResultList.addEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.onItemDoobleClick);
         this.searchResultList.addEventListener(ListEvent.INDEX_CHANGE,this.onIndexChange);
         this.searchNameInput.addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement("searchLabel",this.searchLabel,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("searchNameInput",this.searchNameInput,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("searchButton",this.searchButton,Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("searchResultLabel",this.searchResultLabel,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
         constraints.addElement("searchResultList",this.searchResultList,Constraints.ALL);
         constraints.addElement("bg",this.bg,Constraints.ALL);
         constraints.addElement("joinButton",this.joinButton,Constraints.LEFT | Constraints.BOTTOM);
         App.utils.scheduler.envokeInNextFrame(this.setFocusToInput);
      }

      override public function setSize(param1:Number, param2:Number) : void {
         super.setSize(param1,param2);
      }

      private function setFocusToInput() : void {
         if(this.searchNameInput.enabled)
         {
            this.searchNameInput.validateNow();
            DebugUtils.LOG_WARNING(Errors.INVALID_FOCUS_USING);
            App.utils.focusHandler.setFocus(this.searchNameInput);
         }
      }

      private function onIndexChange(param1:ListEvent=null) : void {
         this.joinButton.enabled = this.searchResultList.selectedIndex > -1;
      }

      override protected function draw() : void {
         super.draw();
         if((constraints) && (isInvalid(InvalidationType.SIZE)))
         {
            constraints.update(_width,_height);
         }
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.searchButton.removeEventListener(ButtonEvent.CLICK,this.onSearchClick);
         this.joinButton.removeEventListener(ButtonEvent.CLICK,this.onJoinButtonClick);
         this.searchResultList.removeEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.onItemDoobleClick);
         this.searchResultList.removeEventListener(ListEventEx.INDEX_CHANGE,this.onIndexChange);
         this.searchNameInput.removeEventListener(InputEvent.INPUT,this.handleInput,false);
      }

      public function update(param1:Object) : void {
         this.setFocusToInput();
      }

      public function set searchResultText(param1:String) : void {
         this.searchResultLabel.text = param1;
      }

      private function onItemDoobleClick(param1:ListEventEx) : void {
         this.tryJoin();
      }

      private function onJoinButtonClick(param1:ButtonEvent) : void {
         this.tryJoin();
      }

      private function tryJoin() : void {
         if(this.searchResultList.selectedIndex >= 0)
         {
            dispatchEvent(new ChannelsFormEvent(ChannelsFormEvent.ON_JOIN,true,false,"","","",this.searchResultList.selectedIndex));
         }
      }

      private function onSearchClick(param1:ButtonEvent) : void {
         this.dispatchSearchEv();
      }

      private function dispatchSearchEv() : void {
         var _loc1_:String = this.searchNameInput.text;
         this.searchResultList.selectedIndex = -1;
         this.searchButton.enabled = this.joinButton.enabled = false;
         dispatchEvent(new ChannelsFormEvent(ChannelsFormEvent.ON_SEARCH_CHANNEL_CLICK,true,false,_loc1_));
      }

      public function lockSearchButton(param1:Boolean) : void {
         this.searchButton.enabled = param1;
      }

      override public function handleInput(param1:InputEvent) : void {
         if(param1.isDefaultPrevented())
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         var _loc3_:uint = _loc2_.controllerIndex;
         if(_loc2_.navEquivalent == null)
         {
            if(_loc2_.code == Keyboard.ENTER)
            {
               this.handlePress(_loc3_);
               param1.handled = true;
            }
         }
         else
         {
            if(_loc2_.code != Keyboard.SPACE)
            {
               switch(_loc2_.navEquivalent)
               {
                  case NavigationCode.ENTER:
                     if(_loc2_.value == InputValue.KEY_DOWN)
                     {
                        this.handlePress(_loc3_);
                        param1.handled = true;
                     }
                     break;
               }
            }
         }
      }

      private function handlePress(param1:uint) : void {
         this.dispatchSearchEv();
      }

      override public function toString() : String {
         return "[WG ChannelsSearchForm " + name + "]";
      }

      public function getComponentForFocus() : InteractiveObject {
         return null;
      }
   }

}