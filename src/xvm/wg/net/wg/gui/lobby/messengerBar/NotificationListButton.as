package net.wg.gui.lobby.messengerBar 
{
    import net.wg.gui.components.advanced.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.events.*;
    
    public class NotificationListButton extends net.wg.infrastructure.base.meta.impl.NotificationListButtonMeta implements net.wg.infrastructure.base.meta.INotificationListButtonMeta
    {
        public function NotificationListButton()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.btnClickHandler, false, 0, true);
            this.button.tooltip = TOOLTIPS.LOBY_MESSENGER_SERVICE_BUTTON;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        internal function btnClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            handleClickS();
            return;
        }

        public function as_setState(arg1:Boolean):void
        {
            if (this.button.blinking != arg1) 
                this.button.blinking = arg1;
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.btnClickHandler);
            return;
        }

        public var button:net.wg.gui.components.advanced.BlinkingButton;
    }
}
