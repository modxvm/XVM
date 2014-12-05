package net.wg.gui.lobby.menu
{
    import net.wg.infrastructure.base.meta.impl.LobbyMenuMeta;
    import net.wg.infrastructure.base.meta.ILobbyMenuMeta;
    import flash.text.TextField;
    import net.wg.gui.components.common.serverStats.ServerStats;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.data.constants.Values;
    import flash.display.MovieClip;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.infrastructure.interfaces.ITextContainer;
    import flash.text.TextFieldAutoSize;
    import net.wg.data.Aliases;
    import flash.display.InteractiveObject;
    
    public class LobbyMenu extends LobbyMenuMeta implements ILobbyMenuMeta
    {
        
        public function LobbyMenu()
        {
            super();
            isCentered = true;
            isModal = true;
            canClose = false;
            showWindowBgForm = false;
            showWindowBg = false;
            canDrag = false;
            this.versionTF.visible = false;
            this.versionButton.visible = false;
        }
        
        private static var STATE_HIDE_ALL:String = "hide_all";
        
        private static var STATE_SHOW_SERVER_NAME:String = "show_server_name";
        
        private static var STATE_HIDE_SERVER_STATS_ITEM:String = "hide_server_stats_item";
        
        private static var STATE_SHOW_ALL:String = "showAll";
        
        private static var VERSION_BTN_OFFSET:Number = 8;
        
        public var header:TextField;
        
        public var serverStats:ServerStats;
        
        public var reportBugPanel:ReportBugPanel;
        
        public var logoffBtn:SoundButtonEx;
        
        public var settingsBtn:SoundButtonEx;
        
        public var quitBtn:SoundButtonEx;
        
        public var cancelBtn:SoundButtonEx;
        
        public var versionTF:TextField;
        
        public var versionButton:SoundButtonEx;
        
        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
        }
        
        override protected function onPopulate() : void
        {
            var _loc1_:String = App.globalVarsMgr.isChinaS()?STATE_SHOW_SERVER_NAME:Values.EMPTY_STR;
            if(_loc1_ == Values.EMPTY_STR)
            {
                _loc1_ = !App.globalVarsMgr.isShowServerStatsS()?STATE_HIDE_SERVER_STATS_ITEM:Values.EMPTY_STR;
            }
            if(_loc1_ == Values.EMPTY_STR)
            {
                _loc1_ = STATE_SHOW_ALL;
            }
            this.gotoAndPlay(_loc1_);
            MovieClip(window.getBackground()).tabEnabled = false;
            MovieClip(window.getBackground()).tabChildren = false;
            this.logoffBtn.addEventListener(ButtonEvent.PRESS,this.onLogoffClick);
            this.settingsBtn.addEventListener(ButtonEvent.PRESS,this.onSettingsClick);
            this.quitBtn.addEventListener(ButtonEvent.PRESS,this.onQuitClick);
            this.cancelBtn.addEventListener(ButtonEvent.PRESS,this.onCancelClick);
            this.versionButton.addEventListener(ButtonEvent.CLICK,this.onVersionButtonClick);
            if(App.globalVarsMgr.isTutorialRunningS())
            {
                this.logoffBtn.label = MENU.LOBBY_MENU_BUTTONS_REFUSE_TRAINING;
                this.logoffBtn.enabled = !App.globalVarsMgr.isTutorialDisabledS();
            }
            var _loc2_:ITextContainer = window.getTitleBtnEx();
            _loc2_.textSize = 20;
            _loc2_.textAlign = TextFieldAutoSize.CENTER;
            _loc2_.x = window.width - _loc2_.width >> 1;
            _loc2_.y = 7;
            window.title = "";
            this.header.text = MENU.LOBBY_MENU_TITLE;
            this.versionButton.tooltip = TOOLTIPS.LOBBYMENU_VERSIONINFOBUTTON;
            registerComponent(this.serverStats,Aliases.SERVER_STATS);
            registerComponent(this.reportBugPanel,Aliases.REPORT_BUG);
            this.reportBugPanel.y = this.versionButton.y + this.versionButton.height + 25;
            super.onPopulate();
            this.updateStage(App.appWidth,App.appHeight);
        }
        
        private function onVersionButtonClick(param1:ButtonEvent) : void
        {
            versionInfoClickS();
        }
        
        override protected function onDispose() : void
        {
            this.logoffBtn.removeEventListener(ButtonEvent.PRESS,this.onLogoffClick);
            this.settingsBtn.removeEventListener(ButtonEvent.PRESS,this.onSettingsClick);
            this.quitBtn.removeEventListener(ButtonEvent.PRESS,this.onQuitClick);
            this.cancelBtn.removeEventListener(ButtonEvent.PRESS,this.onCancelClick);
            this.versionButton.removeEventListener(ButtonEvent.CLICK,this.onVersionButtonClick);
            this.logoffBtn.dispose();
            this.settingsBtn.dispose();
            this.quitBtn.dispose();
            this.cancelBtn.dispose();
            this.versionButton.dispose();
            this.logoffBtn = null;
            this.settingsBtn = null;
            this.quitBtn = null;
            this.cancelBtn = null;
            this.versionButton = null;
            this.versionTF = null;
            this.serverStats = null;
            this.reportBugPanel = null;
            super.onDispose();
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this.cancelBtn);
        }
        
        private function onLogoffClick(param1:ButtonEvent) : void
        {
            if(App.globalVarsMgr.isTutorialRunningS())
            {
                refuseTrainingS();
            }
            else
            {
                logoffClickS();
            }
        }
        
        private function onSettingsClick(param1:ButtonEvent) : void
        {
            settingsClickS();
        }
        
        private function onQuitClick(param1:ButtonEvent) : void
        {
            quitClickS();
        }
        
        private function onCancelClick(param1:ButtonEvent = null) : void
        {
            cancelClickS();
        }
        
        public function as_setVersionMessage(param1:String, param2:Boolean) : void
        {
            var _loc4_:* = NaN;
            var _loc3_:Boolean = (param1) && param1.length > 0;
            if(_loc3_)
            {
                this.versionTF.autoSize = TextFieldAutoSize.LEFT;
                this.versionTF.htmlText = param1;
                _loc4_ = this.versionTF.width;
                if(param2)
                {
                    _loc4_ = _loc4_ + (VERSION_BTN_OFFSET + this.versionButton.width);
                }
                this.versionTF.x = this.header.x + (this.header.width - _loc4_ >> 1);
                this.versionButton.x = this.versionTF.x + this.versionTF.width + VERSION_BTN_OFFSET ^ 0;
            }
            this.versionTF.visible = _loc3_;
            this.versionButton.visible = (_loc3_) && (param2);
        }
    }
}
