package net.wg.infrastructure.base.meta.impl 
{
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.managers.*;
    
    public class ApplicationMeta extends flash.display.MovieClip
    {
        public function ApplicationMeta()
        {
            super();
            return;
        }

        public function setLoaderMgrS(arg1:net.wg.infrastructure.base.meta.ILoaderManagerMeta):void
        {
            App.utils.asserter.assertNotNull(this.setLoaderMgr, "setLoaderMgr" + net.wg.data.constants.Errors.CANT_NULL);
            this.setLoaderMgr(arg1);
            return;
        }

        public function setGlobalVarsMgrS(arg1:net.wg.infrastructure.base.meta.IGlobalVarsMgrMeta):void
        {
            App.utils.asserter.assertNotNull(this.setGlobalVarsMgr, "setGlobalVarsMgr" + net.wg.data.constants.Errors.CANT_NULL);
            this.setGlobalVarsMgr(arg1);
            return;
        }

        public function setSoundMgrS(arg1:net.wg.infrastructure.managers.ISoundManager):void
        {
            App.utils.asserter.assertNotNull(this.setSoundMgr, "setSoundMgr" + net.wg.data.constants.Errors.CANT_NULL);
            this.setSoundMgr(arg1);
            return;
        }

        public function setContainerMgrS(arg1:net.wg.infrastructure.managers.IContainerManager):void
        {
            App.utils.asserter.assertNotNull(this.setContainerMgr, "setContainerMgr" + net.wg.data.constants.Errors.CANT_NULL);
            this.setContainerMgr(arg1);
            return;
        }

        public function setContextMenuMgrS(arg1:net.wg.infrastructure.managers.IContextMenuManager):void
        {
            App.utils.asserter.assertNotNull(this.setContextMenuMgr, "setContextMenuMgr" + net.wg.data.constants.Errors.CANT_NULL);
            this.setContextMenuMgr(arg1);
            return;
        }

        public function setColorSchemeMgrS(arg1:net.wg.infrastructure.managers.IColorSchemeManager):void
        {
            App.utils.asserter.assertNotNull(this.setColorSchemeMgr, "setColorSchemeMgr" + net.wg.data.constants.Errors.CANT_NULL);
            this.setColorSchemeMgr(arg1);
            return;
        }

        public function setTooltipMgrS(arg1:net.wg.infrastructure.managers.ITooltipMgr):void
        {
            App.utils.asserter.assertNotNull(this.setTooltipMgr, "setTooltipMgr" + net.wg.data.constants.Errors.CANT_NULL);
            this.setTooltipMgr(arg1);
            return;
        }

        public function setStatsStorageS(arg1:net.wg.infrastructure.base.meta.IStatsStorageMeta):void
        {
            App.utils.asserter.assertNotNull(this.setStatsStorage, "setStatsStorage" + net.wg.data.constants.Errors.CANT_NULL);
            this.setStatsStorage(arg1);
            return;
        }

        public function setGuiItemsMgrS(arg1:net.wg.infrastructure.base.meta.IGuiItemsManagerMeta):void
        {
            App.utils.asserter.assertNotNull(this.setGuiItemsMgr, "setGuiItemsMgr" + net.wg.data.constants.Errors.CANT_NULL);
            this.setGuiItemsMgr(arg1);
            return;
        }

        public function setVoiceChatMgrS(arg1:net.wg.infrastructure.managers.IVoiceChatManager):void
        {
            App.utils.asserter.assertNotNull(this.setVoiceChatMgr, "setVoiceChatMgr" + net.wg.data.constants.Errors.CANT_NULL);
            this.setVoiceChatMgr(arg1);
            return;
        }

        public function setUtilsMgrS(arg1:net.wg.infrastructure.base.meta.IUtilsManagerMeta):void
        {
            App.utils.asserter.assertNotNull(this.setUtilsMgr, "setUtilsMgr" + net.wg.data.constants.Errors.CANT_NULL);
            this.setUtilsMgr(arg1);
            return;
        }

        public function setGameInputMgrS(arg1:net.wg.infrastructure.base.meta.IGameInputManagerMeta):void
        {
            App.utils.asserter.assertNotNull(this.setGameInputMgr, "setGameInputMgr" + net.wg.data.constants.Errors.CANT_NULL);
            this.setGameInputMgr(arg1);
            return;
        }

        public function handleGlobalKeyEventS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.handleGlobalKeyEvent, "handleGlobalKeyEvent" + net.wg.data.constants.Errors.CANT_NULL);
            this.handleGlobalKeyEvent(arg1);
            return;
        }

        public var setLoaderMgr:Function=null;

        public var setGlobalVarsMgr:Function=null;

        public var setSoundMgr:Function=null;

        public var setContainerMgr:Function=null;

        public var setContextMenuMgr:Function=null;

        public var setColorSchemeMgr:Function=null;

        public var setTooltipMgr:Function=null;

        public var setStatsStorage:Function=null;

        public var setGuiItemsMgr:Function=null;

        public var setVoiceChatMgr:Function=null;

        public var setUtilsMgr:Function=null;

        public var setGameInputMgr:Function=null;

        public var handleGlobalKeyEvent:Function=null;
    }
}
