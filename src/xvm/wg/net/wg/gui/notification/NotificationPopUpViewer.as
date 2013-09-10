package net.wg.gui.notification 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    
    public class NotificationPopUpViewer extends net.wg.infrastructure.base.meta.impl.NotificationPopUpViewerMeta implements net.wg.infrastructure.base.meta.INotificationPopUpViewerMeta
    {
        public function NotificationPopUpViewer(arg1:Class)
        {
            this.layoutInfo = new net.wg.gui.notification.LayoutInfoVO({"paddingRight":0, "paddingBottom":0});
            this.stageDimensions = new flash.geom.Point(0, 0);
            this.pendingForDisplay = new Vector.<net.wg.gui.notification.NotificationInfoVO>();
            this.displayingNowPopUps = new Vector.<net.wg.gui.notification.ServiceMessagePopUp>();
            super();
            this.popupClass = arg1;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=0;
            var loc10:*=NaN;
            super.draw();
            if (this.isMessagesCountInvalid) 
            {
                this.isMessagesCountInvalid = false;
                loc1 = Math.min(this.maxAvailaleMessagesCount, this.pendingForDisplay.length);
                loc2 = 0;
                loc4 = App.systemMessages;
                while (this.pendingForDisplay.length > 0) 
                {
                    loc3 = this.pendingForDisplay.shift();
                    if (!(this.pendingForDisplay.length < loc1)) 
                        continue;
                    (loc5 = new this.popupClass()).animationSpeed = this.animationSpeed;
                    loc5.livingTime = this.messageLivingTime;
                    App.instance.systemMessages.addChild(loc5);
                    loc5.addEventListener(net.wg.gui.notification.ServiceMessageEvent.MESSAGE_AREA_CLICKED, this.messageClickHandler, false, 0, true);
                    loc5.addEventListener(net.wg.gui.notification.ServiceMessageEvent.MESSAGE_BUTTON_CLICKED, this.mouseButtonClickHandler, false, 0, true);
                    loc5.addEventListener(net.wg.gui.notification.ServiceMessageEvent.MESSAGE_LINK_CLICKED, this.messageLinkClickHandler, false, 0, true);
                    loc5.addEventListener(net.wg.gui.notification.ServiceMessagePopUp.HIDED, this.removePopupHandler, false, 0, true);
                    loc5.data = loc3;
                    loc5.validateNow();
                    this.arrangeLayout = true;
                    this.displayingNowPopUps.unshift(loc5);
                    ++loc2;
                }
                while (this.displayingNowPopUps.length > this.maxAvailaleMessagesCount) 
                    this.removePopupAt((this.displayingNowPopUps.length - 1), true);
            }
            if (this.arrangeLayout) 
            {
                this.arrangeLayout = false;
                loc7 = 0;
                loc8 = this.displayingNowPopUps.length;
                loc9 = 0;
                while (loc9 < loc8) 
                {
                    (loc6 = this.displayingNowPopUps[loc9]).x = Math.round(this.stageDimensions.x - loc6.width - this.layoutInfo.paddingRight);
                    loc10 = loc6.height;
                    loc6.y = Math.round(this.stageDimensions.y - loc7 - this.popupPadding * loc9 - this.layoutInfo.paddingBottom - loc10);
                    loc7 = loc7 + loc10;
                    ++loc9;
                }
            }
            return;
        }

        internal function messageClickHandler(arg1:flash.events.Event):void
        {
            arg1.stopImmediatePropagation();
            var loc1:*=net.wg.gui.notification.ServiceMessagePopUp(arg1.target);
            App.utils.scheduler.scheduleTask(this.removePopupAt, 50, this.displayingNowPopUps.indexOf(loc1), false);
            return;
        }

        internal function mouseButtonClickHandler(arg1:flash.events.Event):void
        {
            arg1.stopImmediatePropagation();
            var loc1:*=net.wg.gui.notification.NotificationInfoVO(net.wg.gui.notification.ServiceMessagePopUp(arg1.target).data).messageVO.showMore;
            onMessageShowMoreS(loc1);
            this.messageClickHandler(arg1);
            return;
        }

        internal function messageLinkClickHandler(arg1:net.wg.gui.notification.ServiceMessageEvent):void
        {
            arg1.stopImmediatePropagation();
            var loc1:*=arg1.linkType;
            switch (loc1) 
            {
                case "securityLink":
                    onSecuritySettingsLinkClickS();
                    break;
                default:
                    break;
            }
            return;
        }

        internal function removePopupHandler(arg1:flash.events.Event):void
        {
            var loc1:*=net.wg.gui.notification.ServiceMessagePopUp(arg1.target);
            this.removePopupAt(this.displayingNowPopUps.indexOf(loc1), true);
            return;
        }

        public function as_removeAllMessages():void
        {
            while (this.displayingNowPopUps.length > 0) 
                this.removePopupAt(0, false);
            return;
        }

        internal function removePopupAt(arg1:int, arg2:Boolean, arg3:Boolean=true):void
        {
            var loc1:*;
            if ((loc1 = this.displayingNowPopUps.splice(arg1, 1)[0]).parent) 
                loc1.parent.removeChild(loc1);
            loc1.dispose();
            loc1.removeEventListener(net.wg.gui.notification.ServiceMessagePopUp.HIDED, this.removePopupHandler);
            loc1.removeEventListener(net.wg.gui.notification.ServiceMessageEvent.MESSAGE_AREA_CLICKED, this.messageClickHandler);
            loc1.removeEventListener(net.wg.gui.notification.ServiceMessageEvent.MESSAGE_BUTTON_CLICKED, this.mouseButtonClickHandler);
            loc1.removeEventListener(net.wg.gui.notification.ServiceMessageEvent.MESSAGE_LINK_CLICKED, this.messageLinkClickHandler);
            if (arg3) 
                onMessageHidedS(arg2, net.wg.gui.notification.NotificationInfoVO(loc1.data).notify);
            if (this.displayingNowPopUps.length > 0) 
            {
                this.arrangeLayout = true;
                invalidate();
            }
            else 
            {
                setListClearS();
                this.arrangeLayout = false;
            }
            return;
        }

        public function as_appendMessage(arg1:Object):void
        {
            var loc1:*=new net.wg.gui.notification.NotificationInfoVO(arg1);
            this.pendingForDisplay.push(loc1);
            this.isMessagesCountInvalid = true;
            invalidate();
            return;
        }

        public function as_initInfo(arg1:Number, arg2:Number, arg3:Number, arg4:Number):void
        {
            this.maxAvailaleMessagesCount = arg1;
            this.popupPadding = arg3;
            this.messageLivingTime = arg2;
            this.animationSpeed = arg4;
            this.isMessagesCountInvalid = true;
            invalidate();
            return;
        }

        public function as_layoutInfo(arg1:Object):void
        {
            this.layoutInfo = new net.wg.gui.notification.LayoutInfoVO(arg1);
            this.arrangeLayout = true;
            invalidate();
            return;
        }

        public function updateStage(arg1:Number, arg2:Number):void
        {
            this.stageDimensions = new flash.geom.Point(arg1, arg2);
            this.arrangeLayout = true;
            invalidate();
            return;
        }

        protected override function onDispose():void
        {
            while (this.displayingNowPopUps.length > 0) 
                this.removePopupAt(0, false, false);
            super.onDispose();
            return;
        }

        internal var layoutInfo:net.wg.gui.notification.LayoutInfoVO;

        internal var stageDimensions:flash.geom.Point;

        internal var pendingForDisplay:__AS3__.vec.Vector.<net.wg.gui.notification.NotificationInfoVO>;

        internal var displayingNowPopUps:__AS3__.vec.Vector.<net.wg.gui.notification.ServiceMessagePopUp>;

        internal var messageLivingTime:Number;

        internal var popupPadding:uint=0;

        internal var isMessagesCountInvalid:Boolean;

        internal var arrangeLayout:Boolean;

        internal var maxAvailaleMessagesCount:uint=5;

        internal var popupClass:Class;

        internal var animationSpeed:Number;
    }
}
