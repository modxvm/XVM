package net.wg.gui.lobby.messengerBar
{
   import net.wg.infrastructure.base.meta.impl.NotificationInvitesButtonMeta;
   import net.wg.infrastructure.base.meta.INotificationInvitesButtonMeta;
   import net.wg.gui.components.advanced.BlinkingButton;
   import flash.events.MouseEvent;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.data.constants.SoundTypes;


   public class NotificationInvitesButton extends NotificationInvitesButtonMeta implements INotificationInvitesButtonMeta
   {
          
      public function NotificationInvitesButton() {
         super();
      }

      public var notificationButton:BlinkingButton;

      override protected function onDispose() : void {
         super.onDispose();
         this.notificationButton.dispose();
         this.notificationButton = null;
         removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
      }

      override protected function configUI() : void {
         super.configUI();
         this.notificationButton.addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler);
         this.notificationButton.soundType = SoundTypes.MESSANGER_BTN;
      }

      public function as_setState(param1:Boolean) : void {
         this.notificationButton.blinking = param1;
      }

      private function onButtonClickHandler(param1:ButtonEvent) : void {
         handleClickS();
      }

      private function mouseOverHandler(param1:MouseEvent) : void {
         App.toolTipMgr.showComplex(TOOLTIPS.LOBY_MESSENGER_INVITES_BUTTON);
      }

      private function mouseOutHandler(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }
   }

}