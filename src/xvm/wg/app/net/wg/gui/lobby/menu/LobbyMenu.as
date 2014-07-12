package net.wg.gui.lobby.menu
{
   import net.wg.infrastructure.base.meta.impl.LobbyMenuMeta;
   import net.wg.infrastructure.base.meta.ILobbyMenuMeta;
   import flash.display.MovieClip;
   import scaleform.clik.events.ButtonEvent;
   import flash.text.TextFieldAutoSize;
   import flash.display.InteractiveObject;
   
   public class LobbyMenu extends LobbyMenuMeta implements ILobbyMenuMeta
   {
      
      public function LobbyMenu() {
         super();
         isCentered = true;
         isModal = true;
         canClose = false;
         showWindowBg = false;
         canDrag = false;
      }
      
      public var content:LobbyMenuForm = null;
      
      override public function updateStage(param1:Number, param2:Number) : void {
         super.updateStage(param1,param2);
      }
      
      override protected function onPopulate() : void {
         MovieClip(window.getBackground()).tabEnabled = false;
         MovieClip(window.getBackground()).tabChildren = false;
         this.content.logoffBtn.addEventListener(ButtonEvent.PRESS,this.onLogoffClick);
         this.content.settingsBtn.addEventListener(ButtonEvent.PRESS,this.onSettingsClick);
         this.content.quitBtn.addEventListener(ButtonEvent.PRESS,this.onQuitClick);
         this.content.cancelBtn.addEventListener(ButtonEvent.PRESS,this.onCancelClick);
         if(App.globalVarsMgr.isTutorialRunningS())
         {
            this.content.logoffBtn.label = MENU.LOBBY_MENU_BUTTONS_REFUSE_TRAINING;
            this.content.logoffBtn.enabled = !App.globalVarsMgr.isTutorialDisabledS();
         }
         window.getTitleBtnEx().textSize = 20;
         window.getTitleBtnEx().textAlign = TextFieldAutoSize.CENTER;
         window.getTitleBtnEx().x = window.width - window.getTitleBtnEx().width >> 1;
         window.getTitleBtnEx().y = 7;
         window.title = MENU.LOBBY_MENU_TITLE;
         super.onPopulate();
         this.updateStage(App.appWidth,App.appHeight);
      }
      
      override protected function onDispose() : void {
         this.content.logoffBtn.removeEventListener(ButtonEvent.PRESS,this.onLogoffClick);
         this.content.settingsBtn.removeEventListener(ButtonEvent.PRESS,this.onSettingsClick);
         this.content.quitBtn.removeEventListener(ButtonEvent.PRESS,this.onQuitClick);
         this.content.cancelBtn.removeEventListener(ButtonEvent.PRESS,this.onCancelClick);
         this.content = null;
         super.onDispose();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void {
         super.onInitModalFocus(param1);
         setFocus(this.content.cancelBtn);
      }
      
      private function onLogoffClick(param1:ButtonEvent) : void {
         if(App.globalVarsMgr.isTutorialRunningS())
         {
            refuseTrainingS();
         }
         else
         {
            logoffClickS();
         }
      }
      
      private function onSettingsClick(param1:ButtonEvent) : void {
         settingsClickS();
      }
      
      private function onQuitClick(param1:ButtonEvent) : void {
         quitClickS();
      }
      
      private function onCancelClick(param1:ButtonEvent = null) : void {
         cancelClickS();
      }
   }
}
