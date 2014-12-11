package net.wg.gui.lobby.questsWindow
{
    import net.wg.infrastructure.base.meta.impl.QuestsWindowMeta;
    import net.wg.infrastructure.base.meta.IQuestsWindowMeta;
    import net.wg.infrastructure.interfaces.IFocusChainContainer;
    import net.wg.gui.components.advanced.ButtonBarEx;
    import net.wg.gui.components.advanced.ViewStack;
    import flash.display.Sprite;
    import flash.display.InteractiveObject;
    import scaleform.clik.events.IndexEvent;
    import net.wg.gui.events.ViewStackEvent;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import net.wg.infrastructure.events.FocusChainChangeEvent;
    import net.wg.data.constants.generated.QUESTS_ALIASES;
    import scaleform.clik.data.DataProvider;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import net.wg.infrastructure.interfaces.entity.IFocusContainer;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import net.wg.gui.lobby.quests.views.QuestsPersonalWelcomeView;
    import scaleform.clik.interfaces.IDataProvider;
    
    public class QuestsWindow extends QuestsWindowMeta implements IQuestsWindowMeta, IFocusChainContainer
    {
        
        public function QuestsWindow()
        {
            this._focusList = [];
            super();
            showWindowBgForm = false;
            isCentered = true;
        }
        
        private static var FOCUS_CHAIN:String = "focusChain";
        
        private static var TABS_DP_DATA_FIELD:String = "id";
        
        public var tabs_mc:ButtonBarEx;
        
        public var view_mc:ViewStack;
        
        public var line:Sprite;
        
        private var _currentViewAlias:String = null;
        
        private var _focusList:Array;
        
        public function as_loadView(param1:String, param2:String) : void
        {
            this.view_mc.show(param1);
        }
        
        public function as_selectTab(param1:String) : void
        {
            this.tabs_mc.selectedIndex = this.getDPItemIndex(this.tabs_mc.dataProvider,param1,TABS_DP_DATA_FIELD);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this);
        }
        
        override protected function onSetModalFocus(param1:InteractiveObject) : void
        {
            super.onSetModalFocus(param1);
            setFocus(this);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            window.title = QUESTS.QUESTS_TITLE;
            this.tabs_mc.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabSelectedHandler);
            this.view_mc.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangedHandler);
            this.view_mc.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
            addEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE,this.focusChainChangeHandler);
            var _loc1_:Array = [{"label":QUESTS.QUESTS_TABS_CURRENT,
            "id":QUESTS_ALIASES.TAB_COMMON_QUESTS
        }];
        if(App.globalVarsMgr.isPotapovQuestEnabledS())
        {
            _loc1_.unshift({"label":QUESTS.QUESTS_TABS_PERSONAL,
            "id":QUESTS_ALIASES.TAB_PERSONAL_QUESTS
        });
    }
    this.tabs_mc.dataProvider = new DataProvider(_loc1_);
}

override protected function onDispose() : void
{
    App.utils.scheduler.cancelTask(this.setFocusView);
    this.tabs_mc.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabSelectedHandler);
    this.view_mc.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangedHandler);
    this.view_mc.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
    this.tabs_mc.dispose();
    this.tabs_mc = null;
    this.view_mc.dispose();
    this.view_mc = null;
    this.line = null;
    App.toolTipMgr.hide();
    removeEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE,this.focusChainChangeHandler);
    this._focusList.splice(0,this._focusList.length);
    this._focusList = null;
    super.onDispose();
}

override protected function draw() : void
{
    if(isInvalid(FOCUS_CHAIN))
    {
        this.initFocusChain();
    }
    super.draw();
}

private function setFocusView(param1:IViewStackContent) : void
{
    setFocus(IFocusContainer(param1).getComponentForFocus());
}

private function onTabSelectedHandler(param1:IndexEvent) : void
{
    var _loc2_:Object = this.tabs_mc.dataProvider.requestItemAt(this.tabs_mc.selectedIndex);
    onTabSelectedS(_loc2_.id);
}

private function onViewChangedHandler(param1:ViewStackEvent) : void
{
    App.toolTipMgr.hide();
    if(this._currentViewAlias != null)
    {
        unregisterComponent(this._currentViewAlias);
    }
    if(param1.linkage == QUESTS_ALIASES.PERSONAL_WELCOME_VIEW_LINKAGE)
    {
        this._currentViewAlias = QUESTS_ALIASES.PERSONAL_WELCOME_VIEW_ALIAS;
        registerComponent(IDAAPIModule(param1.view),this._currentViewAlias);
    }
    else if(param1.linkage == QUESTS_ALIASES.SEASONS_VIEW_LINKAGE)
    {
        this._currentViewAlias = QUESTS_ALIASES.SEASONS_VIEW_ALIAS;
        registerComponent(IDAAPIModule(param1.view),this._currentViewAlias);
    }
    else if(param1.linkage == QUESTS_ALIASES.TILE_CHAINS_VIEW_LINKAGE)
    {
        this._currentViewAlias = QUESTS_ALIASES.TILE_CHAINS_VIEW_ALIAS;
        registerComponent(IDAAPIModule(param1.view),this._currentViewAlias);
    }
    else if(param1.linkage == QUESTS_ALIASES.COMMON_QUESTS_VIEW_LINKAGE)
    {
        this._currentViewAlias = QUESTS_ALIASES.COMMON_QUESTS_VIEW_ALIAS;
        registerComponent(IDAAPIModule(param1.view),this._currentViewAlias);
    }
    else
    {
        DebugUtils.LOG_WARNING("Unsupported linkage:" + param1.linkage);
    }
    
    
    
    setFocus(this);
    this.invalidateFocusChain();
}

private function invalidateFocusChain() : void
{
    invalidate(FOCUS_CHAIN);
}

private function initFocusChain() : void
{
    this.clearTabIndexes();
    this._focusList.splice(0,this._focusList.length);
    if(this._currentViewAlias == QUESTS_ALIASES.COMMON_QUESTS_VIEW_ALIAS)
    {
        this.setFocusView(IViewStackContent(this.view_mc.currentView));
    }
    else
    {
        setFocus(this);
        this._focusList = this.getFocusChain();
        App.utils.commons.initTabIndex(this._focusList);
        if(this._currentViewAlias == QUESTS_ALIASES.PERSONAL_WELCOME_VIEW_ALIAS)
        {
            App.utils.scheduler.envokeInNextFrame(this.setFocusView,IViewStackContent(this.view_mc.currentView));
        }
    }
}

private function clearTabIndexes() : void
{
    var _loc3_:InteractiveObject = null;
    var _loc1_:int = this._focusList.length;
    var _loc2_:* = 0;
    while(_loc2_ < _loc1_)
    {
        _loc3_ = this._focusList[_loc2_];
        _loc3_.tabIndex = -1;
        _loc2_++;
    }
}

private function onRequestFocusHandler(param1:FocusRequestEvent) : void
{
    setFocus(param1.focusContainer.getComponentForFocus());
}

public function getFocusChain() : Array
{
    var _loc1_:Array = [];
    if(this._currentViewAlias == QUESTS_ALIASES.PERSONAL_WELCOME_VIEW_ALIAS)
    {
        _loc1_.push(QuestsPersonalWelcomeView(this.view_mc.currentView).successBtn);
    }
    _loc1_.push(window.getCloseBtn());
    _loc1_.push(this.tabs_mc);
    if(this.view_mc.currentView is IFocusChainContainer)
    {
        _loc1_ = _loc1_.concat(IFocusChainContainer(this.view_mc.currentView).getFocusChain());
    }
    return _loc1_;
}

private function focusChainChangeHandler(param1:FocusChainChangeEvent) : void
{
    this.invalidateFocusChain();
}

private function getDPItemIndex(param1:IDataProvider, param2:*, param3:String = "data") : int
{
    var _loc5_:Object = null;
    var _loc4_:* = -1;
    for each(_loc5_ in param1)
    {
        if((_loc5_.hasOwnProperty(param3)) && _loc5_[param3] == param2)
        {
            _loc4_ = param1.indexOf(_loc5_);
            break;
        }
    }
    return _loc4_;
}
}
}
