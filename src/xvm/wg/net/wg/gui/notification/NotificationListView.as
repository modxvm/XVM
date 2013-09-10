package net.wg.gui.notification 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class NotificationListView extends net.wg.infrastructure.base.meta.impl.NotificationsListMeta implements net.wg.infrastructure.base.meta.INotificationsListMeta
    {
        public function NotificationListView()
        {
            this.layoutInfo = new net.wg.gui.notification.LayoutInfoVO({"paddingRight":0, "paddingBottom":0});
            this.stageDimensions = new flash.geom.Point();
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            stage.addEventListener(flash.events.MouseEvent.CLICK, this.stageClickHandler, false, 0, true);
            this.stageDimensions.x = stage.stageWidth;
            this.stageDimensions.y = stage.stageHeight;
            this.list.addEventListener(net.wg.gui.notification.ServiceMessageEvent.MESSAGE_BUTTON_CLICKED, this.messageButtonClickHandler, false, 0, true);
            this.list.addEventListener(net.wg.gui.notification.ServiceMessageEvent.MESSAGE_LINK_CLICKED, this.messageLinkClickHandler, false, 0, true);
            if (this.rendererTemplate) 
                if (this.rendererTemplate.parent) 
                {
                    this.rendererTemplate.parent.removeChild(this.rendererTemplate);
                    this.rendererTemplate = null;
                }
            return;
        }

        internal function messageButtonClickHandler(arg1:net.wg.gui.notification.ServiceMessageEvent):void
        {
            arg1.stopImmediatePropagation();
            onMessageShowMoreS(net.wg.gui.notification.NotificationInfoVO(net.wg.gui.notification.ServiceMessage(arg1.target).data).messageVO.showMore);
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

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            super.handleInput(arg1);
            if (arg1.details.code == flash.ui.Keyboard.ESCAPE && arg1.details.value == scaleform.clik.constants.InputValue.KEY_DOWN) 
            {
                arg1.handled = true;
                onWindowCloseS();
            }
            return;
        }

        internal function stageClickHandler(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=arg1.target as flash.display.DisplayObject;
            if (!loc1) 
                return;
            while (loc1) 
            {
                if (loc1 == this) 
                    return;
                loc1 = loc1.parent;
            }
            onWindowCloseS();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(LAYOUT_INV)) 
            {
                this.x = this.stageDimensions.x - this.width - this.layoutInfo.paddingRight;
                this.y = this.stageDimensions.y - this.height - this.layoutInfo.paddingBottom;
            }
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            super.updateStage(arg1, arg2);
            this.stageDimensions.x = arg1;
            this.stageDimensions.y = arg2;
            invalidate(LAYOUT_INV);
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            return;
        }

        public function as_setInitData(arg1:Object):void
        {
            var loc1:*="scrollStepFactor";
            if (arg1.hasOwnProperty(loc1)) 
                this.list.scrollStepFactor = arg1[loc1];
            return;
        }

        public function as_setMessagesList(arg1:Array):void
        {
            if (arg1 == null) 
                return;
            var loc1:*=[];
            var loc2:*=arg1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1.push(new net.wg.gui.notification.NotificationInfoVO(arg1[loc3]));
                ++loc3;
            }
            this.list.dataProvider = new scaleform.clik.data.DataProvider(loc1);
            return;
        }

        public function as_appendMessage(arg1:Object):void
        {
            this.list.appendData(new net.wg.gui.notification.NotificationInfoVO(arg1));
            return;
        }

        public function as_layoutInfo(arg1:Object):void
        {
            this.layoutInfo = new net.wg.gui.notification.LayoutInfoVO(arg1);
            invalidate(LAYOUT_INV);
            return;
        }

        protected override function onDispose():void
        {
            if (stage) 
                stage.removeEventListener(flash.events.MouseEvent.CLICK, this.stageClickHandler);
            this.list.removeEventListener(net.wg.gui.notification.ServiceMessageEvent.MESSAGE_BUTTON_CLICKED, this.messageButtonClickHandler);
            this.list.removeEventListener(net.wg.gui.notification.ServiceMessageEvent.MESSAGE_LINK_CLICKED, this.messageLinkClickHandler);
            super.onDispose();
            return;
        }

        internal static const LAYOUT_INV:String="layoutInv";

        internal var layoutInfo:net.wg.gui.notification.LayoutInfoVO;

        internal var stageDimensions:flash.geom.Point;

        public var list:net.wg.gui.notification.NotificationsList;

        public var rendererTemplate:net.wg.gui.notification.ServiceMessageItemRenderer;
    }
}
