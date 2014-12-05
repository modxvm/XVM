package net.wg.app.impl
{
    import net.wg.app.impl.base.AbstractApplication;
    import flash.display.MovieClip;
    import net.wg.gui.components.common.ManagedContainer;
    import net.wg.gui.components.common.MainViewContainer;
    import flash.display.Sprite;
    import flash.display.DisplayObjectContainer;
    import net.wg.utils.IUtils;
    import net.wg.infrastructure.managers.utils.impl.Utils;
    import net.wg.infrastructure.managers.utils.impl.Asserter;
    import net.wg.infrastructure.managers.utils.impl.Scheduler;
    import net.wg.infrastructure.managers.utils.impl.Locale;
    import net.wg.infrastructure.managers.utils.impl.WGJSON;
    import net.wg.infrastructure.managers.utils.impl.HelpLayout;
    import net.wg.infrastructure.managers.utils.impl.ClassFactory;
    import net.wg.infrastructure.managers.utils.impl.PopupManager;
    import net.wg.infrastructure.managers.utils.impl.Commons;
    import net.wg.infrastructure.managers.utils.impl.FocusHandlerEx;
    import net.wg.infrastructure.managers.utils.impl.EventCollector;
    import net.wg.infrastructure.managers.utils.impl.IME;
    import net.wg.infrastructure.managers.utils.impl.VOManager;
    import net.wg.infrastructure.managers.utils.impl.Icons;
    import net.wg.infrastructure.managers.utils.impl.StyleSheetManager;
    import net.wg.infrastructure.managers.utils.impl.TweenAnimator;
    import net.wg.infrastructure.managers.utils.impl.AnimBuilder;
    import net.wg.infrastructure.managers.utils.impl.DateTime;
    import net.wg.infrastructure.managers.utils.impl.Nations;
    import net.wg.utils.ITweenManager;
    import net.wg.infrastructure.managers.utils.impl.TweenManager;
    import net.wg.data.constants.ContainerTypes;
    import net.wg.gui.components.common.CursorManagedContainer;
    import net.wg.gui.components.common.WaitingManagedContainer;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.managers.IEnvironmentManager;
    import net.wg.infrastructure.managers.impl.EnvironmentManager;
    import net.wg.infrastructure.managers.ISoundManager;
    import net.wg.infrastructure.managers.impl.SoundManager;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.infrastructure.managers.impl.ToolTipManager;
    import net.wg.infrastructure.managers.IContainerManager;
    import net.wg.infrastructure.managers.impl.ContainerManager;
    import net.wg.infrastructure.managers.IColorSchemeManager;
    import net.wg.infrastructure.managers.impl.ColorSchemeManager;
    import net.wg.infrastructure.managers.IContextMenuManager;
    import net.wg.infrastructure.managers.impl.ContextMenuManager;
    import net.wg.infrastructure.managers.IPopoverManager;
    import net.wg.infrastructure.managers.impl.PopoverManager;
    import net.wg.infrastructure.managers.impl.ClassManager;
    import net.wg.infrastructure.managers.IGuiItemsManager;
    import net.wg.infrastructure.managers.impl.GuiItemsManager;
    import net.wg.infrastructure.managers.IVoiceChatManager;
    import net.wg.infrastructure.managers.impl.VoiceChatManager;
    import net.wg.utils.IGameInputManager;
    import net.wg.infrastructure.managers.impl.GameInputManager;
    import net.wg.infrastructure.managers.IEventLogManager;
    import net.wg.infrastructure.managers.impl.EventLogManager;
    import flash.events.Event;
    import scaleform.gfx.Extensions;
    import scaleform.clik.core.CLIK;
    
    public final class Application extends AbstractApplication
    {
        
        public function Application()
        {
            this.browserBgClassValue = Application_browserBgClassValue;
            this.altBrowserBgClassValue = Application_altBrowserBgClassValue;
            this._librariesList = Vector.<String>(["windows.swf","popovers.swf","animations.swf"]);
            super();
            Extensions.enabled = true;
            Extensions.noInvisibleAdvance = true;
            CLIK.disableNullFocusMoves = true;
        }
        
        public static var APP_REG_CMD:String = "registerApplication";
        
        public var browserBgClassValue:Class;
        
        public var altBrowserBgClassValue:Class;
        
        private var _librariesList:Vector.<String>;
        
        private var _libraries:MovieClip;
        
        private var _serviceLayout:ManagedContainer;
        
        private var _views:MainViewContainer;
        
        private var _windows:ManagedContainer;
        
        private var _systemMessages:Sprite;
        
        private var _browser:ManagedContainer;
        
        private var _dialogs:ManagedContainer;
        
        private var _toolTips:MovieClip;
        
        private var _cursorCtnr:ManagedContainer;
        
        private var _waitingCtnr:ManagedContainer;
        
        public function as_traceObject(param1:*) : void
        {
            DebugUtils.LOG_DEBUG("traceObject",param1);
        }
        
        override public function get browserBgClass() : Class
        {
            return this.browserBgClassValue;
        }
        
        override public function get altBrowserBgClass() : Class
        {
            return this.altBrowserBgClassValue;
        }
        
        override public function get systemMessages() : DisplayObjectContainer
        {
            return this._systemMessages;
        }
        
        override protected function getNewUtils() : IUtils
        {
            var _loc1_:IUtils = new Utils(new Asserter(),new Scheduler(),new Locale(),new WGJSON(),new HelpLayout(),new ClassFactory(),new PopupManager(),new Commons(),new FocusHandlerEx(),new EventCollector(),new IME(),new VOManager(),new Icons(),new StyleSheetManager(),new TweenAnimator(),new AnimBuilder(),new DateTime());
            _loc1_.setNations(new Nations(_loc1_));
            return _loc1_;
        }
        
        override protected function getNewTweenManager() : ITweenManager
        {
            return new TweenManager();
        }
        
        override protected function createContainers() : void
        {
            this._libraries = new MovieClip();
            this._serviceLayout = new ManagedContainer();
            this._serviceLayout.type = ContainerTypes.SERVICE_LAYOUT;
            this._views = new MainViewContainer();
            this._views.type = ContainerTypes.VIEW;
            this._windows = new ManagedContainer();
            this._windows.type = ContainerTypes.WINDOW;
            this._systemMessages = new Sprite();
            this._browser = new ManagedContainer();
            this._browser.type = ContainerTypes.BROWSER;
            this._dialogs = new ManagedContainer();
            this._dialogs.type = ContainerTypes.TOP_WINDOW;
            this._toolTips = new MovieClip();
            this._cursorCtnr = new CursorManagedContainer();
            this._waitingCtnr = new WaitingManagedContainer();
            super.createContainers();
        }
        
        override protected function disposeContainers() : void
        {
            super.disposeContainers();
            this._views.dispose();
            this._views = null;
            this._libraries = null;
            this._windows.dispose();
            this._windows = null;
            this._browser.dispose();
            this._browser = null;
            this._dialogs.dispose();
            this._dialogs = null;
            this._systemMessages = null;
            this._toolTips = null;
            this._serviceLayout.dispose();
            this._serviceLayout = null;
            this._cursorCtnr.dispose();
            this._cursorCtnr = null;
            this._waitingCtnr.dispose();
            this._waitingCtnr = null;
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
        }
        
        override protected function getContainers() : Vector.<DisplayObject>
        {
            var _loc1_:Vector.<DisplayObject> = new <DisplayObject>[this._libraries,this._views,this._windows,this._systemMessages,this._browser,this._dialogs,utils.IME.getContainer(),this._toolTips,this._serviceLayout,this._cursorCtnr,this._waitingCtnr];
            return _loc1_;
        }
        
        override protected function getNewEnvironment() : IEnvironmentManager
        {
            return EnvironmentManager.getInstance();
        }
        
        override protected function getNewSoundManager() : ISoundManager
        {
            return new SoundManager();
        }
        
        override protected function getNewTooltipManager() : ITooltipMgr
        {
            return new ToolTipManager(this._toolTips);
        }
        
        override protected function getNewContainerManager() : IContainerManager
        {
            return new ContainerManager();
        }
        
        override protected function getNewColorSchemeManager() : IColorSchemeManager
        {
            return new ColorSchemeManager();
        }
        
        override protected function getNewContextMenuManager() : IContextMenuManager
        {
            return new ContextMenuManager();
        }
        
        override protected function getNewPopoverManager() : IPopoverManager
        {
            return new PopoverManager(stage);
        }
        
        override protected function getNewClassManager() : Object
        {
            return new ClassManager();
        }
        
        override protected function getNewGuiItemsManager() : IGuiItemsManager
        {
            return new GuiItemsManager();
        }
        
        override protected function getNewVoiceChatManager() : IVoiceChatManager
        {
            return new VoiceChatManager();
        }
        
        override protected function getNewGameInputManager() : IGameInputManager
        {
            return new GameInputManager();
        }
        
        override protected function getEventLogManager() : IEventLogManager
        {
            return new EventLogManager();
        }
        
        override protected function onAfterAppConfiguring() : void
        {
            super.onAfterAppConfiguring();
            libraryLoader.load(this._librariesList);
        }
        
        override protected function onBeforeAppConfiguring() : void
        {
            super.onBeforeAppConfiguring();
            libraryLoader.init(this._libraries);
        }
        
        override protected function onPopUpManagerInit() : void
        {
            super.onPopUpManagerInit();
            addChildAt(utils.popupMgr.popupCanvas,this.getTooltipsLayerIndex());
        }
        
        override protected function getRegCmdName() : String
        {
            return APP_REG_CMD;
        }
        
        override protected function initStage(param1:Event = null) : void
        {
            gameInputMgr.initStage(this.stage);
            super.initStage(param1);
        }
        
        private function getTooltipsLayerIndex() : Number
        {
            return getChildIndex(this._toolTips);
        }
    }
}
