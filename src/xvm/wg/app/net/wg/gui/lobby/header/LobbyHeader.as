package net.wg.gui.lobby.header 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.*;
    import net.wg.gui.components.common.ticker.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class LobbyHeader extends net.wg.infrastructure.base.meta.impl.LobbyHeaderMeta implements net.wg.infrastructure.base.meta.ILobbyHeaderMeta, net.wg.infrastructure.interfaces.IHelpLayoutComponent
    {
        public function LobbyHeader()
        {
            super();
            this.visible = false;
            return;
        }

        public function as_setPremiumParams(arg1:String, arg2:String, arg3:Boolean):void
        {
            this.account.setPremiumParams(arg1, arg2, arg3);
            return;
        }

        public function as_setFreeXP(arg1:String):void
        {
            this.account.setExp(arg1);
            return;
        }

        public function as_creditsResponse(arg1:String):void
        {
            this.account.setCredits(arg1);
            return;
        }

        public function as_goldResponse(arg1:String):void
        {
            this.account.setGold(arg1);
            return;
        }

        public function as_premiumResponse(arg1:Boolean):void
        {
            this.account.onPremiumChange(arg1);
            return;
        }

        internal function onShowExchangeXPWindow(arg1:net.wg.gui.events.HeaderEvent):void
        {
            arg1.stopImmediatePropagation();
            showExchangeXPWindow({});
            return;
        }

        public function as_setServerStats(arg1:Object):void
        {
            this._serverStats = arg1;
            invalidate(INVALIDATE_SERVER_STATS);
            return;
        }

        public function as_setServerInfo(arg1:String, arg2:String):void
        {
            this.serverInfo.htmlText = arg1;
            this.serverStats.tooltipFullData = arg2;
            return;
        }

        public function as_nameResponse(arg1:String, arg2:Boolean, arg3:Boolean):void
        {
            this.tankPanel.setAccountName(arg1, arg2, arg3);
            this._isAccountNameSet = true;
            this.visible = true;
            return;
        }

        public function as_setClanEmblem(arg1:String):void
        {
            this.tankPanel.setClanEmblem(arg1);
            return;
        }

        public function as_setTankName(arg1:String):void
        {
            this.tankPanel.setTankName(arg1);
            return;
        }

        public function as_setTankType(arg1:String):void
        {
            this.tankPanel.setTankType(arg1);
            return;
        }

        public function showHelpLayout():void
        {
            if (!this._isShowHelpLayout) 
            {
                this._isShowHelpLayout = true;
                App.helpLayout.createBackground();
                this.MenuButton.showHelpLayout();
                this.account.premiumBtn.showHelpLayout();
                this.account.accountRefillBtn.showHelpLayout();
                this.account.goldExchangeBtn.showHelpLayout();
                this.account.expGatheringBtn.showHelpLayout();
                this.fightBtn.showHelpLayout();
                this.buttonsBlock.bar.showHelpLayout();
            }
            return;
        }

        public function closeHelpLayout():void
        {
            if (this._isShowHelpLayout) 
            {
                this._isShowHelpLayout = false;
                this.MenuButton.closeHelpLayout();
                this.account.premiumBtn.closeHelpLayout();
                this.account.accountRefillBtn.closeHelpLayout();
                this.account.goldExchangeBtn.closeHelpLayout();
                this.account.expGatheringBtn.closeHelpLayout();
                this.fightBtn.closeHelpLayout();
                this.buttonsBlock.bar.closeHelpLayout();
            }
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            if (isInvalid(INVALIDATE_SERVER_STATS) && this._serverStats) 
            {
                this.serverStats.setValues(this._serverStats);
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                constraints.update(width, height);
                this.buttonsBlock.x = Math.round((App.appWidth - this.buttonsBlock.bar.bg.width) / 2);
                loc1 = App.appWidth - this.ticker.width >> 1;
                if (loc1 - this.account.width < 0) 
                {
                    loc1 = loc1 + ((this.MenuButton.x + this.MenuButton.width - this.account.width >> 1) + 15);
                }
                else 
                {
                    loc1 = loc1 - 15;
                }
                this.ticker.x = loc1;
                this.fightBtn.x = this.fightBtn.x ^ 0;
            }
            return;
        }

        public override function set visible(arg1:Boolean):void
        {
            super.visible = arg1 && this._isAccountNameSet;
            return;
        }

        public override function get visible():Boolean
        {
            return super.visible;
        }

        protected override function configUI():void
        {
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            constraints.addElement("serverStats", this.serverStats, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.LEFT);
            constraints.addElement("account", this.account, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("MenuButton", this.MenuButton, scaleform.clik.utils.Constraints.LEFT);
            constraints.addElement("header_bg", this.header_bg, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement("bg", this.bg, scaleform.clik.utils.Constraints.CENTER_H);
            constraints.addElement("tutorialControl", this.tutorialControl, scaleform.clik.utils.Constraints.LEFT);
            constraints.addElement("questsControl", this.questsControl, scaleform.clik.utils.Constraints.LEFT);
            constraints.addElement("fightBtn", this.fightBtn, scaleform.clik.utils.Constraints.CENTER_H);
            constraints.addElement("voiceWave", this.voiceWave, scaleform.clik.utils.Constraints.CENTER_H);
            constraints.addElement("tankPanel", this.tankPanel, scaleform.clik.utils.Constraints.CENTER_H);
            constraints.addElement("serverInfo", this.serverInfo, scaleform.clik.utils.Constraints.CENTER_H);
            this.MenuButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onMenuButtonClick, false, 0, true);
            addEventListener(net.wg.gui.events.HeaderEvent.SHOW_EXCHANGE, this.onShowExchangeWindow, false, 0, true);
            addEventListener(net.wg.gui.events.HeaderEvent.SHOW_XP_EXCHANGE, this.onShowExchangeXPWindow, false, 0, true);
            addEventListener(net.wg.gui.events.HeaderEvent.LOAD_VIEW, this.onMenuItemClick, false, 0, true);
            addEventListener(net.wg.gui.events.HeaderEvent.SHOW_PREMIUM, this.onShowPremiumHandler, false, 0, true);
            addEventListener(net.wg.gui.events.HeaderEvent.PAYMENT_BTN_CLICK, this.onPaymentClick, false, 0, true);
            this.buttonsBlock.bar.addEventListener(net.wg.gui.events.HeaderButtonBarEvent.RESIZE, this.resizeBtnsBlock);
            App.voiceChatMgr.addEventListener(net.wg.infrastructure.events.VoiceChatEvent.START_SPEAKING, this.setSpeaking);
            App.voiceChatMgr.addEventListener(net.wg.infrastructure.events.VoiceChatEvent.STOP_SPEAKING, this.setSpeaking);
            return;
        }

        internal function resizeBtnsBlock(arg1:net.wg.gui.events.HeaderButtonBarEvent):void
        {
            this.buttonsBlock.x = Math.round((App.appWidth - arg1.width) / 2);
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            registerFlashComponentS(this.tutorialControl, net.wg.data.Aliases.TUTORIAL_CONTROL);
            registerFlashComponentS(this.questsControl, net.wg.data.Aliases.QUESTS_CONTROL);
            registerFlashComponentS(this.ticker, net.wg.data.Aliases.TICKER);
            registerFlashComponentS(this.fightBtn, net.wg.data.Aliases.FIGHT_BUTTON);
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.MenuButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onMenuButtonClick);
            removeEventListener(net.wg.gui.events.HeaderEvent.SHOW_EXCHANGE, this.onShowExchangeWindow);
            removeEventListener(net.wg.gui.events.HeaderEvent.SHOW_XP_EXCHANGE, this.onShowExchangeXPWindow);
            removeEventListener(net.wg.gui.events.HeaderEvent.LOAD_VIEW, this.onMenuItemClick);
            removeEventListener(net.wg.gui.events.HeaderEvent.SHOW_PREMIUM, this.onShowPremiumHandler);
            removeEventListener(net.wg.gui.events.HeaderEvent.PAYMENT_BTN_CLICK, this.onPaymentClick);
            this.tankPanel.dispose();
            this.serverStats.dispose();
            this.buttonsBlock.dispose();
            this.account.dispose();
            this.tutorialControl.dispose();
            this.questsControl.dispose();
            App.voiceChatMgr.removeEventListener(net.wg.infrastructure.events.VoiceChatEvent.START_SPEAKING, this.setSpeaking);
            App.voiceChatMgr.removeEventListener(net.wg.infrastructure.events.VoiceChatEvent.STOP_SPEAKING, this.setSpeaking);
            return;
        }

        internal function onPaymentClick(arg1:net.wg.gui.events.HeaderEvent):void
        {
            onPaymentS();
            return;
        }

        internal function onMenuButtonClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            showLobbyMenuS();
            return;
        }

        internal function onShowExchangeWindow(arg1:net.wg.gui.events.HeaderEvent):void
        {
            arg1.stopImmediatePropagation();
            showExchangeWindow({});
            return;
        }

        public function as_setTankElite(arg1:Boolean):void
        {
            this.tankPanel.setTankElite(arg1);
            return;
        }

        internal function onMenuItemClick(arg1:net.wg.gui.events.HeaderEvent):void
        {
            menuItemClickS(arg1.id);
            return;
        }

        internal function onShowPremiumHandler(arg1:net.wg.gui.events.HeaderEvent):void
        {
            showPremiumDialogS(arg1);
            return;
        }

        public function as_doDisableNavigation():void
        {
            this.buttonsBlock.bar.setDisableNav(true);
            return;
        }

        public function as_setScreen(arg1:String):void
        {
            this.buttonsBlock.bar.setDisableNav(false);
            this.buttonsBlock.setCurrent(arg1);
            return;
        }

        internal function setSpeaking(arg1:net.wg.infrastructure.events.VoiceChatEvent):void
        {
            if (arg1.isHimself()) 
            {
                if (arg1.type == net.wg.infrastructure.events.VoiceChatEvent.START_SPEAKING) 
                {
                    this.voiceWave.setSpeaking(true);
                }
                if (arg1.type == net.wg.infrastructure.events.VoiceChatEvent.STOP_SPEAKING) 
                {
                    this.voiceWave.setSpeaking(false);
                }
            }
            return;
        }

        public function as_setProfileType(arg1:String):void
        {
            this.account.setProfileType(arg1);
            return;
        }

        internal static const INVALIDATE_SERVER_STATS:String="serverStats";

        internal var _isAccountNameSet:Boolean=false;

        internal var _serverStats:Object=null;

        internal var _isShowHelpLayout:Boolean=false;

        public var logo:flash.display.MovieClip;

        public var serverStats:net.wg.gui.lobby.header.ServerStats;

        public var tankPanel:net.wg.gui.lobby.header.TankPanel;

        public var ticker:net.wg.gui.components.common.ticker.Ticker;

        public var buttonsBlock:net.wg.gui.lobby.header.MainMenu;

        public var fightBtn:net.wg.gui.lobby.header.FightButton;

        public var voiceWave:net.wg.gui.components.controls.VoiceWave;

        public var tutorialControl:net.wg.gui.lobby.header.TutorialControl;

        public var questsControl:net.wg.gui.lobby.header.QuestsControl;

        public var MenuButton:net.wg.gui.components.controls.IconTextButton;

        public var account:net.wg.gui.lobby.header.AccountInfo;

        public var header_bg:flash.display.MovieClip;

        public var bg:flash.display.MovieClip;

        public var serverInfo:flash.text.TextField;
    }
}
