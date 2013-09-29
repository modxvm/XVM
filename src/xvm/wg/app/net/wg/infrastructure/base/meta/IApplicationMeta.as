package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    import net.wg.infrastructure.managers.*;
    
    public interface IApplicationMeta extends flash.events.IEventDispatcher
    {
        function setLoaderMgrS(arg1:net.wg.infrastructure.base.meta.ILoaderManagerMeta):void;

        function setGlobalVarsMgrS(arg1:net.wg.infrastructure.base.meta.IGlobalVarsMgrMeta):void;

        function setSoundMgrS(arg1:net.wg.infrastructure.managers.ISoundManager):void;

        function setContainerMgrS(arg1:net.wg.infrastructure.managers.IContainerManager):void;

        function setContextMenuMgrS(arg1:net.wg.infrastructure.managers.IContextMenuManager):void;

        function setColorSchemeMgrS(arg1:net.wg.infrastructure.managers.IColorSchemeManager):void;

        function setTooltipMgrS(arg1:net.wg.infrastructure.managers.ITooltipMgr):void;

        function setStatsStorageS(arg1:net.wg.infrastructure.base.meta.IStatsStorageMeta):void;

        function setGuiItemsMgrS(arg1:net.wg.infrastructure.base.meta.IGuiItemsManagerMeta):void;

        function setVoiceChatMgrS(arg1:net.wg.infrastructure.managers.IVoiceChatManager):void;

        function setUtilsMgrS(arg1:net.wg.infrastructure.base.meta.IUtilsManagerMeta):void;

        function setGameInputMgrS(arg1:net.wg.infrastructure.base.meta.IGameInputManagerMeta):void;

        function handleGlobalKeyEventS(arg1:String):void;

        function as_populate():void;

        function as_dispose():void;

        function as_registerManagers():void;

        function as_updateStage(arg1:Number, arg2:Number):void;
    }
}
