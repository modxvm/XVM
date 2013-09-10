package net.wg.gui.lobby.messengerBar 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import net.wg.data.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.messengerBar.carousel.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class MessengerBar extends net.wg.infrastructure.base.meta.impl.MessengerBarMeta implements net.wg.infrastructure.base.meta.IMessengerBarMeta, net.wg.infrastructure.interfaces.IDAAPIModule, net.wg.infrastructure.interfaces.IHelpLayoutComponent
    {
        public function MessengerBar()
        {
            this.stageDimensions = new flash.geom.Point();
            super();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            registerFlashComponentS(this.notificationListBtn, net.wg.data.Aliases.NOTIFICATION_LIST_BUTTON);
            registerFlashComponentS(this.notificationInvitesBtn, net.wg.data.Aliases.NOTIFICATION_INVITES_BUTTON);
            registerFlashComponentS(this.channelCarousel, net.wg.data.Aliases.CHANNEL_CAROUSEL);
            this.channelButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onChannelButtonClick);
            this.contactButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onContactsButtonClick);
            var loc1:*=App.stage;
            loc1.addEventListener(net.wg.gui.events.MessengerBarEvent.PIN_CHANNELS_WINDOW, this.handlePinChannelsWindow);
            loc1.addEventListener(net.wg.gui.events.MessengerBarEvent.PIN_CONTACTS_WINDOW, this.handlePinContactsWindow);
            loc1.addEventListener(net.wg.gui.events.MessengerBarEvent.PIN_RECEIVED_INVITES_WINDOW, this.handlePinNotificationInviteWindow);
            return;
        }

        protected override function onDispose():void
        {
            this.channelButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onChannelButtonClick);
            this.contactButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onContactsButtonClick);
            var loc1:*=App.stage;
            loc1.removeEventListener(net.wg.gui.events.MessengerBarEvent.PIN_CHANNELS_WINDOW, this.handlePinChannelsWindow);
            loc1.removeEventListener(net.wg.gui.events.MessengerBarEvent.PIN_CONTACTS_WINDOW, this.handlePinContactsWindow);
            loc1.removeEventListener(net.wg.gui.events.MessengerBarEvent.PIN_RECEIVED_INVITES_WINDOW, this.handlePinNotificationInviteWindow);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            constraints.addElement(this.notificationListBtn.name, this.notificationListBtn, scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement(this.notificationInvitesBtn.name, this.notificationInvitesBtn, scaleform.clik.utils.Constraints.RIGHT);
            constraints.addElement(this.channelButton.name, this.channelButton, scaleform.clik.utils.Constraints.LEFT);
            constraints.addElement(this.contactButton.name, this.contactButton, scaleform.clik.utils.Constraints.LEFT);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(LAYOUT_INVALID)) 
            {
                y = this.stageDimensions.y - this.height - this.paddingBottom;
                x = this.paddingLeft;
                width = this.stageDimensions.x - this.paddingLeft - this.paddingRight;
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                constraints.update(_width, _height);
                this.channelCarousel.x = this.contactButton ? this.contactButton.x + this.contactButton.width : this.channelButton ? this.channelButton.x + this.channelButton.width : 0;
                this.channelCarousel.width = (this.notificationInvitesBtn.x - this.channelCarousel.x - 1);
            }
            return;
        }

        internal function handlePinWindow(arg1:net.wg.gui.events.MessengerBarEvent, arg2:flash.display.DisplayObject):void
        {
            var loc2:*=null;
            var loc3:*=null;
            if (arg1.eventPhase != flash.events.EventPhase.BUBBLING_PHASE) 
                return;
            var loc1:*=arg1.target as net.wg.infrastructure.interfaces.IAbstractWindowView;
            if (loc1 != null) 
            {
                loc2 = loc1.window;
                loc3 = this.getPosition(loc2, arg2);
                loc2.x = loc3.x;
                loc2.y = loc3.y;
            }
            return;
        }

        internal function getPosition(arg1:net.wg.infrastructure.interfaces.IWindow, arg2:flash.display.DisplayObject):flash.geom.Point
        {
            var loc1:*=null;
            if (arg2 != this.notificationInvitesBtn) 
                loc1 = new flash.geom.Point(arg2.x + net.wg.gui.lobby.messengerBar.WindowOffsetsInBar.WINDOW_LEFT_OFFSET, -arg1.height);
            else 
                loc1 = new flash.geom.Point(arg2.x - arg1.width + this.notificationInvitesBtn.width + net.wg.gui.lobby.messengerBar.WindowOffsetsInBar.WINDOW_RIGHT_OFFSET, -arg1.height);
            return localToGlobal(loc1);
        }

        internal function onChannelButtonClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            channelButtonClickS();
            return;
        }

        internal function onContactsButtonClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            contactsButtonClickS();
            return;
        }

        internal function handlePinChannelsWindow(arg1:net.wg.gui.events.MessengerBarEvent):void
        {
            this.handlePinWindow(arg1, this.channelButton);
            return;
        }

        internal function handlePinContactsWindow(arg1:net.wg.gui.events.MessengerBarEvent):void
        {
            this.handlePinWindow(arg1, this.contactButton);
            return;
        }

        internal function handlePinNotificationInviteWindow(arg1:net.wg.gui.events.MessengerBarEvent):void
        {
            this.handlePinWindow(arg1, this.notificationInvitesBtn);
            return;
        }

        public function showHelpLayout():void
        {
            var loc1:*=App.utils.helpLayout;
            var loc2:*=this.notificationInvitesBtn.notificationButton;
            var loc3:*=loc1.getProps(loc2.width, loc2.height, net.wg.data.constants.Directions.TOP, LOBBY_HELP.CHAT_INVITES, loc2.x, loc2.y);
            this._notificationInvitesBtnHL = loc1.create(root, loc3, this.notificationInvitesBtn);
            loc2 = this.notificationListBtn.button;
            loc3 = loc1.getProps(loc2.width, loc2.height, net.wg.data.constants.Directions.TOP, LOBBY_HELP.CHAT_SERVICE_CHANNEL, loc2.x, loc2.y);
            this._notificationListBtnHL = loc1.create(root, loc3, this.notificationListBtn);
            this.channelCarousel.showHelpLayout();
            return;
        }

        public function closeHelpLayout():void
        {
            var loc1:*=App.utils.helpLayout;
            loc1.destroy(this._notificationInvitesBtnHL);
            loc1.destroy(this._notificationListBtnHL);
            this.channelCarousel.closeHelpLayout();
            return;
        }

        public function updateStage(arg1:Number, arg2:Number):void
        {
            this.stageDimensions.x = arg1;
            this.stageDimensions.y = arg2;
            invalidate(LAYOUT_INVALID);
            return;
        }

        public function get paddingLeft():uint
        {
            return this._paddingLeft;
        }

        public function set paddingLeft(arg1:uint):void
        {
            this._paddingLeft = arg1;
            invalidate(LAYOUT_INVALID);
            return;
        }

        public function get paddingRight():uint
        {
            return this._paddingRight;
        }

        public function set paddingRight(arg1:uint):void
        {
            this._paddingRight = arg1;
            invalidate(LAYOUT_INVALID);
            return;
        }

        public function get paddingBottom():uint
        {
            return this._paddingBottom;
        }

        public function set paddingBottom(arg1:uint):void
        {
            this._paddingBottom = arg1;
            invalidate(LAYOUT_INVALID);
            return;
        }

        protected override function preInitialize():void
        {
            super.preInitialize();
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            return;
        }

        internal static const LAYOUT_INVALID:String="layoutInv";

        public var channelCarousel:net.wg.gui.lobby.messengerBar.carousel.ChannelCarousel;

        public var notificationListBtn:net.wg.gui.lobby.messengerBar.NotificationListButton;

        public var notificationInvitesBtn:net.wg.gui.lobby.messengerBar.NotificationInvitesButton;

        public var channelButton:net.wg.gui.components.controls.SoundButtonEx;

        public var contactButton:net.wg.gui.components.controls.SoundButtonEx;

        internal var stageDimensions:flash.geom.Point;

        internal var _paddingLeft:uint=0;

        internal var _paddingRight:uint=0;

        internal var _paddingBottom:uint=0;

        internal var _notificationListBtnHL:flash.display.DisplayObject;

        internal var _notificationInvitesBtnHL:flash.display.DisplayObject;
    }
}
