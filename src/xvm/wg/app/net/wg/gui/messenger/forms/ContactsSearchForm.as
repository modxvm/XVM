package net.wg.gui.messenger.forms 
{
    import flash.events.*;
    import flash.ui.*;
    import net.wg.data.components.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.messenger.evnts.*;
    import net.wg.gui.prebattle.squad.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;
    
    public class ContactsSearchForm extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function ContactsSearchForm()
        {
            super();
            return;
        }

        public function update(arg1:Object):void
        {
            if (arg1) 
            {
                this.list.dataProvider = arg1.searchDP;
                this.list.dataProvider.addEventListener(flash.events.Event.CHANGE, this.updateButtons);
                this.resultsLabel.text = arg1.resultText;
                this.searchButton.enabled = !arg1.freezeSearch;
            }
            App.utils.focusHandler.setFocus(this.textInput);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.searchButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSearchClick);
            this.addToFriendsButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onAddToFriendsClick);
            this.addToIgnoredButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onAddToIgnoredClick);
            this.list.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.showContextMenu);
            this.list.removeEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.updateButtons);
            if (this.list.dataProvider && this.list.dataProvider.hasEventListener(flash.events.Event.CHANGE)) 
            {
                this.list.dataProvider.removeEventListener(flash.events.Event.CHANGE, this.updateButtons);
                this.list.dataProvider.cleanUp();
                this.list.dataProvider = null;
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            constraints.addElement("titleLabel", this.titleLabel, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("textInput", this.textInput, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("searchButton", this.searchButton, scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("resultsLabel", this.resultsLabel, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("list", this.list, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement("addToFriendsButton", this.addToFriendsButton, scaleform.clik.utils.Constraints.BOTTOM | scaleform.clik.utils.Constraints.LEFT);
            constraints.addElement("addToIgnoredButton", this.addToIgnoredButton, scaleform.clik.utils.Constraints.BOTTOM | scaleform.clik.utils.Constraints.LEFT);
            this.searchButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSearchClick);
            this.addToFriendsButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onAddToFriendsClick);
            this.addToIgnoredButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onAddToIgnoredClick);
            this.list.addEventListener(net.wg.gui.events.ListEventEx.ITEM_CLICK, this.showContextMenu);
            this.list.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.updateButtons);
            this.textInput.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false, 0, true);
            this.addToFriendsButton.enabled = false;
            this.addToIgnoredButton.enabled = false;
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            super.handleInput(arg1);
            if (arg1.handled) 
            {
                return;
            }
            var loc1:*=arg1.details.code;
            if (arg1.details.value == scaleform.clik.constants.InputValue.KEY_UP) 
            {
                var loc2:*=loc1;
                switch (loc2) 
                {
                    case flash.ui.Keyboard.ENTER:
                    {
                        arg1.handled = true;
                        dispatchEvent(this.generateEvent(net.wg.gui.messenger.evnts.ContactsFormEvent.SEARCH));
                        arg1.handled = true;
                        break;
                    }
                }
            }
            return;
        }

        public function getSelectedItem():Object
        {
            return this.list.dataProvider.requestItemAt(this.list.selectedIndex);
        }

        internal function updateButtons(arg1:flash.events.Event=null):void
        {
            var loc1:*=this.getSelectedItem();
            if (loc1) 
            {
                this.addToFriendsButton.enabled = !net.wg.gui.prebattle.squad.MessengerUtils.isFriend(loc1) && !loc1.himself;
                this.addToIgnoredButton.enabled = !net.wg.gui.prebattle.squad.MessengerUtils.isIgnored(loc1) && !loc1.himself;
            }
            else 
            {
                this.addToFriendsButton.enabled = false;
                this.addToIgnoredButton.enabled = false;
            }
            return;
        }

        internal function showContextMenu(arg1:net.wg.gui.events.ListEventEx):void
        {
            if (arg1.buttonIdx == scaleform.gfx.MouseEventEx.RIGHT_BUTTON) 
            {
                App.contextMenuMgr.showUserContextMenu(this, arg1.itemData, new net.wg.data.components.ContextItemGenerator());
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (constraints && isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                constraints.update(_width, _height);
            }
            return;
        }

        internal function onSearchClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(this.generateEvent(net.wg.gui.messenger.evnts.ContactsFormEvent.SEARCH));
            return;
        }

        internal function onAddToFriendsClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(this.generateEvent(net.wg.gui.messenger.evnts.ContactsFormEvent.ADD_TO_FRIENDS));
            return;
        }

        internal function onAddToIgnoredClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(this.generateEvent(net.wg.gui.messenger.evnts.ContactsFormEvent.ADD_TO_IGNORED));
            return;
        }

        internal function generateEvent(arg1:String):net.wg.gui.messenger.evnts.ContactsFormEvent
        {
            var loc1:*=this.getSelectedItem();
            var loc2:*=new net.wg.gui.messenger.evnts.ContactsFormEvent(arg1, true, false, this.textInput.text);
            if (loc1) 
            {
                loc2.uid = loc1.uid;
                loc2.name = loc1.userName;
            }
            return loc2;
        }

        public var titleLabel:net.wg.gui.components.controls.LabelControl;

        public var resultsLabel:net.wg.gui.components.controls.LabelControl;

        public var searchButton:net.wg.gui.components.controls.SoundButtonEx;

        public var addToFriendsButton:net.wg.gui.components.controls.SoundButtonEx;

        public var addToIgnoredButton:net.wg.gui.components.controls.SoundButtonEx;

        public var textInput:net.wg.gui.components.controls.TextInput;

        public var list:net.wg.gui.components.controls.ScrollingListEx;
    }
}
