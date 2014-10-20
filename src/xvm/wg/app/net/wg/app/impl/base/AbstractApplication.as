package net.wg.app.impl.base
{
    import net.wg.infrastructure.base.meta.impl.ApplicationMeta;
    import net.wg.app.IApplication;
    import net.wg.infrastructure.managers.ILoaderManager;
    import net.wg.infrastructure.managers.GlobalVarsManager;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.infrastructure.managers.IEnvironmentManager;
    import net.wg.infrastructure.managers.IContainerManager;
    import net.wg.infrastructure.managers.IGuiItemsManager;
    import net.wg.utils.IGameInputManager;
    import net.wg.infrastructure.managers.IEventLogManager;
    import net.wg.infrastructure.managers.IWaitingView;
    import net.wg.utils.IUtils;
    import net.wg.utils.ITweenManager;
    import net.wg.infrastructure.managers.ISoundManager;
    import net.wg.infrastructure.managers.IContextMenuManager;
    import net.wg.infrastructure.managers.IPopoverManager;
    import net.wg.infrastructure.managers.IColorSchemeManager;
    import net.wg.infrastructure.managers.IVoiceChatManager;
    import net.wg.infrastructure.interfaces.ICursor;
    import net.wg.infrastructure.helpers.ILibraryLoader;
    import net.wg.infrastructure.interfaces.IView;
    import net.wg.infrastructure.base.meta.IGlobalVarsMgrMeta;
    import flash.display.DisplayObjectContainer;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.data.constants.Errors;
    import flash.display.DisplayObject;
    import net.wg.gui.components.common.ManagedContainer;
    import net.wg.infrastructure.managers.LoaderManager;
    import net.wg.infrastructure.events.LoaderEvent;
    import scaleform.gfx.Extensions;
    import flash.events.Event;
    import scaleform.clik.core.CLIK;
    import flash.display.StageScaleMode;
    import flash.display.StageAlign;
    import net.wg.infrastructure.helpers.LibraryLoader;
    
    public class AbstractApplication extends ApplicationMeta implements IApplication
    {
        
        public function AbstractApplication()
        {
            super();
            App.instance = this;
            this._utils = this.getNewUtils();
            this._tweenMgr = this.getNewTweenManager();
            this._loader = new LibraryLoader();
            this.createContainers();
            this.createManagers();
            this.populateContainers();
            if(stage)
            {
                this.initStage();
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE,this.initStage);
            }
            addEventListener(Event.ENTER_FRAME,this.onFirstFrame);
        }
        
        private static var POPUP_MGR_INIT_EVENT:String = "popUpManagerInited";
        
        private var _loaderMgr:ILoaderManager = null;
        
        private var _classLoaderMgr:Object = null;
        
        private var _varsMgr:GlobalVarsManager = null;
        
        private var _tooltipMgr:ITooltipMgr = null;
        
        private var _environmentMgr:IEnvironmentManager = null;
        
        private var _containersMgr:IContainerManager = null;
        
        private var _guiItemsMgr:IGuiItemsManager = null;
        
        private var _gameInputMgr:IGameInputManager = null;
        
        private var _eventLogManager:IEventLogManager = null;
        
        private var _waiting:IWaitingView = null;
        
        private var _utils:IUtils = null;
        
        private var _tweenMgr:ITweenManager = null;
        
        private var _soundMgr:ISoundManager = null;
        
        private var _contextMenuMgr:IContextMenuManager = null;
        
        private var _popoverMgr:IPopoverManager = null;
        
        private var _colorSchemeMgr:IColorSchemeManager = null;
        
        private var _voiceChatMgr:IVoiceChatManager = null;
        
        private var _cursor:ICursor = null;
        
        private var _loader:ILibraryLoader = null;
        
        private var _appWidth:Number = 0;
        
        private var _appHeight:Number = 0;
        
        private var _isDAAPIInited:Boolean = false;
        
        public final function as_dispose() : void
        {
            this.onDispose();
        }
        
        public final function as_populate() : void
        {
            this._isDAAPIInited = true;
        }
        
        public function as_isDAAPIInited() : Boolean
        {
            return this._isDAAPIInited;
        }
        
        public function get isDAAPIInited() : Boolean
        {
            return this._isDAAPIInited;
        }
        
        public function as_registerManagers() : void
        {
            this.registerManagers();
            this.utils.events.setEnabled(false);
            this.utils.IME.init(this.globalVarsMgr.isShowLangaugeBarS());
        }
        
        public function onLangBarResize(param1:Number, param2:Number) : void
        {
            this.utils.IME.onLangBarResize(param1,param2);
        }
        
        public function as_updateStage(param1:Number, param2:Number) : void
        {
            var w:Number = param1;
            var h:Number = param2;
            try
            {
                this.appWidth = w;
                this.appHeight = h;
                if(this.containerMgr)
                {
                    this.containerMgr.updateStage(w,h);
                }
                if(this.waiting)
                {
                    IView(this.waiting).updateStage(w,h);
                }
            }
            catch(e:Error)
            {
                DebugUtils.LOG_DEBUG("as_updateStage error",e.getStackTrace());
            }
        }
        
        public function get gameInputMgr() : IGameInputManager
        {
            return this._gameInputMgr;
        }
        
        public function get eventLogManager() : IEventLogManager
        {
            return this._eventLogManager;
        }
        
        public final function get utils() : IUtils
        {
            return this._utils;
        }
        
        public final function get tweenMgr() : ITweenManager
        {
            return this._tweenMgr;
        }
        
        public function get libraryLoader() : ILibraryLoader
        {
            return this._loader;
        }
        
        public function get soundMgr() : ISoundManager
        {
            return this._soundMgr;
        }
        
        public function get popoverMgr() : IPopoverManager
        {
            return this._popoverMgr;
        }
        
        public function get contextMenuMgr() : IContextMenuManager
        {
            return this._contextMenuMgr;
        }
        
        public function get colorSchemeMgr() : IColorSchemeManager
        {
            return this._colorSchemeMgr;
        }
        
        public function get voiceChatMgr() : IVoiceChatManager
        {
            return this._voiceChatMgr;
        }
        
        public final function get cursor() : ICursor
        {
            return this._cursor;
        }
        
        public function get appWidth() : Number
        {
            return this._appWidth;
        }
        
        public function set appWidth(param1:Number) : void
        {
            this._appWidth = param1;
        }
        
        public function get appHeight() : Number
        {
            return this._appHeight;
        }
        
        public function set appHeight(param1:Number) : void
        {
            this._appHeight = param1;
        }
        
        public function get globalVarsMgr() : IGlobalVarsMgrMeta
        {
            return this._varsMgr;
        }
        
        public function get toolTipMgr() : ITooltipMgr
        {
            return this._tooltipMgr;
        }
        
        public function get waiting() : IWaitingView
        {
            return this._waiting;
        }
        
        public function get environment() : IEnvironmentManager
        {
            return this._environmentMgr;
        }
        
        public function get containerMgr() : IContainerManager
        {
            return this._containersMgr;
        }
        
        public function get itemsMgr() : IGuiItemsManager
        {
            return this._guiItemsMgr;
        }
        
        public function get browserBgClass() : Class
        {
            return null;
        }
        
        public function get systemMessages() : DisplayObjectContainer
        {
            throw new AbstractException("AbstractApplication.systemMessages" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function onDispose() : void
        {
            this._loader.dispose();
            this.disposeManagers();
            this.disposeContainers();
            this._utils.dispose();
        }
        
        protected function getNewUtils() : IUtils
        {
            throw new AbstractException("BaseApp.getNewUtils" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function getNewTweenManager() : ITweenManager
        {
            throw new AbstractException("BaseApp.getNewTween" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function createContainers() : void
        {
        }
        
        protected function disposeContainers() : void
        {
            var _loc2_:DisplayObject = null;
            var _loc1_:Vector.<DisplayObject> = this.getContainers();
            for each(_loc2_ in _loc1_)
            {
                removeChild(_loc2_);
            }
        }
        
        protected function getContainers() : Vector.<DisplayObject>
        {
            throw new AbstractException("BaseApp.getContainers" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function getNewEnvironment() : IEnvironmentManager
        {
            throw new AbstractException("BaseApp.getNewEnvironment" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function getNewContextMenuManager() : IContextMenuManager
        {
            throw new AbstractException("BaseApp.getNewContextMenuManager" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function getNewPopoverManager() : IPopoverManager
        {
            throw new AbstractException("BaseApp.getNewContextMenuManager" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function getNewContainerManager() : IContainerManager
        {
            throw new AbstractException("BaseApp.getNewContainerManager" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function getNewColorSchemeManager() : IColorSchemeManager
        {
            throw new AbstractException("BaseApp.getNewColorSchemeManager" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function getNewClassManager() : Object
        {
            throw new AbstractException("BaseApp.getNewClassManager" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function getNewSoundManager() : ISoundManager
        {
            throw new AbstractException("BaseApp.getNewSoundManager" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function getNewTooltipManager() : ITooltipMgr
        {
            throw new AbstractException("BaseApp.getNewTooltipManager" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function getNewGuiItemsManager() : IGuiItemsManager
        {
            throw new AbstractException("BaseApp.getNewGuiItemsManager" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function getNewVoiceChatManager() : IVoiceChatManager
        {
            throw new AbstractException("BaseApp.getNewVoiceChatManager" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function getNewGameInputManager() : IGameInputManager
        {
            throw new AbstractException("BaseApp.getNewGameInputManager" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function getEventLogManager() : IEventLogManager
        {
            throw new AbstractException("BaseApp.getEventLogManager" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function getRegCmdName() : String
        {
            throw new AbstractException("BaseApp.getRegCmdName" + Errors.ABSTRACT_INVOKE);
        }
        
        protected function onAfterAppConfiguring() : void
        {
            onAsInitializationCompletedS();
        }
        
        protected function onBeforeAppConfiguring() : void
        {
        }
        
        protected function onPopUpManagerInit() : void
        {
        }
        
        protected final function registerManagers() : void
        {
            this._containersMgr.loader = this._loaderMgr;
            setGlobalVarsMgrS(this._varsMgr);
            setLoaderMgrS(this._loaderMgr);
            setContainerMgrS(this._containersMgr);
            setContextMenuMgrS(this._contextMenuMgr);
            setPopoverMgrS(this._popoverMgr);
            setSoundMgrS(this._soundMgr);
            setTooltipMgrS(this._tooltipMgr);
            setColorSchemeMgrS(this._colorSchemeMgr);
            setEventLogMgrS(this._eventLogManager);
            setGuiItemsMgrS(this._guiItemsMgr);
            setVoiceChatMgrS(this._voiceChatMgr);
            setGameInputMgrS(this._gameInputMgr);
            setUtilsMgrS(this._utils);
            setTweenMgrS(this._tweenMgr);
        }
        
        private function populateContainers() : void
        {
            var _loc2_:DisplayObject = null;
            var _loc1_:Vector.<DisplayObject> = this.getContainers();
            for each(_loc2_ in _loc1_)
            {
                _loc2_.x = _loc2_.y = 0;
                addChild(_loc2_);
                if(_loc2_ is ManagedContainer)
                {
                    this.containerMgr.registerContainer(_loc2_ as ManagedContainer);
                }
            }
        }
        
        private function createManagers() : void
        {
            this._containersMgr = this.getNewContainerManager();
            this._classLoaderMgr = this.getNewClassManager();
            this._loaderMgr = new LoaderManager();
            this._varsMgr = new GlobalVarsManager();
            this._soundMgr = this.getNewSoundManager();
            this._tooltipMgr = this.getNewTooltipManager();
            this._environmentMgr = this.getNewEnvironment();
            this._contextMenuMgr = this.getNewContextMenuManager();
            this._popoverMgr = this.getNewPopoverManager();
            this._colorSchemeMgr = this.getNewColorSchemeManager();
            this._guiItemsMgr = this.getNewGuiItemsManager();
            this._voiceChatMgr = this.getNewVoiceChatManager();
            this._gameInputMgr = this.getNewGameInputManager();
            this._eventLogManager = this.getEventLogManager();
            this._containersMgr.addEventListener(LoaderEvent.CURSOR_LOADED,this.onCursorLoadedHandler);
            this._containersMgr.addEventListener(LoaderEvent.WAITING_LOADED,this.onWaitingLoadedHandler);
        }
        
        private function disposeManagers() : void
        {
            this._classLoaderMgr = null;
            this._contextMenuMgr.dispose();
            this._contextMenuMgr = null;
            this._containersMgr.removeEventListener(LoaderEvent.CURSOR_LOADED,this.onCursorLoadedHandler);
            this._containersMgr.removeEventListener(LoaderEvent.WAITING_LOADED,this.onWaitingLoadedHandler);
            this._containersMgr = null;
            this._popoverMgr.dispose();
            this._popoverMgr = null;
            this._tweenMgr = null;
            this._eventLogManager = null;
            this._soundMgr = null;
            this._loaderMgr = null;
            this._varsMgr = null;
            this._tooltipMgr = null;
            this._waiting = null;
            this._environmentMgr = null;
            this._colorSchemeMgr = null;
        }
        
        private function configure() : void
        {
            Extensions.enabled = true;
            Extensions.noInvisibleAdvance = true;
            DebugUtils.LOG_DEBUG("complete App configuring. Under scaleform:" + Extensions.isScaleform + "; Under gfx:" + Extensions.isGFxPlayer);
        }
        
        private function onCursorLoadedHandler(param1:LoaderEvent) : void
        {
            this._cursor = param1.view as ICursor;
            this._utils.asserter.assertNotNull(this._cursor,"cursor initialization problem");
        }
        
        private function onWaitingLoadedHandler(param1:LoaderEvent) : void
        {
            this._waiting = param1.view as IWaitingView;
            this._utils.asserter.assertNotNull(this._waiting,"waiting initialization problem");
            this._waiting.updateStage(this._appWidth,this._appHeight);
        }
        
        private function onFirstFrame(param1:Event) : void
        {
            removeEventListener(Event.ENTER_FRAME,this.onFirstFrame);
            this.onBeforeAppConfiguring();
            this._environmentMgr.envoke(this.getRegCmdName());
            this.configure();
            this.onAfterAppConfiguring();
        }
        
        private function onPopUpManagerInitHandler(param1:Event) : void
        {
            stage.removeEventListener(POPUP_MGR_INIT_EVENT,this.onPopUpManagerInitHandler);
            this.onPopUpManagerInit();
        }
        
        protected function initStage(param1:Event = null) : void
        {
            if(!CLIK.initialized)
            {
                stage.addEventListener(POPUP_MGR_INIT_EVENT,this.onPopUpManagerInitHandler,false,0,true);
            }
            else
            {
                this.onPopUpManagerInit();
            }
            removeEventListener(Event.ADDED_TO_STAGE,this.initStage);
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
        }
    }
}
