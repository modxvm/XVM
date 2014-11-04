package net.wg.gui.rally
{
    import net.wg.infrastructure.base.meta.impl.RallyMainWindowWithSearchMeta;
    import net.wg.gui.cyberSport.interfaces.ICSAutoSearchMainView;
    import net.wg.gui.cyberSport.vo.AutoSearchVO;
    import flash.display.InteractiveObject;
    import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
    import flash.display.MovieClip;
    
    public class RallyMainWindowWithSearch extends RallyMainWindowWithSearchMeta
    {
        
        public function RallyMainWindowWithSearch()
        {
            super();
            this.autoSearch.visible = false;
            isCentered = true;
        }
        
        private static var UPDATE_AUTO_SEARCH_MODEL:String = "autoSearchModel";
        
        private static var UPDATE_AUTO_SEARCH_BUTTONS:String = "updateAutoSearchButtons";
        
        public var autoSearch:ICSAutoSearchMainView;
        
        private var autoSearchModel:AutoSearchVO;
        
        private var lastFocusedElementUnderAS:InteractiveObject;
        
        private var waitingPlayers:Boolean = false;
        
        private var searchEnemy:Boolean = false;
        
        private var updatedBtns:Boolean = true;
        
        override public function as_loadView(param1:String, param2:String) : void
        {
            this.lastFocusedElementUnderAS = null;
            super.as_loadView(param1,param2);
        }
        
        public function as_autoSearchEnableBtn(param1:Boolean) : void
        {
            this.autoSearch.enableButton(param1);
        }
        
        public function as_hideAutoSearch() : void
        {
            this.autoSearch.stopTimer();
            this.autoSearch.visible = false;
            this.autoSearchModel = null;
            setFocus(this.lastFocusedElementUnderAS?this.lastFocusedElementUnderAS:this);
        }
        
        public function as_changeAutoSearchState(param1:Object) : void
        {
            if(param1 == null)
            {
                return;
            }
            this.autoSearchModel = new AutoSearchVO(param1);
            invalidate(UPDATE_AUTO_SEARCH_MODEL);
        }
        
        public function as_changeAutoSearchBtnsState(param1:Boolean, param2:Boolean) : void
        {
            this.updatedBtns = false;
            this.waitingPlayers = param1;
            this.searchEnemy = param2;
            invalidate(UPDATE_AUTO_SEARCH_BUTTONS);
        }
        
        override protected function onDispose() : void
        {
            this.lastFocusedElementUnderAS = null;
            this.autoSearch.stopTimer();
            this.autoSearch.dispose();
            this.autoSearch = null;
            if(this.autoSearchModel)
            {
                this.autoSearchModel.dispose();
                this.autoSearchModel = null;
            }
            removeEventListener(CSComponentEvent.SHOW_AUTO_SEARCH_VIEW,this.showAutoSearchView);
            removeEventListener(CSComponentEvent.AUTO_SEARCH_APPLY_BTN,this.autoSearchApplyHandler);
            removeEventListener(CSComponentEvent.AUTO_SEARCH_CANCEL_BTN,this.autoSearchCancelHandler);
            super.onDispose();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(CSComponentEvent.SHOW_AUTO_SEARCH_VIEW,this.showAutoSearchView);
            addEventListener(CSComponentEvent.AUTO_SEARCH_APPLY_BTN,this.autoSearchApplyHandler);
            addEventListener(CSComponentEvent.AUTO_SEARCH_CANCEL_BTN,this.autoSearchCancelHandler);
            invalidate(UPDATE_AUTO_SEARCH_MODEL);
        }
        
        override protected function draw() : void
        {
            if((isInvalid(UPDATE_AUTO_SEARCH_MODEL)) && (this.autoSearchModel))
            {
                this.lastFocusedElementUnderAS = lastFocusedElement;
                this.autoSearch.changeState = this.autoSearchModel;
                this.autoSearch.visible = true;
                App.utils.scheduler.envokeInNextFrame(this.autoSearchUpdateFocus);
            }
            super.draw();
            if(!this.updatedBtns && (isInvalid(UPDATE_AUTO_SEARCH_BUTTONS)) && (this.autoSearchModel))
            {
                this.updatedBtns = true;
                this.autoSearch.changeButtonsState(this.waitingPlayers,this.searchEnemy);
            }
        }
        
        override protected function registerCurrentView(param1:MovieClip, param2:String) : void
        {
            super.registerCurrentView(param1,param2);
            if(hasFocus)
            {
                this.lastFocusedElementUnderAS = lastFocusedElement;
            }
        }
        
        protected function autoSearchUpdateFocus() : void
        {
            var _loc1_:InteractiveObject = this.autoSearch.getComponentForFocus();
            if(_loc1_ != null)
            {
                setFocus(_loc1_);
            }
        }
        
        private function autoSearchCancelHandler(param1:CSComponentEvent) : void
        {
            autoSearchCancelS(param1.data.toString());
        }
        
        private function autoSearchApplyHandler(param1:CSComponentEvent) : void
        {
            autoSearchApplyS(param1.data.toString());
        }
        
        private function showAutoSearchView(param1:CSComponentEvent) : void
        {
            onAutoMatchS(param1.data.state.toString(),param1.data.cmpDescr);
        }
    }
}
