package net.wg.gui.prebattle.squad
{
    import net.wg.infrastructure.base.meta.impl.SquadWindowMeta;
    import net.wg.infrastructure.base.meta.ISquadWindowMeta;
    import net.wg.gui.components.windows.Window;
    import scaleform.clik.utils.Padding;
    import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
    import net.wg.gui.events.MessengerBarEvent;
    import net.wg.data.constants.generated.PREBATTLE_ALIASES;
    import net.wg.data.Aliases;
    import scaleform.clik.events.InputEvent;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import net.wg.gui.components.windows.WindowEvent;
    
    public class SquadWindow extends SquadWindowMeta implements ISquadWindowMeta
    {
        
        public function SquadWindow()
        {
            super();
        }
        
        public var squadView:SquadView = null;
        
        override protected function configUI() : void
        {
            super.configUI();
            currentView = this.squadView;
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
        }
        
        override protected function onPopulate() : void
        {
            Window(window).visible = false;
            super.onPopulate();
            window.useBottomBtns = true;
            canDrag = true;
            canMinimize = true;
            isCentered = false;
            showWindowBgForm = false;
            var _loc1_:Padding = window.contentPadding as Padding;
            _loc1_.bottom = 19;
            _loc1_.right = 13;
            window.contentPadding = _loc1_;
            geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CAROUSEL_WINDOW,getClientIDS());
            App.utils.scheduler.envokeInNextFrame(this.windowIsUpdated);
            registerComponent(this.squadView,PREBATTLE_ALIASES.SQUAD_VIEW_PY);
            registerComponent(this.squadView.getChannelComponent(),Aliases.CHANNEL_COMPONENT);
        }
        
        private function windowIsUpdated() : void
        {
            Window(window).visible = true;
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
        
        override protected function getWindowTitle() : String
        {
            return MENU.HEADERBUTTONS_BATTLE_TYPES_SQUAD;
        }
        
        override protected function onScaleChanged(param1:WindowEvent) : void
        {
        }
        
        override protected function isChatFocusNeeded() : Boolean
        {
            return true;
        }
        
        override protected function updateFocus() : void
        {
            if(lastFocusedElement)
            {
                setFocus(lastFocusedElement);
            }
            else
            {
                super.updateFocus();
            }
        }
        
        override public function as_enableWndCloseBtn(param1:Boolean) : void
        {
            super.as_enableWndCloseBtn(param1);
            this.squadView.leaveSquadBtn.enabled = param1;
        }
    }
}
