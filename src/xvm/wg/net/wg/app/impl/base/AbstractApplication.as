package net.wg.app.impl.base 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.app.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.common.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.managers.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    import scaleform.gfx.*;
    
    public class AbstractApplication extends net.wg.infrastructure.base.meta.impl.ApplicationMeta implements net.wg.app.IApplication
    {
        public function AbstractApplication()
        {
            super();
            App.instance = this;
            this._utils = this.getNewUtils();
            this.createContainers();
            this.createManagers();
            this.populateContainers();
            if (stage) 
            {
                this.initStage();
            }
            else 
            {
                addEventListener(flash.events.Event.ADDED_TO_STAGE, this.initStage);
            }
            addEventListener(flash.events.Event.ENTER_FRAME, this.onFirstFrame);
            return;
        }

        protected function getNewTooltipManager():net.wg.infrastructure.managers.ITooltipMgr
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("BaseApp.getNewTooltipManager" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected function getNewGuiItemsManager():net.wg.infrastructure.managers.IGuiItemsManager
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("BaseApp.getNewGuiItemsManager" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected function getNewVoiceChatManager():net.wg.infrastructure.managers.IVoiceChatManager
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("BaseApp.getNewVoiceChatManager" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected function getNewGameInputManager():net.wg.utils.IGameInputManager
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("BaseApp.getNewGameInputManager" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected function getRegCmdName():String
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("BaseApp.getRegCmdName" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected function onAppConfiguring():void
        {
            return;
        }

        protected function onPopUpManagerInit():void
        {
            return;
        }

        public function get toolTipMgr():net.wg.infrastructure.managers.ITooltipMgr
        {
            return this._tooltipMgr;
        }

        protected final function registerManagers():void
        {
            this._containersMgr.loader = this._loaderMgr;
            setGlobalVarsMgrS(this._varsMgr);
            setLoaderMgrS(this._loaderMgr);
            setContainerMgrS(this._containersMgr);
            setContextMenuMgrS(this._contextMenuMgr);
            setSoundMgrS(this._soundMgr);
            setTooltipMgrS(this._tooltipMgr);
            setColorSchemeMgrS(this._colorSchemeMgr);
            setGuiItemsMgrS(this._guiItemsMgr);
            setVoiceChatMgrS(this._voiceChatMgr);
            setGameInputMgrS(this._gameInputMgr);
            setUtilsMgrS(this._utils);
            return;
        }

        internal function populateContainers():void
        {
            var loc2:*=null;
            var loc1:*=this.getContainers();
            var loc3:*=0;
            var loc4:*=loc1;
            for each (loc2 in loc4) 
            {
                var loc5:*;
                loc2.y = loc5 = 0;
                loc2.x = loc5;
                addChild(loc2);
                if (!(loc2 is net.wg.gui.components.common.ManagedContainer)) 
                {
                    continue;
                }
                this.containerMgr.registerContainer(loc2 as net.wg.gui.components.common.ManagedContainer);
            }
            return;
        }

        internal function disposeManagers():void
        {
            removeChild(this._classLoaderMgr);
            this._classLoaderMgr = null;
            this._contextMenuMgr.dispose();
            this._contextMenuMgr = null;
            this._containersMgr.removeEventListener(net.wg.infrastructure.events.LoaderEvent.CURSOR_LOADED, this.onCursorLoadedHandler);
            this._containersMgr.removeEventListener(net.wg.infrastructure.events.LoaderEvent.WAITING_LOADED, this.onWaitingLoadedHandler);
            this._containersMgr = null;
            this._soundMgr = null;
            this._loaderMgr = null;
            this._varsMgr = null;
            this._tooltipMgr = null;
            this._waiting = null;
            this._environmentMgr = null;
            this._colorSchemeMgr = null;
            return;
        }

        internal function configure():void
        {
            scaleform.gfx.Extensions.enabled = true;
            scaleform.gfx.Extensions.noInvisibleAdvance = true;
            DebugUtils.LOG_DEBUG("complete App configuring. Under scaleform:" + scaleform.gfx.Extensions.isScaleform + "; Under gfx:" + scaleform.gfx.Extensions.isGFxPlayer);
            return;
        }

        internal function onCursorLoadedHandler(arg1:net.wg.infrastructure.events.LoaderEvent):void
        {
            this._cursor = arg1.view as net.wg.infrastructure.interfaces.ICursor;
            this._utils.asserter.assertNotNull(this._cursor, "cursor initialization problem");
            return;
        }

        internal function onWaitingLoadedHandler(arg1:net.wg.infrastructure.events.LoaderEvent):void
        {
            this._waiting = arg1.view as net.wg.infrastructure.managers.IWaitingView;
            this._utils.asserter.assertNotNull(this._waiting, "waiting initialization problem");
            addChild(flash.display.DisplayObject(this._waiting));
            net.wg.infrastructure.interfaces.IView(this._waiting).updateStage(this._appWidth, this._appHeight);
            return;
        }

        internal function onFirstFrame(arg1:flash.events.Event):void
        {
            removeEventListener(flash.events.Event.ENTER_FRAME, this.onFirstFrame);
            this._environmentMgr.envoke(this.getRegCmdName());
            this.configure();
            this.onAppConfiguring();
            return;
        }

        internal function onPopUpManagerInitHandler(arg1:flash.events.Event):void
        {
            stage.removeEventListener(POPUP_MGR_INIT_EVENT, this.onPopUpManagerInitHandler);
            this.onPopUpManagerInit();
            return;
        }

        protected function initStage(arg1:flash.events.Event=null):void
        {
            if (scaleform.clik.core.CLIK.initialized) 
            {
                this.onPopUpManagerInit();
            }
            else 
            {
                stage.addEventListener(POPUP_MGR_INIT_EVENT, this.onPopUpManagerInitHandler, false, 0, true);
            }
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.initStage);
            stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
            stage.align = flash.display.StageAlign.TOP_LEFT;
            return;
        }

        public final function as_dispose():void
        {
            this.onDispose();
            return;
        }

        public final function as_populate():void
        {
            return;
        }

        public function as_registerManagers():void
        {
            this.registerManagers();
            this.utils.events.setEnabled(false);
            this.utils.IME.init(this.globalVarsMgr.isShowLangaugeBarS());
            return;
        }

        public function onLangBarResize(arg1:Number, arg2:Number):void
        {
            this.utils.IME.onLangBarResize(arg1, arg2);
            return;
        }

        public function as_updateStage(arg1:Number, arg2:Number):void
        {
            var w:Number;
            var h:Number;

            var loc1:*;
            w = arg1;
            h = arg2;
            try 
            {
                this.appWidth = w;
                this.appHeight = h;
                if (this.containerMgr) 
                {
                    this.containerMgr.updateStage(w, h);
                }
                if (this.waiting) 
                {
                    net.wg.infrastructure.interfaces.IView(this.waiting).updateStage(w, h);
                }
            }
            catch (e:Error)
            {
                DebugUtils.LOG_DEBUG("as_updateStage error", e.getStackTrace());
            }
            return;
        }

        public function get gameInputMgr():net.wg.utils.IGameInputManager
        {
            return this._gameInputMgr;
        }

        public final function get utils():net.wg.utils.IUtils
        {
            return this._utils;
        }

        public function get soundMgr():net.wg.infrastructure.managers.ISoundManager
        {
            return this._soundMgr;
        }

        public function get contextMenuMgr():net.wg.infrastructure.managers.IContextMenuManager
        {
            return this._contextMenuMgr;
        }

        public function get colorSchemeMgr():net.wg.infrastructure.managers.IColorSchemeManager
        {
            return this._colorSchemeMgr;
        }

        public function get voiceChatMgr():net.wg.infrastructure.managers.IVoiceChatManager
        {
            return this._voiceChatMgr;
        }

        public final function get cursor():net.wg.infrastructure.interfaces.ICursor
        {
            return this._cursor;
        }

        public function get appWidth():Number
        {
            return this._appWidth;
        }

        public function set appWidth(arg1:Number):void
        {
            this._appWidth = arg1;
            return;
        }

        public function get appHeight():Number
        {
            return this._appHeight;
        }

        public function set appHeight(arg1:Number):void
        {
            this._appHeight = arg1;
            return;
        }

        public function get globalVarsMgr():net.wg.infrastructure.base.meta.IGlobalVarsMgrMeta
        {
            return this._varsMgr;
        }

        internal function createManagers():void
        {
            this._containersMgr = this.getNewContainerManager();
            this._classLoaderMgr = this.getNewClassManager();
            addChild(this._classLoaderMgr);
            this._loaderMgr = new net.wg.infrastructure.managers.LoaderManager();
            this._varsMgr = new net.wg.infrastructure.managers.GlobalVarsManager();
            this._soundMgr = this.getNewSoundManager();
            this._tooltipMgr = this.getNewTooltipManager();
            this._environmentMgr = this.getNewEnvironment();
            this._contextMenuMgr = this.getNewContextMenuManager();
            this._colorSchemeMgr = this.getNewColorSchemeManager();
            this._guiItemsMgr = this.getNewGuiItemsManager();
            this._voiceChatMgr = this.getNewVoiceChatManager();
            this._gameInputMgr = this.getNewGameInputManager();
            this._containersMgr.addEventListener(net.wg.infrastructure.events.LoaderEvent.CURSOR_LOADED, this.onCursorLoadedHandler);
            this._containersMgr.addEventListener(net.wg.infrastructure.events.LoaderEvent.WAITING_LOADED, this.onWaitingLoadedHandler);
            return;
        }

        public function get waiting():net.wg.infrastructure.managers.IWaitingView
        {
            return this._waiting;
        }

        public function get environment():net.wg.infrastructure.managers.IEnvironmentManager
        {
            return this._environmentMgr;
        }

        public function get containerMgr():net.wg.infrastructure.managers.IContainerManager
        {
            return this._containersMgr;
        }

        public function get itemsMgr():net.wg.infrastructure.managers.IGuiItemsManager
        {
            return this._guiItemsMgr;
        }

        public function get browserBgClass():Class
        {
            return null;
        }

        public function get systemMessages():flash.display.DisplayObjectContainer
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("AbstractApplication.systemMessages" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected function onDispose():void
        {
            this.disposeManagers();
            this.disposeContainers();
            this._utils.dispose();
            return;
        }

        protected function getNewUtils():net.wg.utils.IUtils
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("BaseApp.getNewUtils" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected function createContainers():void
        {
            return;
        }

        protected function disposeContainers():void
        {
            var loc2:*=null;
            var loc1:*=this.getContainers();
            var loc3:*=0;
            var loc4:*=loc1;
            for each (loc2 in loc4) 
            {
                removeChild(loc2);
            }
            return;
        }

        protected function getContainers():__AS3__.vec.Vector.<flash.display.DisplayObject>
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("BaseApp.getContainers" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected function getNewEnvironment():net.wg.infrastructure.managers.IEnvironmentManager
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("BaseApp.getNewEnvironment" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected function getNewContextMenuManager():net.wg.infrastructure.managers.IContextMenuManager
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("BaseApp.getNewContextMenuManager" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected function getNewContainerManager():net.wg.infrastructure.managers.IContainerManager
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("BaseApp.getNewContainerManager" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected function getNewColorSchemeManager():net.wg.infrastructure.managers.IColorSchemeManager
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("BaseApp.getNewColorSchemeManager" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected function getNewClassManager():flash.display.Sprite
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("BaseApp.getNewClassManager" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        protected function getNewSoundManager():net.wg.infrastructure.managers.ISoundManager
        {
            throw new net.wg.infrastructure.exceptions.AbstractException("BaseApp.getNewSoundManager" + net.wg.data.constants.Errors.ABSTRACT_INVOKE);
        }

        internal static const POPUP_MGR_INIT_EVENT:String="popUpManagerInited";

        internal var _loaderMgr:net.wg.infrastructure.base.meta.ILoaderManagerMeta=null;

        internal var _classLoaderMgr:flash.display.Sprite=null;

        internal var _varsMgr:net.wg.infrastructure.managers.GlobalVarsManager=null;

        internal var _tooltipMgr:net.wg.infrastructure.managers.ITooltipMgr=null;

        internal var _environmentMgr:net.wg.infrastructure.managers.IEnvironmentManager=null;

        internal var _containersMgr:net.wg.infrastructure.managers.IContainerManager=null;

        internal var _guiItemsMgr:net.wg.infrastructure.managers.IGuiItemsManager=null;

        internal var _waiting:net.wg.infrastructure.managers.IWaitingView=null;

        internal var _utils:net.wg.utils.IUtils=null;

        internal var _soundMgr:net.wg.infrastructure.managers.ISoundManager=null;

        internal var _contextMenuMgr:net.wg.infrastructure.managers.IContextMenuManager=null;

        internal var _colorSchemeMgr:net.wg.infrastructure.managers.IColorSchemeManager=null;

        internal var _voiceChatMgr:net.wg.infrastructure.managers.IVoiceChatManager=null;

        internal var _cursor:net.wg.infrastructure.interfaces.ICursor=null;

        internal var _appWidth:Number=0;

        internal var _appHeight:Number=0;

        internal var _gameInputMgr:net.wg.utils.IGameInputManager=null;
    }
}
