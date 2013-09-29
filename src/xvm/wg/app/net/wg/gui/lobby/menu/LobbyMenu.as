package net.wg.gui.lobby.menu 
{
    import flash.text.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.events.*;
    
    public class LobbyMenu extends net.wg.infrastructure.base.meta.impl.LobbyMenuMeta implements net.wg.infrastructure.base.meta.ILobbyMenuMeta
    {
        public function LobbyMenu()
        {
            super();
            isCentered = true;
            isModal = true;
            canClose = false;
            showWindowBg = false;
            canDrag = false;
            return;
        }

        protected override function onPopulate():void
        {
            this.content.logoffBtn.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.onLogoffClick);
            this.content.settingsBtn.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.onSettingsClick);
            this.content.quitBtn.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.onQuitClick);
            this.content.cancelBtn.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.onCancelClick);
            if (App.globalVarsMgr.isTutorialRunningS()) 
            {
                this.content.logoffBtn.label = MENU.LOBBY_MENU_BUTTONS_REFUSE_TRAINING;
                this.content.logoffBtn.enabled = !App.globalVarsMgr.isTutorialDisabledS();
            }
            window.getTitleBtnEx().textSize = 20;
            window.getTitleBtnEx().textAlign = flash.text.TextFieldAutoSize.CENTER;
            window.getTitleBtnEx().x = window.width - window.getTitleBtnEx().width >> 1;
            window.getTitleBtnEx().y = 7;
            window.title = MENU.LOBBY_MENU_TITLE;
            super.onPopulate();
            this.updateStage(App.appWidth, App.appHeight);
            return;
        }

        protected override function onDispose():void
        {
            this.content.logoffBtn.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.onLogoffClick);
            this.content.settingsBtn.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.onSettingsClick);
            this.content.quitBtn.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.onQuitClick);
            this.content.cancelBtn.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.onCancelClick);
            this.content = null;
            super.onDispose();
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            super.updateStage(arg1, arg2);
            return;
        }

        internal function onLogoffClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (App.globalVarsMgr.isTutorialRunningS()) 
            {
                refuseTrainingS();
            }
            else 
            {
                logoffClickS();
            }
            return;
        }

        internal function onSettingsClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            settingsClickS();
            return;
        }

        internal function onQuitClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            quitClickS();
            return;
        }

        internal function onCancelClick(arg1:scaleform.clik.events.ButtonEvent=null):void
        {
            cancelClickS();
            return;
        }

        public override function setFocus():void
        {
            super.setFocus();
            App.utils.focusHandler.setFocus(this.content.cancelBtn);
            return;
        }

        public var content:net.wg.gui.lobby.menu.LobbyMenuForm=null;
    }
}
