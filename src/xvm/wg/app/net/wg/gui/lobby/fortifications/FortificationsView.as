package net.wg.gui.lobby.fortifications
{
    import net.wg.infrastructure.base.meta.impl.FortificationsViewMeta;
    import net.wg.infrastructure.base.meta.IFortificationsViewMeta;
    import net.wg.gui.components.advanced.ViewStack;
    import net.wg.gui.lobby.fortifications.data.base.BaseFortificationVO;
    import net.wg.gui.lobby.fortifications.data.FortificationVO;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.gui.lobby.fortifications.data.FortConstants;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import net.wg.gui.events.ViewStackEvent;
    import scaleform.clik.core.UIComponent;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.ui.InputDetails;
    import flash.ui.Keyboard;
    import scaleform.clik.constants.InputValue;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import flash.events.Event;
    
    public class FortificationsView extends FortificationsViewMeta implements IFortificationsViewMeta
    {
        
        public function FortificationsView()
        {
            super();
        }
        
        public var viewStack:ViewStack = null;
        
        private var _data:BaseFortificationVO = null;
        
        private var _currentViewAlias:String = null;
        
        override public final function setViewSize(param1:Number, param2:Number) : void
        {
            this.invalidateSize();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override public function invalidateSize() : void
        {
            super.invalidateSize();
            this.invalidateCurrentViewSize();
        }
        
        override public final function updateStage(param1:Number, param2:Number) : void
        {
            this.setViewSize(param1,param2);
        }
        
        public function as_loadView(param1:String, param2:String) : void
        {
            this.viewStack.show(param1);
            this.invalidateSize();
        }
        
        override protected function setCommonData(param1:FortificationVO) : void
        {
            if(this._data != null)
            {
                this._data.dispose();
            }
            this._data = param1;
            if(this._data != null)
            {
                IViewStackContent(this.viewStack.currentView).update(param1);
            }
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                y = 0;
                if(this.viewStack.currentLinkage == FORTIFICATION_ALIASES.WELCOME_VIEW_LINKAGE)
                {
                    x = 0;
                }
                else
                {
                    this.invalidateCurrentViewSize();
                    x = 0;
                }
            }
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.viewStack.addEventListener(FortConstants.ON_FORT_CREATE_EVENT,this.onFortCreateHandler);
            this.viewStack.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onFocusRequestHandler);
            this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangedHandler);
        }
        
        override protected function onDispose() : void
        {
            this.setCommonData(null);
            this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangedHandler);
            this.viewStack.removeEventListener(FortConstants.ON_FORT_CREATE_EVENT,this.onFortCreateHandler);
            this.viewStack.dispose();
            this.viewStack = null;
            super.onDispose();
        }
        
        private function invalidateCurrentViewSize() : void
        {
            var _loc1_:UIComponent = null;
            if(this.viewStack.currentView != null)
            {
                _loc1_ = UIComponent(this.viewStack.currentView);
                _loc1_.invalidateSize();
                _loc1_.validateNow();
            }
        }
        
        override public function handleInput(param1:InputEvent) : void
        {
            if(param1.handled)
            {
                return;
            }
            var _loc2_:InputDetails = param1.details;
            if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
            {
                param1.handled = true;
                onEscapePressS();
            }
        }
        
        private function onViewChangedHandler(param1:ViewStackEvent) : void
        {
            App.toolTipMgr.hide();
            if(this._currentViewAlias != null)
            {
                unregisterComponent(this._currentViewAlias);
            }
            if(param1.linkage == FORTIFICATION_ALIASES.MAIN_VIEW_LINKAGE)
            {
                this._currentViewAlias = FORTIFICATION_ALIASES.MAIN_VIEW_ALIAS;
                registerComponent(IDAAPIModule(param1.view),FORTIFICATION_ALIASES.MAIN_VIEW_ALIAS);
            }
            else if(param1.linkage == FORTIFICATION_ALIASES.WELCOME_VIEW_LINKAGE)
            {
                this._currentViewAlias = FORTIFICATION_ALIASES.WELCOME_VIEW_ALIAS;
                registerComponent(IDAAPIModule(param1.view),FORTIFICATION_ALIASES.WELCOME_VIEW_ALIAS);
            }
            else if(param1.linkage == FORTIFICATION_ALIASES.DISCONNECT_VIEW_LINCKAGE)
            {
                this._currentViewAlias = FORTIFICATION_ALIASES.DISCONNECT_VIEW_ALIAS;
                registerComponent(IDAAPIModule(param1.view),FORTIFICATION_ALIASES.DISCONNECT_VIEW_ALIAS);
            }
            else
            {
                DebugUtils.LOG_WARNING("Unsupported linkage:" + param1.linkage);
            }
            
            
        }
        
        private function onFocusRequestHandler(param1:FocusRequestEvent) : void
        {
            setFocus(param1.focusContainer.getComponentForFocus());
        }
        
        private function onFortCreateHandler(param1:Event) : void
        {
            setFocus(this.viewStack);
            onFortCreateClickS();
        }
    }
}
