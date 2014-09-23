package net.wg.gui.lobby.menu
{
    import net.wg.infrastructure.base.meta.impl.LobbyMenuMeta;
    import net.wg.infrastructure.base.meta.ILobbyMenuMeta;
    import flash.text.TextField;
    import net.wg.gui.components.common.serverStats.ServerStats;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.MovieClip;
    import scaleform.clik.events.ButtonEvent;
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
        }
        
        public var header:TextField;
        
        public var serverStats:ServerStats;
        
        public var logoffBtn:SoundButtonEx;
        
        public var settingsBtn:SoundButtonEx;
        
        public var quitBtn:SoundButtonEx;
        
        public var cancelBtn:SoundButtonEx;
        
        private var STATE_SHOW_ALL:String = "showAll";
        
        private var STATE_HIDE_SERVER_STATS:String = "_server_stats";
        
        private var STATE_HIDE_SERVERS_LIST:String = "_servers_list";
        
        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
        }
        
        override protected function onPopulate() : void
        {
            var _loc1_:String = App.globalVarsMgr.isShowServerStatsS()?"":this.STATE_HIDE_SERVER_STATS;
            _loc1_ = _loc1_ + (App.globalVarsMgr.isShowServersListS()?"":this.STATE_HIDE_SERVERS_LIST);
            _loc1_ = _loc1_ == ""?this.STATE_SHOW_ALL:"hide" + _loc1_;
            this.gotoAndPlay(_loc1_);
            MovieClip(window.getBackground()).tabEnabled = false;
            MovieClip(window.getBackground()).tabChildren = false;
            this.logoffBtn.addEventListener(ButtonEvent.PRESS,this.onLogoffClick);
            this.settingsBtn.addEventListener(ButtonEvent.PRESS,this.onSettingsClick);
            this.quitBtn.addEventListener(ButtonEvent.PRESS,this.onQuitClick);
            this.cancelBtn.addEventListener(ButtonEvent.PRESS,this.onCancelClick);
            if(App.globalVarsMgr.isTutorialRunningS())
            {
                this.logoffBtn.label = MENU.LOBBY_MENU_BUTTONS_REFUSE_TRAINING;
                this.logoffBtn.enabled = !App.globalVarsMgr.isTutorialDisabledS();
            }
            window.getTitleBtnEx().textSize = 20;
            window.getTitleBtnEx().textAlign = TextFieldAutoSize.CENTER;
            window.getTitleBtnEx().x = window.width - window.getTitleBtnEx().width >> 1;
            window.getTitleBtnEx().y = 7;
            window.title = "";
            this.header.text = MENU.LOBBY_MENU_TITLE;
            registerComponent(this.serverStats,Aliases.SERVER_STATS);
            super.onPopulate();
            this.updateStage(App.appWidth,App.appHeight);
        }
        
        override protected function onDispose() : void
        {
            this.logoffBtn.removeEventListener(ButtonEvent.PRESS,this.onLogoffClick);
            this.settingsBtn.removeEventListener(ButtonEvent.PRESS,this.onSettingsClick);
            this.quitBtn.removeEventListener(ButtonEvent.PRESS,this.onQuitClick);
            this.cancelBtn.removeEventListener(ButtonEvent.PRESS,this.onCancelClick);
            this.serverStats = null;
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
    }
}
