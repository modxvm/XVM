package net.wg.gui.prebattle.squads
{
    import net.wg.infrastructure.base.meta.impl.SquadWindowMeta;
    import net.wg.infrastructure.base.meta.ISquadWindowMeta;
    import net.wg.utils.IScheduler;
    import net.wg.infrastructure.interfaces.IWindow;
    import net.wg.gui.prebattle.squads.ev.SquadViewEvent;
    import flash.events.Event;
    import flash.display.DisplayObject;
    import net.wg.gui.components.windows.Window;
    import scaleform.clik.utils.Padding;
    import net.wg.data.constants.Errors;
    import scaleform.clik.constants.ConstrainMode;
    import scaleform.clik.events.InputEvent;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import net.wg.gui.components.windows.WindowEvent;
    import net.wg.data.Aliases;

    public class SquadWindow extends SquadWindowMeta implements ISquadWindowMeta
    {

        private static const INVALID_CONTENT_SIZE:String = "invalidContentSize";

        private static const WINDOW_PADDING_BOTTOM:Number = 19;

        private static const WINDOW_PADDING_RIGHT:Number = 13;

        public var squadView:SquadView = null;

        private var _componentId:String;

        private var _scheduler:IScheduler;

        public function SquadWindow()
        {
            this._scheduler = App.utils.scheduler;
            super();
        }

        override public function as_enableWndCloseBtn(param1:Boolean) : void
        {
            super.as_enableWndCloseBtn(param1);
            this.squadView.leaveSquadBtn.enabled = param1;
        }

        override public function setWindow(param1:IWindow) : void
        {
            super.setWindow(param1);
            this.initWindowProps();
        }

        override protected function configUI() : void
        {
            super.configUI();
            currentView = this.squadView;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INVALID_CONTENT_SIZE))
            {
                this.updateWindowSize();
                this._scheduler.scheduleOnNextFrame(this.showWindow);
            }
        }

        override protected function onDispose() : void
        {
            this._scheduler.cancelTask(this.showWindow);
            this.squadView.removeEventListener(SquadViewEvent.ON_POPULATED,this.onViewOnPopulatedHandler);
            this.squadView.removeEventListener(Event.RESIZE,this.onViewResizeHandler);
            this.squadView = null;
            this._scheduler = null;
            super.onDispose();
        }

        override protected function onPopulate() : void
        {
            this.squadView.addEventListener(Event.RESIZE,this.onViewResizeHandler);
            this.squadView.addEventListener(SquadViewEvent.ON_POPULATED,this.onViewOnPopulatedHandler);
            registerFlashComponentS(this.squadView,this._componentId);
        }

        override protected function getWindowTitle() : String
        {
            return MENU.HEADERBUTTONS_BATTLE_TYPES_SQUAD;
        }

        override protected function isChatFocusNeeded() : Boolean
        {
            return true;
        }

        public function as_setComponentId(param1:String) : void
        {
            this._componentId = param1;
        }

        public function as_setWindowTitle(param1:String) : void
        {
            window.title = param1;
        }

        private function showWindow() : void
        {
            if(!DisplayObject(window).visible)
            {
                DisplayObject(window).visible = true;
            }
        }

        private function updateWindowSize() : void
        {
            this.width = this.squadView.width;
            this.height = this.squadView.height;
            window.updateSize(this.squadView.width,this.squadView.height,true);
        }

        private function initWindowProps() : void
        {
            Window(window).visible = false;
            super.onPopulate();
            window.useBottomBtns = true;
            canMinimize = true;
            showWindowBgForm = false;
            var _loc1_:Padding = window.contentPadding as Padding;
            App.utils.asserter.assertNotNull(_loc1_,"windowPadding" + Errors.CANT_NULL);
            _loc1_.bottom = WINDOW_PADDING_BOTTOM;
            _loc1_.right = WINDOW_PADDING_RIGHT;
            window.contentPadding = _loc1_;
            window.getConstraints().scaleMode = ConstrainMode.COUNTER_SCALE;
        }

        override public function handleInput(param1:InputEvent) : void
        {
            super.handleInput(param1);
            if(param1.handled)
            {
                return;
            }
            if(param1.details.code == Keyboard.F1 && param1.details.value == InputValue.KEY_UP)
            {
                param1.handled = true;
                this.squadView.dispatchEvent(new RallyViewsEvent(RallyViewsEvent.SHOW_FAQ_WINDOW));
            }
        }

        override protected function onScaleChangedHandler(param1:WindowEvent) : void
        {
        }

        private function onViewResizeHandler(param1:Event) : void
        {
            invalidate(INVALID_CONTENT_SIZE);
        }

        private function onViewOnPopulatedHandler(param1:SquadViewEvent) : void
        {
            this.squadView.removeEventListener(SquadViewEvent.ON_POPULATED,this.onViewOnPopulatedHandler);
            registerFlashComponentS(this.squadView.getChannelComponent(),Aliases.CHANNEL_COMPONENT);
            invalidate(INVALID_CONTENT_SIZE);
        }
    }
}
