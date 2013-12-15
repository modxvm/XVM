package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.infrastructure.managers.IContainerManager;
   import net.wg.infrastructure.managers.IContextMenuManager;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.IVoiceChatManager;


   public interface IApplicationMeta extends IEventDispatcher
   {
          
      function setLoaderMgrS(param1:ILoaderManagerMeta) : void;

      function setGlobalVarsMgrS(param1:IGlobalVarsMgrMeta) : void;

      function setSoundMgrS(param1:ISoundManager) : void;

      function setContainerMgrS(param1:IContainerManager) : void;

      function setContextMenuMgrS(param1:IContextMenuManager) : void;

      function setColorSchemeMgrS(param1:IColorSchemeManager) : void;

      function setTooltipMgrS(param1:ITooltipMgr) : void;

      function setStatsStorageS(param1:IStatsStorageMeta) : void;

      function setGuiItemsMgrS(param1:IGuiItemsManagerMeta) : void;

      function setVoiceChatMgrS(param1:IVoiceChatManager) : void;

      function setUtilsMgrS(param1:IUtilsManagerMeta) : void;

      function setGameInputMgrS(param1:IGameInputManagerMeta) : void;

      function handleGlobalKeyEventS(param1:String) : void;

      function onAsInitializationCompletedS() : void;

      function as_populate() : void;

      function as_dispose() : void;

      function as_registerManagers() : void;

      function as_updateStage(param1:Number, param2:Number) : void;
   }

}