package net.wg.gui.messenger.forms 
{
    import flash.display.*;
    import flash.ui.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.messenger.evnts.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    import scaleform.clik.utils.*;
    
    public class ChannelsSearchForm extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function ChannelsSearchForm()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.joinButton.enabled = false;
            this.searchButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSearchClick);
            this.joinButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onJoinButtonClick);
            this.searchResultList.addEventListener(net.wg.gui.events.ListEventEx.ITEM_DOUBLE_CLICK, this.onItemDoobleClick);
            this.searchResultList.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.onIndexChange);
            this.searchNameInput.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false, 0, true);
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            constraints.addElement("searchLabel", this.searchLabel, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP);
            constraints.addElement("searchNameInput", this.searchNameInput, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP);
            constraints.addElement("searchButton", this.searchButton, scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP);
            constraints.addElement("searchResultLabel", this.searchResultLabel, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT | scaleform.clik.utils.Constraints.TOP);
            constraints.addElement("searchResultList", this.searchResultList, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement("bg", this.bg, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement("joinButton", this.joinButton, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.BOTTOM);
            App.utils.scheduler.envokeInNextFrame(this.setFocusToInput);
            return;
        }

        public override function setSize(arg1:Number, arg2:Number):void
        {
            super.setSize(arg1, arg2);
            return;
        }

        internal function setFocusToInput():void
        {
            if (this.searchNameInput.enabled) 
            {
                this.searchNameInput.validateNow();
                App.utils.focusHandler.setFocus(this.searchNameInput);
            }
            return;
        }

        internal function onIndexChange(arg1:scaleform.clik.events.ListEvent=null):void
        {
            this.joinButton.enabled = this.searchResultList.selectedIndex > -1;
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

        public override function dispose():void
        {
            super.dispose();
            this.searchButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSearchClick);
            this.joinButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onJoinButtonClick);
            this.searchResultList.removeEventListener(net.wg.gui.events.ListEventEx.ITEM_DOUBLE_CLICK, this.onItemDoobleClick);
            this.searchResultList.removeEventListener(net.wg.gui.events.ListEventEx.INDEX_CHANGE, this.onIndexChange);
            this.searchNameInput.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput, false);
            return;
        }

        public function update(arg1:Object):void
        {
            this.setFocusToInput();
            return;
        }

        public function set searchResultText(arg1:String):void
        {
            this.searchResultLabel.text = arg1;
            return;
        }

        internal function onItemDoobleClick(arg1:net.wg.gui.events.ListEventEx):void
        {
            this.tryJoin();
            return;
        }

        internal function onJoinButtonClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.tryJoin();
            return;
        }

        internal function tryJoin():void
        {
            if (this.searchResultList.selectedIndex >= 0) 
            {
                dispatchEvent(new net.wg.gui.messenger.evnts.ChannelsFormEvent(net.wg.gui.messenger.evnts.ChannelsFormEvent.ON_JOIN, true, false, "", "", "", this.searchResultList.selectedIndex));
            }
            return;
        }

        internal function onSearchClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.dispatchSearchEv();
            return;
        }

        internal function dispatchSearchEv():void
        {
            var loc1:*=this.searchNameInput.text;
            this.searchResultList.selectedIndex = -1;
            var loc2:*;
            this.joinButton.enabled = loc2 = false;
            this.searchButton.enabled = loc2;
            dispatchEvent(new net.wg.gui.messenger.evnts.ChannelsFormEvent(net.wg.gui.messenger.evnts.ChannelsFormEvent.ON_SEARCH_CHANNEL_CLICK, true, false, loc1));
            return;
        }

        public function lockSearchButton(arg1:Boolean):void
        {
            this.searchButton.enabled = arg1;
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.isDefaultPrevented()) 
            {
                return;
            }
            var loc1:*=arg1.details;
            var loc2:*=loc1.controllerIndex;
            if (loc1.navEquivalent != null) 
            {
                if (loc1.code != flash.ui.Keyboard.SPACE) 
                {
                    var loc3:*=loc1.navEquivalent;
                    switch (loc3) 
                    {
                        case scaleform.clik.constants.NavigationCode.ENTER:
                        {
                            if (loc1.value == scaleform.clik.constants.InputValue.KEY_DOWN) 
                            {
                                this.handlePress(loc2);
                                arg1.handled = true;
                            }
                            break;
                        }
                    }
                }
            }
            else if (loc1.code == flash.ui.Keyboard.ENTER) 
            {
                this.handlePress(loc2);
                arg1.handled = true;
            }
            return;
        }

        internal function handlePress(arg1:uint):void
        {
            this.dispatchSearchEv();
            return;
        }

        public override function toString():String
        {
            return "[WG ChannelsSearchForm " + name + "]";
        }

        public var searchLabel:net.wg.gui.components.controls.LabelControl=null;

        public var searchResultLabel:net.wg.gui.components.controls.LabelControl=null;

        public var searchNameInput:net.wg.gui.components.controls.TextInput=null;

        public var searchButton:net.wg.gui.components.controls.SoundButtonEx=null;

        public var searchResultList:net.wg.gui.components.controls.ScrollingListEx=null;

        public var joinButton:net.wg.gui.components.controls.SoundButtonEx=null;

        public var bg:flash.display.Sprite=null;

        internal var _data:Object=null;
    }
}
