package net.wg.gui.lobby.messengerBar
{
   import net.wg.infrastructure.base.meta.impl.NotificationListButtonMeta;
   import net.wg.infrastructure.base.meta.INotificationListButtonMeta;
   import net.wg.gui.components.advanced.BlinkingButton;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.data.constants.SoundTypes;


   public class NotificationListButton extends NotificationListButtonMeta implements INotificationListButtonMeta
   {
          
      public function NotificationListButton() {
         super();
      }

      public var button:BlinkingButton;

      override protected function configUI() : void {
         super.configUI();
         addEventListener(ButtonEvent.CLICK,this.btnClickHandler,false,0,true);
         this.button.tooltip = TOOLTIPS.LOBY_MESSENGER_SERVICE_BUTTON;
         this.button.soundType = SoundTypes.MESSANGER_BTN;
      }

      override protected function draw() : void {
         super.draw();
      }

      private function btnClickHandler(param1:ButtonEvent) : void {
         handleClickS();
      }

      public function as_setState(param1:Boolean) : void {
         if(this.button.blinking != param1)
         {
            this.button.blinking = param1;
         }
      }

      override protected function onDispose() : void {
         super.onDispose();
         removeEventListener(ButtonEvent.CLICK,this.btnClickHandler);
         this.button.dispose();
         this.button = null;
      }
   }

}