package net.wg.gui.prebattle.invites 
{
    import flash.ui.*;
    import flash.utils.*;
    import net.wg.gui.components.controls.*;
    import org.idmedia.as3commons.util.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    
    public class PrbInviteSearchUsersForm extends net.wg.gui.prebattle.invites.InviteStackContainerBase
    {
        public function PrbInviteSearchUsersForm()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            this.addEventListener(scaleform.clik.events.ComponentEvent.SHOW, this.showHandler);
            this.nameInput.focusable = true;
            if (this.searchButton != null) 
            {
                this.searchButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleSearchUsers);
                this.nameInput.addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput);
            }
            if (rosterList != null) 
                rosterList.labelField = "displayName";
            super.configUI();
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            if (arg1.details.code == flash.ui.Keyboard.ENTER && arg1.details.value == scaleform.clik.constants.InputValue.KEY_UP) 
                if ((this.nameInput.focused || this.searchButton.focused) && this.searchButton.enabled) 
                {
                    this.handleSearchUsers();
                    arg1.handled = true;
                }
            return;
        }

        internal function handleSearchUsers(arg1:scaleform.clik.events.ButtonEvent=null):void
        {
            var loc1:*=org.idmedia.as3commons.util.StringUtils.trim(this.nameInput.text);
            if (loc1 == null) 
                return;
            rosterList.selectedIndex = -1;
            this.coolDownButton();
            var loc2:*=new net.wg.gui.prebattle.invites.SendInvitesEvent(net.wg.gui.prebattle.invites.SendInvitesEvent.SEARCH_TOKEN, true);
            loc2.searchString = loc1;
            dispatchEvent(loc2);
            return;
        }

        internal function coolDownButton():void
        {
            this.enableButton(false);
            this.searchButtonIntervalID = flash.utils.setTimeout(this.enableButton, 1000, true);
            return;
        }

        internal function enableButton(arg1:Boolean=false):void
        {
            this.searchButton.enabled = arg1;
            if (this.searchButtonIntervalID != 0) 
                flash.utils.clearTimeout(this.searchButtonIntervalID);
            return;
        }

        internal function showHandler(arg1:scaleform.clik.events.ComponentEvent):void
        {
            if (visible) 
                flash.utils.setTimeout(this.setDefaultFocus, 50);
            return;
        }

        internal function setDefaultFocus():void
        {
            if (!this.nameInput.hasFocus) 
                App.utils.focusHandler.setFocus(this.nameInput);
            return;
        }

        public override function dispose():void
        {
            if (this.searchButton != null) 
            {
                this.searchButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleSearchUsers);
                this.nameInput.removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput);
            }
            super.dispose();
            return;
        }

        public var nameInput:net.wg.gui.components.controls.TextInput;

        public var searchButton:net.wg.gui.components.controls.SoundButtonEx;

        internal var searchButtonIntervalID:uint=0;
    }
}
