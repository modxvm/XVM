package net.wg.app 
{
    import flash.display.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.managers.*;
    import net.wg.utils.*;
    
    public interface IApplication extends net.wg.infrastructure.base.meta.IApplicationMeta
    {
        function onLangBarResize(arg1:Number, arg2:Number):void;

        function get appWidth():Number;

        function get appHeight():Number;

        function get stage():flash.display.Stage;

        function get systemMessages():flash.display.DisplayObjectContainer;

        function get globalVarsMgr():net.wg.infrastructure.base.meta.IGlobalVarsMgrMeta;

        function get soundMgr():net.wg.infrastructure.managers.ISoundManager;

        function get toolTipMgr():net.wg.infrastructure.managers.ITooltipMgr;

        function get waiting():net.wg.infrastructure.managers.IWaitingView;

        function get environment():net.wg.infrastructure.managers.IEnvironmentManager;

        function get cursor():net.wg.infrastructure.interfaces.ICursor;

        function get containerMgr():net.wg.infrastructure.managers.IContainerManager;

        function get contextMenuMgr():net.wg.infrastructure.managers.IContextMenuManager;

        function get colorSchemeMgr():net.wg.infrastructure.managers.IColorSchemeManager;

        function get itemsMgr():net.wg.infrastructure.managers.IGuiItemsManager;

        function get voiceChatMgr():net.wg.infrastructure.managers.IVoiceChatManager;

        function get gameInputMgr():net.wg.utils.IGameInputManager;

        function get utils():net.wg.utils.IUtils;

        function get browserBgClass():Class;
    }
}
