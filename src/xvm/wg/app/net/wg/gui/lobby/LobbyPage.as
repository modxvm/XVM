package net.wg.gui.lobby
{
    import net.wg.infrastructure.base.meta.impl.LobbyPageMeta;
    import net.wg.infrastructure.interfaces.entity.IDraggable;
    import net.wg.infrastructure.base.meta.ILobbyPageMeta;
    import flash.display.MovieClip;
    import net.wg.gui.components.common.ManagedContainer;
    import net.wg.gui.lobby.header.LobbyHeader;
    import net.wg.gui.notification.ServiceMessagePopUp;
    import net.wg.gui.notification.NotificationPopUpViewer;
    import net.wg.gui.lobby.messengerBar.MessengerBar;
    import flash.display.InteractiveObject;
    import net.wg.infrastructure.interfaces.IManagedContainer;
    import net.wg.data.constants.DragType;
    import net.wg.gui.events.LobbyEvent;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.Aliases;
    import net.wg.data.constants.Linkages;
    import net.wg.data.constants.ContainerTypes;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Cursors;
    
    public class LobbyPage extends LobbyPageMeta implements IDraggable, ILobbyPageMeta
    {
        
        public function LobbyPage()
        {
            super();
        }
        
        public var vehicleHitArea:MovieClip = null;
        
        public var subViewContainer:ManagedContainer = null;
        
        public var header:LobbyHeader;
        
        public var messagePopupTemplate:ServiceMessagePopUp;
        
        public var notificationPopupViewer:NotificationPopUpViewer;
        
        public var messengerBar:MessengerBar;
        
        private var dragOffsetX:Number = 0;
        
        private var dragOffsetY:Number = 0;
        
        private var _isShowHelpLayout:Boolean = false;
        
        private var previousFocus:InteractiveObject;
        
        private var TOP_SUB_VIEW_POSITION:Number = 126;
        
        override public function getSubContainer() : IManagedContainer
        {
            return this.subViewContainer;
        }
        
        override public function updateStage(param1:Number, param2:Number) : void
        {
            _originalWidth = param1;
            _originalHeight = param2;
            setSize(param1,param2);
            this.vehicleHitArea.x = 0;
            this.vehicleHitArea.y = this.TOP_SUB_VIEW_POSITION;
            this.vehicleHitArea.width = param1;
            this.vehicleHitArea.height = param2 - this.vehicleHitArea.y;
            this.messengerBar.updateStage(param1,param2);
            var _loc3_:Number = param2 - this.subViewContainer.y - this.messengerBar.height - this.messengerBar.paddingBottom + this.messengerBar.paddingTop;
            this.subViewContainer.updateStage(param1,_loc3_);
            this.header.width = param1;
            if(this.notificationPopupViewer)
            {
                this.notificationPopupViewer.updateStage(param1,param2);
            }
            if(this._isShowHelpLayout)
            {
                this.as_closeHelpLayout();
            }
        }
        
        public function onStartDrag() : void
        {
            this.dragOffsetX = stage.mouseX;
            this.dragOffsetY = stage.mouseY;
        }
        
        public function onDragging(param1:Number, param2:Number) : void
        {
            var _loc3_:Number = -(this.dragOffsetX - stage.mouseX);
            var _loc4_:Number = -(this.dragOffsetY - stage.mouseY);
            this.dragOffsetX = stage.mouseX;
            this.dragOffsetY = stage.mouseY;
            moveSpaceS(_loc3_,_loc4_,0);
        }
        
        public function onEndDrag() : void
        {
        }
        
        public function getDragType() : String
        {
            return DragType.SOFT;
        }
        
        public function getHitArea() : InteractiveObject
        {
            if(this.vehicleHitArea == null)
            {
                DebugUtils.LOG_WARNING("vehicleHitArea is null!");
                return this;
            }
            return this.vehicleHitArea.hit;
        }
        
        public function as_showHelpLayout() : void
        {
            if(!this._isShowHelpLayout)
            {
                this.previousFocus = App.utils.focusHandler.getFocus(0);
                this._isShowHelpLayout = true;
                this.header.showHelpLayout();
                this.messengerBar.showHelpLayout();
            }
        }
        
        public function as_closeHelpLayout() : void
        {
            if(this._isShowHelpLayout)
            {
                if(this.previousFocus)
                {
                    setFocus(this.previousFocus);
                    this.previousFocus = null;
                }
                this._isShowHelpLayout = false;
                this.header.closeHelpLayout();
                this.messengerBar.closeHelpLayout();
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            App.stage.addEventListener(LobbyEvent.REGISTER_DRAGGING,this.handleRegisterDragging);
            App.stage.addEventListener(LobbyEvent.UNREGISTER_DRAGGING,this.handleUnregisterDragging);
            constraints = new Constraints(this,ConstrainMode.COUNTER_SCALE);
            this.updateStage(App.appWidth,App.appHeight);
            this.messagePopupTemplate.dispose();
            this.messagePopupTemplate.parent.removeChild(this.messagePopupTemplate);
            this.messagePopupTemplate = null;
        }
        
        override protected function onSetModalFocus(param1:InteractiveObject) : void
        {
            super.onSetModalFocus(param1);
            if(param1 == null)
            {
                setFocus(this.header.buttonsBlock.bar);
            }
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                constraints.update(width,height);
            }
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerComponent(this.header,Aliases.LOBBY_HEADER);
            if(!this.notificationPopupViewer)
            {
                this.notificationPopupViewer = new NotificationPopUpViewer(App.utils.classFactory.getClass(Linkages.SERVICE_MESSAGES_POPUP));
                addChild(this.notificationPopupViewer);
                registerComponent(this.notificationPopupViewer,Aliases.SYSTEM_MESSAGES);
            }
            registerComponent(this.messengerBar,Aliases.MESSENGER_BAR);
            this.subViewContainer.manageSize = false;
            this.subViewContainer.type = ContainerTypes.LOBBY_SUB_VIEW;
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            App.stage.removeEventListener(LobbyEvent.REGISTER_DRAGGING,this.handleRegisterDragging,true);
            App.stage.removeEventListener(LobbyEvent.UNREGISTER_DRAGGING,this.handleUnregisterDragging,true);
            removeChild(this.notificationPopupViewer);
            this.vehicleHitArea = null;
            this.subViewContainer = null;
            this.header = null;
            this.notificationPopupViewer = null;
            this.messengerBar = null;
            this.previousFocus = null;
        }
        
        private function registerDraging() : void
        {
            this.vehicleHitArea.hit.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,false,0,true);
            App.cursor.registerDragging(this,Cursors.ROTATE);
        }
        
        private function unregisterDragging() : void
        {
            this.vehicleHitArea.hit.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
            App.cursor.unRegisterDragging(this);
        }
        
        private function onMouseWheel(param1:MouseEvent) : void
        {
            moveSpaceS(0,0,param1.delta * 200);
        }
        
        private function handleRegisterDragging(param1:LobbyEvent) : void
        {
            this.registerDraging();
        }
        
        private function handleUnregisterDragging(param1:LobbyEvent) : void
        {
            this.unregisterDragging();
        }
    }
}
