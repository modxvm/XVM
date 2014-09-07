package net.wg.gui.rally
{
    import net.wg.gui.prebattle.meta.impl.AbstractRallyWindowMeta;
    import net.wg.gui.prebattle.meta.IAbstractRallyWindowMeta;
    import net.wg.gui.components.advanced.ViewStack;
    import net.wg.infrastructure.base.meta.IAbstractRallyViewMeta;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import scaleform.clik.controls.Button;
    
    public class AbstractRallyWindow extends AbstractRallyWindowMeta implements IAbstractRallyWindowMeta
    {
        
        public function AbstractRallyWindow()
        {
            super();
        }
        
        public var stack:ViewStack;
        
        protected var currentView:IAbstractRallyViewMeta;
        
        public function as_loadView(param1:String, param2:String) : void
        {
            if(this.currentView)
            {
                this.currentView.removeEventListener(RallyViewsEvent.LOAD_VIEW_REQUEST,this.onViewLoadRequest);
                if(!this.stack.cache)
                {
                    this.unregisterCurrentView();
                }
            }
            var _loc3_:MovieClip = this.stack.show(param1);
            this.registerCurrentView(_loc3_,param2);
            App.toolTipMgr.hide();
        }
        
        protected function registerCurrentView(param1:MovieClip, param2:String) : void
        {
            this.currentView = param1 as IAbstractRallyViewMeta;
            this.currentView.as_setPyAlias(param2);
            this.currentView.addEventListener(RallyViewsEvent.LOAD_VIEW_REQUEST,this.onViewLoadRequest);
            registerComponent(this.currentView as IDAAPIModule,this.currentView.as_getPyAlias());
        }
        
        protected function unregisterCurrentView() : void
        {
            setFocus(this);
            unregisterComponent(this.currentView.as_getPyAlias());
        }
        
        protected function onViewLoadRequest(param1:RallyViewsEvent) : void
        {
        }
        
        public function as_enableWndCloseBtn(param1:Boolean) : void
        {
            Button(window.getCloseBtn()).enabled = param1;
        }
        
        override protected function onDispose() : void
        {
            if(this.stack)
            {
                this.stack.dispose();
                this.stack = null;
            }
            this.currentView = null;
            super.onDispose();
        }
    }
}
