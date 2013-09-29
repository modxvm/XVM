package net.wg.gui.lobby 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.common.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.header.*;
    import net.wg.gui.lobby.messengerBar.*;
    import net.wg.gui.notification.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.utils.*;
    
    public class LobbyPage extends net.wg.infrastructure.base.meta.impl.LobbyPageMeta implements net.wg.infrastructure.interfaces.entity.IDraggable, net.wg.infrastructure.base.meta.ILobbyPageMeta
    {
        public function LobbyPage()
        {
            super();
            return;
        }

        public override function getSubContainer():net.wg.infrastructure.interfaces.IManagedContainer
        {
            return this.subViewContainer;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            _originalWidth = arg1;
            _originalHeight = arg2;
            setSize(arg1, arg2);
            this.vehicleHitArea.x = 0;
            this.vehicleHitArea.y = 120;
            this.vehicleHitArea.width = arg1;
            this.vehicleHitArea.height = arg2 - this.vehicleHitArea.y;
            this.messengerBar.updateStage(arg1, arg2);
            var loc1:*=arg2 - this.subViewContainer.y - this.messengerBar.height - this.messengerBar.paddingBottom;
            this.subViewContainer.updateStage(arg1, loc1);
            this.header.width = arg1;
            if (this.notificationPopupViewer) 
            {
                this.notificationPopupViewer.updateStage(arg1, arg2);
            }
            if (this._isShowHelpLayout) 
            {
                this.as_closeHelpLayout();
            }
            return;
        }

        public function onStartDrag():void
        {
            this.dragOffsetX = stage.mouseX;
            this.dragOffsetY = stage.mouseY;
            return;
        }

        public function onDragging(arg1:Number, arg2:Number):void
        {
            var loc1:*=-(this.dragOffsetX - stage.mouseX);
            var loc2:*=-(this.dragOffsetY - stage.mouseY);
            this.dragOffsetX = stage.mouseX;
            this.dragOffsetY = stage.mouseY;
            moveSpaceS(loc1, loc2, 0);
            return;
        }

        public function onEndDrag():void
        {
            return;
        }

        public function getDragType():String
        {
            return net.wg.data.constants.DragType.SOFT;
        }

        public function getHitArea():flash.display.InteractiveObject
        {
            if (this.vehicleHitArea == null) 
            {
                DebugUtils.LOG_WARNING("vehicleHitArea is null!");
                return this;
            }
            return this.vehicleHitArea.hit;
        }

        public function as_showHelpLayout():void
        {
            if (!this._isShowHelpLayout) 
            {
                this.previousFocus = App.utils.focusHandler.getFocus(0);
                this._isShowHelpLayout = true;
                this.header.showHelpLayout();
                this.messengerBar.showHelpLayout();
            }
            return;
        }

        public function as_closeHelpLayout():void
        {
            if (this._isShowHelpLayout) 
            {
                if (this.previousFocus) 
                {
                    App.utils.focusHandler.setFocus(this.previousFocus);
                    this.previousFocus = null;
                }
                this._isShowHelpLayout = false;
                this.header.closeHelpLayout();
                this.messengerBar.closeHelpLayout();
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            App.stage.addEventListener(net.wg.gui.events.LobbyEvent.REGISTER_DRAGGING, this.handleRegisterDragging);
            App.stage.addEventListener(net.wg.gui.events.LobbyEvent.UNREGISTER_DRAGGING, this.handleUnregisterDragging);
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.COUNTER_SCALE);
            this.updateStage(App.appWidth, App.appHeight);
            this.messagePopupTemplate.parent.removeChild(this.messagePopupTemplate);
            this.messagePopupTemplate = null;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                constraints.update(width, height);
            }
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            registerComponent(this.header, net.wg.data.Aliases.LOBBY_HEADER);
            if (!this.notificationPopupViewer) 
            {
                this.notificationPopupViewer = new net.wg.gui.notification.NotificationPopUpViewer(App.utils.classFactory.getClass(net.wg.data.constants.Linkages.SERVICE_MESSAGES_POPUP));
                addChild(this.notificationPopupViewer);
                registerComponent(this.notificationPopupViewer, net.wg.data.Aliases.SYSTEM_MESSAGES);
            }
            registerComponent(this.messengerBar, net.wg.data.Aliases.MESSENGER_BAR);
            this.subViewContainer.manageSize = false;
            this.subViewContainer.type = net.wg.data.constants.ContainerTypes.LOBBY_SUB_VIEW;
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            App.stage.removeEventListener(net.wg.gui.events.LobbyEvent.REGISTER_DRAGGING, this.handleRegisterDragging, true);
            App.stage.removeEventListener(net.wg.gui.events.LobbyEvent.UNREGISTER_DRAGGING, this.handleUnregisterDragging, true);
            removeChild(this.notificationPopupViewer);
            return;
        }

        internal function registerDraging():void
        {
            this.vehicleHitArea.hit.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.onMouseWheel, false, 0, true);
            App.cursor.registerDragging(this, net.wg.data.constants.Cursors.ROTATE);
            return;
        }

        internal function unregisterDragging():void
        {
            this.vehicleHitArea.hit.removeEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            App.cursor.unRegisterDragging(this);
            return;
        }

        internal function onMouseWheel(arg1:flash.events.MouseEvent):void
        {
            moveSpaceS(0, 0, arg1.delta * 200);
            return;
        }

        internal function handleRegisterDragging(arg1:net.wg.gui.events.LobbyEvent):void
        {
            this.registerDraging();
            return;
        }

        internal function handleUnregisterDragging(arg1:net.wg.gui.events.LobbyEvent):void
        {
            this.unregisterDragging();
            return;
        }

        public var vehicleHitArea:flash.display.MovieClip=null;

        public var subViewContainer:net.wg.gui.components.common.ManagedContainer=null;

        public var header:net.wg.gui.lobby.header.LobbyHeader;

        public var messagePopupTemplate:net.wg.gui.notification.ServiceMessagePopUp;

        public var notificationPopupViewer:net.wg.gui.notification.NotificationPopUpViewer;

        public var messengerBar:net.wg.gui.lobby.messengerBar.MessengerBar;

        internal var dragOffsetX:Number=0;

        internal var dragOffsetY:Number=0;

        internal var _isShowHelpLayout:Boolean=false;

        internal var previousFocus:flash.display.InteractiveObject;
    }
}
