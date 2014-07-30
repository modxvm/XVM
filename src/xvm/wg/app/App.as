package
{
    $AppLinks;
    import net.wg.app.IApplication;
    import net.wg.infrastructure.base.meta.IGlobalVarsMgrMeta;
    import net.wg.infrastructure.managers.ISoundManager;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.infrastructure.managers.IWaitingView;
    import net.wg.infrastructure.managers.IEnvironmentManager;
    import net.wg.infrastructure.managers.IContextMenuManager;
    import net.wg.infrastructure.managers.IPopoverManager;
    import net.wg.infrastructure.managers.IColorSchemeManager;
    import net.wg.infrastructure.managers.IGuiItemsManager;
    import net.wg.infrastructure.managers.IVoiceChatManager;
    import net.wg.utils.IUtils;
    import net.wg.utils.ITweenManager;
    import net.wg.infrastructure.interfaces.ICursor;
    import net.wg.infrastructure.managers.IContainerManager;
    import net.wg.utils.IGameInputManager;
    import net.wg.infrastructure.managers.IEventLogManager;
    import net.wg.data.constants.LobbyMetrics;
    import net.wg.utils.IHelpLayout;
    import flash.display.Stage;
    import flash.display.DisplayObjectContainer;
    import net.wg.infrastructure.helpers.ILibraryLoader;
    
    public class App extends Object
    {
        
        public function App()
        {
            super();
        }
        
        private static var ms_instance:IApplication;
        
        public static function set instance(param1:IApplication) : void
        {
            if(ms_instance == null)
            {
                ms_instance = param1;
            }
            else
            {
                DebugUtils.LOG_ERROR("Application already set to App!");
            }
        }
        
        public static function get instance() : IApplication
        {
            return ms_instance;
        }
        
        public static function get globalVarsMgr() : IGlobalVarsMgrMeta
        {
            return instance.globalVarsMgr;
        }
        
        public static function get soundMgr() : ISoundManager
        {
            return instance.soundMgr;
        }
        
        public static function get toolTipMgr() : ITooltipMgr
        {
            return instance.toolTipMgr;
        }
        
        public static function get waiting() : IWaitingView
        {
            return instance != null?instance.waiting:null;
        }
        
        public static function get environment() : IEnvironmentManager
        {
            return instance.environment;
        }
        
        public static function get contextMenuMgr() : IContextMenuManager
        {
            return instance.contextMenuMgr;
        }
        
        public static function get popoverMgr() : IPopoverManager
        {
            return instance.popoverMgr;
        }
        
        public static function get colorSchemeMgr() : IColorSchemeManager
        {
            return instance.colorSchemeMgr;
        }
        
        public static function get itemsMgr() : IGuiItemsManager
        {
            return instance.itemsMgr;
        }
        
        public static function get voiceChatMgr() : IVoiceChatManager
        {
            return instance.voiceChatMgr;
        }
        
        public static function get utils() : IUtils
        {
            return instance.utils;
        }
        
        public static function get tweenMgr() : ITweenManager
        {
            return instance.tweenMgr;
        }
        
        public static function get cursor() : ICursor
        {
            return instance.cursor;
        }
        
        public static function get containerMgr() : IContainerManager
        {
            return instance.containerMgr;
        }
        
        public static function get gameInputMgr() : IGameInputManager
        {
            return instance.gameInputMgr;
        }
        
        public static function get eventLogManager() : IEventLogManager
        {
            return instance.eventLogManager;
        }
        
        public static function get appWidth() : Number
        {
            return instance != null?instance.appWidth:LobbyMetrics.MIN_STAGE_WIDTH;
        }
        
        public static function get appHeight() : Number
        {
            return instance != null?instance.appHeight:LobbyMetrics.MIN_STAGE_HEIGHT;
        }
        
        public static function get helpLayout() : IHelpLayout
        {
            return instance.utils.helpLayout;
        }
        
        public static function get stage() : Stage
        {
            return instance.stage;
        }
        
        public static function get browserBgClass() : Class
        {
            return instance.browserBgClass;
        }
        
        public static function get systemMessages() : DisplayObjectContainer
        {
            return instance.systemMessages;
        }
        
        public static function get libraryLoader() : ILibraryLoader
        {
            return instance.libraryLoader;
        }
    }
}
