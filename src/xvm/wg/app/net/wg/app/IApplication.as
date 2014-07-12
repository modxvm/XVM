package net.wg.app
{
   import net.wg.infrastructure.base.meta.IApplicationMeta;
   import flash.display.Stage;
   import flash.display.DisplayObjectContainer;
   import net.wg.infrastructure.base.meta.IGlobalVarsMgrMeta;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.IWaitingView;
   import net.wg.infrastructure.managers.IEnvironmentManager;
   import net.wg.infrastructure.interfaces.ICursor;
   import net.wg.infrastructure.managers.IContainerManager;
   import net.wg.infrastructure.managers.IContextMenuManager;
   import net.wg.infrastructure.managers.IPopoverManager;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.infrastructure.managers.IGuiItemsManager;
   import net.wg.infrastructure.managers.IVoiceChatManager;
   import net.wg.utils.IGameInputManager;
   import net.wg.infrastructure.managers.IEventLogManager;
   import net.wg.utils.IUtils;
   import net.wg.utils.ITweenManager;
   import net.wg.infrastructure.helpers.ILibraryLoader;
   
   public interface IApplication extends IApplicationMeta
   {
      
      function onLangBarResize(param1:Number, param2:Number) : void;
      
      function get appWidth() : Number;
      
      function get appHeight() : Number;
      
      function get stage() : Stage;
      
      function get systemMessages() : DisplayObjectContainer;
      
      function get globalVarsMgr() : IGlobalVarsMgrMeta;
      
      function get soundMgr() : ISoundManager;
      
      function get toolTipMgr() : ITooltipMgr;
      
      function get waiting() : IWaitingView;
      
      function get environment() : IEnvironmentManager;
      
      function get cursor() : ICursor;
      
      function get containerMgr() : IContainerManager;
      
      function get contextMenuMgr() : IContextMenuManager;
      
      function get popoverMgr() : IPopoverManager;
      
      function get colorSchemeMgr() : IColorSchemeManager;
      
      function get itemsMgr() : IGuiItemsManager;
      
      function get voiceChatMgr() : IVoiceChatManager;
      
      function get gameInputMgr() : IGameInputManager;
      
      function get eventLogManager() : IEventLogManager;
      
      function get utils() : IUtils;
      
      function get tweenMgr() : ITweenManager;
      
      function get browserBgClass() : Class;
      
      function get libraryLoader() : ILibraryLoader;
   }
}
