package net.wg.infrastructure.base.meta.impl
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.meta.ILoaderManagerMeta;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.meta.IGlobalVarsMgrMeta;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.infrastructure.managers.IContainerManager;
   import net.wg.infrastructure.managers.IContextMenuManager;
   import net.wg.infrastructure.managers.IPopoverManager;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.infrastructure.managers.IEventLogManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.base.meta.IStatsStorageMeta;
   import net.wg.infrastructure.base.meta.IGuiItemsManagerMeta;
   import net.wg.infrastructure.managers.IVoiceChatManager;
   import net.wg.infrastructure.base.meta.IUtilsManagerMeta;
   import net.wg.utils.ITweenManager;
   import net.wg.infrastructure.base.meta.IGameInputManagerMeta;


   public class ApplicationMeta extends MovieClip
   {
          
      public function ApplicationMeta() {
         super();
      }

      public var setLoaderMgr:Function = null;

      public var setGlobalVarsMgr:Function = null;

      public var setSoundMgr:Function = null;

      public var setContainerMgr:Function = null;

      public var setContextMenuMgr:Function = null;

      public var setPopoverMgr:Function = null;

      public var setColorSchemeMgr:Function = null;

      public var setEventLogMgr:Function = null;

      public var setTooltipMgr:Function = null;

      public var setStatsStorage:Function = null;

      public var setGuiItemsMgr:Function = null;

      public var setVoiceChatMgr:Function = null;

      public var setUtilsMgr:Function = null;

      public var setTweenMgr:Function = null;

      public var setGameInputMgr:Function = null;

      public var handleGlobalKeyEvent:Function = null;

      public var onAsInitializationCompleted:Function = null;

      public function setLoaderMgrS(param1:ILoaderManagerMeta) : void {
         App.utils.asserter.assertNotNull(this.setLoaderMgr,"setLoaderMgr" + Errors.CANT_NULL);
         this.setLoaderMgr(param1);
      }

      public function setGlobalVarsMgrS(param1:IGlobalVarsMgrMeta) : void {
         App.utils.asserter.assertNotNull(this.setGlobalVarsMgr,"setGlobalVarsMgr" + Errors.CANT_NULL);
         this.setGlobalVarsMgr(param1);
      }

      public function setSoundMgrS(param1:ISoundManager) : void {
         App.utils.asserter.assertNotNull(this.setSoundMgr,"setSoundMgr" + Errors.CANT_NULL);
         this.setSoundMgr(param1);
      }

      public function setContainerMgrS(param1:IContainerManager) : void {
         App.utils.asserter.assertNotNull(this.setContainerMgr,"setContainerMgr" + Errors.CANT_NULL);
         this.setContainerMgr(param1);
      }

      public function setContextMenuMgrS(param1:IContextMenuManager) : void {
         App.utils.asserter.assertNotNull(this.setContextMenuMgr,"setContextMenuMgr" + Errors.CANT_NULL);
         this.setContextMenuMgr(param1);
      }

      public function setPopoverMgrS(param1:IPopoverManager) : void {
         App.utils.asserter.assertNotNull(this.setPopoverMgr,"setPopoverMgr" + Errors.CANT_NULL);
         this.setPopoverMgr(param1);
      }

      public function setColorSchemeMgrS(param1:IColorSchemeManager) : void {
         App.utils.asserter.assertNotNull(this.setColorSchemeMgr,"setColorSchemeMgr" + Errors.CANT_NULL);
         this.setColorSchemeMgr(param1);
      }

      public function setEventLogMgrS(param1:IEventLogManager) : void {
         App.utils.asserter.assertNotNull(this.setEventLogMgr,"setEventLogMgr" + Errors.CANT_NULL);
         this.setEventLogMgr(param1);
      }

      public function setTooltipMgrS(param1:ITooltipMgr) : void {
         App.utils.asserter.assertNotNull(this.setTooltipMgr,"setTooltipMgr" + Errors.CANT_NULL);
         this.setTooltipMgr(param1);
      }

      public function setStatsStorageS(param1:IStatsStorageMeta) : void {
         App.utils.asserter.assertNotNull(this.setStatsStorage,"setStatsStorage" + Errors.CANT_NULL);
         this.setStatsStorage(param1);
      }

      public function setGuiItemsMgrS(param1:IGuiItemsManagerMeta) : void {
         App.utils.asserter.assertNotNull(this.setGuiItemsMgr,"setGuiItemsMgr" + Errors.CANT_NULL);
         this.setGuiItemsMgr(param1);
      }

      public function setVoiceChatMgrS(param1:IVoiceChatManager) : void {
         App.utils.asserter.assertNotNull(this.setVoiceChatMgr,"setVoiceChatMgr" + Errors.CANT_NULL);
         this.setVoiceChatMgr(param1);
      }

      public function setUtilsMgrS(param1:IUtilsManagerMeta) : void {
         App.utils.asserter.assertNotNull(this.setUtilsMgr,"setUtilsMgr" + Errors.CANT_NULL);
         this.setUtilsMgr(param1);
      }

      public function setTweenMgrS(param1:ITweenManager) : void {
         App.utils.asserter.assertNotNull(this.setTweenMgr,"setTweenMgr" + Errors.CANT_NULL);
         this.setTweenMgr(param1);
      }

      public function setGameInputMgrS(param1:IGameInputManagerMeta) : void {
         App.utils.asserter.assertNotNull(this.setGameInputMgr,"setGameInputMgr" + Errors.CANT_NULL);
         this.setGameInputMgr(param1);
      }

      public function handleGlobalKeyEventS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.handleGlobalKeyEvent,"handleGlobalKeyEvent" + Errors.CANT_NULL);
         this.handleGlobalKeyEvent(param1);
      }

      public function onAsInitializationCompletedS() : void {
         App.utils.asserter.assertNotNull(this.onAsInitializationCompleted,"onAsInitializationCompleted" + Errors.CANT_NULL);
         this.onAsInitializationCompleted();
      }
   }

}