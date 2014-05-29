package net.wg.gui.lobby.header
{
   import net.wg.infrastructure.base.meta.impl.LobbyHeaderMeta;
   import net.wg.infrastructure.base.meta.ILobbyHeaderMeta;
   import net.wg.infrastructure.interfaces.IHelpLayoutComponent;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.RegionDropdownMenu;
   import net.wg.gui.components.common.ticker.Ticker;
   import net.wg.gui.components.controls.VoiceWave;
   import net.wg.gui.components.controls.IconTextButton;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import net.wg.gui.events.HeaderEvent;
   import net.wg.gui.events.HeaderButtonBarEvent;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.infrastructure.events.VoiceChatEvent;
   import net.wg.data.Aliases;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.constants.InvalidationType;


   public class LobbyHeader extends LobbyHeaderMeta implements ILobbyHeaderMeta, IHelpLayoutComponent
   {
          
      public function LobbyHeader() {
         super();
         this.visible = false;
      }

      private static const INVALIDATE_SERVER_STATS:String = "serverStats";

      public var logo:MovieClip;

      public var serverStats:ServerStats;

      public var serverInfo:TextField;

      public var regionDD:RegionDropdownMenu;

      public var tankPanel:TankPanel;

      public var ticker:Ticker;

      public var buttonsBlock:MainMenu;

      public var fightBtn:FightButton;

      public var voiceWave:VoiceWave;

      public var tutorialControl:TutorialControl;

      public var questsControl:QuestsControl;

      public var MenuButton:IconTextButton;

      public var account:AccountInfo;

      public var header_bg:MovieClip;

      public var bg:MovieClip;

      private var _isAccountNameSet:Boolean = false;

      private var _serverStats:Object = null;

      private var _isShowHelpLayout:Boolean = false;

      public function as_doDisableNavigation() : void {
         this.buttonsBlock.bar.setDisableNav(true);
      }

      public function as_setScreen(param1:String) : void {
         this.buttonsBlock.bar.setDisableNav(false);
         this.buttonsBlock.setCurrent(param1);
      }

      public function as_setProfileType(param1:String) : void {
         this.account.setProfileType(param1);
      }

      public function as_disableRoamingDD(param1:Boolean) : void {
         this.regionDD.enabled = !param1;
      }

      public function as_setPremiumParams(param1:String, param2:String, param3:Boolean) : void {
         this.account.setPremiumParams(param1,param2,param3);
      }

      public function as_setFreeXP(param1:String, param2:Boolean) : void {
         this.account.setExp(param1,param2);
      }

      public function as_creditsResponse(param1:String) : void {
         this.account.setCredits(param1);
      }

      public function as_goldResponse(param1:String) : void {
         this.account.setGold(param1);
      }

      public function as_setWalletStatus(param1:Object) : void {
         App.utils.voMgr.walletStatusVO.update(param1);
         this.account.updateWalletStatus();
      }

      public function as_premiumResponse(param1:Boolean) : void {
         this.account.onPremiumChange(param1);
      }

      public function as_setServerStats(param1:Object) : void {
         this._serverStats = param1;
         invalidate(INVALIDATE_SERVER_STATS);
      }

      public function as_setServerInfo(param1:String, param2:String) : void {
         this.serverInfo.htmlText = param1;
         this.serverStats.tooltipFullData = param2;
      }

      public function as_nameResponse(param1:String, param2:String, param3:String, param4:Boolean, param5:Boolean) : void {
         this.tankPanel.setAccountName(param1,param2,param3,param4,param5);
         this._isAccountNameSet = true;
         this.visible = true;
      }

      public function as_setClanEmblem(param1:String) : void {
         this.tankPanel.setClanEmblem(param1);
      }

      public function as_setTankName(param1:String) : void {
         this.tankPanel.setTankName(param1);
      }

      public function as_setTankType(param1:String) : void {
         this.tankPanel.setTankType(param1);
      }

      public function as_setTankElite(param1:Boolean) : void {
         this.tankPanel.setTankElite(param1);
      }

      public function showHelpLayout() : void {
         if(!this._isShowHelpLayout)
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
      }

      public function closeHelpLayout() : void {
         if(this._isShowHelpLayout)
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
      }

      override public function get visible() : Boolean {
         return super.visible;
      }

      override public function set visible(param1:Boolean) : void {
         super.visible = (param1) && (this._isAccountNameSet);
      }

      override protected function configUI() : void {
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement("serverStats",this.serverStats,Constraints.TOP | Constraints.LEFT);
         constraints.addElement("account",this.account,Constraints.TOP | Constraints.RIGHT);
         constraints.addElement("MenuButton",this.MenuButton,Constraints.LEFT);
         constraints.addElement("header_bg",this.header_bg,Constraints.LEFT | Constraints.RIGHT);
         constraints.addElement("bg",this.bg,Constraints.CENTER_H);
         constraints.addElement("tutorialControl",this.tutorialControl,Constraints.LEFT);
         constraints.addElement("fightBtn",this.fightBtn,Constraints.CENTER_H);
         constraints.addElement("voiceWave",this.voiceWave,Constraints.CENTER_H);
         constraints.addElement("tankPanel",this.tankPanel,Constraints.CENTER_H);
         constraints.addElement("serverInfo",this.serverInfo,Constraints.CENTER_H);
         this.addListeners();
         this.serverStats.focusable = false;
         this.serverInfo.mouseEnabled = false;
      }

      private function addListeners() : void {
         addEventListener(HeaderEvent.SHOW_EXCHANGE,this.onShowExchangeWindow,false,0,true);
         addEventListener(HeaderEvent.SHOW_XP_EXCHANGE,this.onShowExchangeXPWindow,false,0,true);
         addEventListener(HeaderEvent.LOAD_VIEW,this.onMenuItemClick,false,0,true);
         addEventListener(HeaderEvent.SHOW_PREMIUM,this.onShowPremiumHandler,false,0,true);
         addEventListener(HeaderEvent.PAYMENT_BTN_CLICK,this.onPaymentClick,false,0,true);
         this.buttonsBlock.bar.addEventListener(HeaderButtonBarEvent.RESIZE,this.resizeBtnsBlock);
         this.MenuButton.addEventListener(ButtonEvent.CLICK,this.onMenuButtonClick,false,0,true);
         App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.setSpeaking);
         App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.setSpeaking);
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         this.checkRoaming();
         registerFlashComponentS(this.tutorialControl,Aliases.TUTORIAL_CONTROL);
         registerFlashComponentS(this.questsControl,Aliases.QUESTS_CONTROL);
         registerFlashComponentS(this.ticker,Aliases.TICKER);
         registerFlashComponentS(this.fightBtn,Aliases.FIGHT_BUTTON);
      }

      private function checkRoaming() : void {
         var _loc3_:* = false;
         var _loc1_:Boolean = App.globalVarsMgr.isRoamingEnabledS();
         var _loc2_:Array = getServersS();
         _loc3_ = (_loc1_) && _loc2_.length > 1;
         this.regionDD.visible = _loc3_;
         this.serverInfo.visible = !_loc3_;
         if(_loc3_)
         {
            this.setupServersData(_loc2_);
            this.regionDD.addEventListener(ListEvent.INDEX_CHANGE,this.changeRegion);
            this.regionDD.x = 100;
            this.serverStats.x = 300;
         }
         else
         {
            this.serverStats.x = 155;
         }
      }

      public function as_setPeripheryChanging(param1:Boolean) : void {
         if(!param1)
         {
            this.regionDD.removeEventListener(ListEvent.INDEX_CHANGE,this.changeRegion);
            this.setupServersData(getServersS());
            this.regionDD.addEventListener(ListEvent.INDEX_CHANGE,this.changeRegion);
         }
      }

      private function setupServersData(param1:Array) : void {
         var _loc5_:ServerVO = null;
         var _loc2_:DataProvider = new DataProvider();
         var _loc3_:* = -1;
         var _loc4_:* = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = new ServerVO(param1[_loc4_]);
            _loc2_.push(_loc5_);
            if(_loc5_.selected)
            {
               _loc3_ = _loc4_;
            }
            _loc4_++;
         }
         this.regionDD.dataProvider = _loc2_;
         this.regionDD.selectedIndex = _loc3_;
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.removeListeners();
         this.disposeComponents();
         this.cleanRefs();
      }

      private function cleanRefs() : void {
         var _loc1_:String = null;
         this.header_bg = null;
         this.bg = null;
         this.MenuButton = null;
         this.serverInfo = null;
         this.tankPanel = null;
         this.serverStats = null;
         this.buttonsBlock = null;
         this.voiceWave = null;
         this.account = null;
         this.fightBtn = null;
         this.ticker = null;
         this.tutorialControl = null;
         this.regionDD = null;
         this.questsControl = null;
         for (_loc1_ in this._serverStats)
         {
            delete this._serverStats[[_loc1_]];
         }
         this._serverStats = null;
         this.logo = null;
      }

      private function disposeComponents() : void {
         this.MenuButton.dispose();
         this.regionDD.dispose();
         this.tankPanel.dispose();
         this.serverStats.dispose();
         this.buttonsBlock.dispose();
         this.voiceWave.dispose();
         this.account.dispose();
      }

      private function removeListeners() : void {
         removeEventListener(HeaderEvent.SHOW_EXCHANGE,this.onShowExchangeWindow);
         removeEventListener(HeaderEvent.SHOW_XP_EXCHANGE,this.onShowExchangeXPWindow);
         removeEventListener(HeaderEvent.LOAD_VIEW,this.onMenuItemClick);
         removeEventListener(HeaderEvent.SHOW_PREMIUM,this.onShowPremiumHandler);
         removeEventListener(HeaderEvent.PAYMENT_BTN_CLICK,this.onPaymentClick);
         this.MenuButton.removeEventListener(ButtonEvent.CLICK,this.onMenuButtonClick);
         this.regionDD.removeEventListener(ListEvent.INDEX_CHANGE,this.changeRegion);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.setSpeaking);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.setSpeaking);
      }

      override protected function draw() : void {
         var _loc1_:* = NaN;
         if((isInvalid(INVALIDATE_SERVER_STATS)) && (this._serverStats))
         {
            this.serverStats.setValues(this._serverStats);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            constraints.update(width,height);
            this.buttonsBlock.x = Math.round((App.appWidth - this.buttonsBlock.bar.bg.width) / 2);
            _loc1_ = App.appWidth - this.ticker.width >> 1;
            if(_loc1_ - this.account.width < 0)
            {
               _loc1_ = _loc1_ + ((this.MenuButton.x + this.MenuButton.width - this.account.width >> 1) + 15);
            }
            else
            {
               _loc1_ = _loc1_ - 15;
            }
            this.ticker.x = _loc1_;
            this.fightBtn.x = this.fightBtn.x ^ 0;
         }
      }

      private function resizeBtnsBlock(param1:HeaderButtonBarEvent) : void {
         this.buttonsBlock.x = Math.round((App.appWidth - param1.width) / 2);
      }

      private function onPaymentClick(param1:HeaderEvent) : void {
         onPaymentS();
      }

      private function onMenuButtonClick(param1:ButtonEvent) : void {
         showLobbyMenuS();
      }

      private function onShowExchangeWindow(param1:HeaderEvent) : void {
         param1.stopImmediatePropagation();
         showExchangeWindow({});
      }

      private function onShowExchangeXPWindow(param1:HeaderEvent) : void {
         param1.stopImmediatePropagation();
         showExchangeXPWindow({});
      }

      private function onMenuItemClick(param1:HeaderEvent) : void {
         menuItemClickS(param1.id);
      }

      private function onShowPremiumHandler(param1:HeaderEvent) : void {
         showPremiumDialogS(param1);
      }

      private function setSpeaking(param1:VoiceChatEvent) : void {
         if(param1.isHimself())
         {
            if(param1.type == VoiceChatEvent.START_SPEAKING)
            {
               this.voiceWave.setSpeaking(true);
            }
            if(param1.type == VoiceChatEvent.STOP_SPEAKING)
            {
               this.voiceWave.setSpeaking(false);
            }
         }
      }

      private function changeRegion(param1:ListEvent) : void {
         reloginS(ServerVO(param1.itemData).id);
      }
   }

}