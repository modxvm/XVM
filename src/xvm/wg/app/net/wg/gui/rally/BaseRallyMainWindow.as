package net.wg.gui.rally
{
    import net.wg.infrastructure.base.meta.impl.BaseRallyMainWindowMeta;
    import net.wg.infrastructure.base.meta.IBaseRallyMainWindowMeta;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import net.wg.gui.components.advanced.ViewStack;
    import net.wg.gui.cyberSport.interfaces.ICSAutoSearchMainView;
    import net.wg.infrastructure.base.meta.IBaseRallyViewMeta;
    import net.wg.gui.cyberSport.vo.AutoSearchVO;
    import flash.display.InteractiveObject;
    import net.wg.infrastructure.interfaces.IWindow;
    import net.wg.gui.components.windows.WindowEvent;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import flash.display.MovieClip;
    import scaleform.clik.controls.Button;
    import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import net.wg.gui.cyberSport.interfaces.IChannelComponentHolder;
    import net.wg.data.Aliases;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    
    public class BaseRallyMainWindow extends BaseRallyMainWindowMeta implements IBaseRallyMainWindowMeta
    {
        
        public function BaseRallyMainWindow() {
            super();
            this.autoSearch.visible = false;
        }
        
        private static var UPDATE_AUTO_SEARCH_MODEL:String = "autoSearchModel";
        
        public static function getTeamHeader(param1:String, param2:IRallyVO, param3:int = 7) : String {
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            var _loc8_:IRallySlotVO = null;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            if((param2) && (param2.slotsArray))
            {
                _loc7_ = param2.slotsArray.length;
                _loc6_ = 0;
                while(_loc6_ < _loc7_)
                {
                    _loc8_ = param2.slotsArray[_loc6_];
                    if(!_loc8_.isClosedVal)
                    {
                        _loc4_++;
                    }
                    if(_loc8_.playerObj)
                    {
                        _loc5_++;
                    }
                    _loc6_++;
                }
            }
            else
            {
                _loc5_ = 1;
                _loc4_ = param3;
            }
            return App.utils.locale.makeString(param1,{
                "current":Utils.instance.htmlWrapper(_loc5_.toString(),Utils.instance.COLOR_NORMAL,13,"$FieldFont"),
                "max":_loc4_.toString()
            });
    }
    
    public var stack:ViewStack;
    
    public var autoSearch:ICSAutoSearchMainView;
    
    private var currentView:IBaseRallyViewMeta;
    
    private var chatFocusNeeded:Boolean = true;
    
    private var autoSearchModel:AutoSearchVO;
    
    private var lastFocusedElementUnderAS:InteractiveObject;
    
    override public function setWindow(param1:IWindow) : void {
        if(window)
        {
            window.removeEventListener(WindowEvent.SCALE_X_CHANGED,this.onScaleChanged);
            window.removeEventListener(WindowEvent.SCALE_Y_CHANGED,this.onScaleChanged);
        }
        super.setWindow(param1);
        if(window)
        {
            window.addEventListener(WindowEvent.SCALE_X_CHANGED,this.onScaleChanged);
            window.addEventListener(WindowEvent.SCALE_Y_CHANGED,this.onScaleChanged);
        }
    }
    
    override public function as_getGeometry() : Array {
        if(window)
        {
            return [window.x,window.y,-1,-1];
        }
        return null;
    }
    
    public function as_autoSearchEnableBtn(param1:Boolean) : void {
        this.autoSearch.enableButton(param1);
    }
    
    public function as_hideAutoSearch() : void {
        this.autoSearch.stopTimer();
        this.autoSearch.visible = false;
        this.autoSearchModel = null;
        setFocus(this.lastFocusedElementUnderAS?this.lastFocusedElementUnderAS:this);
    }
    
    public function as_changeAutoSearchState(param1:Object) : void {
        if(param1 == null)
        {
            return;
        }
        this.autoSearchModel = new AutoSearchVO(param1);
        invalidate(UPDATE_AUTO_SEARCH_MODEL);
    }
    
    public function as_loadView(param1:String, param2:String) : void {
        this.lastFocusedElementUnderAS = null;
        if(this.currentView)
        {
            this.currentView.removeEventListener(RallyViewsEvent.LOAD_VIEW_REQUEST,this.onViewLoadRequest);
            if(!this.stack.cache)
            {
                this.unregisterCurrentView();
            }
        }
        setFocus(window.getCloseBtn());
        var _loc3_:MovieClip = this.stack.show(param1);
        this.registerCurrentView(_loc3_,param2);
        App.toolTipMgr.hide();
    }
    
    public function as_enableWndCloseBtn(param1:Boolean) : void {
        Button(window.getCloseBtn()).enabled = param1;
    }
    
    override protected function onSetModalFocus(param1:InteractiveObject) : void {
        super.onSetModalFocus(param1);
        this.updateFocus();
    }
    
    override protected function onPopulate() : void {
        super.onPopulate();
        window.title = this.getWindowTitle();
    }
    
    override protected function onDispose() : void {
        this.lastFocusedElementUnderAS = null;
        removeEventListener(CSComponentEvent.SHOW_AUTO_SEARCH_VIEW,this.showAutoSearchView);
        removeEventListener(CSComponentEvent.AUTO_SEARCH_APPLY_BTN,this.autoSearchApplyHandler);
        removeEventListener(CSComponentEvent.AUTO_SEARCH_CANCEL_BTN,this.autoSearchCancelHandler);
        this.autoSearch.stopTimer();
        this.autoSearch.dispose();
        this.autoSearch = null;
        this.stack.dispose();
        this.stack = null;
        this.currentView = null;
        if(this.autoSearchModel)
        {
            this.autoSearchModel.dispose();
            this.autoSearchModel = null;
        }
        removeEventListener(RallyViewsEvent.BACK_NAVIGATION_REQUEST,this.backBtnClick);
        removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
        super.onDispose();
    }
    
    override protected function configUI() : void {
        if(_baseDisposed)
        {
            DebugUtils.LOG_WARNING("CyberSportMainWindow disposed before initializing");
            return;
        }
        super.configUI();
        addEventListener(CSComponentEvent.SHOW_AUTO_SEARCH_VIEW,this.showAutoSearchView);
        addEventListener(CSComponentEvent.AUTO_SEARCH_APPLY_BTN,this.autoSearchApplyHandler);
        addEventListener(CSComponentEvent.AUTO_SEARCH_CANCEL_BTN,this.autoSearchCancelHandler);
        invalidate(UPDATE_AUTO_SEARCH_MODEL);
        addEventListener(RallyViewsEvent.BACK_NAVIGATION_REQUEST,this.backBtnClick);
        addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
    }
    
    override protected function draw() : void {
        super.draw();
        if((isInvalid(UPDATE_AUTO_SEARCH_MODEL)) && (this.autoSearchModel))
        {
            this.lastFocusedElementUnderAS = lastFocusedElement;
            this.autoSearch.changeState = this.autoSearchModel;
            this.autoSearch.visible = true;
            App.utils.scheduler.envokeInNextFrame(this.autoSearchUpdateFocus);
        }
    }
    
    protected function getCurrentView() : IBaseRallyViewMeta {
        return this.currentView;
    }
    
    protected function isChatFocusNeeded() : Boolean {
        return this.chatFocusNeeded;
    }
    
    protected function resetChatFocusRequirement() : void {
        this.chatFocusNeeded = false;
    }
    
    protected function getWindowTitle() : String {
        return "BaseRallyWindow";
    }
    
    protected function registerCurrentView(param1:MovieClip, param2:String) : void {
        this.currentView = param1 as IBaseRallyViewMeta;
        this.currentView.as_setPyAlias(param2);
        this.currentView.addEventListener(RallyViewsEvent.LOAD_VIEW_REQUEST,this.onViewLoadRequest);
        var _loc3_:IChannelComponentHolder = param1 as IChannelComponentHolder;
        if(_loc3_ != null)
        {
            registerComponent(_loc3_.getChannelComponent(),Aliases.CHANNEL_COMPONENT);
        }
        registerComponent(this.currentView as IDAAPIModule,this.currentView.as_getPyAlias());
        this.chatFocusNeeded = true;
        if(hasFocus)
        {
            this.updateFocus();
            this.lastFocusedElementUnderAS = lastFocusedElement;
        }
    }
    
    protected function unregisterCurrentView() : void {
        setFocus(this);
        if(this.currentView is IChannelComponentHolder)
        {
            unregisterComponent(Aliases.CHANNEL_COMPONENT);
        }
        unregisterComponent(this.currentView.as_getPyAlias());
    }
    
    protected function updateFocus() : void {
        var _loc1_:IChannelComponentHolder = this.currentView as IChannelComponentHolder;
        if((_loc1_) && (this.chatFocusNeeded))
        {
            setFocus(_loc1_.getChannelComponent().messageInput);
            this.chatFocusNeeded = false;
        }
        else
        {
            setFocus(lastFocusedElement);
        }
    }
    
    protected function autoSearchUpdateFocus() : void {
        var _loc1_:InteractiveObject = this.autoSearch.getComponentForFocus();
        if(_loc1_ != null)
        {
            setFocus(_loc1_);
        }
    }
    
    private function autoSearchCancelHandler(param1:CSComponentEvent) : void {
        autoSearchCancelS(param1.data.toString());
    }
    
    private function autoSearchApplyHandler(param1:CSComponentEvent) : void {
        autoSearchApplyS(param1.data.toString());
    }
    
    private function showAutoSearchView(param1:CSComponentEvent) : void {
        onAutoMatchS(param1.data.state.toString(),param1.data.cmpDescr);
    }
    
    protected function onViewLoadRequest(param1:RallyViewsEvent) : void {
    }
    
    protected function onScaleChanged(param1:WindowEvent) : void {
        if(param1.type == WindowEvent.SCALE_X_CHANGED)
        {
            window.width = param1.prevValue;
        }
        else
        {
            window.height = param1.prevValue;
        }
    }
    
    protected function backBtnClick(param1:RallyViewsEvent) : void {
        onBackClickS();
    }
    
    protected function onRequestFocusHandler(param1:FocusRequestEvent) : void {
        setFocus(param1.focusContainer.getComponentForFocus());
    }
}
}
