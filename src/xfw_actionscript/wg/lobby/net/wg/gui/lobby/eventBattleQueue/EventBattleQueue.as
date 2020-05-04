package net.wg.gui.lobby.eventBattleQueue
{
    import net.wg.infrastructure.base.meta.impl.EventBattleQueueMeta;
    import net.wg.infrastructure.interfaces.entity.IDraggable;
    import net.wg.infrastructure.base.meta.IEventBattleQueueMeta;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.display.Sprite;
    import net.wg.gui.events.UILoaderEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Cursors;
    import scaleform.clik.constants.InvalidationType;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.events.LobbyEvent;
    import net.wg.data.constants.DragType;
    import flash.display.InteractiveObject;
    import scaleform.clik.events.InputEvent;

    public class EventBattleQueue extends EventBattleQueueMeta implements IDraggable, IEventBattleQueueMeta
    {

        private static const LOW:String = "low";

        private static const HIGH:String = "high";

        public static const VIGNETTE_INV:String = "vignette_inv";

        public static const TIMER_INV:String = "timer_inv";

        public static const LAYOUT_INV:String = "layout_inv";

        private static const VERTICAL_THRESHOLD:int = 1366;

        private static const WARNING_MISSING_HIT_AREA_MSG:String = "vehicleHitArea is null!";

        public var vignette:UILoaderAlt;

        public var subdivisionLabel:TextField;

        public var titleLabel:TextField;

        public var timerLabel:TextField;

        public var exitButton:ISoundButtonEx;

        public var draggingArea:Sprite = null;

        public var chatLine:Sprite;

        private var _subdivisionValue:String;

        private var _titleValue:String;

        private var _timerValue:String;

        private var _resetDragParams:Boolean;

        private var _dragOffsetX:Number = 0;

        private var _dragOffsetY:Number = 0;

        public function EventBattleQueue()
        {
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            setSize(param1,param2);
            if(param1 < VERTICAL_THRESHOLD && currentFrameLabel != LOW || param1 >= VERTICAL_THRESHOLD && currentFrameLabel != HIGH)
            {
                invalidate(LAYOUT_INV);
            }
            invalidate(VIGNETTE_INV);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.vignette.mouseEnabled = this.vignette.mouseChildren = false;
            this.vignette.autoSize = false;
            this.vignette.addEventListener(UILoaderEvent.COMPLETE,this.onVignetteLoadingCompleteHandler);
            this.vignette.source = RES_ICONS.MAPS_ICONS_SECRETEVENT_BASE_BGSHADOW;
            this.exitButton.addEventListener(ButtonEvent.CLICK,this.onExitButtonClickHandler);
            this.exitButton.label = MENU.PREBATTLE_EXITBUTTON_EVENT;
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
            this.draggingArea.addEventListener(MouseEvent.ROLL_OVER,this.onVehicleHitAreaRollOverHandler);
            this.draggingArea.addEventListener(MouseEvent.ROLL_OUT,this.onVehicleHitAreaRollOutHandler);
            this.draggingArea.addEventListener(MouseEvent.MOUSE_WHEEL,this.onHitAreaMouseWheelHandler);
            App.cursor.registerDragging(this,Cursors.ROTATE);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                x = width >> 1;
                this.chatLine.x = -x;
                this.chatLine.y = height;
                this.chatLine.width = width;
                this.draggingArea.x = -x;
                this.draggingArea.width = width;
                this.draggingArea.height = height;
            }
            if(isInvalid(VIGNETTE_INV))
            {
                this.vignette.x = -width >> 1;
                this.vignette.y = 0;
                this.vignette.width = width;
                this.vignette.height = height;
            }
            if(isInvalid(LAYOUT_INV))
            {
                gotoAndStop(width < VERTICAL_THRESHOLD?LOW:HIGH);
                this.titleLabel.autoSize = TextFieldAutoSize.CENTER;
                this.timerLabel.autoSize = TextFieldAutoSize.CENTER;
            }
            if(isInvalid(InvalidationType.DATA,LAYOUT_INV))
            {
                this.subdivisionLabel.autoSize = TextFieldAutoSize.CENTER;
                this.subdivisionLabel.text = this._subdivisionValue;
            }
            if(isInvalid(TIMER_INV,LAYOUT_INV))
            {
                this.titleLabel.text = this._titleValue;
                this.timerLabel.text = this._timerValue;
            }
        }

        override protected function onBeforeDispose() : void
        {
            App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape);
            this.exitButton.removeEventListener(ButtonEvent.CLICK,this.onExitButtonClickHandler);
            this.exitButton.dispose();
            this.exitButton = null;
            this.vignette.removeEventListener(UILoaderEvent.COMPLETE,this.onVignetteLoadingCompleteHandler);
            this.vignette.dispose();
            this.vignette = null;
            this.subdivisionLabel = null;
            this.titleLabel = null;
            this.timerLabel = null;
            this.chatLine = null;
            App.cursor.unRegisterDragging(this);
            this.draggingArea.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onHitAreaMouseWheelHandler);
            this.draggingArea.removeEventListener(MouseEvent.ROLL_OVER,this.onVehicleHitAreaRollOverHandler);
            this.draggingArea.removeEventListener(MouseEvent.ROLL_OUT,this.onVehicleHitAreaRollOutHandler);
            this.draggingArea = null;
            super.onDispose();
        }

        public function as_setSubdivisionName(param1:String) : void
        {
            this._subdivisionValue = param1;
            invalidateData();
        }

        public function as_setTimer(param1:String, param2:String) : void
        {
            this._titleValue = param1;
            this._timerValue = param2;
            invalidate(TIMER_INV);
        }

        public function as_showExit(param1:Boolean) : void
        {
            this.exitButton.visible = param1;
        }

        public function getDragType() : String
        {
            return DragType.SOFT;
        }

        public function getHitArea() : InteractiveObject
        {
            if(this.draggingArea == null)
            {
                DebugUtils.LOG_WARNING(WARNING_MISSING_HIT_AREA_MSG);
                return this;
            }
            return this.draggingArea;
        }

        public function onDragging(param1:Number, param2:Number) : void
        {
            var _loc3_:Number = this._resetDragParams?0:-(this._dragOffsetX - stage.mouseX);
            var _loc4_:Number = this._resetDragParams?0:-(this._dragOffsetY - stage.mouseY);
            this._resetDragParams = false;
            this._dragOffsetX = stage.mouseX;
            this._dragOffsetY = stage.mouseY;
            dispatchEvent(new LobbyEvent(LobbyEvent.DRAGGING));
            moveSpaceS(_loc3_,_loc4_,0);
        }

        public function onEndDrag() : void
        {
            var _loc1_:Number = this._resetDragParams?0:-(this._dragOffsetX - stage.mouseX);
            var _loc2_:Number = this._resetDragParams?0:-(this._dragOffsetY - stage.mouseY);
            this._resetDragParams = false;
            this._dragOffsetX = stage.mouseX;
            this._dragOffsetY = stage.mouseY;
            dispatchEvent(new LobbyEvent(LobbyEvent.DRAGGING));
            moveSpaceS(_loc1_,_loc2_,0);
        }

        public function onStartDrag() : void
        {
            dispatchEvent(new LobbyEvent(LobbyEvent.DRAGGING_START));
            notifyCursorDraggingS(true);
            this._dragOffsetX = stage.mouseX;
            this._dragOffsetY = stage.mouseY;
        }

        private function onVignetteLoadingCompleteHandler(param1:UILoaderEvent) : void
        {
            invalidate(VIGNETTE_INV);
        }

        private function onExitButtonClickHandler(param1:ButtonEvent) : void
        {
            exitClickS();
        }

        private function handleEscape(param1:InputEvent) : void
        {
            onEscapeS();
        }

        private function onVehicleHitAreaRollOverHandler(param1:MouseEvent) : void
        {
            notifyCursorOver3dSceneS(true);
        }

        private function onVehicleHitAreaRollOutHandler(param1:MouseEvent) : void
        {
            this._resetDragParams = true;
            notifyCursorOver3dSceneS(false);
        }

        private function onHitAreaMouseWheelHandler(param1:MouseEvent) : void
        {
            moveSpaceS(0,0,param1.delta * 200);
        }
    }
}
