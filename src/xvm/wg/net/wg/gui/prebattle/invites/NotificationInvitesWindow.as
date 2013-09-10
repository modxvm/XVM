package net.wg.gui.prebattle.invites 
{
    import flash.events.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.messengerBar.*;
    import net.wg.gui.prebattle.meta.*;
    import net.wg.gui.prebattle.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.utils.*;
    
    public class NotificationInvitesWindow extends net.wg.gui.prebattle.meta.impl.NotificationInvitesWindowMeta implements net.wg.gui.prebattle.meta.INotificationInvitesWindowMeta
    {
        public function NotificationInvitesWindow()
        {
            super();
            return;
        }

        public function get defaultPosition():Object
        {
            return this._defaultPosition;
        }

        public function set defaultPosition(arg1:Object):void
        {
            if (arg1 == null) 
                return;
            this._defaultPosition = {"paddingRight":arg1.paddingRight, "paddingBottom":arg1.paddingBottom};
            return;
        }

        protected override function preInitialize():void
        {
            super.preInitialize();
            return;
        }

        public function as_setInvites(arg1:Object):void
        {
            this.messageArea.htmlText = arg1.toString();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            canResize = true;
            canClose = true;
            canDrag = true;
            showWindowBg = false;
            isCentered = false;
            window.title = INVITES.GUI_TITLES_RECEIVEDINVITES;
            var loc1:*=window.contentPadding as scaleform.clik.utils.Padding;
            loc1.right = 15;
            loc1.left = 16;
            loc1.top = 40;
            loc1.bottom = 20;
            window.contentPadding = loc1;
            geometry = new net.wg.gui.lobby.messengerBar.WindowGeometryInBar(net.wg.gui.events.MessengerBarEvent.PIN_RECEIVED_INVITES_WINDOW);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE) && constraints) 
                this.updateSizes();
            return;
        }

        protected override function configUI():void
        {
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            super.configUI();
            if (constraints) 
                constraints.addElement("messageArea", this.messageArea, scaleform.clik.utils.Constraints.ALL);
            this.messageArea.textField.addEventListener(flash.events.TextEvent.LINK, this.onLinkClickHandler);
            this.updateSizes();
            requestInvitesS();
            window.setMaxWidth(MAX_MIN_WINDOW_SIZE.maxWidth);
            window.setMaxHeight(MAX_MIN_WINDOW_SIZE.maxHeight);
            return;
        }

        internal function updateSizes():void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (constraints) 
            {
                loc1 = window.width - window.contentPadding.left - window.contentPadding.right;
                loc2 = window.height - window.contentPadding.top - window.contentPadding.bottom;
                constraints.update(loc1, loc2);
            }
            return;
        }

        internal function onLinkClickHandler(arg1:flash.events.TextEvent):void
        {
            selectedInviteS(arg1.text);
            return;
        }

        internal static const MAX_MIN_WINDOW_SIZE:Object={"minWidth":332, "minHeight":330, "maxWidth":1023, "maxHeight":768};

        public var messageArea:net.wg.gui.components.advanced.TextAreaSimple;

        internal var _defaultPosition:Object=null;
    }
}
