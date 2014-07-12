package net.wg.gui.lobby.header
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.WalletResourcesStatus;
   import net.wg.gui.components.controls.IconTextButton;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.events.HeaderEvent;
   
   public class AccountInfo extends UIComponent
   {
      
      public function AccountInfo() {
         super();
      }
      
      public var premium_info:MovieClip;
      
      public var gold:IconText;
      
      public var credits:IconText;
      
      public var experience:IconText;
      
      public var walletHaveNotGold:WalletResourcesStatus = null;
      
      public var walletHaveNotFreeXp:WalletResourcesStatus = null;
      
      public var premiumBtn:IconTextButton;
      
      public var accountRefillBtn:IconTextButton;
      
      public var goldExchangeBtn:IconTextButton;
      
      public var expGatheringBtn:IconTextButton;
      
      private var m_isPremium:Boolean = false;
      
      public var steamPackets:Array;
      
      override protected function configUI() : void {
         this.gold.focusable = false;
         this.gold.mouseChildren = false;
         this.credits.focusable = false;
         this.credits.mouseChildren = false;
         this.experience.focusable = false;
         this.experience.mouseChildren = false;
         this.premium_info.mouseEnabled = false;
         this.premium_info.mouseChildren = false;
         this.premiumBtn.addEventListener(ButtonEvent.CLICK,this.onPremiumBtnClickHndlr);
         this.goldExchangeBtn.addEventListener(ButtonEvent.CLICK,this.showExchange);
         this.accountRefillBtn.addEventListener(ButtonEvent.CLICK,this.onPaymentBtnClick);
         this.expGatheringBtn.addEventListener(ButtonEvent.CLICK,this.onGatheringXPBtnClick);
      }
      
      override protected function onDispose() : void {
         super.onDispose();
         this.premiumBtn.removeEventListener(ButtonEvent.CLICK,this.onPremiumBtnClickHndlr);
         this.goldExchangeBtn.removeEventListener(ButtonEvent.CLICK,this.showExchange);
         this.accountRefillBtn.removeEventListener(ButtonEvent.CLICK,this.onPaymentBtnClick);
         this.expGatheringBtn.removeEventListener(ButtonEvent.CLICK,this.onGatheringXPBtnClick);
         this.premium_info = null;
         this.gold.dispose();
         this.gold = null;
         this.credits.dispose();
         this.credits = null;
         this.experience.dispose();
         this.experience = null;
         this.premiumBtn.dispose();
         this.premiumBtn = null;
         this.accountRefillBtn.dispose();
         this.accountRefillBtn = null;
         this.goldExchangeBtn.dispose();
         this.goldExchangeBtn = null;
         this.expGatheringBtn.dispose();
         this.expGatheringBtn = null;
         this.walletHaveNotGold.dispose();
         this.walletHaveNotGold = null;
         this.walletHaveNotFreeXp.dispose();
         this.walletHaveNotFreeXp = null;
         if(this.steamPackets)
         {
            this.steamPackets.splice(0,this.steamPackets.length);
            this.steamPackets = null;
         }
      }
      
      public function setProfileType(param1:String) : void {
         this.premiumBtn.label = MENU.COMMON_PREMIUMBUY;
         this.premiumBtn.tooltip = TOOLTIPS.HEADER_PREMIUM_BUY;
         this.premiumBtn.enabled = true;
         this.premium_info.textField.htmlText = param1;
      }
      
      public function setPremiumParams(param1:String, param2:String, param3:Boolean) : void {
         this.premiumBtn.label = param2;
         this.premiumBtn.tooltip = TOOLTIPS.HEADER_PREMIUM_EXTEND;
         this.premiumBtn.enabled = !param3;
         this.premium_info.textField.htmlText = this.premium_info.textField.htmlText + (" " + param1);
      }
      
      public function setExp(param1:String, param2:Boolean) : void {
         this.experience.text = param1;
         this.experience.toolTip = param2?TOOLTIPS.USEFREEXP:TOOLTIPS.FREEXP;
      }
      
      public function setCredits(param1:String) : void {
         this.credits.text = param1;
      }
      
      public function setGold(param1:String) : void {
         this.gold.text = param1;
      }
      
      public function updateWalletStatus() : void {
         this.gold.visible = !this.walletHaveNotGold.updateStatus(App.utils.voMgr.walletStatusVO.goldStatus);
         this.experience.visible = !this.walletHaveNotFreeXp.updateStatus(App.utils.voMgr.walletStatusVO.freeXpStatus);
      }
      
      public function onPremiumChange(param1:Boolean) : void {
         this.m_isPremium = param1;
      }
      
      public function disablePaymentButon(param1:Boolean) : void {
         this.accountRefillBtn.enabled = param1;
      }
      
      public function onPaymentBtnClick(param1:ButtonEvent) : void {
         dispatchEvent(new HeaderEvent(HeaderEvent.PAYMENT_BTN_CLICK));
      }
      
      public function showExchange(param1:ButtonEvent) : void {
         dispatchEvent(new HeaderEvent(HeaderEvent.SHOW_EXCHANGE));
      }
      
      public function onGatheringXPBtnClick(param1:Object) : void {
         dispatchEvent(new HeaderEvent(HeaderEvent.SHOW_XP_EXCHANGE));
      }
      
      public function onPremiumBtnClickHndlr(param1:ButtonEvent) : void {
         dispatchEvent(new HeaderEvent(HeaderEvent.SHOW_PREMIUM));
      }
   }
}
