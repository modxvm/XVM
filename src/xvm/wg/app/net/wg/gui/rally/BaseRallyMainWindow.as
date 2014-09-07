package net.wg.gui.rally
{
    import net.wg.infrastructure.base.meta.impl.BaseRallyMainWindowMeta;
    import net.wg.infrastructure.base.meta.IBaseRallyMainWindowMeta;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.gui.components.tooltips.helpers.Utils;
    import net.wg.infrastructure.base.interfaces.IWindow;
    import net.wg.gui.components.windows.WindowEvent;
    import flash.display.InteractiveObject;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import net.wg.infrastructure.base.meta.IAbstractRallyViewMeta;
    import flash.display.MovieClip;
    import net.wg.gui.cyberSport.interfaces.IChannelComponentHolder;
    import net.wg.data.Aliases;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    
    public class BaseRallyMainWindow extends BaseRallyMainWindowMeta implements IBaseRallyMainWindowMeta
    {
        
        public function BaseRallyMainWindow()
        {
            super();
        }
        
        public static function getTeamHeader(param1:String, param2:IRallyVO, param3:int = 7) : String
        {
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
                    if(_loc8_.player)
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
            return App.utils.locale.makeString(param1,{"current":Utils.instance.htmlWrapper(_loc5_.toString(),Utils.instance.COLOR_NORMAL,13,"$FieldFont"),
            "max":_loc4_.toString()
        });
    }
    
    private var chatFocusNeeded:Boolean = true;
    
    override public function setWindow(param1:IWindow) : void
    {
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
    
    override public function as_getGeometry() : Array
    {
        if(window)
        {
            return [window.x,window.y,-1,-1];
        }
        return null;
    }
    
    override public function as_loadView(param1:String, param2:String) : void
    {
        super.as_loadView(param1,param2);
        setFocus(window.getCloseBtn());
    }
    
    override protected function onSetModalFocus(param1:InteractiveObject) : void
    {
        super.onSetModalFocus(param1);
        this.updateFocus();
    }
    
    override protected function onPopulate() : void
    {
        super.onPopulate();
        window.title = this.getWindowTitle();
    }
    
    override protected function onDispose() : void
    {
        removeEventListener(RallyViewsEvent.BACK_NAVIGATION_REQUEST,this.backBtnClick);
        removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
        super.onDispose();
    }
    
    override protected function configUI() : void
    {
        if(_baseDisposed)
        {
            DebugUtils.LOG_WARNING("CyberSportMainWindow disposed before initializing");
            return;
        }
        super.configUI();
        addEventListener(RallyViewsEvent.BACK_NAVIGATION_REQUEST,this.backBtnClick);
        addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
    }
    
    override protected function draw() : void
    {
        super.draw();
    }
    
    protected function getCurrentView() : IAbstractRallyViewMeta
    {
        return currentView;
    }
    
    protected function isChatFocusNeeded() : Boolean
    {
        return this.chatFocusNeeded;
    }
    
    protected function resetChatFocusRequirement() : void
    {
        this.chatFocusNeeded = false;
    }
    
    protected function getWindowTitle() : String
    {
        return "BaseRallyWindow";
    }
    
    override protected function registerCurrentView(param1:MovieClip, param2:String) : void
    {
        currentView = param1 as IAbstractRallyViewMeta;
        currentView.as_setPyAlias(param2);
        currentView.addEventListener(RallyViewsEvent.LOAD_VIEW_REQUEST,onViewLoadRequest);
        var _loc3_:IChannelComponentHolder = param1 as IChannelComponentHolder;
        if(_loc3_ != null)
        {
            registerComponent(_loc3_.getChannelComponent(),Aliases.CHANNEL_COMPONENT);
        }
        registerComponent(currentView as IDAAPIModule,currentView.as_getPyAlias());
        this.chatFocusNeeded = true;
        if(hasFocus)
        {
            this.updateFocus();
        }
    }
    
    override protected function unregisterCurrentView() : void
    {
        setFocus(this);
        if(currentView is IChannelComponentHolder)
        {
            unregisterComponent(Aliases.CHANNEL_COMPONENT);
        }
        unregisterComponent(currentView.as_getPyAlias());
    }
    
    protected function updateFocus() : void
    {
        var _loc1_:IChannelComponentHolder = currentView as IChannelComponentHolder;
        if((_loc1_) && (this.isChatFocusNeeded()))
        {
            setFocus(_loc1_.getChannelComponent().messageInput);
            this.chatFocusNeeded = false;
        }
        else
        {
            setFocus(lastFocusedElement);
        }
    }
    
    protected function onScaleChanged(param1:WindowEvent) : void
    {
        if(param1.type == WindowEvent.SCALE_X_CHANGED)
        {
            window.width = param1.prevValue;
        }
        else
        {
            window.height = param1.prevValue;
        }
    }
    
    protected function backBtnClick(param1:RallyViewsEvent) : void
    {
        onBackClickS();
    }
    
    protected function onRequestFocusHandler(param1:FocusRequestEvent) : void
    {
        setFocus(param1.focusContainer.getComponentForFocus());
    }
}
}
