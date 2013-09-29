package net.wg.gui.lobby.messengerBar 
{
    import flash.events.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.events.*;
    
    public class NotificationInvitesButton extends net.wg.infrastructure.base.meta.impl.NotificationInvitesButtonMeta implements net.wg.infrastructure.base.meta.INotificationInvitesButtonMeta
    {
        public function NotificationInvitesButton()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.notificationButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onButtonClickHandler);
            this.addEventListener(flash.events.MouseEvent.MOUSE_OVER, this.mouseOverHandler);
            this.addEventListener(flash.events.MouseEvent.MOUSE_OUT, this.mouseOutHandler);
            return;
        }

        public function as_setState(arg1:Boolean):void
        {
            this.notificationButton.blinking = arg1;
            return;
        }

        internal function onButtonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            handleClickS();
            return;
        }

        internal function mouseOverHandler(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.showComplex(TOOLTIPS.LOBY_MESSENGER_INVITES_BUTTON);
            return;
        }

        internal function mouseOutHandler(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        public var notificationButton:net.wg.gui.components.advanced.BlinkingButton;
    }
}
