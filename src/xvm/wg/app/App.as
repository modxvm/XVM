package 
{
    $AppLinks;

    import flash.display.*;
    import net.wg.app.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.managers.*;
    import net.wg.utils.*;
    
    public class App extends Object
    {
        public function App()
        {
            super();
            return;
        }

        public static function set instance(arg1:net.wg.app.IApplication):void
        {
            if (ms_instance != null) 
            {
                DebugUtils.LOG_ERROR("Application already set to App!");
            }
            else 
            {
                ms_instance = arg1;
            }
            return;
        }

        public static function get instance():net.wg.app.IApplication
        {
            return ms_instance;
        }

        public static function get globalVarsMgr():net.wg.infrastructure.base.meta.IGlobalVarsMgrMeta
        {
            return instance.globalVarsMgr;
        }

        public static function get soundMgr():net.wg.infrastructure.managers.ISoundManager
        {
            return instance.soundMgr;
        }

        public static function get toolTipMgr():net.wg.infrastructure.managers.ITooltipMgr
        {
            return instance.toolTipMgr;
        }

        public static function get waiting():net.wg.infrastructure.managers.IWaitingView
        {
            return instance == null ? null : instance.waiting;
        }

        public static function get environment():net.wg.infrastructure.managers.IEnvironmentManager
        {
            return instance.environment;
        }

        public static function get contextMenuMgr():net.wg.infrastructure.managers.IContextMenuManager
        {
            return instance.contextMenuMgr;
        }

        public static function get colorSchemeMgr():net.wg.infrastructure.managers.IColorSchemeManager
        {
            return instance.colorSchemeMgr;
        }

        public static function get itemsMgr():net.wg.infrastructure.managers.IGuiItemsManager
        {
            return instance.itemsMgr;
        }

        public static function get voiceChatMgr():net.wg.infrastructure.managers.IVoiceChatManager
        {
            return instance.voiceChatMgr;
        }

        public static function get utils():net.wg.utils.IUtils
        {
            return instance.utils;
        }

        public static function get cursor():net.wg.infrastructure.interfaces.ICursor
        {
            return instance.cursor;
        }

        public static function get containerMgr():net.wg.infrastructure.managers.IContainerManager
        {
            return instance.containerMgr;
        }

        public static function get gameInputMgr():net.wg.utils.IGameInputManager
        {
            return instance.gameInputMgr;
        }

        public static function get appWidth():Number
        {
            return instance == null ? net.wg.data.constants.LobbyMetrics.MIN_STAGE_WIDTH : instance.appWidth;
        }

        public static function get appHeight():Number
        {
            return instance == null ? net.wg.data.constants.LobbyMetrics.MIN_STAGE_HEIGHT : instance.appHeight;
        }

        public static function get helpLayout():net.wg.utils.IHelpLayout
        {
            return instance.utils.helpLayout;
        }

        public static function get stage():flash.display.Stage
        {
            return instance.stage;
        }

        public static function get browserBgClass():Class
        {
            return instance.browserBgClass;
        }

        public static function get systemMessages():flash.display.DisplayObjectContainer
        {
            return instance.systemMessages;
        }

        internal static var ms_instance:net.wg.app.IApplication;
    }
}
